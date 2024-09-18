Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B846224F0
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726690758; cv=none; b=mGhXGbgqJQ9T1sCQh3XoYhtpSI9p25Hdb8Z5Z8vv3KXf99jY9yFB5ApyJjk+vl8edUkZMLz5ExHpJ0d11jhNmhlGB7UjjFVCuxrC3Uogp+q0oBAJqwp+XbW72h9HDpGvTdq1fdtII2QqLixTDw9Rmeu5r3vAYuFk2Qjel5nFfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726690758; c=relaxed/simple;
	bh=g18ybOwt3oodzYyS78GUMVOJHzWkdOVbYgMBPSQv3YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2Pdo3fROu9BHmTbIdWlkpxTmR9ImwimDXbZO/hvNbUI2iLLZot/2gfR/aNx45Njf/xrOPv974NOlbm4uIk623DJctY8dS4rfAUZPmEKIEOn1bVxZwHInFh1Lt1abVoew9Jhq9+NaujMUjrhSobUi/PcJk/3yQ9uG8+IiACe1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vcNAZYFN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vcNAZYFN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C1DA19204;
	Wed, 18 Sep 2024 16:19:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g18ybOwt3oodzYyS78GUMVOJHzWkdOVbYgMBPS
	Qv3YE=; b=vcNAZYFNVChp3w2AMXgdlcyJmh0+79dd92CA9+3/U9cBYh/nE9QO1W
	TC12SCBsYOqjdMyKeETf97o+0eV7bzbut4Y31BmPpGTqvlfG7HxunuwlEVO60WM+
	h/ImAUZ2kEtH+mKWUflL62JtzwTanfGLKUPkb3FmojHkL/oR+ib2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4287E19203;
	Wed, 18 Sep 2024 16:19:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A042819202;
	Wed, 18 Sep 2024 16:19:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 4/5] ref: add symref content check for files backend
In-Reply-To: <ZuRzzwZds8ys-JEN@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 14 Sep 2024 01:18:07 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRzzwZds8ys-JEN@ArchLinux>
Date: Wed, 18 Sep 2024 13:19:13 -0700
Message-ID: <xmqqldzobtq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4632C488-75FB-11EF-8251-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

Expect that people do not read the body of the message as completing
a paragrpah the title started.  I.e. ...

> We have already introduced the checks for regular refs. There is no need
> to check the consistency of the target which the symref points to.
> Instead, we just need to check the content of the symref itself.

... this needs a bit of preamble, like

    We have code that check regular ref contents, but we do not yet
    check contents of symbolic refs.

> A regular file is accepted as a textual symref if it begins with
> "ref:", followed by zero or more whitespaces, followed by the full
> refname, followed only by whitespace characters. We always write
> a single SP after "ref:" and a single LF after the refname, but
> third-party reimplementations of Git may have taken advantage of the
> looser syntax. Put it more specific, we accept the following contents
> of the symref:
>
> 1. "ref: refs/heads/master   "
> 2. "ref: refs/heads/master   \n  \n"
> 3. "ref: refs/heads/master\n\n"
>
> Thus, we could reuse "refMissingNewline" and "trailingRefContent"
> FSCK_INFOs to do the same retroactive tightening as we introduce for
> regular references.
>
> But we do not allow any other trailing garbage. The followings are bad
> symref contents which will be reported as fsck error by "git-fsck(1)".

This description needs to be updated, as it is unclear if you are
talking about errors we already detect, or if you are planning to
update fsck to notice and report these errors.

> 1. "ref: refs/heads/master garbage\n"
> 2. "ref: refs/heads/master \n\n\n garbage  "
>
> And we introduce a new "badReferentName(ERROR)" fsck message to report
> above errors to the user.

OK.

> In order to check the content of the symref, create a function
> "files_fsck_symref_target". It will first check whether the "referent"
> is under the "refs/" directory, if not, we will report "escapeReferent"
> fsck error message to notify the user this situation.
>
> Then, we will first check whether the symref content misses the newline
> by peeking the last byte of the "referent" to see whether it is '\n'.

