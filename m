Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A2C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692352088E
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7AzxCCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgE0QU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgE0QU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:20:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B34C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:20:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so3731510pgb.10
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VcWFvi2JtegEec3Vl7xOkZGhjNKMucDS2CTf0vIv3d0=;
        b=j7AzxCCbxwdQlkfF0S3YdLVao0GosuNVG1w4HYCY/4tzbATKoeJU4wCAAKH/nXd9KE
         RupZF37sLesjq4MQ6dZ786m6Oht3BE6VQGeN4hYb+zI13kGiIZIUKq8yLEJcbk6sBmQj
         uxs5RXZKXoibgPf4C79B+lUxoLC1RckgEEQnoY8YlWlE4BYE2MzROf3XzFPB0jVK7XIh
         ueULYPaGfMZpPmhHfbw95cw8z3t3qZXP1VuU6FIuXJsVRBHB5IsgiywkVGXhLEST1K8p
         zfNJVss6Ed1yDhDNSxgUEBBbFAYp1GaA4aIafWmnOuqGQfJ4RkuMqicQbmHuuLE4frhR
         tfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VcWFvi2JtegEec3Vl7xOkZGhjNKMucDS2CTf0vIv3d0=;
        b=RTEpKpodBCTFxL+uHrViOQ3o6QXZprJI4CuukT6tINj3alq2hU8CFVxWGHyLEv1ZTK
         9V5wXSSXKsMoaKCB89AGui35imgiMf3q5oNvuBWSbtExtwz2ZsJIkjHcyY3wBGyMhv78
         vMnJcLhhO/OjGgLeoQ4nh6SAX4LrKLG3+bGa5BLgFVOCiHlgyb/ZyzhDU9yA0+FN4qix
         FbKO+FWbXKYFumGXeTz5+qGdKF9Aw3sqSWzXk79Lt2i6GG54v0ZIQ7Z2Kh5fOzbYJJXf
         4UjRbWS5H64Wo03gEB2iOTOs/ZJHhldFPA5fVT+cxQBgukuhnropGE+vxkWs6KC9APo0
         Gr0Q==
X-Gm-Message-State: AOAM531+Ms0cK31n8xmSQPVodjbeW6XW/UcUKum8xwrP7++02Isyk0lD
        KottBZi37h7xDEThASk8WAG8yYoGk8g=
X-Google-Smtp-Source: ABdhPJyxIsSBVRPuKnYAUtvWDkBk6TmKczs89sIwpi6fLqJlUeAu8QmTfvtPvSYDoaBTMERFB+GBJQ==
X-Received: by 2002:a63:534d:: with SMTP id t13mr4850750pgl.32.1590596455770;
        Wed, 27 May 2020 09:20:55 -0700 (PDT)
Received: from konoha ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id m14sm2363075pgn.83.2020.05.27.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:20:54 -0700 (PDT)
Date:   Wed, 27 May 2020 21:50:48 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de, heba.waly@gmail.com,
        stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC] Shourya's Blog
Message-ID: <20200527162048.GA19421@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is the third installation of my GSoC blog covering week 3
https://shouryashukla.blogspot.com/2020/05/gsoc-week-3.html

All feedbacks and suggestions are welcome! :)
PS: Got a bit late in posting this one cause my internet went down!

Thanks,
Shourya Shukla
