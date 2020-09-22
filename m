Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AB0C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AF3221F0
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQtFpoVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIVXQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 19:16:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B2C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:16:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e4so3234156pjd.4
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sri8vXYZjPG5GimQQI6XT6BLlgI+eMXK9HxHlz95V0M=;
        b=pQtFpoVdMOdKdsVfYAtbo7Uasd/E13d95xcXUWXdMklm5OHSm6mdxABti15Q8+ZsR8
         aozxjfDyb7W6B1Eisepp1kNDA7BC5kHea7RRiWCWsj0mtO7TTG0TDHoCyCRD4j8DaYWP
         U6HthVZwAiDgtsHl+e2LEDsv27v9TZ7BYMBANMUVqXIjcHGfyMuvajLrPtwqhUJid/wJ
         ukK8id61WcsOP5YKlyDxmsoA07j+5ApULzAUhL3a3tO85ZLqrkW8vZ/GPJftOcYWMiUl
         01NfBsnXGY67Jd/WtEwigE+YDmneBCU+/rSUo0Xal2Hkr+CjgET4oUenvRfQ0dDhEfgI
         Eo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sri8vXYZjPG5GimQQI6XT6BLlgI+eMXK9HxHlz95V0M=;
        b=fPQH72kZw2emR6+dhZmohre4UZ4HGSvRvF7CYQQ5yGQ2Q+SIQs7dPi7ANTMUiozCNd
         PpMBNREPQxeIJlqOGILv0kxqHY7OAVSZBcO4mMvBr96QMJrf035pZ05AmqJ5F9CRzbRo
         5v6Uv/VkzhQpCDEM1dYWQhLv0uEDhGCWF5zTWOuLCMoUFJOkcWC952UadCZHS8h8nrMg
         qisHaLoye0aCXw5Qz8cfJ21O11QQ0QrCr+TDHDII2tz+KKkvARejaDBst8Nm/H6DNQYR
         2R5QddB6K0ZOhT7XASTJmXNIiRkzH1IIvPo5p+Lh8gsKO7H4Pk6TKZ34rWDIyyQ1DmEo
         d2/w==
X-Gm-Message-State: AOAM531bvoWnC6piCfqi2yuTRpOPHUgHE3U2jxY3iLaLaGViDRQcTrbC
        QX7iudtmnKJd3yciIez5kbhYT4DZdSZLLEQ0oPUA
X-Google-Smtp-Source: ABdhPJwfqTQ0QGMq7NZnoCjSMt15EV+h65RUFQJ3Ga7bEWlLvKPLt45eC8d2MBqZ8v9a9Sq+q9iGUtXJumrD1K/xSyQs
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:941:: with SMTP id
 dw1mr158600pjb.1.1600816615340; Tue, 22 Sep 2020 16:16:55 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:16:52 -0700
In-Reply-To: <d0f2ec70d9dc0b4901704d48bf5cbddbd6e50c01.1598380599.git.gitgitgadget@gmail.com>
Message-Id: <20200922231652.910686-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d0f2ec70d9dc0b4901704d48bf5cbddbd6e50c01.1598380599.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 4/8] midx: enable core.multiPackIndex by default
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/repository.h b/repository.h
> index 3c1f7d54bd..3901ce0b65 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -37,6 +37,8 @@ struct repo_settings {
>  
>  	int pack_use_sparse;
>  	enum fetch_negotiation_setting fetch_negotiation_algorithm;
> +
> +	int core_multi_pack_index;

The only thing I noticed here is why this isn't a bit ("unsigned
core_multi_pack_index : 1"), but I guess it is consistent with "int
pack_use_sparse".
