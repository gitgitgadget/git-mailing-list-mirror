From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 32/44] environment: add set_index_file()
Date: Fri, 10 Jun 2016 22:11:06 +0200
Message-ID: <20160610201118.13813-33-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSo5-0004KE-G6
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbcFJUNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34529 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbcFJUMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so1057610wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vnEN3jO51x96VKwvufs/j8RLEORMg+cT6CY/rgnWmqg=;
        b=ZsiKh0z5SuRe27tlASrq/74/ePXrROrRlGOvCly+x9BigOJfbzyBlwQUMvHJmD2pbH
         fzUEBDjqoNG0UruRTrq6wQJg7i15N8xlX0mC/n6PQrArkyS2HJ8FZHSXI+xsGeDZTNnt
         26CX9IyQDaJ81wFsAS11NApl/ILy8eJUl9+/Hvs6kQs3Q8JCYTAqCo+EaBLNfjc1E9OW
         M/5/r01GB8FMbBfGEwStDu7GOX/KUXUbtK/Vw1qb6CBV6twlJdM20iIfQSzEc+ezDUIr
         WcYCPTJzOkv7T13xiDTSxG647WcpL8Xa7LipHcMjRtLahBmScWthiAGRDcODXrVojlgE
         tUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vnEN3jO51x96VKwvufs/j8RLEORMg+cT6CY/rgnWmqg=;
        b=atcGY8/S1p+MKVhcDX/OBocGL+1Y3hmbZfke8LuTBr1zUELsfxCqmzvM4e9F7CxSbR
         6Hk+YK/zCZ4wQWSqL012j2RHq9RDVOrbopm6a1n0CrXwKCKeunl35YJqVrilZ1rZwwnH
         wmaBnW7yzFhA65B64z27czXVc2l/NJ/YrLRN1xol9Q45z1aoQJk7K8ATsvPyKnZEgqNF
         j9Cs0mVSUnuT7o0NIunI3l66KsJ/WC9rcE+NdbOnQBdidZS0nHHU4k2+m1VuwatPGioE
         navLjP2Plvx6t2umGfCm2P4caQq8B4GDKePmKDPEu5FsDaog9HgeUnf+dw6ulpb5a1QB
         +RIA==
X-Gm-Message-State: ALyK8tIfWbDtt7QOl8v38qwG5a+mTxxIx/AY0tIc/dEuD2uTMSOhyUFxweFGfll+7Gf37g==
X-Received: by 10.28.209.13 with SMTP id i13mr660807wmg.93.1465589554675;
        Fri, 10 Jun 2016 13:12:34 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:33 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297057>

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
2.9.0.rc2.362.g3cd93d0
