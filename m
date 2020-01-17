Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7576C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE81922522
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBZXc2Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgAQXiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:38:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38652 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgAQXiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 18:38:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so9204586wmc.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 15:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDuSkblCJphL+oSqg/pCp/OZntGmMPmOFoDEYJ1ONYw=;
        b=EBZXc2Yjfr4yZbGDwbLPiIr0ssVEvkowznmfzxhky0XH/ld/5D0P0A88+3dMIWaOUb
         M5M2vpHvBE1DxPqoC1PqNqPrzVFOMQ4wodtvZXIgJNYNM/dX5X6jxXL3QsX+kzgc0U9y
         gM94wxMClfAFvRaR9CzImauMVRpOKDMD9mWnsCi93jnixu4t9bnmQWL8UDJFpWmAP9aV
         xFAsB/5tQGnWgbxSxNTK8DkuuXKJ1RXAoGLzQzKgp3AsRibOx+5oN5l3xIK7wsSufls8
         u5IVkno8tAbyGKC9qMJkFpdsPVP7ZoyPlMUcEJmgMh1M9gcf0QniU+gdrIb/uOt4fBnt
         YGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDuSkblCJphL+oSqg/pCp/OZntGmMPmOFoDEYJ1ONYw=;
        b=hM78Y/iTuKtQx7CzT/uHA3Nc3E4kCOb3L/s7n/ZWItXlerJOpOsSJTWKdd3yIGk+78
         24RdHtJdR7+Cku/M6OEO1/HaO+NEj4Cm1+hIRCZ4K/H05OfDucxEMg6tO7PZV4k5ISlK
         ECBs9jkvSysfh+BVLpirYPoB274qVpX/EjwulrniboaG/AFRcbPLEifog72HyQaFUDKC
         zv36W7EcCc4AnMUPIivBGvg49sFhsDSO4AeKOLs8qsPoLbzs/UdYehWJSElhLu1robwd
         jmhVrtA09MBPyKXoOK7Fb1A8KvZyBqBx+VP+k/PEph9NR4lQmLyCoR0qiuW3RLIcmh76
         avQg==
X-Gm-Message-State: APjAAAXT85mTzOykv3aNX+bu4mVkad3iyUfbk50uWANTA5CSffgHQ4Aw
        JWdyQgEtuXVj2G1knqvcMRaFQdEO
X-Google-Smtp-Source: APXvYqzs86vZqXLgeC/9m+r2ItwGQcRCphRyVW5opvMSyBikFgo8odcvAwYmnVTT6wxYGVlKshLqcw==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr7312224wmj.189.1579304285696;
        Fri, 17 Jan 2020 15:38:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t190sm142911wmt.44.2020.01.17.15.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:38:05 -0800 (PST)
Message-Id: <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579304283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 23:38:01 +0000
Subject: [PATCH v2 1/3] parse_insn_line(): improve error message when parsing
 failed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the case that a `get_oid()` call failed, we showed some rather bogus
part of the line instead of the precise string we sent to said function.
That makes it rather hard for users to understand what is going wrong,
so let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..7c30dad59c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2118,6 +2118,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_oid(bol, &commit_oid);
+	if (status < 0)
+		error(_("could not parse '%s'"), bol); /* return later */
 	*end_of_object_name = saved;
 
 	bol = end_of_object_name + strspn(end_of_object_name, " \t");
@@ -2125,11 +2127,10 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	item->arg_len = (int)(eol - bol);
 
 	if (status < 0)
-		return error(_("could not parse '%.*s'"),
-			     (int)(end_of_object_name - bol), bol);
+		return status;
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
-	return !item->commit;
+	return item->commit ? 0 : -1;
 }
 
 int sequencer_get_last_command(struct repository *r, enum replay_action *action)
-- 
gitgitgadget

