Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F91C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17DB20739
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1PdZef8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFQJfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 05:35:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB44C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:35:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d4so991392pgk.4
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=5RmqVrgQV+qf0UErEbieoW0JepFhWHWD2zn1p+/07bg=;
        b=J1PdZef8pzkIY+Xh9JbokIfxP0ufIBQJOU7I1gIjNddT1j2Ri/6V36FNRmP6IEnood
         0JesBm7AAznyONv2c6Jivx+PTKun58hACRsbA3eRYd8Cezdblq84cZUKK7y6xKPnQHu0
         IqsZIpO1pXoEMSbyJLsiwxOQaI0CNul9W+9uAFjuxhcXVcKMILbVom+OzDq6TaJ/Fn8g
         tfccXah2oUULFKP/Lk07MEugvrj+0qKTrTCCqpS7CTMvWtd7VjWn6962LZj7mF6O4M1t
         fN61esHoNb/65iJUBPvBSYCtfDEUHcmpl8pGRz6PXD+4a02t6oidWFqLxX1TEQ1QgZx4
         RSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=5RmqVrgQV+qf0UErEbieoW0JepFhWHWD2zn1p+/07bg=;
        b=UcDPfOHCWdXTC2jNh3Z5huHWcY7Mkl5fmSdDifYZGsnZqGl5ABiDTpZMWlE29KND33
         +jO4fkZ9ILqF8reagq3MCL5b+KXIphLRGsAN84ZFy6bDZ0MFKryV/teO4SsRniaLbSuK
         RD9X8H4JWFqC76uxEYDV/yAWkAJnoRRltq9LuIp4cRn5S89Oo5HkjlsIZQVQarXdYdUJ
         a9d2pV9cFJW2Osu71flycraACsdlWu26Xcw9x5TI5mbzeJ3/VDF3WFFYcip6NGHJetoT
         mKFdlZi0eZ2RXblgrdtt7sRgZED7ABPsSRi8COjiFM4J0taiP8wyg6t9s5R/SdL3Vnuw
         7GFw==
X-Gm-Message-State: AOAM530c89JKDIiXm9oWNHdJ3LL0OTgvH41hMhmYjKDzlpKqDLC+9vgi
        6EqjPVvzeKC/BGD90HKQE33G+Vlt
X-Google-Smtp-Source: ABdhPJxJwbu8iY+tc9pGN8mVVglhk2G2H0FW7yx4D1yhr8aKg9iYXjt8VYR83aelksWsgUTMGgT+uw==
X-Received: by 2002:a63:8b4c:: with SMTP id j73mr5546970pge.209.1592386544821;
        Wed, 17 Jun 2020 02:35:44 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:40b:ccca:8c2b:e6b:e670:4483])
        by smtp.gmail.com with ESMTPSA id x14sm19752011pfq.80.2020.06.17.02.35.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:35:44 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:03:28 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [GSOC] Blog about weeks 1, 2
Message-ID: <20200617093328.GA1327@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

Apologies on missing out on first week's blog post article. Here's an
post detailing the first two weeks of work that I have done, a bit of
problems I had faced and what's next.

https://abhishekkumar2718.github.io/programming/2020/06/14/gsoc-weeks-1-2.html

I am not good at writing subjectively, so there could have been other
things that I probably should have talked about.

All feedbacks and suggestions are welcome!

Thanks
Abhishek Kumar
