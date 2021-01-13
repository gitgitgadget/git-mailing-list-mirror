Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27154C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABA820780
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbhAMSoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbhAMSoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 13:44:21 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369FC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:43:41 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id l14so1244215qvh.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dvRYLOk+Lljd742uBJp+6RnKfQzKBjtAhkx2DkX2w1k=;
        b=fLaZ+C9oGPHKQ8KapYla8jTr612mExEB8Fg9SEBrnh3ImIZEXx4JLvsPNMG3rs6daV
         COjp1mL5IE5LrEn59IvceE/fZQhOnO0cFW+jsJ0pHNwp2mikmz0vfjshQaVhlo/aad/n
         7RhKGBHEynO2+fb9gwg+lafImPN/doLfbfK79/iEm5M/9kZNS0mh38yjFIDpPxXi50VW
         aVSgLSrNF8dnyWOapXpDtId9OneyXR2cbDusf6ZxRbYRyfGNq8Xw5Nk5CYafsjZ50JTx
         sS6oNQFhSjpskwhrES2Zfci+gf+UIYnLPmAjrGFFKgAmWlr1cZdV6hX0NTMUz7JiCqtw
         KSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dvRYLOk+Lljd742uBJp+6RnKfQzKBjtAhkx2DkX2w1k=;
        b=t3p9S7H5z2PRmkO39P21JQwa0b8Eup2lA+FCT1mf4cL1AmPLnBUjXBgSsOT70DbQJy
         jT8rDNoOOC6S/bV7v8QAgL77zDyet5frb7PqkLLXEUvbKR2u4BG9zqQzMpd3JgBG1gSN
         laLgUC22k0D0D3tPka+nBUo2pEzDqhldswkApZF6ON1s8CbCGuA6BurNvNQp2zNeP/Ko
         AvcZVUOAdBmn4rSgS7RSmVaIlSVCPSY1JYXuMo7Omqq5x9HmAeCY8tFG7g3E5+7BoJLJ
         RdxqWWQeJN4d4f4zvsgUpUieqkIZyXIQbWJZT1fonrcBBGPft1tPZMdUewzxkB3DjUOH
         Ewbw==
X-Gm-Message-State: AOAM530o82mxt5HqVc71BRyudrsnaRtd0UjI/+dQq+ZJ24E/VAl+Rqx0
        3os0LNCuIybbgIGt6cGZH1e8SJ8df+Rl0A==
X-Google-Smtp-Source: ABdhPJyV74hRfz8bIpLXnADX9fuyGb5DEUWHnJDm172KmIc1Z62m9vRcKp1Ss0+7P90RL7DqhlDJhg==
X-Received: by 2002:ad4:434e:: with SMTP id q14mr3706753qvs.15.1610563420387;
        Wed, 13 Jan 2021 10:43:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id a3sm1454679qtp.63.2021.01.13.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:43:39 -0800 (PST)
Date:   Wed, 13 Jan 2021 13:43:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's
 needed
Message-ID: <X/8/WassxF7ujqjX@nand.local>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210108092345.2178-2-charvi077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108092345.2178-2-charvi077@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 02:53:39PM +0530, Charvi Mendiratta wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
> commands, there's no point in writing it for squash commands as it is
> immediately deleted.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  sequencer.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 8909a46770..f888a7ed3b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1757,11 +1757,13 @@ static int update_squash_messages(struct repository *r,
>  			return error(_("could not read HEAD's commit message"));
>
>  		find_commit_subject(head_message, &body);
> -		if (write_message(body, strlen(body),
> -				  rebase_path_fixup_msg(), 0)) {
> -			unuse_commit_buffer(head_commit, head_message);
> -			return error(_("cannot write '%s'"),
> -				     rebase_path_fixup_msg());
> +		if (command == TODO_FIXUP) {
> +			if (write_message(body, strlen(body),
> +					  rebase_path_fixup_msg(), 0)) {
> +				unuse_commit_buffer(head_commit, head_message);
> +				return error(_("cannot write '%s'"),
> +					     rebase_path_fixup_msg());
> +			}

I'm nit-picking here, but would this be clearer instead as:

    if (command == TODO_FIXUP && write_message(...) < 0) {
      unuse_commit_buffer(...);
      // ...
    }

There are two changes there. One is two squash the two if-statements
together, and the latter is to add a check that 'write_message()'
returns an error. This explicit '< 0' checking was discussed recently in
another thread[1], and I think makes the conditional here read more
clearly.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqlfcz8ggj.fsf@gitster.c.googlers.com/
