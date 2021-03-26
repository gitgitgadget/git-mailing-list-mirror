Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B75C433E3
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC161A2B
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCZPz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZPzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:55:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E86C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:55:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so3248019wmi.3
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a6GG/gSIF8gmFiNmpHoynCia/uZjY8EI7mdcF6SDVA=;
        b=KbzPk6wrAujKNS9pIOGKUMA/hMGtVlmuXWFChQvTRVJ2Z0MKLl3zndj09dp5v29+3r
         7eJIaBJACJMCoCCp88Dix9n5GWlpth6eU1nfj6fu05ysN4/tRXmavD/+oyxaVzIS5HyE
         x+eR/vday6miyKQhy95Qu/IrKovG2DawGtY6SIh1HPchG/ekQxzUzG2S6EQAo+jVMMym
         y4n/0m37x79YJLNqJuxIx5aTiOta9CW5rlgqWEJflrsR/YKOamzjxlVJC9HV9vgbt1Wm
         UKP/iEIx1Sm1nUhJLZa0Ylod6fLz1jvzsOwmObqdzrSVJyzQG+u5SZfGFZt8fcQgNUyk
         O/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a6GG/gSIF8gmFiNmpHoynCia/uZjY8EI7mdcF6SDVA=;
        b=GFzzLycER5HRELdD1RsDfNHu6mhUFZ6KHJcZTYdr0xi9IgXWVKfBV06SvNE5lcHVez
         IJfQmzDK6kFMwa99pWxeEfs+7485M8jGjX6sg4dhZ7dexOwpEzhbLSiX7zLDmCtdhWGz
         DEGPpjP3xDTiH+DrG2ywt4nBTGkldl2nVjKhDqGYIM9TUxKnRlQjWnce8Oq+IotsQTAj
         8cMh2Idche9BLQGSIAy+pRcMd9SjD5X0/so/rd91DcNZo6TFWuj9eb9milB8jDM+Qz6x
         mCOYoJbCJGZDSgh/gry0BnrM20WDD2HMDWkirtgOJ53YY6vpZ6PRWPmQDwe/EhA4mj2b
         xAmQ==
X-Gm-Message-State: AOAM531Tv5uwds6PTlM02hsVoEnMjc+yA4xYag/HzxscKgyfvJaeA2YG
        4MrHCLqfGW6VBH5zSK3QFUU=
X-Google-Smtp-Source: ABdhPJzfGlE6V/sTbL/iK7bIq55zz3JDgsSioiFKqUr+OSgzvIgxc8tjsdnGD5HOND5eBrVImLogag==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr13571579wmi.88.1616774146141;
        Fri, 26 Mar 2021 08:55:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id e17sm13680606wra.65.2021.03.26.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:55:45 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     bagasdotme@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stdedos+git@gmail.com
Subject: Re: [RFC PATCH v1 2/2] fixup! pathspec: warn: long and short forms are incompatible
Date:   Fri, 26 Mar 2021 17:55:43 +0200
Message-Id: <20210326155543.21549-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <f4d7c771-f35c-2a62-f655-5b6469d76ee1@gmail.com>
References: <f4d7c771-f35c-2a62-f655-5b6469d76ee1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I merely wanted to give visibility on the "resulting" patch
https://lore.kernel.org/git/20210326024411.28615-2-stdedos+git@gmail.com/,
by giving the two versions of the implementation
(as discussed in the https://lore.kernel.org/git/20210326024005.26962-1-stdedos+git@gmail.com/ cover)
