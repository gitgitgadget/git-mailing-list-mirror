Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4EC2D0EC
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCD8206E5
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 20:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LByr6SMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCD8206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgDLU0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLU0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 16:26:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E20C0A3BF0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 13:26:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E187C48EAF;
        Sun, 12 Apr 2020 16:26:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hmWFnFIjxzOJ0dU+GzsgtwsPpCw=; b=LByr6S
        Mo1EZmCMYSMLG/NW8l898BEJWf3OPbzrKILSKXiDtij3f109vbge9yL7/lJaM5tH
        KWsjA+DlCKteNRv1v4lsDuPu5kxGola+e4i89S4wiFuWeGZba2nM4XZfzqtt2pt4
        FqZ5W226a8n/NpnTPDwxFKZVWozOIJYYEPEkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G82TVqVTqCibu/m+j0mWu9LEGDluy7H+
        g/bWYsYEd8tkNxUjZSsrPd3PVyhz7FCqwR4oM+m/8DCBeeOOKCRP8eXE4KHzQhr7
        kALVCdOf6sZ4OhqHGJOaCg9l7jut1525oxiwpIQJr7zsa8T/wOcjH9E3h6600pVV
        TYJsDjcUO88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D856348EAE;
        Sun, 12 Apr 2020 16:26:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B49048EAD;
        Sun, 12 Apr 2020 16:26:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v10 1/8] transport: not report a non-head push as a branch
References: <20200407120813.25025-1-worldhello.net@gmail.com>
        <20200412133022.17590-2-worldhello.net@gmail.com>
Date:   Sun, 12 Apr 2020 13:26:32 -0700
In-Reply-To: <20200412133022.17590-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 12 Apr 2020 09:30:15 -0400")
Message-ID: <xmqqa73ge9hj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E67E771E-7CFB-11EA-95B9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>  create mode 100755 t/t5411-proc-receive-hook.sh
>  create mode 100644 t/t5411/common-functions.sh
>  create mode 100644 t/t5411/common-test-cases.sh
>  create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh
>
> diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
> new file mode 100755
> index 0000000000..ef289fe92a
> --- /dev/null
> +++ b/t/t5411-proc-receive-hook.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2020 Jiang Xin
> +#
> +
> +test_description='Test proc-receive hook'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/t5411/common-functions.sh
> +
> +# Format the output of git-push, git-show-ref and other commands to make a
> +# user-friendly and stable text.  In addition to the common format method,
> +# we also replace the URL of different protocol for the upstream repository
> +# with a fixed pattern.
> +make_user_friendly_and_stable_output () {
> +	make_user_friendly_and_stable_output_common | sed \
> +		-e "s#To ../upstream.git#To <URL/of/upstream.git>#"

Break the line immediately after the pipe, and begin the next line
with the command.  That way, the shell knows that you haven't
finished giving the command at the end of the first line, and you do
not have to use a backslash, i.e.

    make_user_friendly |
    sed -e 's/from/to/'

> +		cd workbench &&
> +		# Try to make a stable fixed width for abbreviated commit ID,
> +		# this fixed-width oid will be replaced with "<OID>".
> +		git config core.abbrev 7 &&
> +		git remote add origin ../upstream.git &&
> +		git update-ref refs/heads/master $A &&
> +		git tag -m "v123" v123 $A &&
> +		git push origin \
> +			$B:refs/heads/master \
> +			$A:refs/heads/next
> +	) &&
> +	TAG=$(git -C workbench rev-parse v123) &&
> +
> +	# setup pre-receive hook
> +	cat >upstream.git/hooks/pre-receive <<-\EOF &&

Use write_script and you don't need the chmod at the end.

> +	#!/bin/sh
> +
> +	echo >&2 "# pre-receive hook"
> +
> +	while read old new ref
> +	do
> +		echo >&2 "pre-receive< $old $new $ref"
> +	done
> +	EOF

Perhaps "exec >&2" upfront?

> +	# setup post-receive hook
> +	cat >upstream.git/hooks/post-receive <<-\EOF &&
> +	#!/bin/sh
> +
> +	echo >&2 "# post-receive hook"
> +
> +	while read old new ref
> +	do
> +		echo >&2 "post-receive< $old $new $ref"
> +	done
> +	EOF
> +
> +	chmod a+x \
> +		upstream.git/hooks/pre-receive \
> +		upstream.git/hooks/post-receive &&

Ditto.

> +	upstream=upstream.git
> +'
> +
> +# Include test cases for both file and HTTP protocol
> +. "$TEST_DIRECTORY"/t5411/common-test-cases.sh
> +
> +test_done


> diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
> new file mode 100644
> index 0000000000..6e400c0625
> --- /dev/null
> +++ b/t/t5411/common-functions.sh
> @@ -0,0 +1,50 @@

It is good that this omits "#!" and leaves the file without +x bit.

> +# Format the output of git-push, git-show-ref and other commands to make a
> +# user-friendly and stable text.  We can easily prepare the expect text
> +# without having to worry about future changes of the commit ID and spaces
> +# of the output.  We also replce single quotes with double quotes, because
> +# it is boring to prepare unquoted single quotes in expect txt.

s/txt/text/

