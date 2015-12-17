From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] Porting resolve_relative_url from shell to C
Date: Wed, 16 Dec 2015 16:26:38 -0800
Message-ID: <1450311999-3992-1-git-send-email-sbeller@google.com>
References: <1449709654-30189-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jens.lehmann@web.de, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 01:26:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9MPC-00084J-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 01:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbbLQA0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 19:26:45 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36145 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbLQA0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 19:26:43 -0500
Received: by mail-pf0-f170.google.com with SMTP id o64so20486737pfb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CXS5PF/C6LDWnwOg3JWzsS/zPkZoeHNYEdQbxXm7XyY=;
        b=g8QNS9d46nT8pjDtsvJA7/GoUSlu8yWu/wcgkUJpKfIaLS/sMeXOZA/LjUCJlxJtLX
         vJVzETJ5Up41DrXwcs+IqnQHK48/ExC8S3i6z2nkknswVqwvNv5KDTcyg4ENx6gLJmVw
         c1IYNRpL8+bBNSakl/+Gumy1XyIT32Y9zw1P/xG603Nt2bQdl6gVGDZ2PituKQcWdLdT
         WvI615KMIPqMwjsg9WFA2k4yn1OeTiMNFIoP8V+H6JNJTgBMpFpHfGmWN/JvCjldmpX1
         eO3bXln7OpJJcIOXqP4Oo01PuW4Qf5fpeFzHVq2zGiTQyK+2TTTOyHTlZmfgPCse9rE5
         XYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CXS5PF/C6LDWnwOg3JWzsS/zPkZoeHNYEdQbxXm7XyY=;
        b=h8XSTua3X88M1AYYqhapVw7ASeYvXaHupgWOexSdO6tpEWl9nyIM/CBLWlbhk5aEfy
         QwQrLmzdIXbSbPnUBLtBSi80tfwLmohFf8ckKX2LYy1LLGqk5gtU38LOUHladeNVFrI1
         SsvL4eg+blg/I+D70oKBixBwEMW2KaGZ358oLKmf/Cdzc2JP9popLs4+1Mb8oTg2wDhF
         uF4qt2J8/SfKKHpe+IXEJnvs5Dj511u3yiw7HYMo7R4Dcs5/lKyUPD7o4X2e/9HzWJQf
         vYkpRx9O4TZSJyvIC/VVB8qo2yIv3S5ITLyHA6pvOV7maLt56TTDP+NDWxx+xYivkbtv
         OonA==
X-Gm-Message-State: ALoCoQnKcWLtvNCucN+S8lQISEz4WPXhixUd4ii8OIxC1ldxthBemBfDJoZDJjroHHCM3dBtflnhWNLqWwuNWnzjXUOQ1OY+mA==
X-Received: by 10.98.18.155 with SMTP id 27mr10008854pfs.91.1450312003285;
        Wed, 16 Dec 2015 16:26:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b866:3ab5:f751:fa9b])
        by smtp.gmail.com with ESMTPSA id k15sm7170087pfb.37.2015.12.16.16.26.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 16:26:42 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.2.gfc39790.dirty
In-Reply-To: <1449709654-30189-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282626>

A new version of the patch, which spells out more its intent and
may actually work in Windows.

Any comment welcome,
Thanks,
Stefan

Stefan Beller (1):
  submodule: Port resolve_relative_url from shell to C

 builtin/submodule--helper.c | 151 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  81 ++----------------------
 2 files changed, 155 insertions(+), 77 deletions(-)

interdiff to previous version:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f48b5b5..b925bed 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -31,6 +31,36 @@ static const char *get_default_remote(void)
 		return xstrdup(dest);
 }
 
+static int has_same_dir_prefix(const char *str, const char **out)
+{
+#ifdef GIT_WINDOWS_NATIVE
+	return skip_prefix(str, "./", out)
+		|| skip_prefix(str, ".\\", out);
+#else
+	return skip_prefix(str, "./", out);
+#endif
+}
+
+static int has_upper_dir_prefix(const char *str, const char **out)
+{
+#ifdef GIT_WINDOWS_NATIVE
+	return skip_prefix(str, "../", out)
+		|| skip_prefix(str, "..\\", out);
+#else
+	return skip_prefix(str, "../", out);
+#endif
+}
+
+static char *last_dir_separator(const char *str)
+{
+#ifdef GIT_WINDOWS_NATIVE
+	return strrchr(str, "/")
+		|| strrchr(str, "\\");
+#else
+	return strrchr(str, '/');
+#endif
+}
+
 /*
  * The function takes at most 2 arguments. The first argument is the
  * URL that navigates to the submodule origin repo. When relative, this URL
@@ -64,13 +94,14 @@ static const char *relative_url(const char *url, const char *up_path)
 		/* the repository is its own authoritative upstream */
 		remoteurl = xgetcwd();
 
-	if (strip_suffix(remoteurl, "/", &len))
+	len = strlen(remoteurl);
+	if (is_dir_sep(remoteurl[len]))
 		remoteurl[len] = '\0';
 
-	if (strchr(remoteurl, ':') || skip_prefix(remoteurl, "/", &out))
+	if (strchr(remoteurl, ':') || is_dir_sep(*remoteurl))
 		is_relative = 0;
-	else if (skip_prefix(remoteurl, "./", &out) ||
-		    skip_prefix(remoteurl, "../", &out))
+	else if (has_same_dir_prefix(remoteurl, &out) ||
+		    has_upper_dir_prefix(remoteurl, &out))
 		is_relative = 1;
 	else {
 		is_relative = 1;
@@ -80,11 +111,11 @@ static const char *relative_url(const char *url, const char *up_path)
 	}
 
 	while (url) {
-		if (skip_prefix(url, "../", &out)) {
+		if (has_upper_dir_prefix(url, &out)) {
 			char *rfind;
 			url = out;
 
-			rfind = strrchr(remoteurl, '/');
+			rfind = last_dir_separator(remoteurl);
 			if (rfind)
 				*rfind = '\0';
 			else {
@@ -99,7 +130,7 @@ static const char *relative_url(const char *url, const char *up_path)
 						remoteurl = ".";
 				}
 			}
-		} else if (skip_prefix(url, "./", &out))
+		} else if (has_same_dir_prefix(url, &out))
 			url = out;
 		else
 			break;
@@ -107,7 +138,7 @@ static const char *relative_url(const char *url, const char *up_path)
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
 
-	if (!skip_prefix(sb.buf, "./", &out))
+	if (!has_same_dir_prefix(sb.buf, &out))
 		out = sb.buf;
 	out = xstrdup(out);
 

-- 
2.7.0.rc1.2.gfc39790.dirty
