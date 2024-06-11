Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36E171A5
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132890; cv=none; b=DTV5vd9zqXGQKf2MtmuBWaO9rX/kyPjA1gwTWjdIbZnk5uCZfgJfgnRYW1l+IVIxFxiriMMXQ463wwPzHNI+igvBebwcq6zBmhXr7FziEFMu4SLBdODXjMSikmTDe0OKZyQ+jP9lzcaT4G3qa4FhBk6j3cj5EceahHUGCmagQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132890; c=relaxed/simple;
	bh=ir7lyRpyQ+h0CC682F6MNaWXOwccvTLZZeU3Qe6rgHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rpw+fxNwQ3IQlBknUyXa5lGQaJrBJvGnH+jiwRB8PZ1cBgFb+QdsM/TAIpa0kYRJs7jXBHcv67FP71P+rKSDWn6V0hQP6dYnFWRTk0gP2xqy5I55V01S3W8Zvxxy0XE+ZGi3mGSTwyUcu7w9Lk+NyyyqTw87V/OnBZ++q0MkGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FM1Cxl7H; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FM1Cxl7H"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5928299EB;
	Tue, 11 Jun 2024 15:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ir7lyRpyQ+h0CC682F6MNaWXOwccvTLZZeU3Qe
	6rgHs=; b=FM1Cxl7H7MzsHtRPzAEUoexe7BxOA45dlC86o4hcnGAkdHADvJs1uU
	EmZf5QBzi1P+rKAR66GhVCmL4GhuoCE1mLTfmsEhhU/aiVply3lPAQ3NE1nydfoN
	rlChunm08hI4jK3saeR+gQziLKFupMuigHK8NvfIJ6LledfTqQv0I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B573F299EA;
	Tue, 11 Jun 2024 15:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7895299E9;
	Tue, 11 Jun 2024 15:08:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v6 1/3] bundle-uri: verify oid before writing refs
