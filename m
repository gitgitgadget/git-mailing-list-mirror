From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 3/4] wrapper: add xgetcwd()
Date: Sun, 20 Jul 2014 18:50:33 +0200
Message-ID: <53CBF359.2040400@web.de>
References: <53CBF277.3090101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 18:51:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8uKR-00057H-71
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbaGTQvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 12:51:11 -0400
Received: from mout.web.de ([212.227.15.14]:58799 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863AbaGTQvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 12:51:10 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M2us2-1WISOR1Qco-00sgFb; Sun, 20 Jul 2014 18:50:53
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CBF277.3090101@web.de>
X-Provags-ID: V03:K0:Yh4Gg2S3gllKmli80oqd/NhVEo9zBov27NQKpL+X9O+y0x1mUgu
 +BDCqyiAhMhrrcid/HyXWfuFhfLuPdHn5CRzpC9MuJGdJB1CNsw55xIlzrhANWUl0m66Yc5
 0QJMa76W6zOzk0O1MYD6jdqMzp4oobuPeE8o7f3t4qmCaWazvlrWOPLJz7sFuK428F3REMh
 mWhmfT9DwWCReIZCu9DQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253933>

Add the helper function xgetcwd(), which returns the current directory
or dies.  The returned string has to be free()d after use.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 1 +
 wrapper.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 0b53c9a..d64d012 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -605,6 +605,7 @@ extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
+extern char *xgetcwd(void);
 
 static inline size_t xsize_t(off_t len)
 {
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..bd24cda 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -493,3 +493,11 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
+
+char *xgetcwd(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (strbuf_getcwd(&sb))
+		die_errno(_("unable to get current working directory"));
+	return strbuf_detach(&sb, NULL);
+}
-- 
2.0.2
