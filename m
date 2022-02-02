Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39013C433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiBBVc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347620AbiBBVcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:32:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C4C061748
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:32:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so910538pjd.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Yi5SwFpAyVIr3npOwiS+KbmHBo+SA/HgWRY1Ng4qRAs=;
        b=kd/teehrBej9Qli2aoiCx/wURPGNWbPYaoSeMcMjc7HpE2skDddwiz7a8SIQADg79r
         Ktly1QsPrJXHJXs6eTs3kbSfL+57aB7oPF5PJbrmmDXUylyjh31Yf3QXdXL8Kmah1FeL
         LWZNlCzOLaAgoKy2Px31KVcyhv4yHDgi0QyPRElRLQLMVLiFiqUVdq8IiPpEIj29Ix/n
         DrvY3Cez5/bl6ScNA7uNvydUbFvgdqpna+Syl11HBfphRCy1fcO+t1+BVD9Zu1KhQUW8
         iOhzzllK0gNFx8+V91LJnTXtvIiZY1K91wYimBMKUN3Y8oEklK0RqZReTMBL8flEO3TH
         Trdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Yi5SwFpAyVIr3npOwiS+KbmHBo+SA/HgWRY1Ng4qRAs=;
        b=V2RidcsqG/F8BezddNaVyKhwpJOBcP87Il5DmUhiLdSq9OU8vrMdmDncWabwCYSZnH
         iiXl7dIMn2pqDIabPCNlEOW/3OW/g9eznIhOoAWMTkkq5nCLGSLpO5W2+aAEQbAtKrTv
         6fnLiEUX4NiKrKcNfJ3VNlN/watmZbTTAX41qSwL9SS3hpBTqkLnimskSOhwlkSUSw4h
         I9La54gmNHg2fJQNvdMiiozoO+0GRI4iILXkgkvkozYWcmHFCQ0RI5yJK2yHOff45hLZ
         1Pm4r9sNlupIK8Wpd/Jluu0BzSD6DSx2jSN2ugdaqIcanWs97pHjXkYHdoGzLMK/F24e
         GkZw==
X-Gm-Message-State: AOAM533Ud0/H26KKRajK84CcsFijZGtLdIayiEptE105KTcByOk11dw/
        lcQ3Dy3J9Tc0MFQKWHwrIpE=
X-Google-Smtp-Source: ABdhPJwWwrm/JNQvL/Wpv958aL+pePg6EEmPDJNJ2EEDl7Dw0UxoENgPJXGQSkhH4QPuc94sD1uEaw==
X-Received: by 2002:a17:90a:e7d1:: with SMTP id kb17mr10359869pjb.1.1643837569858;
        Wed, 02 Feb 2022 13:32:49 -0800 (PST)
Received: from localhost ([2620:15c:289:200:da7f:76ba:d0d5:da44])
        by smtp.gmail.com with ESMTPSA id x1sm26796749pfh.167.2022.02.02.13.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:32:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 12/13] merge-tree: add a --allow-unrelated-histories
 flag
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <25677d5038cab591774eaa1349365871b23aa2fc.1643479633.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:32:48 -0800
Message-ID: <xmqqleytvtrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -430,7 +431,7 @@ static int real_merge(struct merge_tree_options *o,
>  	 * merge_incore_recursive in merge-ort.h
>  	 */
>  	common = get_merge_bases(parent1, parent2);
> -	if (!common)
> +	if (!common && !o->allow_unrelated_histories)
>  		die(_("refusing to merge unrelated histories"));
>  	for (j = common; j; j = j->next)
>  		commit_list_insert(j->item, &merge_bases);

Curious.  This step _adds_ an "--allow" option from the command
line, but we actually did not have to die() when seeing that there
is no common ancestor before this step.  The end result is OK either
way.

> @@ -494,6 +495,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  			   &o.exclude_modes_oids_stages,
>  			   N_("list conflicted files without modes/oids/stages"),
>  			   PARSE_OPT_NONEG),
> +		OPT_BOOL_F(0, "allow-unrelated-histories",
> +			   &o.allow_unrelated_histories,
> +			   N_("allow merging unrelated histories"),
> +			   PARSE_OPT_NONEG),
>  		OPT_END()
>  	};