In-Reply-To: <e958a3ab20c0c06f52a00038f39605f14302032a.1718109943.git.gitgitgadget@gmail.com>
	(Xing Xin via GitGitGadget's message of "Tue, 11 Jun 2024 12:45:41
	+0000")
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
	<pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
	<e958a3ab20c0c06f52a00038f39605f14302032a.1718109943.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 12:08:04 -0700
Message-ID: <xmqqa5jruwkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF841F24-2825-11EF-BA59-965B910A682E-77302942!pb-smtp2.pobox.com

"Xing Xin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This commit fixes the bug by removing `REF_SKIP_OID_VERIFICATION` flag

"Fix the bug by ...".

> when writing bundle refs. When `refs.c:refs_update_ref` is called to to

"to to"

> write the corresponding bundle refs, it triggers
> `refs.c:ref_transaction_commit`.  This, in turn, invokes
> `refs.c:ref_transaction_prepare`, which calls `transaction_prepare` of
> the refs storage backend. For files backend, this function is
> `files-backend.c:files_transaction_prepare`, and for reftable backend,
> it is `reftable-backend.c:reftable_be_transaction_prepare`. Both
> functions eventually call `object.c:parse_object`, which can invoke
> `packfile.c:reprepare_packed_git` to refresh `packed_git`.

Nice.  That does sound like the right fix.  The one who did
something to _require_ us to reprepare causes the packed_git
list refreshed.

>  test_expect_success 'create bundle' '
>  	git init clone-from &&
> -	git -C clone-from checkout -b topic &&
> -	test_commit -C clone-from A &&
> -	test_commit -C clone-from B &&
> -	git -C clone-from bundle create B.bundle topic
> +	(
> +		cd clone-from &&
> +		git checkout -b topic &&
> +
> +		test_commit A &&
> +		git bundle create A.bundle topic &&
> +
> +		test_commit B &&
> +		git bundle create B.bundle topic &&
> +
> +		# Create a bundle with reference pointing to non-existent object.
> +		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle

I suspect that this would be terribly unportable.  The early part of
a bundle file may be text and sed may be able to grok but are you
sure everybody's implementation of sed would not barf (or even
worse, corrupt) the pack stream data that follows?

The code used in t/lib-bundle.sh:convert_bundle_to_pack() has been
in use since 8315588b (bundle: fix wrong check of read_header()'s
return value & add tests, 2007-03-06), so munging the bundle with
a code similar to it may have a better portability story.

Add something like:

        corrupt_bundle_header () {
                sed -e '/^$/q' "$@"
                cat
        }

to t/lib-bundle.sh, which can take an arbitrary sequence of command
line parameters to drive "sed", and can be used like so:

	corrupt_bundle_header \
		-e "s/^$(git rev-parse A) /$(git rev-parse B) /" \
		<A.bndl >B.bndl

perhaps?

> @@ -33,6 +42,16 @@ test_expect_success 'clone with path bundle' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone with bundle that has bad header' '
> +	git clone --bundle-uri="clone-from/bad-header.bundle" \
> +		clone-from clone-bad-header 2>err &&
> +	# Write bundle ref fails, but clone can still proceed.
> +	commit_b=$(git -C clone-from rev-parse B) &&
> +	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
> +	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
> +	! grep "refs/bundles/" refs
> +'
> +

So this is the test the proposed log message discussed.  The
description gave a false impression that the "broken header" test
that has not much to do with the bug being fixed was the only added
test---we probably want to correct that impression.

> @@ -259,6 +278,132 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
>  	! grep "refs/bundles/" refs
>  '
>  
> +#########################################################################
> +# Clone negotiation related tests begin here

Drop this divider and comment.  The HTTP tests you see below has a
much better reason to be separated like that in order to warn test
writers (they shouldn't add their random new tests after that point,
because everything after that one is skipped when HTTPD tests are
disabled---see the beginning of t/lib-httpd.sh which is included
after that divider line), but everything here you added is not
special.  Everybody should run these tests.

> +test_expect_success 'negotiation: bundle with part of wanted commits' '
> +	test_when_finished rm -rf trace*.txt &&

Do not overly depend on glob not matching at this point when you
establish the when-finished handler (or glob matching the files you
want to catch and later test not adding anything you would want to
clean).  Quote "rm -f trace*.txt" and drop "r" if you do not absolutely
need it (and I would imagine you don't, given the .txt suffix).

> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --bundle-uri="clone-from/A.bundle" \
> +		clone-from nego-bundle-part &&
> +	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/topic
> +	EOF

Hmph, if the expected pattern is only a few lines without any magic,

	test_write_lines >expect refs/bundles/topic &&

may be easier to follow.

> +	test_cmp expect actual &&
> +	# Ensure that refs/bundles/topic are sent as "have".
> +	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
> +'

Using "test_grep" would make it easier to diagnose when test breaks.
A failing "grep" will be silent (i.e., "I didn't find anything you
told me to look for").  A failing "test_grep" will tell you "I was
told to find this, but didn't find any in that".

> +test_expect_success 'negotiation: bundle with all wanted commits' '
> +	test_when_finished rm -rf trace*.txt &&
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --single-branch --branch=topic --no-tags \
> +		--bundle-uri="clone-from/B.bundle" \
> +		clone-from nego-bundle-all &&
> +	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/topic
> +	EOF
> +	test_cmp expect actual &&
> +	# We already have all needed commits so no "want" needed.
> +	! grep "clone> want " trace-packet.txt
> +'
> +
> +test_expect_success 'negotiation: bundle list (no heuristic)' '
> +	test_when_finished rm -f trace*.txt &&
> +	cat >bundle-list <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +
> +	[bundle "bundle-1"]
> +		uri = file://$(pwd)/clone-from/bundle-1.bundle
> +
> +	[bundle "bundle-2"]
> +		uri = file://$(pwd)/clone-from/bundle-2.bundle
> +	EOF

OK.  This is a good use of here-doc (as opposed to test_write_lines
I sugested earlier for different purposes).  I wondered if these
$(pwd) and file://$(pwd) are safe (I always get confused by the need
to sometimes use $PWD to help Windows), but I see them used in what
Derrick wrote in this file, so they must be fine.

But there may be characters in the leading part of $(pwd) that we do
not control that needs quoting (like a double quote '"').  The value
of bundle.*.uri may need to be quoted a bit carefully.  This is not
a new problem this patch introduces, so you do not have to rewrite
this part of the patch; I'll mark it with #leftoverbits here---the
idea being somebody else who is too bored can come back, see if it
is truly broken, and fix them after all dust settles.

Abusing "git config -f bundle-list" might be safer, e.g.

	$ git config -f bundle.list bundle.bundle-1.uri \
		'file:///home/abc"def/t/trash dir/clone-from/b1.bndl'
	$ cat bundle.list
        [bundle "bundle-1"]
                uri = file:///home/abc\"def/t/trash dir/clone-from/b1.bndl

as you do not know what other garbage character is in $(pwd) part.

> +	# We already have all needed commits so no "want" needed.
> +	! grep "clone> want " trace-packet.txt

Just FYI, to negate test_grep, use

	test_grep ! "clone > want " trace-packet.txt

not	

	! test_grep "clone > want " trace-packet.txt ;# WRONG

