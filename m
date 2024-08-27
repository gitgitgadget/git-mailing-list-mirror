Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C121CFECE
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786362; cv=none; b=oIRo53V6EXdwFBPtxbMw5IEBNeWi9JYQsn/rY6IT706JqsYh3UKOL4qTTk7cL+b1DafwruWxNR10C5rakwQG43oYWp1OVB77mKopHFgTioFzRPDBryOWRP+r3GPFDiZSVbwilReH7NsVEFUxYmmxC9cIoJtvk8fGI6l5osNPQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786362; c=relaxed/simple;
	bh=w0lyjNlbOnMx3kZKMPpaj1zUon9ekjOzEUdpH62Iks4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUm7JqwoWXH0qRZrVJKDsovMENQoP2NgAP3lGI734DUO1zGJgdvsWqbwJf4i7DUavOdyei90r06hyUCIaGdchiF2tfTClYhCJaBcy3v8Nt3FdEsYX/l/YZXLsAQn7vdK9k5mI0SEumLan32X1dyWgAJxlBjWViWQdxOwYF4pDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oAtsWWbn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oAtsWWbn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B51B71CDE6;
	Tue, 27 Aug 2024 15:19:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=w0lyjNlbOnMx3kZKMPpaj1zUon9ekjOzEUdpH6
	2Iks4=; b=oAtsWWbniZBaj+0uV6p1b/k53rLcDEuDS4qCSFVWFwdFz0WYogLJj4
	4jo6PJidl3CRPoz6MdeuVB1U4WJB1jq2uq6MMVHhNVE0lHPovaGDS1hJFOJfqLEf
	zMDfD/h9kYZBkmqheM728wjheIoiR2kYg6EumuKPeD1g+z9Fb5gaw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 985561CDE5;
	Tue, 27 Aug 2024 15:19:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 082591CDE2;
	Tue, 27 Aug 2024 15:19:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/4] ref: add symbolic ref content check for files
 backend
In-Reply-To: <Zs3558scHssaG_XS@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 28 Aug 2024 00:08:07 +0800")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs3558scHssaG_XS@ArchLinux>
Date: Tue, 27 Aug 2024 12:19:11 -0700
Message-ID: <xmqq1q2993kg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E607966-64A9-11EF-8E54-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> We have already introduced the checks for regular refs. There is no need
> to check the consistency of the target which the symbolic ref points to.
> Instead, we just check the content of the symbolic ref itself.

Just in case you need it in the future, if you ever need to refer to
a symbolic ref in a way that it is clear which of the two kinds you
are talking about, you can say "textual symref" (a regular file
whose contents is "ref: " followed by the target), to contrast them
with "symbolic link used as symref".

In the proposed log message of this commit, all references to
"symbolic ref" talk about textual ones, so I do not see any need to
be extra explicit by saying "textual symref".

> In order to check the content of the symbolic ref, create a function
> "files_fsck_symref_target". It will first check whether the "pointee" is
> under the "refs/" directory and then we will check the "pointee" itself.

Hmph, as the pointee must be within the usual places that you would
find refs (either in refs/ directory or pseudo ref files immediately
below $GIT_DIR), wouldn't we check the pointee when fsck (or "git
refs verify") run and check everything?  The pointee will have its
turn to be checked, and I am not sure why you need to check the
pointee when you find a symbolic ref is pointing at it, which will
lead for it to be checked twice (or more).

I however did not find an additional code to "check the pointee itself"
in the patch, so perhaps it is OK---the only thing that needs fixing
may be the above paragraph if that is the case.

> There is no specification about the content of the symbolic ref.
> Although we do write "ref: %s\n" to create a symbolic ref by using
> "git-symbolic-ref(1)" command. However, this is not mandatory. We still
> accept symbolic refs with null trailing garbage. Put it more specific,
> the following are correct:
>
> 1. "ref: refs/heads/master   "
> 2. "ref: refs/heads/master   \n  \n"
> 3. "ref: refs/heads/master\n\n"
>
> But we do not allow any non-null trailing garbage.

Your use of word "null" is probably too confusing to contributors to
this project.  None of the above has NUL bytes in them.  I think you
want to say something like this:

    A regular file is accepted as a textual symbolic ref if it
    begins with "ref:", followed by zero or more whitespaces,
    followed by the full refname (e.g. "refs/heads/master",
    "refs/tags/v1.0"), followed only by whitespace characters.  We
    always write a single SP after "ref:" and a single LF after the
    full refname, but third-party reimplementations of Git may have
    taken advantage of the looser syntax that is allowed as above.

