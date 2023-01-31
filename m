Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84964C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 17:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjAaRf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAaRf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 12:35:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D137460A1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 09:35:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k13so15882753plg.0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 09:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4q7TF6q5Y6dzmpbyOeksyTGaMDpB+HjZUIWu74dvfzw=;
        b=irRdNumBmjSGJaWOSOXrVQaywLeA+v0HX3VuSm0tQIbzbM1pXIvilto1HaGhh4DFvm
         TVcCB6e8KNMwSl+LEtkqDIDKre5+9IR1t6Hh2g4fYj5qwpuWP3gAL1DRfzs62LjWXRLV
         On2IuoyJcI4hpYdOp7tBtfZy1h7yQw4/woG143/6vL6LleiAHbShuPcO3CBmk7HKbxZf
         BTh/GLwksHHnr5XYZlC1vgmBKHgEsjoi21cPba/kpXtEu3Ijsxl9fIuaxcvn8lNMo+91
         RQrQutNiEmN53pmxFc8WGVwXYneUo7IqxrjAxAXiMkpCLRLGH7uZOQQicRZfpvZoFGR9
         Rgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4q7TF6q5Y6dzmpbyOeksyTGaMDpB+HjZUIWu74dvfzw=;
        b=wiaOilSH4BEchaFNOuTZf3NW8m2UpxUNIEr/3AJJOqzUnv6YdSXXjLoLYR1SuzpOvw
         U0uYmL/k9ZrBh03ZqqVoG4vAjyquQixMoxXO3HRTyEH0shMJISRKYwY2fUNUNP274m+3
         mkFlDNB3pZubRJmLs4p20+4DMwb8OyGa2q9p0JezvYeG50PuCvXjAsrY/tn9SXD+XHYU
         G9wVadj0Rz9GH0ILS6UFsefwXsysGxgyXxnbr9lDaKXId/7QZvGmrzppmJCvVWB0+Lj3
         gaF2yFxhJVLwgXFsT6N14NEoUCE35DIcPvEukHRFlmw9Svfv88jlm80xRz9KAjWH7F1W
         RrGQ==
X-Gm-Message-State: AO0yUKVtV+HhnUUifMs+0ql6NQurRdNAf9fHIIk5mfR3EXRCsMpmgyUb
        CZt8V3pidmvHIILj4PW6yeI=
X-Google-Smtp-Source: AK7set9TjHpf0M6dGAfJfc2iPg1OlXmc0fGEqaxZi4NPQJT3iMHGQ+QHa4PDIJYYtp2v+jVZobAktw==
X-Received: by 2002:a17:902:dac9:b0:194:645a:fa9a with SMTP id q9-20020a170902dac900b00194645afa9amr30160069plx.8.1675186525485;
        Tue, 31 Jan 2023 09:35:25 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001963bc7bdb8sm10007148plr.274.2023.01.31.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:35:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 02/11] bundle: verify using check_connected()
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
        <20c29d37f9c1ba1367145331d25dd27f966312cd.1675171759.git.gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 09:35:24 -0800
In-Reply-To: <20c29d37f9c1ba1367145331d25dd27f966312cd.1675171759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 31 Jan 2023
        13:29:10 +0000")
Message-ID: <xmqqr0vay5cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thus, the code in verify_bundle() has previously had the additional
> check that all prerequisite commits are reachable from repository
> references. This is done via a revision walk from all references,
> stopping only if all prerequisite commits are discovered or all commits
> are walked. This uses a custom walk to verify_bundle().
>
> This check is more strict than what Git applies to fetched pack-files.
> In the fetch case, Git guarantees that the new references are closed
> under reachability by walking from the new references until walking
> commits that are reachable from repository refs. This is done through
> the well-used check_connected() method.
>
> To better align with the restrictions required by 'git fetch',
> reimplement this check in verify_bundle() to use check_connected(). This
> also simplifies the code significantly.

