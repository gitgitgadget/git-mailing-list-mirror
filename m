Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8DEC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD482072C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 15:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXo9AMkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgJ2PJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2PJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 11:09:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C4C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 08:09:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p93so3387653edd.7
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rovQjSzRVa5IWEbLAzgJBHsAGejmOgnVyfEHCwv7gGM=;
        b=EXo9AMkgFKgL2tDcoyWopupUmVlGrc+fcxB3NasqhormW5txarSSsOdqC6GZCm8viy
         N44EE7ihvyTukah3L47csyI305OmFvR41kaDE9E3E+mCpBJdh5y20QfRLkGLQ/P/ZP3O
         D2JFrN7Vkb8awcNVvBRcIDV5KmDxheeBH2+CRtTn6kNeWZrnRsPVeFxPVKy5Gy8DRU4O
         2ZFKG1xoy7+9DV7QQ1pP/mVgn25buy0GX4JHsG2qM9JKaTdOCJ90Mm0i8/FQeiEFk2y+
         PJwLY6dhqXaooUlJIDsz8SzKeVOJWAkbmcqXvJhKvDVw0Yy//bJByQjFK0p9t/LBHrjm
         SZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rovQjSzRVa5IWEbLAzgJBHsAGejmOgnVyfEHCwv7gGM=;
        b=FVRjtItBCgXkv8N2VHeu382ZmpeQN9m36JRlSOnXPNXDVCYO+1l4YsUj1uCud/ix1U
         PB8GFkjCwfojPwgZUQzpZIm6SBL3qJxh7/JkAqZ72rH/vlUmJjInIeqlU6xlEzKDf6yW
         OcdRsPBaey67DT+lL0/0s6AliHhm4wDP3ZiHq2Ae1hQlT7+zrfmy6djiIBZQnRDhS3gI
         mtp7I+xi+z5/24ovZKGKbBhCd6YziApHVAJYs/wz4Qgqp9eyD8fACWBUTaaQYw2JOds9
         iDRjBkkFKa2RQt/rH0DPcJfdTKzK5ZkGvV6JdJQOWxTDe+4lcdmemkomItZD+UBCVPh7
         CUYQ==
X-Gm-Message-State: AOAM532pvgjPzS6T4A48LDX/NjT4Q3Fxq9Dlj+ahSHnhBhpUgE67qRTY
        a2bHWOQo7SmHwEn5ETm5EK0=
X-Google-Smtp-Source: ABdhPJwlqTkpMo42l6G5suxe8X0YU4GyS+vyhQ3Npu9Rc+3eyACwvu8cjnKr33nJLBDE+S+wcl2KJA==
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr4380354edv.264.1603984159143;
        Thu, 29 Oct 2020 08:09:19 -0700 (PDT)
Received: from partizan.lan ([46.98.122.18])
        by smtp.gmail.com with ESMTPSA id a10sm1645580edu.78.2020.10.29.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:09:18 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     marcnarc@xiplink.com
Cc:     git@vger.kernel.org, Serg Tereshchenko <serg.partizan@gmail.com>
Subject: Reply
Date:   Thu, 29 Oct 2020 17:09:14 +0200
Message-Id: <20201029150914.72973-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
References: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--
Regards,
Serg Tereshchenko
