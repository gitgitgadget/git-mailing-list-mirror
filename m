Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93289C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6442860ED4
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbhIARSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344754AbhIARSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:18:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7BC061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 10:17:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso529661ott.13
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lGkQSjYRu4Fk4vIKGmaCKBxBYYVOmmoSrKsqWeV4ruw=;
        b=pXYg/NZs6pwIO7MSujeEXAlKaG4GQ1/nHN9c4x9L1ZBKKoKe206Rb4QKKmpfSE4xDl
         KVEsY6OSwE1HPTwa3NN2i9RtZm00j8jYihw6W5I+euw8LHO0p+JeU5QNYA/JvtdcPZo3
         VHDr+vNVftX4/llrx/Z5Kkz76cKG9fpvA0jl+3W5fAx/W1iMCD4jlntZxXHRxGfJ9Sjx
         ayCCICzp0jjPwXCbyH2iCqieFb+yxAuWp7PfmfZy4S5JM58WUvLEVJZJLBFyMgE3D/DH
         aYVScTjuokuLIj2Vl0D+HulJhK1r50p1AaWh6hacXlKQpc2qN+SRQQ7NxHhkKRzUz4zU
         1Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lGkQSjYRu4Fk4vIKGmaCKBxBYYVOmmoSrKsqWeV4ruw=;
        b=n878L1cF45EX/0fFsZhAN/+tdlHiQOkW89+kCXiI0/3ci6/z5+PEcMdijbp6Z2ppzl
         PJSss1xQdnGxOU7/KWRZJNrt//Kxka7zDWuS6lD/UUIgzqZScDo9wcfDeTSbjMTV+vTn
         NI8tmkf/5HvTb32m0qB9quX0rNfoeOkTjsQpG2leAUOoyghYmTEL95Vi3qZ10QbDCZIp
         sXyLFanFlL9LMaU6c0q8/YU+mJdrx93d2MWlVW50U2hsswJHWnQpFLQnFto6xcfxh3ZT
         ALe4WDNVQVGDrGpyMg8xYhMF3tW2TTjke4uxtO02NZ9F6BcZlack96GqWyvJlFa+ELLf
         SUFQ==
X-Gm-Message-State: AOAM531kV6UYWsDhIX75A0StFU7nd4o5T1xMUeL4nP9oApC9cAe6/y4v
        x7ERVrIaJ2RnFyZWtv7jthNY1UKEEN4=
X-Google-Smtp-Source: ABdhPJy+YgIodA5oxjJNNcqmvK9U8gIb+25Hpwkm+ihXa4v+EedkxgsC6ZBI//unaWUo20uYYAJLjg==
X-Received: by 2002:a9d:123:: with SMTP id 32mr442372otu.124.1630516667270;
        Wed, 01 Sep 2021 10:17:47 -0700 (PDT)
Received: from localhost (fixed-187-188-76-1.totalplay.net. [187.188.76.1])
        by smtp.gmail.com with ESMTPSA id v29sm77196ooe.31.2021.09.01.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:17:46 -0700 (PDT)
Date:   Wed, 01 Sep 2021 12:17:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>, git@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>
Message-ID: <612fb5b96b69a_35b832088a@natae.notmuch>
In-Reply-To: <20210901121616.2109658-1-someguy@effective-light.com>
References: <20210901121616.2109658-1-someguy@effective-light.com>
Subject: RE: [PATCH] pretty: colorize pattern matches in commit messages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz wrote:
> Currently, for example when
> 
>   git log --grep=pattern
> 
> is executed, the outputted commits that are matched by the pattern do not
> have the relevant substring matches highlighted.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  pretty.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++------

Can you add some tests?

-- 
Felipe Contreras