> The following are bad
> symbolic contents which will be reported as fsck error by "git-fsck(1)".
>
> 1. "ref: refs/heads/master garbage\n"
> 2. "ref: refs/heads/master \n\n\n garbage  "
>
> In order to provide above checks, we will use "strrchr" to check whether
> we have newline in the ref content.

strrchr() to look for only LF is overly strict.  You need to match
what refs/files-backend.c:read_ref_internal() does to the contents
read from such a loose ref file, i.e. strbuf_rtrim().  Any isspace()
bytes are trimmed at the end, including SP, HT, CR and LF.

> +static int files_fsck_symref_target(struct fsck_options *o,
> +				    struct fsck_ref_report *report,
> +				    const char *refname,
> +				    struct strbuf *pointee_name,
> +				    struct strbuf *pointee_path)
> +{
> +	const char *newline_pos = NULL;
> +	const char *p = NULL;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
> +
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> +				      "points to ref outside the refs directory");
> +		goto out;
> +	}
> +
> +	newline_pos = strrchr(p, '\n');
> +	if (!newline_pos || *(newline_pos + 1)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_REF_MISSING_NEWLINE,
> +				      "missing newline");

If newline_pos is NULL, it is truly a "missing newline" situation.
If I am reading the code correctly, the severity level is set to
INFO, which is good.

If newline_pos is not NULL but newline_pos[1] is not NUL, however,
that is not a "missing newline".  "refs: refs/heads/master\n " would
trigger this report, for example.

As far as I can tell, such a textual symbolic ref is taken as a
valid symbolic ref pointing at "refs/heads/master" by
refs/files-backend.c:read_ref_internal(), so we are trying to detect
a valid but curiously formatted textual symbolic ref file with the
above code?

And strrchr() to find the last LF is not sufficient for that
purpose.  We would never write "refs:  refs/head/master \n",
but the above code will find the LF, be satisified that the LF is
followed by NUL, without realizing that SP there is not something we
would have written!

I am not sure if that is worth detecting that if it is something we
would have written, but if that were the case, then you would
probably need to do

    (1) check the last byte of pointee_name.buf[] to make sure that
        it is LF; and
    (2) remember pointee_name.len, run strbuf_rtrim() on pointee_name,
        and that LF at the end was the only thing that was trimmed by
        checking the pointee_name.len after trimming.

or something like that.  Then you do not have to have an ugly "oh we
need to check again"---the production code would not do that, either.

> +	if (check_refname_format(pointee_name->buf, 0)) {
> +		/*
> +		 * When containing null-garbage, "check_refname_format" will
> +		 * fail, we should trim the "pointee" to check again.
> +		 */
> +		strbuf_rtrim(pointee_name);
> +		if (!check_refname_format(pointee_name->buf, 0)) {
> +			ret = fsck_report_ref(o, report,
> +					      FSCK_MSG_TRAILING_REF_CONTENT,
> +					      "trailing null-garbage");
> +			goto out;
> +		}

IOW, the above "let's retry" feels totally wrong.  You shouldn't
have to do so, and that comes from running check_refname_format()
before rtrimming the pointee_name.

> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> +				      "points to refname with invalid format");
> +	}

Good.  With this check, we know that the referent, if exists, is
well-formed.  The contents of the referent will then be checked just
like all other refs that may not be pointed by any symbolic ref.

> +	/*
> +	 * Missing target should not be treated as any error worthy event and
> +	 * not even warn. It is a common case that a symbolic ref points to a
> +	 * ref that does not exist yet. If the target ref does not exist, just
> +	 * skip the check for the file type.
> +	 */
> +	if (lstat(pointee_path->buf, &st) < 0)
> +		goto out;

Good.

> +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> +				      "points to an invalid file type");
> +		goto out;

I do not think it is wrong per se, but I am not sure if this check
is needed, either.  When "git fsck" or "git refs verify" is told to
check the loose refs, wouldn't it walk the refs directory and report
such an unusual filesystem entity that is not a regular file,
symbolic link, or a directory as "there is unusual cruft exist
here"?