"Then, we will first" -> "Then it checks" or something.

You already consumed "first" for the check to limit the referent to
those under "refs/" hierarchy.

> And we will remember the untrimmed length of the "referent" and call
> "strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
> to check whether the trimmed referent format is valid. If not, we will
> report to the user that the symref points to referent which has invalid
> format. If it is valid, we will compare the untrimmed length and trimmed
> length, if they are not the same, we need to warn the user there is some
> trailing garbage in the symref content.

That is an implementation detail of what you did.  But if the
implementation were buggy and did not exactly what you intended to
do, the above description gives no information to help others to fix
it up so that it works as you intended it to work, because you do
not explain it.

So what did you want to achieve in the third step (the first being
"limit to refs/ hiararchy", the second being "no incomplete lines
allowed")?

    Third, we want to make sure that the contents of a textual
    symref MUST have a single LF after the target refname and
    NOTHING ELSE.

or something.

> At last, we need to check whether the referent is a directory. We cannot

"a directory" -> "an existing directory"?

I am not comfortable to see the word "directory" used in this
proposed log message, as some refs could be stored in the packed
backend and are referenced by the symbolic ref you are inspecting
(this comment also refers to the "refs/ directory" you mentioned
earlier as "the first check").

    Lastly, a symbolic ref MUST either point to an existing ref,
    or if the referent does not exist, it MUST NOT be a leading
    subpath for another existing ref (e.g., when "refs/heads/main"
    exists, a symbolic ref that points at "refs/heads" is a no-no).

or something (but again, I am open to a phrasing better than
"subpath").

Design question.  What do we want to do when we have no loose refs
under the "refs/heads/historical/" hiearchy, (i.e. all of them are
in packed-refs file) hence ".git/refs/heads/historical" directory
does not exist on the filesystem.  And a symbolic ref points at
"refs/heads/historical".  Shouldn't we give the same error whether
the .git/refs/heads/historical directory exist or not, as long as
the refs/heads/historical/main branch exists (in the packed-refs
backend)?

> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index 8827137ef0..03bcb77972 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -28,6 +28,12 @@
>  `badRefName`::
>  	(ERROR) A ref has an invalid format.
>  
> +`badReferentFiletype`::
> +	(ERROR) The referent of a symref has a bad file type.
> +
> +`badReferentName`::
> +	(ERROR) The referent name of a symref is invalid.
> +
>  `badTagName`::
>  	(INFO) A tag has an invalid format.
>  
> @@ -49,6 +55,9 @@
>  `emptyName`::
>  	(WARN) A path contains an empty name.
>  
> +`escapeReferent`::
> +	(ERROR) The referent of a symref is outside the "ref" directory.

I am not sure starting this as ERROR is wise.  Users and third-party
tools make creative uses of the system and I cannot offhand think of
an argument why it should be forbidden to create a symbolic link to
our own HEAD or to some worktree-specific ref in another worktree.

> +	size_t len = referent->len - 1;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!starts_with(referent->buf, "refs/")) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_ESCAPE_REFERENT,
> +				      "points to ref outside the refs directory");
> +		goto out;
> +	}
> +
> +	if (referent->buf[referent->len - 1] != '\n') {

As you initialized "len" to "referent->len-1" earlier, wouldn't it
more natural to use it here?  That would match the incrementing of
len++ later in this block.

> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_REF_MISSING_NEWLINE,
> +				      "missing newline");
> +		len++;
> +	}

Having said that, the above should be simplified more like:

 * declare but not initialize "len".  better yet, declare "orig_len"
   and leave it uninitialized.

 * do not touch "len++" in the above block (actually, you can
   discard the above "if(it does not end with LF)" block, see
   below).

 * instead grab "referent->len" in "len" (or "orig_len") immediately
   before you first modify referent, i.e. before strbuf_rtrim() call.

	orig_len = referent->len;
	orig_last_byte = referent->buf[orig_len - 1];

> +	strbuf_rtrim(referent);
> +	if (check_refname_format(referent->buf, 0)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_REFERENT_NAME,
> +				      "points to refname with invalid format");

