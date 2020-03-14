Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C73C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 04:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E697820722
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 04:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSE+5tz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCOEZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:25:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37199 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgCOEZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 00:25:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so17054678wre.4
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 21:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pNTZUDjJPBSKm8DnqvbjiMFhIXpHTgA3IEGTERjokJ4=;
        b=fSE+5tz6rtk2NKwAR39b5YZ4uPIs4fXzQFbmADjVsAknKUtcrGBatnVwQeJ+ZwX176
         2L7cOpJKV4kmaQUSJkIBcNA8A7xE0Sf0oBo9LbuLXNy/2IkYsLbrq7QI84H9GZ9MORPm
         VV7T7HDa+uF/Bl3Uen99ikjaOCf1wjNjLZ1JHn0EofbOXuqjPiN0OiK7VudnrWtRGoZ7
         WSIQs/gQwYQWcF340qrFjD48rRSgv2G8VweEADlplLYSop+0hnaUugX3CgUWGD5FUbJZ
         QbW4icDoQL5tanyoWeXkKPQlIVKgRvbFLxzHfFqJHRCIpHeqnoor5G4huKqw5INx2nJh
         wceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pNTZUDjJPBSKm8DnqvbjiMFhIXpHTgA3IEGTERjokJ4=;
        b=eqmvssnkDeh01WQme4zJYa1NvoEGL02JqptzE4K/9VS1hA94Bt1UNVNdodr+2iUjNw
         pKVcz8ikU7THOgGTDeo1H6yRjjP4SSySubYTXrOprBxEnBKydsn75lQhWLCdR6JmWMP7
         S1y0yC95z53jgqR3QfqHRKhDg0QpHnvXIpKCC/JmoZH7bESsKdswniwJMiJIG8Fn43na
         b7SBM1Q64i8TECBR5239I2dQrZdRaWUclXpqwDXnlIOu3+hAw/iidBjhQZIWZ2A+Cc+R
         5/+/IN2O1EYHes/GKXZafoAM63nrjoJhQMcooeZSXW2fRJHCRxMZN6V7OQIc4EJ324JS
         vDcg==
X-Gm-Message-State: ANhLgQ3AWouFTpqIod7Z3oENAg59K8LUj98UYMowB2k0oRn3en4j8OU7
        Y84VSil4ozSUZIM2yak7P5XADyju
X-Google-Smtp-Source: ADFU+vsJImX/OezvZGW1bGU8Ks9wne1GZIdWBPVtn4EM/aZLRyRyg/DsUD/Ok4OVy5VKQ1RVu0ssmw==
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr14478082ejb.166.1584169896299;
        Sat, 14 Mar 2020 00:11:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id aq2sm1702998ejc.9.2020.03.14.00.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:35 -0700 (PDT)
Message-Id: <b07fdab55aae88cf30d9be41b81414c0664e5c31.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:28 +0000
Subject: [PATCH 2/7] t1091: make some tests a little more defensive against
 failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 44a91205d60..8607a8e6d1a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -278,6 +278,7 @@ test_expect_success 'cone mode: add parent path' '
 '
 
 test_expect_success 'revert to old sparse-checkout on bad update' '
+	test_when_finished git -C repo sparse-checkout disable &&
 	test_when_finished git -C repo reset --hard &&
 	git -C repo sparse-checkout set deep &&
 	echo update >repo/deep/deeper2/a &&
@@ -328,6 +329,7 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 '
 
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
+	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
 	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
 	cat >expect <<-\EOF &&
-- 
gitgitgadget

