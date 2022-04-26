Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26AEC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351735AbiDZSex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351550AbiDZSei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 14:34:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169622982C
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 11:31:30 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e2442907a1so20271129fac.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwxKc1W0AFhbDINI9SZTzOrGpP2Kx1WLv4dZvmznkw4=;
        b=Rjil6qJQsRf3Hy/8xZXpscDPkul7XIJ4YLfSIqifTSli1mEIzdQQUuSOiQAnF6sGEU
         +nkXTpf99YmPyHO3ejHlpUgerTcoYwcfK4a/3hsVzeOMMoPHsB/nDS8HxywjoqA+OkO4
         cvNlj3CA/VJg67S3MVruHEn1g5jtZixeQfE8xg4+OnrrViOFh8MzK1/Pr881l4AYS8vY
         U0eoZEpctokzzZSQQB+15DB4ztk004PS9PQaoDnHu7o1u5e44xcF1nJvIfMIKjVw9KUY
         xrf0pdAXMSZ/oEQkUMkwXw765gbgWXsUhoyPT5cjLs08xJeKFK7eVMpMLTXZTpsVj1b6
         sOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwxKc1W0AFhbDINI9SZTzOrGpP2Kx1WLv4dZvmznkw4=;
        b=i9Lh4zXIAYfOAZEtYXKBzW3T1eh4IoooU7dO783BdX1tn6FRjN6Y6trUKUBfV26xC+
         9Gdu1rsgkykiJ1UjEcE/qtudAPPRudrNodVVKy2cc8hT3CbVnQQwImR6jkGgysJE5XeY
         G8TdFnt8jEfX1YbUoqEx8Qt89Ai4VEuY1Y0phKkYNRfFrdyPYWANDojEEXLWzUjV/sJH
         ZCk+J1DarspQiS8LQNH9XgwXPIybO0dnygdendFKc6oNd1ZHn1eOisXQfga5qyBFOBg1
         DXHBTM0erK+066VRsK1X13gpyiRMCnEYrwxPVRFyoC1uqhPw+bZemG+df5V+iyVH8xog
         BpyA==
X-Gm-Message-State: AOAM531A6xVgu9lofS3ybc4O6vkYFEiXkpYMq/MrOrywnvnMCma3X8LX
        3AVmzfBGoGUK8sfux9gXyQTxrbgUD6c=
X-Google-Smtp-Source: ABdhPJxLZ0SVYFHSQcWDzsxQbuFFpoYF2jsRNqKrpzOOjazzOToqwty2U96OHxZgqm33yYueta/uyg==
X-Received: by 2002:a05:6870:a70f:b0:e2:a562:f476 with SMTP id g15-20020a056870a70f00b000e2a562f476mr10070298oam.29.1650997888519;
        Tue, 26 Apr 2022 11:31:28 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j17-20020a056808119100b00322e1b61907sm5152297oil.35.2022.04.26.11.31.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2022 11:31:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH] git-compat-util: avoid failing dir ownership checks if running priviledged
Date:   Tue, 26 Apr 2022 11:31:05 -0700
Message-Id: <20220426183105.99779-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bdc77d1d685 (Add a function to determine whether a path is owned by the
current user, 2022-03-02) checks for the effective uid of the running
process using geteuid() but didn't account for cases where that uid was
root (because git was invoked through sudo or doas) and the effetive id
that repositiry trusted for its config was different, therefore failing
the following common call:

  guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
  [sudo] password for guy:
  fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)

Attempt to detect those cases by using the environment variables that
those tools create to keep track of the original user id, and do the
ownership check using those instead.

This assumes the environment the user is running with after going
priviledged can't be tampered with, and also does the check only for
root to keep the most common case less complicated, but as a side effect
will miss cases where sudo (or an equivalent) was used to change to
another unpriviledged user.

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Sent as an RFC as it has been only lightly tested and because some of
the assumptions I have to make, made me unconfortable.

Ex, in order to make the atoi() calls safe, I was originally doing
is_digit(), but that would require this function to move further down
to work.

It is also now big enough that would make sense for it to move into
its own compat file and outside for git-compat-util.h, but if that is
done we might not keep the "root uid is not always 0" bits that seem
useful to have for the future.

getent() is not thread safe, so it might be worth to use an alternative
but that would require a bigger change.

IMHO it should have a test added, but not sure where it would fit.

Original discussion in :

  https://lore.kernel.org/git/4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de/

 git-compat-util.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..2ed97b47979 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -437,12 +437,34 @@ static inline int git_offset_1st_component(const char *path)
 #endif
 
 #ifndef is_path_owned_by_current_user
+
+#ifdef __TANDEM
+#define ROOT_UID 65535
+#else
+#define ROOT_UID 0
+#endif
+
 static inline int is_path_owned_by_current_uid(const char *path)
 {
 	struct stat st;
+	uid_t euid;
+
 	if (lstat(path, &st))
 		return 0;
-	return st.st_uid == geteuid();
+
+	euid = geteuid();
+	if (euid == ROOT_UID) {
+		/* we might have raised our priviledges with sudo or doas */
+		const char *real_uid = getenv("SUDO_UID");
+		if (real_uid && *real_uid)
+			euid = atoi(real_uid);
+		else {
+			real_uid = getenv("DOAS_UID");
+			if (real_uid && *real_uid)
+				euid = atoi(real_uid);
+		}
+	}
+	return st.st_uid == euid;
 }
 
 #define is_path_owned_by_current_user is_path_owned_by_current_uid
-- 
2.36.0.266.g59f845bde02