Similar to an earlier step, the message does not give any more
information than the enum.  Wouldn't the user who got this error
want to learn what referent->buf said and which part of it was bad
in the same message, instead of having to look it up on their own
after fsck finishes?

> +		goto out;
> +	}

At this point we know check_refname_format() is happy with what is
left after rtrimming the referent.  There are four cases:

 - rtrim() did not trim anything (orig_len == referent->len); the file
   lacked the terminating LF.

 - rtrim() trimmed one byte (orig_len - 1 == referent->len) and
   the byte was not LF (orig_last_byte != '\n').  The file lacked
   the terminating LF.

 - rtrim() trimmed exactly one byte (orig_len - 1 == referent->len)
   and the byte was LF (orig_last_byte == '\n').  There is no error.

 - all other cases, i.e., rtrim() trimmed two or more bytes.  The
   file had trailing whitespaces after a valid referent that passed
   check_refname_format().

So in short,

	if (referent->len == orig_len ||
	    referent->len == orig_len - 1 && orig_last_byte != '\n') {
		FSCK_MSG_REF_MISSING_NEWLINE;
	} else if (referent->len < orig_len - 1) {
		FSCK_MSG_REF_TRAILING_WHITESPACE;
	}

can replace the next block you wrote, and we can also remove the
earlier "it is an error if it does not end with '\n'", I think.

> +	if (len != referent->len) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_TRAILING_REF_CONTENT,
> +				      "trailing garbage in ref");

As check_refname_format() was happy, the difference between orig_len
and referent->len are only coming from trailing whitespaces, i.e. it
is not that it had arbitrary garbage.  Shouldn't we be more explicit
about that?

> +	/*
> +	 * Dangling symrefs are common and so we don't report them.
> +	 */
> +	if (lstat(referent_path->buf, &st)) {
> +		if (errno != ENOENT) {
> +			ret = error_errno(_("unable to stat '%s'"),
> +					  referent_path->buf);
> +		}
> +		goto out;
> +	}
> +
> +	/*
> +	 * We cannot distinguish whether "refs/heads/a" is a directory or not by
> +	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
> +	 * check the file type of the target.
> +	 */
> +	if (S_ISDIR(st.st_mode)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_REFERENT_FILETYPE,
> +				      "points to the directory");
> +		goto out;
> +	}

If referent_path->buf refers to "refs/heads/historical/", and all
the branches under the hierarchy have been sent to packed-refs,
then this check will not trigger.

I wonder if this check is the right thing to enforce in the first
place, though.

As far as the end user is concerned, refs/heads/historical/master
branch stil exists, and there is no refs/heads/historical branch, so
such a symbolic ref, for all intents and purposes, is the same as
any other dangling symbolic refs, no?

Of course, "git update-ref SUCH_A_SYMREF HEAD" will complain because
there is refs/heads/historical, with something like 

    "refs/heads/historical/master" exists, cannot create "refs/heads/historical"

but that is to be expected.  If you remove the last branch in the
refs/heads/historical hierarchy, you should be able to do such an
update-ref to instanciate refs/heads/historical as a regular ref.

> @@ -3484,12 +3553,24 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  					      "trailing garbage in ref");
>  			goto cleanup;
>  		}
> +	} else {
> +		strbuf_addf(&referent_path, "%s/%s",
> +			    ref_store->gitdir, referent.buf);
> +		/*
> +		 * the referent may contain the spaces and the newline, need to
> +		 * trim for path.
> +		 */
> +		strbuf_rtrim(&referent_path);

I doubt this is a good design.  We have referent, and the symbolic
ref checker knows that the true referent refname may be followed by
whitespaces, so instead of inventing referent _path here, it would
be a better design to let the files_fsck_symref_target() to decide
what file to open and check based on referent, no?  Give it the
refstore or refstore's gitdir and have the concatenation with the
rtrimmed contents in the referent->buf after it inspected it
instead, perhaps?

> +		ret = files_fsck_symref_target(o, &report,
> +					       &referent,
> +					       &referent_path);