> +make_user_friendly_and_stable_output_common () {
> +	sed \
> +		-e "s/  *\$//" \
> +		-e "s/   */ /g" \
> +		-e "s/'/\"/g" \
> +		-e "s/$A/<COMMIT-A>/g" \
> +		-e "s/$B/<COMMIT-B>/g" \
> +		-e "s/$TAG/<TAG-v123>/g" \
> +		-e "s/$ZERO_OID/<ZERO-OID>/g" \
> +		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
> +		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g"
> +}

So a full object name for commit "A" becomes <COMMIT-A> while an
abbreviated one becomes <OID-A>?  OK.  I wonder if we force the full
length (i.e. no abbreviation), the tests become simpler, but it is
OK.  As long as A and B does not share the same 7 hexdigits in any
future hash function we choose, the above will do the right thing
;-)

> diff --git a/t/t5412-proc-receive-hook-http-protocol.sh b/t/t5412-proc-receive-hook-http-protocol.sh
> new file mode 100755
> index 0000000000..e2446d4d32
> --- /dev/null
> +++ b/t/t5412-proc-receive-hook-http-protocol.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2020 Jiang Xin
> +#
> +
> +test_description='Test proc-receive hook for HTTP protocol'
> +
> +. ./test-lib.sh
> +
> +ROOT_PATH="$PWD"
> +. "$TEST_DIRECTORY"/lib-gpg.sh
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
> +start_httpd
> +
> +. "$TEST_DIRECTORY"/t5411/common-functions.sh
> +
> +# Format the output of git-push, git-show-ref and other commands to make a
> +# user-friendly and stable text.  In addition to the common format method,
> +# we also replace the URL of different protocol for the upstream repository
> +# with a fixed pattern.
> +make_user_friendly_and_stable_output () {
> +	make_user_friendly_and_stable_output_common | sed \
> +		-e "s#To http:.*/upstream.git#To <URL/of/upstream.git>#"
> +}

Ditto.

> +# Refs of upstream : master(B)  next(A)
> +# Refs of workbench: master(A)           tags/v123
> +test_expect_success "setup" '
> +	git init --bare upstream.git &&
> +	git -C upstream.git config http.receivepack true &&
> +	git init workbench &&
> +	create_commits_in workbench A B &&
> +	(
> +		cd workbench &&
> +		# Try to make a stable fixed width for abbreviated commit ID,
> +		# this fixed-width oid will be replaced with "<OID>".
> +		git config core.abbrev 7 &&
> +		git remote add origin ../upstream.git &&
> +		git update-ref refs/heads/master $A &&
> +		git tag -m "v123" v123 $A &&
> +		git push origin \
> +			$B:refs/heads/master \
> +			$A:refs/heads/next
> +	) &&
> +	TAG=$(git -C workbench rev-parse v123) &&
> +
> +	# setup pre-receive hook
> +	cat >upstream.git/hooks/pre-receive <<-\EOF &&
> +	#!/bin/sh

Ditto.

> +
> +	echo >&2 "# pre-receive hook"
> +
> +	while read old new ref
> +	do
> +		echo >&2 "pre-receive< $old $new $ref"
> +	done
> +	EOF
> +
> +	# setup post-receive hook
> +	cat >upstream.git/hooks/post-receive <<-\EOF &&
> +	#!/bin/sh
> +
> +	echo >&2 "# post-receive hook"
> +
> +	while read old new ref
> +	do
> +		echo >&2 "post-receive< $old $new $ref"
> +	done
> +	EOF
> +
> +	chmod a+x \
> +		upstream.git/hooks/pre-receive \
> +		upstream.git/hooks/post-receive &&
> +
> +	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
> +	mv upstream.git "$upstream" &&
> +	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
> +'
> +
> +setup_askpass_helper
> +
> +# Include test cases for both file and HTTP protocol
> +. "$TEST_DIRECTORY"/t5411/common-test-cases.sh
> +
> +test_done
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 9ff041a093..9e4b9313b5 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
>  test_expect_success 'push --porcelain' '
>  	mk_empty testrepo &&
>  	echo >.git/foo  "To testrepo" &&
> -	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
> +	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
>  	echo >>.git/foo "Done" &&
>  	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
>  	(
> diff --git a/transport.c b/transport.c
> index 1fdc7dac1a..272c0f4046 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
>  				 porcelain, summary_width);
>  	else if (is_null_oid(&ref->old_oid))

This block is about an update to missing "old", i.e. a creation.

>  		print_ref_status('*',
> -			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
> -			"[new branch]"),
> -			ref, ref->peer_ref, NULL, porcelain, summary_width);

We used to say "if outside refs/tags/, let's call it branch".

> +				 (starts_with(ref->name, "refs/tags/")
> +				  ? "[new tag]"
> +				  : (starts_with(ref->name, "refs/heads/")
> +				     ? "[new branch]"
> +				     : "[new reference]")),
> +				 ref, ref->peer_ref, NULL, porcelain, summary_width);

Now we say "outside refs/heads/ and refs/tags/, that's just a
reference, different from branch".  OK.

Do we ever update refs/remotes/ with this codepath?  Would we want
to label it differently, i.e. as "remote-tracking branch"?

>  	else {
>  		struct strbuf quickref = STRBUF_INIT;
>  		char type;

Thanks.
