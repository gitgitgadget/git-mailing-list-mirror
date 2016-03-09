From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 27/48] builtin/apply: move 'read_stdin' global into cmd_apply()
Date: Wed,  9 Mar 2016 18:48:55 +0100
Message-ID: <1457545756-20616-28-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIZ-0008Ga-GF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933748AbcCIRxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:24 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34336 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933733AbcCIRxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:13 -0500
Received: by mail-wm0-f47.google.com with SMTP id p65so203130997wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTXRhfQbfp1uEY3vLpDmexxMxfVGNHs2V/hBEBJ6PIM=;
        b=vkpRFOXzRRNDVbQWu5i2Vd8JOGeMs4qcB/lxB/EHMrS03BQAoOooFDT+7o1M4BpKWE
         syoc5j3TIqZCmjt0gq6V1FewF/kbrtWSrzD4PL1TrDuYvv4bhWxaNqaej8ng/Ii2dDR0
         /0Hts01mztpl6Y9+NW6mu6t0dp7pkvvJ+exPj4ww0psFkLx3tuGV87L5GpV6/fSOVVSI
         7BYSkh6L1Kax/xoXPpzTNC/FZ0/jJhfs57B52JQ+FGVkLVW6WGgGe01LEUzsu4O7kKZ9
         ML97dPehVvD0a0gDYmjZLH3QTArL0PKN6WzAY14ND8nP8/MUChP/bRx0oETkAdK59hvk
         K4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTXRhfQbfp1uEY3vLpDmexxMxfVGNHs2V/hBEBJ6PIM=;
        b=Kdz6AaLYuSvgd6xYC+gRtsRtrQkA4o+iAPxkM/mE3iqkpVxakqaeKEeltwlHY1xE2g
         5To3Pifo1n1k+O3spetpKt/U7PwZLqlCZxX+oB9LXwrQ+iiW9+g1OrdsthqHP5V1D7hn
         1Zkm0/jMqTSRwGxwZLbzq6/AZoo/8wS6UMLZykRhe0/QcySGEj9Ta7F+cIL6ggrV7RUj
         lUKP5v4Pivm4LzRgYteBQ5dz/W/++pshwcdcp/0RGLPVhXNyORH/MjnsLuun0eT7nOxk
         KEtQVqI/sHLKbus+zVUQSkFHqzbJIzlW/S7S0JmeN69zWpG915h0FvKBGY8viCYOAZBT
         hsEg==
X-Gm-Message-State: AD7BkJJzLRDwS/e5rckPby1FU3dc43yIWO943nmJAn8CKVPibcylPrij8EoDGCOmCzHPOw==
X-Received: by 10.28.176.200 with SMTP id z191mr338628wme.91.1457545991845;
        Wed, 09 Mar 2016 09:53:11 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:10 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288515>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6342b61..44fdb9d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -95,7 +95,6 @@ static enum ws_ignore {
 
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
-static int read_stdin = 1;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4583,6 +4582,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
+	int read_stdin = 1;
 	struct apply_state state;
 
 	const char *whitespace_option = NULL;
-- 
2.8.0.rc1.49.gca61272
