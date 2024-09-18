Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB35136327
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726685990; cv=none; b=iqlqdOfREd7SA2TbdQCQAmDtJvmUpfdR3xRRda2ghZi8fGjcC9fDOo1mN77mS1tnOWobWQVXEolCC5p5ulc6fAmVvq4lc3KbRXK/nlu1CjMYvolbbTR6ZSZmkOnWC1JIJj6r5rAxW2TNKCch7Le+awXcwPFopx+LfZo2FezfI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726685990; c=relaxed/simple;
	bh=Euela6xq4YQb5U9hOqdStiFEWGiqC/l0cnNUXtgcyjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eoxBMiyc9KfIJNsXfMwm4OsHhppEp2kLnML4P6i3UogKQr7CfeIAs126g+k1A1HwmsbhRcZs+fFWWXi6441WZRdytl5S2KuY9IKeQ7WVO6gzTXJFwOUUVN0ZJB2NoPxBTHIUrFm/LA3iD8MNTZ87W3PTqIDqFoieJZ20ePYcSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HLlNmfX7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLlNmfX7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D5BA1820F;
	Wed, 18 Sep 2024 14:59:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Euela6xq4YQb5U9hOqdStiFEWGiqC/l0cnNUXt
	gcyjg=; b=HLlNmfX7TX3nSTj7z/9fJoGQIT34P+JfpObrDtSgyPNIFUjDBLh9Si
	ZcFh56tk++YWUa/IU5kkAsZDDoPkYYwQaKyHr+H7fZd1m3TKyMpr4U7beoTqq6dd
	CxSVjB/LV0E8NJehcTwy4iQtnUJa0Lvx3jxXIvJXLSdXCBlxdvUYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 23CAB1820E;
	Wed, 18 Sep 2024 14:59:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80D3E1820D;
	Wed, 18 Sep 2024 14:59:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 2/5] ref: port git-fsck(1) regular refs check for
 files backend
In-Reply-To: <ZuRzwKTFd65RL4HC@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 14 Sep 2024 01:17:52 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRzwKTFd65RL4HC@ArchLinux>
Date: Wed, 18 Sep 2024 11:59:45 -0700
Message-ID: <xmqqh6acdbz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C2C16DA-75F0-11EF-AC51-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> We implicitly rely on "git-fsck(1)" to check the consistency of regular
> refs. However, we have already set up the infrastructure of the ref
> consistency checks. We need to port original checks from "git-fsck(1)".
> Thus, we could clean the "git-fsck(1)" code by removing these implicit
> checks.

The above reads as if you are, in preparation to "port" the checks
we have in "fsck" to elsewhere (presumably to "refs verify"), you
are removing the checks that _will_ become redundant from "fsck".

But that does not seem to be what is happening.  Let me try to
paraphrase, in order to check my understanding of what you wanted to
say:

    "git-fsck(1) has some consistency checks for regular refs.  As
    we want to align the checks "git refs verify" performs with
    them (and eventually call the unified code that checks refs from
    both), port the logic "git fsck" has to "git refs verify".

If we fail to achieve the "a single unified code to check called by
both fsck and refs-verify" at the end of this series, and instead
end up with duplicated code that implements the checks in two
separate code, risking them to be slightly different and drift away
over time from each other, that is fine, as long as our intention is
to continue the effort for unification in a follow up series.  

But such a plan needs to be spelled out.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 890d0324e1..b1ed2e5c04 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3430,6 +3430,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
>  
> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct strbuf refname = STRBUF_INIT;
> +	struct fsck_ref_report report = {0};
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +	report.path = refname.buf;
> +
> +	if (S_ISLNK(iter->st.st_mode))
> +		goto cleanup;

"symbolic links are OK" for now.  We'll add sanity checks for them
in later steps.  OK.

> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret = error_errno(_("unable to read ref '%s/%s'"),
> +				  refs_check_dir, iter->relative_path);

Is there a reason why we cannot to use report.path aka refname.buf,
and instead we have to recompute the same path again?

Should this error be propagated back to the caller, not just to the
end-user, by a call to fsck_report_ref(), like you do for a ref file
that has questionable contents?  If ref iteration (like for-each-ref)
claims there is this ref, and you cannot read its value when you try
to use it, it is just as bad as having a loose ref file that has
unusable contents, isn't it?

It is a separate matter if such a failure mode deserves its own
error code (FSCK_MSG_UNREADABLE_REF) or can be rolled into the same
FSCK_MSG_BAD_REF_CONTENT.  I can see arguments for both sides and
offhand have no strong preference either way.

Thanks.

> +		goto cleanup;
> +	}
> +
> +	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
> +				     ref_content.buf, &oid, &referent,
> +				     &type, &failure_errno)) {
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_REF_CONTENT,
> +				      "invalid ref content");
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	strbuf_release(&refname);
> +	strbuf_release(&ref_content);
> +	strbuf_release(&referent);
> +	return ret;
> +}
