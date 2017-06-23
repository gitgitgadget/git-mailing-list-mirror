Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEF02082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbdFWB3n (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:43 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35535 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbdFWB3f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:35 -0400
Received: by mail-pg0-f52.google.com with SMTP id 132so15005548pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Feg6AGSBK9ro7axVhRnsLylAXB/QThwEuckCu8tOpNA=;
        b=MuyGMbqFIiDAfp1boBS/Y7X4fIcTR8qHJYwn0YrwIuRajtd4XpgHIeGM8/1hyIdgJH
         288ij5LIGWiGVbpumGMyOzYQRzLDAhgIP9CWClHaGjrfydsYIuqb9GspQk6hRVTlUiDM
         2c0MPRR2/TWaB1xe4Wf/Z7M8whh1WOI01UBT3suw9lsA+GAN4KMjpWBKW7Bg+CtAmtyh
         fsVjdUw9qvPRhh3QKD/93LfB5JZQBj4iAjGW+iqUUcdY/8OCii6YvCzRLRS073Qq0wex
         HOmwHoIPz+FMWCaBFzJ+IMT2E2RNWGx6JE9HieY4PZGD0BQzJyqdIYYw9SPUgmHHwLN1
         sH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Feg6AGSBK9ro7axVhRnsLylAXB/QThwEuckCu8tOpNA=;
        b=MdchRIqt8j/MAHW7BDawtD2amj5Nolq7TKh6pq6NALy1z1/VGz7mEIRgAcxahmZvuC
         bVzHpMmfpL+VLv44ndC0e67CSXZoM55bwbA67joyGFtWPK6y74vCLXDiU69CFu38hwje
         vb7NRTTsVmR7/UIK06ii/xEMIvb9WngDp//q8XGp0S5NK8jbQuYOufiTNKZoYLSClwRd
         8QWE1qNHY9khnyzh5sIPw1X+Pv/LAaMxvA38ajGaNMNC++iv5zsfkrmFxiIPPPHPMiX5
         MWfrV59u7W9GAkm+0M3iHcP/WkpNU2x4jnVggGLeJjcrm54BosdCSjYE8eISMMOyAeeY
         L7rw==
X-Gm-Message-State: AKS2vOwCoRJwZBz7tY5apKhxE9C7m7nQlJhAfdNt10Uv5HVCXIMW64Lh
        TB9RRKzeV0mdGTRm
X-Received: by 10.98.211.89 with SMTP id q86mr5534467pfg.37.1498181374886;
        Thu, 22 Jun 2017 18:29:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id t11sm6184722pfl.3.2017.06.22.18.29.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 05/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
Date:   Thu, 22 Jun 2017 18:28:59 -0700
Message-Id: <20170623012919.28693-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 2257d44e2c..c550f75195 100644
--- a/diff.c
+++ b/diff.c
@@ -560,13 +560,20 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_CONTEXT_MARKER:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		break;
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
 			diff_line_prefix(o),
@@ -661,7 +668,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_diff_symbol(ecbdata->opt,
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
-- 
2.12.2.575.gb14f27f917

