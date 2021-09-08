Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41CC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9C161157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhIHWSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhIHWSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:18:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65CC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 15:17:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a15so5323029iot.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGDSvYvc150kaOrOZO2v4d3Xihe6LQmxzAeQFCvv2DA=;
        b=Ri0uyWnpJ+3nywioqCRNQfV1BON0V5Ss3rGcZ2G/wH9fbCX0ErLnAIPYr9ZFMk7IAK
         adD649g5qGG42dcYmMc2YwPl8OpGAfeSb4AhIdQl3ljYIBqITxGVi8MHperd8sxz3/RO
         IPGbxhS1rD/JUhn9yIQaOmgkvLAYwMBWuUf/UKOJMiJPXIQwxCc5A4IPytDmiPUMrx9A
         2Y6/DjHR+Htlml4EipelMj+k7WzQperMsFICiDZ16NqZYPXvLpQ9xZuxpVVFyqFDFeh2
         uxwVLpI8CW47hiOzTA9Gt7cd3+X7ZlCB2xMo7t6JgIIdvZX4Pi50secIQde4bgO5M0KR
         LTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGDSvYvc150kaOrOZO2v4d3Xihe6LQmxzAeQFCvv2DA=;
        b=eZNSHtYiGXi6vBpsCjpQDr8Z6M1zlCAIDQLsk6gFK5bPpY57XY+0aj/vDjZJI8QQgZ
         zM+3FbG8l0eq2Tthhf6sAveFZCycTJXIANoxndCxg/dzaIp0K0k7A11xtdiiTgwY45ff
         ReaYX+ZwcD1fWBzKYXp11Q9Bavl924l3cJrIav3UeWFwhPza3LPudSBGvYak6BlqbY2J
         tvKrQ7JBrZfKCzK1xGBcDBAgx9Z/ay7HZepl0wlA7UtQ+OXGiX7EQ1o0YM5FPPuQ93Tl
         RaIFH8Q7WMjLzDiTLawkfsBtJDFx1SPmTCtKIGpZJE1+76WMeT+HS72YHtcNz5LBjj1h
         7GiA==
X-Gm-Message-State: AOAM531KCdWvw2JwzTo9Xlb34BRr9Dtlx8PGJBqXy31AgFIUxCsSo1+h
        t637jaAFuDy8l1gBUolHWQuxsAxn8Y8U8NEc
X-Google-Smtp-Source: ABdhPJzfBdKJGwu87ySfLvyXwhKQIo4R6RBGjUF42MyQa4UuF+R7sY0sl+WwJUy+OCJia6+ztdylDw==
X-Received: by 2002:a6b:fc17:: with SMTP id r23mr405860ioh.89.1631139445440;
        Wed, 08 Sep 2021 15:17:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e1sm187005ils.76.2021.09.08.15.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:17:25 -0700 (PDT)
Date:   Wed, 8 Sep 2021 18:17:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 3/3] builtin/index-pack.c: move `.idx` files into place
 last
Message-ID: <460b7b915157503df2ebef61f6863ed259586385.1631139433.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631139433.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous patch, fix the identical problem
in `git index-pack`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865..6ca47c5c03 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1517,14 +1517,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
 
-	if (final_index_name != curr_index_name) {
-		if (!final_index_name)
-			final_index_name = odb_pack_name(&index_name, hash, "idx");
-		if (finalize_object_file(curr_index_name, final_index_name))
-			die(_("cannot store index file"));
-	} else
-		chmod(final_index_name, 0444);
-
 	if (curr_rev_index_name) {
 		if (final_rev_index_name != curr_rev_index_name) {
 			if (!final_rev_index_name)
@@ -1535,6 +1527,14 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			chmod(final_rev_index_name, 0444);
 	}
 
+	if (final_index_name != curr_index_name) {
+		if (!final_index_name)
+			final_index_name = odb_pack_name(&index_name, hash, "idx");
+		if (finalize_object_file(curr_index_name, final_index_name))
+			die(_("cannot store index file"));
+	} else
+		chmod(final_index_name, 0444);
+
 	if (do_fsck_object) {
 		struct packed_git *p;
 		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
-- 
2.33.0.96.g73915697e6
