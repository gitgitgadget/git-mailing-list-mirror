From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 31/40] environment: add set_index_file()
Date: Mon, 13 Jun 2016 18:09:33 +0200
Message-ID: <20160613160942.1806-32-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUS4-00042v-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424970AbcFMQK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36239 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id m124so16001693wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKHJhkhCanpH0yHdH5DYTw+B4laR/fF3RWF6M6P5HNo=;
        b=sro+hQNJuPQ7rriisyMtY84rWIuK/jvmAdj+FVXzc7fzQpQ2oNbltjr3ecGPKZoynC
         O1qRj6FtLv3W4SIoLZmUiubXwIKgx3os6PYq/DaFAspWXPaoP25wjv039CwPN+Z9FDmv
         VhwJe0dbF1uliuvP3h96CFIgU/iDsms9P6zP45ono3zKOk8Ov9uo65YFQQw0/gD/bVKP
         mGhCfw5lOrxCE+rVhBIu0ipISb5YpL6vS7Zb7L1x3T0FxBKoXVEpWDvgH3+xtcZtpJxW
         pv/1HcNWEsTn2hh+R+Rx3oCzpUrjIrUDXPJSW9VlleSEGFv/b57zAOcd7JBqntF0pCmQ
         b4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKHJhkhCanpH0yHdH5DYTw+B4laR/fF3RWF6M6P5HNo=;
        b=NgEbzYZwnakDhX6q88p28GkKY0PFUULwKs7gYekrohxobpxyYHyPP3gxn5OCk5H1WC
         hrXAcQYtCYNLLWEqGpGWC3Mnee6aSRGtzbZr7vM6yq43ZDYR3uwUUKMOwTuZx1iW05u0
         SDpxVoY9NFqL1/oWe0K9fG2AyFb5xI4YgR06UxJY2c6naDRfeogIvbxqavHcEmaWJPYx
         lb6bZcyLMIdNcCONAUmcVTKmIqGptoMEauqvM/M/A2Hl8hCU/neV8pKmFsXtYH101x1T
         lEDYXdwQz6faygACLBUr/Me/TS0DNbBABObvc+0fDMYRIaBtH/Kn3w1W2RlAV/yaghVF
         541Q==
X-Gm-Message-State: ALyK8tKu4zFmEbIgnV7o2cjUsXp9N7d+O79/xgmOpuJLJVWmkAGNSi7qJ4naw4syehtxTQ==
X-Received: by 10.194.79.226 with SMTP id m2mr580872wjx.130.1465834250511;
        Mon, 13 Jun 2016 09:10:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:49 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297206>

Introduce set_index_file() to be able to temporarily change the index file.

It should be used like this:

    /* Save current index file */
    old_index_file = get_index_file();
    set_index_file((char *)tmp_index_file);

    /* Do stuff that will use tmp_index_file as the index file */
    ...

    /* When finished reset the index file */
    set_index_file(old_index_file);

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |  1 +
 environment.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index 81d4ac3..28fc0bf 100644
--- a/cache.h
+++ b/cache.h
@@ -461,6 +461,7 @@ extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
+extern void set_index_file(char *index_file);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
diff --git a/environment.c b/environment.c
index ca72464..7a53799 100644
--- a/environment.c
+++ b/environment.c
@@ -292,6 +292,16 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
+/*
+ * Temporarily change the index file.
+ * Please save the current index file using get_index_file() before changing
+ * the index file. And when finished, reset it to the saved value.
+ */
+void set_index_file(char *index_file)
+{
+	git_index_file = index_file;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
2.9.0.rc2.411.g3e2ca28
