Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B2FC7EE21
	for <git@archiver.kernel.org>; Mon,  1 May 2023 19:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEATKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEATKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 15:10:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE8173E
        for <git@vger.kernel.org>; Mon,  1 May 2023 12:10:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso737987a91.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682968229; x=1685560229;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMAQWC2gvLZ8PA41f1ZQZemUmEvK9YtQaTVR+2kuZFQ=;
        b=A8cQav0/HRnR1aI8GaW3pMqv/Q/a29W9g+jH6D8Wniif/O3exXoJkn6V0x8UrxLo2a
         uOK5HOX1S27OUw09brcklAaMIJA3/swtaKLycQDKGu2bgJhzD7pg6AkxXlYL/HdBUxvO
         F3z64w6n8Be2JcQXNrrOL2GBeT6ryj6NSwfCntoo5G6Nal+vaYpWmc7beMWyYLuMT2+f
         zyHmZL2AEO9wmDxfkfg/WxKEUVTdxhyn9uK+mE6Son0KOUeVsrwZFrGE5rsG1J5U9T6n
         MiXHtS6rkd0pikFezvhUKhZHeGSJoM1KU8qrTgY4QzsiYC152+/sPcwrsiRanlWv0NqS
         GudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968229; x=1685560229;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMAQWC2gvLZ8PA41f1ZQZemUmEvK9YtQaTVR+2kuZFQ=;
        b=YSAyhapOBbgG2nn4mQsCtTN+AVz61k+fIph2jLBt7DG8aBm/HTA8YszB6vaY04pTru
         jQ2c5clX2C7Azal8WGYOmSGV/k3JhssdR8CaNPWfmJT5CmYsskiYNp3/Q5Iq3oU77ROW
         nmPMATJ8Ac5I6EMA+WByrFGPXxzAxC3rCjFoSFheyUQQkcXzjvvwnDy356AKsCzsf8mV
         BdpzOt/z0MJ2ASkpGOaouUxvtwzHAPtm0pPkJP5hG+CPrmbSGdTDxKCQn3tlCTben9UH
         XehU5cUdaGpohQLEL9DORqMMB1Q34fi0s0QRThLsFuhMx+fnaOqx5HVOUUb18FdzTwyq
         ZUow==
X-Gm-Message-State: AC+VfDybogqvI88Gygvd7QTK98FSe3D1wfcPcdJU+1B/wiWOwu3Qf7Mq
        2iB0IWqcNjBdqrha46f4g1A=
X-Google-Smtp-Source: ACHHUZ4keqwlXstFT7gj8sK5dT08GdoDJyqmZdWGphWQJyOFXyzKcBG7TQVpBudOOEa2R3b/7ozmVw==
X-Received: by 2002:a17:90a:d190:b0:24e:113d:db82 with SMTP id fu16-20020a17090ad19000b0024e113ddb82mr2506855pjb.8.1682968228675;
        Mon, 01 May 2023 12:10:28 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b001a5fccab02dsm18199830plb.177.2023.05.01.12.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:10:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] fsck: use local repository
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
        <2162a352a46dc0c40afccc4defc88a1e8940ce6c.1682965296.git.gitgitgadget@gmail.com>
Date:   Mon, 01 May 2023 12:10:28 -0700
In-Reply-To: <2162a352a46dc0c40afccc4defc88a1e8940ce6c.1682965296.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 01 May 2023
        18:21:35 +0000")
Message-ID: <xmqqr0rz50m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> In 0d30feef3c5 (fsck: create scaffolding for rev-index checks,
> 2023-04-17) and later 5a6072f631d (fsck: validate .rev file header,
> 2023-04-17), the check_pack_rev_indexes() method was created with a
> 'struct repository *r' parameter. However, this parameter was unused and
> instead 'the_repository' was used in its place.
>
> Fix this situation with the obvious replacement.

Indeed obvious it is.  Thanks, will queue.

>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/fsck.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 75b30d1d00c..dcc165bf0c5 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -869,20 +869,20 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
>  	int res = 0;
>  
>  	if (show_progress) {
> -		for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)
> +		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
>  			pack_count++;
>  		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);
>  		pack_count = 0;
>  	}
>  
> -	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
> +	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
>  		int load_error = load_pack_revindex_from_disk(p);
>  
>  		if (load_error < 0) {
>  			error(_("unable to load rev-index for pack '%s'"), p->pack_name);
>  			res = ERROR_PACK_REV_INDEX;
>  		} else if (!load_error &&
> -			   !load_pack_revindex(the_repository, p) &&
> +			   !load_pack_revindex(r, p) &&
>  			   verify_pack_revindex(p)) {
>  			error(_("invalid rev-index for pack '%s'"), p->pack_name);
>  			res = ERROR_PACK_REV_INDEX;
