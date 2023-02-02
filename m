Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2EC63797
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBBJpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjBBJo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:44:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CD875AB
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so1092947wrg.13
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWcCaX2blm8nfgTGsiNz3wflSNtwAhgXBOFbIOfg37g=;
        b=Q/9qMKAF3Ih9rlH9eCZkTPjfD132SpHxlYPNuSbglrZBfsW/x+prtYj1/qNAq0Oaw7
         L3S4SjlfxMJ4Gt0Z1BO/EwOSntsPx+H/8dBQhDXW0LDxSDs1LQIGjb2q5Wm3l3aix1jL
         DPm7BmNyE1rrW82X+VBk4UEJDcKP5zTpkt+fWDhzlY+uxnSwveIIZBi2pz2rNTv4tdgV
         x0qIyTtW3nM0jFO+2SCCQHdbLwHKC6mbeNEHRH2DcO+yGqo6CvNdBUzJ4gaG3eEUv3KW
         CCSdgTpxNeUZiG5J1u91/jvMB3FLvO/b5pneAqrGffIQJE2vQfPpYqsXkh1HSjdSZo74
         vGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWcCaX2blm8nfgTGsiNz3wflSNtwAhgXBOFbIOfg37g=;
        b=ZEnnkwPejkowVGpsqADr4jW1xpBshI/a77RRslU4DATgpd0flbmApgOAGIgq7jNPqO
         TK7r5y401EQUEvOHRhY8jQvingqDi3WDNmVeg8cM6kV5NSOjQj4r+zA/OKOHzMTVbpFe
         WvbaEojZByhZRJiFJcV5dContOMNMl13WhxTy2/7frVAIOIf2FdG3etZJOPIwTJTBkkq
         piuDDihi5tZBRoNThAJq9+ggvlyvPp7mICghNxqXevDj6YVOgfM3mZElCoaHMpNsUstp
         fXLokIAwQacHDpQ1vTsU+GYK2thDXS0Uo63agnbC6KinZwBwAHG7tJb++YseZeszO9FH
         d3oQ==
X-Gm-Message-State: AO0yUKWnsd4U/R+Oexv57m060FbX66YSG8GnvP+d0j0ATTiQ4tQ8WfCT
        VKqfxd8MINF0WM22a+HG54KHGBio9hdt171x
X-Google-Smtp-Source: AK7set+/41GJ5KcQzaTcjlYqBtzKXbyAXesB/94dKxaThl5TTSC+EZlafltId+9U2q4OoY5aEdXscw==
X-Received: by 2002:a05:6000:10c3:b0:2bf:b113:8ae2 with SMTP id b3-20020a05600010c300b002bfb1138ae2mr5222497wrx.15.1675331063978;
        Thu, 02 Feb 2023 01:44:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] imap-send: note "auth_method", not "host" on auth method failure
Date:   Thu,  2 Feb 2023 10:44:12 +0100
Message-Id: <patch-v2-1.6-3187a643035-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix error reporting added in ae9c606ed22 (imap-send: support CRAM-MD5
authentication, 2010-02-15), the use of "srvc->host" here was
seemingly copy/pasted from other uses added in the same commit.

But here we're complaining about the "auth_method" being incorrect, so
let's note it, and not the hostname.

In a subsequent commit we'll alter other uses of "host" here after
getting rid of the non-tunnel OpenSSL codepath. This preparatory fix
makes that subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index a50af56b827..b7902babd4c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1121,7 +1121,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					goto bail;
 				}
 			} else {
-				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				fprintf(stderr, "Unknown authentication method:%s\n", srvc->auth_method);
 				goto bail;
 			}
 		} else {
-- 
2.39.1.1392.g63e6d408230

