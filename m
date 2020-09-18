Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA42C43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 10:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD6321D92
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 10:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fETH4VIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRKeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIRKeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 06:34:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B19C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 03:34:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so3238886pgl.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qr5uqG+Tx0X3QH+p6usNAA0NNCj5wspKtM7mOXYMqhg=;
        b=fETH4VIW9CICyhckiMnYXWvWStsiKTiX5b7Szopz8vqwtJKPTZdeG0/LdVY28kaZ7X
         T2sBYZ8hQ4+PbpLsN6Psr5wUABkqXg5/a1JgvWVfyAeKE6h7bYi/CdMDfy3iMB22R/8j
         5Ln4gs127hQP4hJG1XE9lcvF/pfz5Eq0Pe8nA6aaazg/uR/P6F1EwBJaHWMGWbcT6KsS
         leE+MuDNtWEceP/7eWkHwwTgfOSeCVm3ceHrU8EyZAkhe3Uy9SAOgDbSkYCfhHcu+wB2
         3aSjul1DRnqIGs6DnRZ05zjvKLqTm9S90IUuPDQ0heqqUalcAQZVrWk/CbVqFLJep5S1
         LZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qr5uqG+Tx0X3QH+p6usNAA0NNCj5wspKtM7mOXYMqhg=;
        b=VBqRCrDsJnBenQZO35f7D9e5Ei+0qp7KQifjad07Dlb4Y45PeAp1q8jsbeIGIzo1+7
         DFlSnMPC22aHm5MI9E3VkzFDuJPniNn31PpXGC6y102vz917t/QGFPp3Z2LOHfaX2Kpv
         rYeeT6sKjhzFSO7bqzuEPo4PT6xKGcsnzdRjMeiw+ojf2HnKItYFejQ5wt+OW+puyqlf
         REYZUscRzdmEh7QH/o8I8EgLPFeqb0DeEqG5dUYuLar8ySjLoUSvm1rugwrrOOXJmOhs
         qP8hAM2jaPuxo7dRY9wiP9yodXqPLh8QYeVnLT2OczYlYAPA1ZjJNhDFiL/2865FnFDm
         AflA==
X-Gm-Message-State: AOAM533Ghaa6mv+DVRA8iWs55tcYjCSNIpDr53qP03duySvINt5l0J1Q
        iMjm7ltTZypzqWjWCejua9w=
X-Google-Smtp-Source: ABdhPJymUdPxQbnZjDVHdf8r5QIMFFIohgsAM0FeizcFkCaGTsIkIsCF/e7DypHu/Ovkemvd4A1cyA==
X-Received: by 2002:a65:438d:: with SMTP id m13mr16872823pgp.429.1600425243073;
        Fri, 18 Sep 2020 03:34:03 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j6sm2726939pfi.129.2020.09.18.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:34:02 -0700 (PDT)
Date:   Fri, 18 Sep 2020 03:34:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] diff-lib: define diff_get_merge_base()
Message-ID: <20200918103400.GA1874074@generichostname>
References: <cover.1599723087.git.liu.denton@gmail.com>
 <cover.1600328335.git.liu.denton@gmail.com>
 <6aac57ca022963fb41d93905e41dff36dccd5969.1600328335.git.liu.denton@gmail.com>
 <xmqqd02ks4qk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd02ks4qk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Sep 17, 2020 at 10:16:51AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > +void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
> > +{
> > +	int i;
> > +	struct commit *mb_child[2] = {0};
> > +	struct commit_list *merge_bases;
> > +
> > +	for (i = 0; i < revs->pending.nr; i++) {
> > +		struct object *obj = revs->pending.objects[i].item;
> > +		if (obj->flags)
> > +			die(_("--merge-base does not work with ranges"));
> > +		if (obj->type != OBJ_COMMIT)
> > +			die(_("--merge-base only works with commits"));
> > +	}
> 
> This is the first use of die() in this file, that is designed to
> keep a set of reusable library functions so that the caller(s) can
> do their own die().  They may want to become

Although this is the first instance of die(), run_diff_index() has an
exit(128), which is basically a die() in disguise.

> 	return error(_(...));
> 
> The same comment applies to all die()s the patch adds.

I applied this change but then each callsite of diff_get_merge_base()
became something like

	if (diff_get_merge_base(revs, &oid))
		exit(128);

so I do agree with the spirit of the change but in reality, it just
creates more busywork for the callers.

> > +	/*
> > +	 * This check must go after the for loop above because A...B
> > +	 * ranges produce three pending commits, resulting in a
> > +	 * misleading error message.
> > +	 */
> 
> Should "git diff --merge-base A...B" be forbidden, or does it just
> ask the same thing twice and is not a die-worthy offence?

I think that it should be die-worthy because it's a logic error for a
user to do this. I can't think of any situation where it wouldn't be
more desirable error early to correct a user's thinking. Plus, we're
trying to move away from the `...` notation anyway ;)

> > +	for (i = 0; i < revs->pending.nr; i++)
> > +		mb_child[i] = lookup_commit_reference(the_repository, &revs->pending.objects[i].item->oid);
> > +	if (revs->pending.nr < ARRAY_SIZE(mb_child)) {
> > +		struct object_id oid;
> > +
> > +		if (revs->pending.nr != 1)
> > +			BUG("unexpected revs->pending.nr: %d", revs->pending.nr);
> 
> This is an obviously impossible condition as we will not take more
> than 2.

We also want to ensure that revs->pending.nr isn't 0 here. That being
said, I can explicitly check earlier in the function that the number of
pending is 1 or 2 so that it's more clearly written.

Thanks,
Denton
