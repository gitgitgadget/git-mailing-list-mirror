Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF2FC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 11:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiBWLyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiBWLyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 06:54:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F897BB1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:54:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d187so15081002pfa.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+meiwIx1mBwrW0tUcEm4F6+u+dV2yAd2DFwji2PEh4=;
        b=YzPV37xR1RqiSOMyZ2UWRlB2MQvJCfulzuoZSaQIu8bytcCpiFfYUhdb8ykOg36vOO
         fkdkAe7EYhLK4h8CB6Px8cJqrNFrUOq41q8CE/FBhbiuvGRag/csLk87tbWcxm1sh0Yu
         Xc3rw7CeBFj9ZBGh8YEC2t0EaOwHvs2hWWy+gJO3V6P3ii6+R2+GU263AUIjiukZp4Z1
         7HR+IMhQ2cTX7BQi63+L63HaWzWzMDSccOq9W/sUAei8NotlHvamRN4T8kHnT0Eq/nOR
         s9Oh4bZ8cxtZK3aW5Ql7EkEKZCU+1Yb9ID8jXkvl1u4iXpqesnHfRrt6YoZAF6bOactV
         tZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+meiwIx1mBwrW0tUcEm4F6+u+dV2yAd2DFwji2PEh4=;
        b=Qw2p7d9NK+EKEOARZYQkcbpcC5DAg4aC4ThVu72jp2RO2mbHONEaTCXZyJ1miJGvwm
         NCnfdIUuIYofZfJJNDytj8tZArws6OdhYWhwmbXKfnewV9lZmYLLb84JRE/EZgZ964f6
         JSUzzx0lSB2TuWAbNNz1YKsuLnw0pVZQtGbZGi1+1dliwFAP46u4vynJAthSauS2CsNl
         9/MU5fMtkytSQFSvrEDjF2a14Fc46SYRaA6qxYhxCs38iLHsn5CSMmq+DJs+ZyDAcBim
         nY3W8dfDfO/k2ucJh7INnP7/Pe8h62ta5epRoJHg7S5Y8zBZ5L/PiwncTtAZn9dIaq28
         hvjA==
X-Gm-Message-State: AOAM532lz1sT0bKOJxM6GqhoLj86nl2tpeX7+OWr3y5auw430TPyLbkr
        IpHGH502bB6g796kaiX6VlC/IdGSY3zLBmS5XnE=
X-Google-Smtp-Source: ABdhPJw9DX2msx66+Sxu9UpOo5q80d0RFvIoBoYqNO+CH36/drLeeKX1l/nZamp/SHIgD2ig0hfbcg==
X-Received: by 2002:a63:30c:0:b0:373:a611:b010 with SMTP id 12-20020a63030c000000b00373a611b010mr23250077pgd.167.1645617243432;
        Wed, 23 Feb 2022 03:54:03 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.99])
        by smtp.gmail.com with ESMTPSA id rm6sm2728578pjb.52.2022.02.23.03.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 03:54:02 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, derrickstolee@github.com, avarab@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v2 0/2] avoid pipes with Git on LHS
Date:   Wed, 23 Feb 2022 17:23:45 +0530
Message-Id: <20220223115347.3083-1-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222114313.14921-1-shivam828787@gmail.com>
References: <20220222114313.14921-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fixed commit messages and endline after '&&' formatting from previous
version.

Shubham Mishra (2):
  t0001: avoid pipes with Git on LHS
  t0003: avoid pipes with Git on LHS

 t/t0001-init.sh       | 6 ++++--
 t/t0003-attributes.sh | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  620a5b991f = 1:  620a5b991f t0001: avoid pipes with Git on LHS
2:  c17d49d802 = 2:  c17d49d802 t0003: avoid pipes with Git on LHS
-- 
2.25.1

