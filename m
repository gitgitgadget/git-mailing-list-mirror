From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/41] Add and use error_errno() and warning_errno()
Date: Sun,  8 May 2016 16:47:20 +0700
Message-ID: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:49:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKK-0007vq-Db
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbcEHJsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 05:48:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35210 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHJsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:48:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so16136538pfr.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dUnSV7gE4pW2cSnu7/Tc5Fc18ugnBF6vq4Iv/lfBf4=;
        b=SXe3wU3yHxx+mr5JDuDVb4gzp/V/qpSUAgzfIsipHChHyvbBXhka3TO6/7VMxlo4o2
         kZ5ThMx56JMK8XPDWBujwDfbOHUWQaEC4vpgB3CECCHV3zY4ZeXHd1yRTy2wnWGtaEwf
         wkw3je9hN416VynKroHvBIKAH2Q8ewz+yb9AU1SgsepJZ398aRUX2jDM47k88StYQ6Iu
         3r+xvbc0Us67HZl7QohGZ9P+KiIUxCm+CQL+G1F+9baPTdGHNZdxDD/51U0dnk7Lxnyh
         oJKgKcI8j1x/OaYfFJATPVkIUgRAuUiVvAw/qoNfK++yzQvn9nKruetRCfByYki1TzGo
         nX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dUnSV7gE4pW2cSnu7/Tc5Fc18ugnBF6vq4Iv/lfBf4=;
        b=cYjz0xXYsMQPZYGavfXgTjMfdaEnKvkF96SQkUWPfjv7mS6SUwog9ZrnK1YOAeU0w6
         q9r269Licrb2ca0ByW7gM8N7/s2+XxRVQBJcJbl9wHh2X9W4sOhu1+uu3mUsL/YqoCxc
         9FC5EKshsvkvcqbjlrBJ0Qnf+o7VLW7hyxbdTWaDw94A1IGheWDrHkPlFzxMJ6LZqC0w
         18+Nugn1uB0EZ8sH49/4e92+P0M0D22Tf8At3adiSxm6MVSMrSvRaR2cHi8B8GGdKsAB
         SIfnoi+1lexaTHjKmKsYaSsc6ofmiU7XuZqMN2fHvtOzUKJzrJw88RFFaXx3Xer8JUZA
         bJMw==
X-Gm-Message-State: AOPr4FWyy+aqvJPFZM+QE2lNqL2dlxtrB1bV2Y3bdeRdIPQVwtwQmkQrplT63jcn8ZLqpg==
X-Received: by 10.98.6.4 with SMTP id 4mr42067847pfg.8.1462700910414;
        Sun, 08 May 2016 02:48:30 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id b27sm32702665pfc.74.2016.05.08.02.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:48:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:48:28 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293919>

Code changes compared to v2 is below (one incorrect conversion
reverted, two error message improvements). Other changes are text in
these commits, not shown as diff in this mail:

  [06/41] builtin/fetch.c: use error_errno()
  [08/41] builtin/mailsplit.c: use error_errno()
  [09/41] builtin/merge-file.c: use error_errno()
  [11/41] builtin/rm.c: use warning_errno()
  [14/41] builtin/worktree.c: use error_errno()
  [27/41] grep.c: use error_errno()

I didn't mention string format changes (e.g. from "abc (error)" to
"abc: error") in the commit messages though.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e18e190..1145747 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2018,7 +2018,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		ret = pthread_create(&p[i].thread, NULL,
 				     threaded_find_deltas, &p[i]);
 		if (ret)
-			die_errno("unable to create thread");
+			die("unable to create thread: %s", strerror(ret));
 		active_threads++;
 	}
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 13b9639..fd47d20 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -152,7 +152,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT && errno != ENOTDIR)
-				warning_errno("'%s'", ce->name);
+				warning_errno(_("failed to stat '%s'"), ce->name);
 			/* It already vanished from the working tree */
 			continue;
 		}
diff --git a/grep.c b/grep.c
index 4f3779a..ec6f7ff 100644
--- a/grep.c
+++ b/grep.c
@@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_source *gs)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno != ENOENT)
-			error_errno("'%s'", filename);
+			error_errno(_("failed to stat '%s'"), filename);
 		return -1;
 	}
 	if (!S_ISREG(st.st_mode))
