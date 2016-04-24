From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 27/83] builtin/apply: move 'read_stdin' global into cmd_apply()
Date: Sun, 24 Apr 2016 15:33:27 +0200
Message-ID: <1461504863-15946-28-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEr-0000wH-F7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbcDXNf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:29 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38336 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbcDXNfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so89931439wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CsBTuGSvQ8l6XYH84lClpIqY5lmMEYGwl8OnCNtxkvM=;
        b=VRTLOh5n5K90IPIxsCJU3NsZaUcK8erwoimCS+uPRu2dJ6aFaYan1XTVgszAPk2wmx
         SydAIcXH/45w4WDu153f364+EEk3JY+CIzMYK/16ZFVnSNj6d48PjaqZfnlfpoPLxx6M
         6DyHsWRIbCAsVhA4jsWRxHIfJdb0JEaoVERzuyrhQ56yLLF5YSMeEVJrKcgxL+sbdKwA
         BgxeHWqFZz0U5+YTiONvaj4qrSgc6O1Jcs9hAsJovryUpFOT5mh6wdjlRlXWgICJ3+Oz
         ANf3/CZxwmu3Jpzns+cFYLBUBAFGlShnU3RSUnkS5xaMME/KNWjWVZHIlwiNgV15j7fd
         tkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CsBTuGSvQ8l6XYH84lClpIqY5lmMEYGwl8OnCNtxkvM=;
        b=a5cW+TIHIXbCcoGiIm5nmjVzwmx2whoq8gIsplG0ePHTElnOfqnWAdj2iM9OPZCsh3
         qEV/Ti/kQszuOXtFFuoYIIAarKslm8rmri3pBvjj6zRvu0+Az5/MGuIQDjY35gxUfZ/3
         3imTaAqqlLD0WHYv+5LFN7D9em1uTZbX5BC0hEafSNNdXsrd3p20ZvheRXmBkikvdaI8
         FUPw34yPnPl5TNI3FM2U55f4UB2bla+pr8SIzeWAV32BGF1tu0oY/s1sOnfDlOBnQdLn
         X0uqR0Y479M8agXf/Vy0TSzqDQrNytnIJkPiwfjzVNDNxKfldTutWrutcm5iGgkcnMR4
         xDag==
X-Gm-Message-State: AOPr4FXPl9vcGVUMTL+YgHd6uPMcOmf9WhtLFxaRDdzcuviTegOj+qG1OXgbKgqBTSle6w==
X-Received: by 10.28.170.194 with SMTP id t185mr7112455wme.91.1461504923093;
        Sun, 24 Apr 2016 06:35:23 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:22 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292386>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 699cabf..be237d1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -96,7 +96,6 @@ static enum ws_ignore {
 
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
-static int read_stdin = 1;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4586,6 +4585,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
+	int read_stdin = 1;
 	struct apply_state state;
 
 	const char *whitespace_option = NULL;
-- 
2.8.1.300.g5fed0c0
