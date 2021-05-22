Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F4C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48A061155
	for <git@archiver.kernel.org>; Sat, 22 May 2021 16:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhEVQnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhEVQna (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 12:43:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D100C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 09:42:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j12so16749095pgh.7
        for <git@vger.kernel.org>; Sat, 22 May 2021 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=P3UGAnyKPhxKAOXoMr0X2tVWt9esSTQM9AM6TYtm3+E=;
        b=eEoKvU6V45alu9+4JFxlWSeqmbbPey/Z5Ox6gjU/jIznhgtxnCFfDeDqP3esd10klJ
         jR6gsa5bvc8KctEhYhrKHPGXo8u1k6rPB6xFYxuYciXgsIaqph0/GGxMUBbfl5qfcaLF
         JZg5srNSzYLGTuhDPHDj2Pv8MYnD4O1MIjQibeE346awkgojkNvjZ1MlwhKQ29dtsVt9
         pWGa53VEW8p/DHlonGU9zNUdSDEHBmJ5ZsuW04SWYWiWgC4nHjIaGa5ZIUrfC/tiBz7m
         Jk9OQrMv3J9qf9UMnV/HgKyV67rnneVjSCPj12P8PIQZWFA4cjYPvDid1Z4nRbJRqPhw
         9wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=P3UGAnyKPhxKAOXoMr0X2tVWt9esSTQM9AM6TYtm3+E=;
        b=sfZ8DU3EtqXRfFuq7kQUc6ZR4um0VmkEHNm1UIgcP5nNxL53gvHPBFPdhJSAedSwg9
         7ss1MV8clnaVxSHJPRao7Nk+IHxwhYNW+lxnrGhGigmdjKgBUmBVfDg8wmmS39QEmQP9
         amBpXKp8UR7SGFUWhmpY1rcUtSvMYq7Wg0xGmSw7zo31bVgXsG1YJ9e6qAM82jegvHlB
         JYUWfixbBWM13qs8dPAIhf95d4geqrQI3zHQTbvWVJI4JO+LBzeJ8/osX18tcEfNjmuo
         hmMCoNBRGuDo6VoQA7KSeLmNl4WwDnnxE3yXqbc9Az1ZbOVD6Xf2YinlA+qESU3zj1G9
         UFQA==
X-Gm-Message-State: AOAM53254N1pwWsMu9Z1/20kGfeBCBXT5AGRiLSeinMjUOpWIcIN10Aq
        XFrQxyRd9pCQNv2Shs01yNFmyIEZ1FOVbQ==
X-Google-Smtp-Source: ABdhPJztSc5HRcxj7A6FPXLllZapji5PF9bXQFxx1a8Jw4Q5xIHUoqgStGmE8ZyTkk9uFM4klu5BLw==
X-Received: by 2002:a63:af46:: with SMTP id s6mr4937321pgo.446.1621701723917;
        Sat, 22 May 2021 09:42:03 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id k21sm7053176pgb.56.2021.05.22.09.42.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 May 2021 09:42:03 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [GSoC] My Git Dev Blog
Message-Id: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
Date:   Sat, 22 May 2021 22:12:00 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

As is tradition, I have started my weekly GSoC blog :)

Here is week 1: https://atharvaraykar.me/gitnotes/week1

I shall be sharing my progress, thoughts, experiences and any
information that might help future contributors in my blog.

After my GSoC period, I hope to convert it into a blog that
will help pull in and guide new contributors to Git development.

Any kind of feedback will be appreciated!

You can find the listing of all of the posts at
https://atharvaraykar.me/gitnotes/

I will update this thread every week when I make a new post.

--
Atharva Raykar
