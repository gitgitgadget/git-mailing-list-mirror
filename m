Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB309C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB23761002
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhHYOQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:16:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C21C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:16:09 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id l4so1204193qvl.12
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6sjE1klxAf/YyVq9CeVrjyRnOUDiyADtGM4Gw8ygX4=;
        b=RWNnSP2B2UA2MlHQW+c25pEOun+aiuH7gP4XX+zNmLzAAnSkcPBGDiQgadcbmw0WX1
         puUWSmir61pihFGxdSFlosFiuxoVeR4zS1627CGhCGMJyE+J3YRAlnTKRTdZ5AEy6LW9
         3uYwueLVyEhUZpRiewJ/TClQ+SI4yr+yAkFIxOSzhj6yrk5QmShHyaX2p76fW0fTmMFg
         6ekIhztq3RcyQUbX3/4vXu+S1sdc5aR45074TfV6+5Tu6qlQTechBWqnd3PaF+5uyllZ
         XounFBMfF5CKxZ6cuWAXXLubIdlaMLeFkXimTdxlrLErT1NBwmw/OB1k3eBamli8CEZz
         f2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6sjE1klxAf/YyVq9CeVrjyRnOUDiyADtGM4Gw8ygX4=;
        b=AgmcQEsiQ42Y7p7INtw0kZ3umYlwvBN84FxewEo6pg9Qo9ARYq/c/s/hpptrXqYKzM
         Uc/XIy6AxU+o9UdCfyJqH1qJb4DSlBjr5351k92GhRzGSApnRXje2vcHd3ShZRlQfjir
         Be2ZmZBuROHY0G9xw8JpEr3AlFAmJAnosxxUmzx1WExdRtHco4fw/eHaJgnqazGy5h9/
         nKQhSiWN4okgFj+LPqHBqIlXroIXjd+humca0FbqqogGMSSywSDm0l2+t7zNRZLbpwoJ
         UVX/tV+LTA+z/vNzarRZrzGmrKBWpSjEO6p+Xpalwatd/PfBb1PEfB+168JPyfD/BYqp
         9cbw==
X-Gm-Message-State: AOAM5309w5arjmVjEzkz1TvQA2yUhuDU7Xd9pU7gdQSfd+LpAyChwPVU
        T07cDtc9c4C35kr/Cev8EfQ=
X-Google-Smtp-Source: ABdhPJzopARNc83AIf9YYL0wE7czV1tg9APuQ1/uPegwuf/VFV6GUe9vhK7Gz0P72Z5BZ0J8UQ2XeQ==
X-Received: by 2002:a05:6214:240b:: with SMTP id fv11mr43059201qvb.28.1629900968392;
        Wed, 25 Aug 2021 07:16:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6d81:bb65:3870:d879? ([2600:1700:e72:80a0:6d81:bb65:3870:d879])
        by smtp.gmail.com with ESMTPSA id f12sm4178975qte.66.2021.08.25.07.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:16:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] fetch: speed up lookup of want refs via
 commit-graph
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover.1629452412.git.ps@pks.im> <cover.1629800774.git.ps@pks.im>
 <4a819a68309bf03db2d9a5e5be070e52c3542af8.1629800774.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <50329e98-862b-5240-cf6c-cfe4cd7e248c@gmail.com>
Date:   Wed, 25 Aug 2021 10:16:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4a819a68309bf03db2d9a5e5be070e52c3542af8.1629800774.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 6:36 AM, Patrick Steinhardt wrote:
> Speed this up by opportunistcally trying to resolve object IDs via the

s/opportunistcally/opportunistically/ 

> +			/*
> +			 * References in "refs/tags/" are often going to point
> +			 * to annotated tags, which are not part of the
> +			 * commit-graph. We thus only try to look up refs in
> +			 * the graph which are not in that namespace to not
> +			 * regress performance in repositories with many
> +			 * annotated tags.
> +			 */
> +			if (!starts_with(rm->name, "refs/tags/"))
> +				commit = lookup_commit_in_graph(the_repository, &rm->old_oid);

This new logic looks good.

> +			if (!commit) {
> +				commit = lookup_commit_reference_gently(the_repository,
> +									&rm->old_oid,
> +									1);
> +				if (!commit)
> +					rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
> +			}

Thanks,
-Stolee
