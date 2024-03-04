Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F627869E
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594606; cv=none; b=dyvsCpJGEC7jIEWw94d+jGWhOl0U/pJXsokUDYu5kbdhB8d8X+oEIGn+bfwHrDAp2reAme062HmgiH3HqFRvHnDajO7Ff9f26KFm+y0irDkuz5Xumto+AeTrQUfXJW22ak2ZNuG6eDkefUtD6R5isMS+TE+NAnGs2qp/5O+kAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594606; c=relaxed/simple;
	bh=5/rCVsOCWhyy+1uFvcfQ+irT31neUVBKIAABSBc2r1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=THa/NtmIYuLEybt/QOQWTrzWKbWBodE97idh2ZEdC3BTvqH1WMWjuX+ajqs6DMmxQO5r1FaKp4oH41fcQDEHPkd1dJDPJ3y5HnB2UIAmUKbm3CfnhM0OUpSBZvtenlCNwQab5Ylwlq0YXDwu4EPR/ubc0CmFFXgV6uhobH7ffZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B8rXhrrc; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B8rXhrrc"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E8FB91F5693;
	Mon,  4 Mar 2024 18:23:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5/rCVsOCWhyy+1uFvcfQ+irT31neUVBKIAABSB
	c2r1U=; b=B8rXhrrc4qMbkfSuyvgDtRE8kL0TjR00OSQ4Q5Kw2/KeTJWpziW3VG
	TPEqivjYhdZ5eIhhO4RRsUUC5tD50MgIRMwOcjToyG0e6NM3UDNz+vkikTaPkU0q
	wNRkQxmmTwo4w7I/eG4HuN099YsNrlakqteelhSmvynaKoxcmlz9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E07151F5692;
	Mon,  4 Mar 2024 18:23:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 429071F5691;
	Mon,  4 Mar 2024 18:23:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
In-Reply-To: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Mon, 04 Mar 2024 22:51:58 +0000")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 15:23:21 -0800
Message-ID: <xmqqplw9mviu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 314C8F7C-DA7E-11EE-9B48-25B3960A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> For reftable development, it would be handy to have a tool to provide
> the direct value of any ref whether it be a symbolic ref or not.
> Currently there is git-symbolic-ref, which only works for symbolic refs,
> and git-rev-parse, which will resolve the ref. Let's add a --unresolved
> option that will only take one ref and return whatever it points to
> without dereferencing it.

The approach may be reasonble, but the above description can use
some improvements.

 * Even though the title of the patch says show-ref, the last
   sentence is a bit too far from there and it was unclear to what
   you are adding a new feature at least to me during my first read.

      Let's teach show-ref a `--unresolved` optionthat will ...

   may make it easier to follow.

 * "Whatever it points to without dereferencing it" implied that it
   assumes what it is asked to show can be dereferenced, which
   invites a natural question: what happens to a thing that is not
   dereferenceable in the first place?  The implementation seems to
   show either symbolic-ref target (for symbolic refs) or the object
   name (for others), but let's make it easier for readers.

>  Documentation/git-show-ref.txt |  8 ++++++
>  builtin/show-ref.c             | 33 ++++++++++++++++--------
>  t/t1403-show-ref.sh            | 47 ++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
> index ba757470059..2f9b4de1346 100644
> --- a/Documentation/git-show-ref.txt
> +++ b/Documentation/git-show-ref.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	     [--] [<ref>...]
>  'git show-ref' --exclude-existing[=<pattern>]
>  'git show-ref' --exists <ref>
> +'git show-ref' --unresolved <ref>
>  
>  DESCRIPTION
>  -----------
> @@ -76,6 +77,13 @@ OPTIONS
>  	it does, 2 if it is missing, and 1 in case looking up the reference
>  	failed with an error other than the reference being missing.
>  
> +--unresolved::
> +
> +	Prints out what the reference points to without resolving it. Returns
> +	an exit code of 0 if it does, 2 if it is missing, and 1 in case looking
> +	up the reference failed with an error other than the reference being
> +	missing.

Exactly the same issue as in the proposed log message, i.e. what is
printed for what kind of ref is not really clear.

> -static int cmd_show_ref__exists(const char **refs)
> +static int cmd_show_ref__raw(const char **refs, int show)
>  {
> -	struct strbuf unused_referent = STRBUF_INIT;
> -	struct object_id unused_oid;
> -	unsigned int unused_type;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct object_id oid;
> +	unsigned int type;
>  	int failure_errno = 0;
>  	const char *ref;
>  	int ret = 0;
> @@ -236,7 +237,7 @@ static int cmd_show_ref__exists(const char **refs)
>  		die("--exists requires exactly one reference");
>  
>  	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
> -			      &unused_oid, &unused_referent, &unused_type,
> +			      &oid, &referent, &type,
>  			      &failure_errno)) {
>  		if (failure_errno == ENOENT || failure_errno == EISDIR) {
>  			error(_("reference does not exist"));
> @@ -250,8 +251,16 @@ static int cmd_show_ref__exists(const char **refs)
>  		goto out;
>  	}
>  
> +		if (!show)
> +			goto out;
> +
> +		if (type & REF_ISSYMREF)
> +			printf("ref: %s\n", referent.buf);
> +		else
> +			printf("ref: %s\n", oid_to_hex(&oid));

If I create a symbolic ref whose value is deadbeef....deadbeef 40-hex,
I cannot tell from this output if it is a symbolic ref of a ref that
stores an object whose name is that hash.  Reserve the use of "ref: %s"
to the symbolic refs (so that it will also match how the files backend
stores them in modern Git), and use some other prefix (or no
perfix).

Actually, I am not sure if what is proposed is even a good
interface.  Given a repository with these few refs:

    $ git show-ref refs/heads/master
    b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/heads/master
    $ git show-ref refs/remotes/repo/HEAD
    b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/remotes/repo/HEAD
    $ git symbolic-ref refs/remotes/repo/HEAD
    refs/remotes/repo/master

I would think that the second command above shows the gap in feature
set our current "show-ref" has.  If we could do

    $ git show-ref --<option> refs/heads/master refs/remotes/repo/HEAD
    b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/heads/master
    ref:refs/remotes/repo/master refs/remotes/repo/HEAD

or alternatively

    $ git show-ref --<option> refs/heads/master refs/remotes/repo/HEAD
    b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/heads/master
    ref:refs/remotes/repo/master b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/remotes/repo/HEAD

wouldn't it match the existing feature set better?  You also do not
have to limit yourself to single ref query per process invocation.

I am not sure if you need to worry about quoting of the values of
symbolic-ref, though.  You _might_ need to move the (optional)
symref information to the end, i.e. something like this you might
prefer.  I dunno.

    $ git show-ref --<option> refs/remotes/repo/HEAD
    b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/remotes/repo/HEAD refs/remotes/repo/master 

I do not know what the <option> should be called, either.  From an
end-user's point of view, the option tells the command to also
report which ref the ref points at, if it were a symbolic one.
"unresolved" may be technically acceptable name to those who know
the underlying implementation (i.e. we tell read_raw_ref not to
resolve when it does its thing), but I am afraid that is a bit too
opaque implementation detail for end-users who are expected to learn
this option.