As I often say, breaking repository faster is not the kind of
performance gain we want to have in Git, and I am in favor of this
iteration compared to the earlier version that mostly punted on
ensuring the correctness (rather, it relied on assumption that "most
of the time this should be OK").

>  bundle.c               | 75 ++++++++++++++++--------------------------
>  t/t6020-bundle-misc.sh |  8 ++---
>  2 files changed, 33 insertions(+), 50 deletions(-)

The diffstat is very pleasing to see.

Let me read the postimage along aloud (preimage omitted).

> diff --git a/bundle.c b/bundle.c
> index 4ef7256aa11..76c3a904898 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -187,6 +188,21 @@ static int list_refs(struct string_list *r, int argc, const char **argv)
>  /* Remember to update object flag allocation in object.h */
>  #define PREREQ_MARK (1u<<16)
>  
> +struct string_list_iterator {
> +	struct string_list *list;
> +	size_t cur;
> +};
> +
> +static const struct object_id *iterate_ref_map(void *cb_data)
> +{
> +	struct string_list_iterator *iter = cb_data;
> +
> +	if (iter->cur >= iter->list->nr)
> +		return NULL;
> +
> +	return iter->list->items[iter->cur++].util;
> +}

This is to let check_connected() collect all the prerequisite object
names.  OK.

>  int verify_bundle(struct repository *r,
>  		  struct bundle_header *header,
>  		  enum verify_bundle_flags flags)
>  {
>  	/*
>  	 * Do fast check, then if any prereqs are missing then go line by line
>  	 * to be verbose about the errors
>  	 */
>  	struct string_list *p = &header->prerequisites;
> +	int i, ret = 0;
>  	const char *message = _("Repository lacks these prerequisite commits:");
> +	struct string_list_iterator iter = {
> +		.list = p,
> +	};
> +	struct check_connected_options opts = {
> +		.quiet = 1,
> +	};
>  
>  	if (!r || !r->objects || !r->objects->odb)
>  		return error(_("need a repository to verify a bundle"));
>  
>  	for (i = 0; i < p->nr; i++) {
>  		struct string_list_item *e = p->items + i;
>  		const char *name = e->string;
>  		struct object_id *oid = e->util;
>  		struct object *o = parse_object(r, oid);
> +		if (o)
>  			continue;
>  		ret++;
>  		if (flags & VERIFY_BUNDLE_QUIET)
>  			continue;
>  		if (ret == 1)
>  			error("%s", message);
>  		error("%s %s", oid_to_hex(oid), name);
>  	}
> +	if (ret)
>  		goto cleanup;

The "quick fail" logic as before.  Looking sensible.

>  
> +	if ((ret = check_connected(iterate_ref_map, &iter, &opts)))
> +		error(_("some prerequisite commits exist in the object store, "
> +			"but are not connected to the repository's history"));

And then we let check_connected() to ensure that traversing from
these prerequisite objects down to the DAG formed by existing refs
will not die from missing objects.  Makes sense.

> +	/* TODO: preserve this verbose language. */

I am lost -- aren't we preserving the BUNDLE_VERBOSE code below?

>  	if (flags & VERIFY_BUNDLE_VERBOSE) {



> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 38dbbf89155..7d40994991e 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -595,14 +595,14 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
>  		# Verify should fail
>  		test_must_fail git bundle verify \
>  			../clone-from/tip.bundle 2>err &&
> -		grep "Could not read $BAD_OID" err &&
> -		grep "Failed to traverse parents of commit $TIP_OID" err &&
> +		grep "some prerequisite commits .* are not connected" err &&
> +		test_line_count = 1 err &&
>  
>  		# Unbundling should fail
>  		test_must_fail git bundle unbundle \
>  			../clone-from/tip.bundle 2>err &&
> -		grep "Could not read $BAD_OID" err &&
> -		grep "Failed to traverse parents of commit $TIP_OID" err
> +		grep "some prerequisite commits .* are not connected" err &&
> +		test_line_count = 1 err
>  	)
>  '

Especially with the new test added in the previous step, we know we
are not trading correctness off.  Excellent.

I wonder how much the performance hit does this version incur over
the "not safe at all" version and over the "use custom and
stricter-than-needed" version, by the way?

Thanks.
