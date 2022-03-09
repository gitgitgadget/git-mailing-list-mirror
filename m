Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A577C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 14:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiCIOf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCIOf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 09:35:58 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54275D04A0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 06:34:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id v15so1839585qkg.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7eGNYp8zYJRK9+189qSwerKZSZKQ/Lr/bxACsHTPMSU=;
        b=jMumuYOYdyDtaSG1QDRweW9sjJ8oRoN6DjsN+JwPborQSPRUn119MqYl1paUchZc+5
         Zn5awm/o6JTOZvhKCru2zAbLuHjQ+VVBNNSboZARr7/2DU1DUAM8K4QTzHMz9jXAfARF
         q2zksv/O5/R7+ddb1pGxp+lMzoczOUEinQDjVEwr6WV/u+XjrD8tenewTzuOeYKg6iBM
         5OMPm3Mv92Ia5OS7w7NQI9/RvtQ0WycOUR5gkusY0xrmLWNqvFKT4Fbzpwb1GZIEHXx3
         OB8CJhv61I2HMoU/b2sBWDSmAYcf493+UFM88jWBXfXXsQI/SneOjkG5Pjb6XuK4Cm2s
         ugFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7eGNYp8zYJRK9+189qSwerKZSZKQ/Lr/bxACsHTPMSU=;
        b=6qTkDFWhIrAbra0AATi8awDN4ebObKnh0wrtGAak0yYf45Iml3VUslt3TQS6rKa1vR
         syV5zZ7G4y63PqD3CY6EwggAO1ZFdu7iN0A6DB846aaj64qMo/hHmYm5zv+giFMwFlI+
         qECOZ5LzDRjLlVoErxSvHedbS6lEw+fYvUXCHD4DC3TNyHKoRhN2Aq4i/5ueMEf+bpdz
         8jilUXNWPGnlrlerMqOpVLhSLHvsrZLw/WqldTcusMk2Zp60BWKHPDJtHszd6Hf1v8uu
         +CZ86DDfoflBcBZVuuAmFcE3L8BPwwkAnYxN7JK/GzLpka5/O0e8qtfnc9rYofRzv9LG
         Yy9w==
X-Gm-Message-State: AOAM530N8xbssaIyKaBpJWXhGZt/mxfI+2Qe98gELu9n7FZ43clrzc2o
        a/tL8NZKCnqxL8deHFUWDT9h
X-Google-Smtp-Source: ABdhPJwjSB3wE5Qoi/4cDTkGYcsOQx8E6bkHwL3Qj8H3XvwaobN5ejNy50+/ZPoXV2JoUTsY/Drs+w==
X-Received: by 2002:a05:620a:24d6:b0:67d:177f:3464 with SMTP id m22-20020a05620a24d600b0067d177f3464mr5461536qkn.47.1646836498383;
        Wed, 09 Mar 2022 06:34:58 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 188-20020a3709c5000000b0067b147584c2sm947302qkj.102.2022.03.09.06.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 06:34:58 -0800 (PST)
Message-ID: <77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com>
Date:   Wed, 9 Mar 2022 09:34:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 00/24] revision.[ch]: add and use release_revisions()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
> == For Junio ==
> 
> This has a trivially resolved conflict with Derrick Stolee's
> aaf251cdc5c (revision: put object filter into struct rev_info,
> 2022-03-08) currently in "seen" in builtin/rev-list.c.
> 
> The resolution is to just keep the "goto cleanup" in place of "return
> 0" in the conflicting lines, but to otherwise keep Derrick's version.
> 
> It will pass with/without SANITIZE=leak when applied to both "master"
> and "seen". I omitted one test change (described in a relevant commit
> message) due to the latter not being true (no fault of "seen", just a
> new leaking command being added to a test).

Since ds/partial-bundles will soon be updated in v4 to change the
pointer added to struct rev_info, it is even more likely that there
will be more important things to do with regards to clearing the
memory of rev_infos based on that change. It might be better to wait
for that update (coming soon) and then rebase directly on top.

Thanks,
-Stolee

