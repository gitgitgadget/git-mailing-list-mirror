From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/3] wrapper: add xgetcwd()
Date: Sun, 20 Jul 2014 13:21:36 +0200
Message-ID: <53CBA640.1010601@web.de>
References: <53CBA59C.8050901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 13:22:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8pBt-0002Nz-BY
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 13:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaGTLWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 07:22:00 -0400
Received: from mout.web.de ([212.227.15.3]:53009 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbaGTLWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 07:22:00 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MfCyA-1Wsy3q20h0-00Ooqr; Sun, 20 Jul 2014 13:21:56
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CBA59C.8050901@web.de>
X-Provags-ID: V03:K0:GYqOfmDJ4/ox4kxCE0sXuearBJZCFlyuzRIHMXjQ9os+SNuvf/8
 Qc6aOJh5zzfS14hjiyb6EFVOKEAFjAN81/fE03XDfEqVSn7mPdDVAxY776hzcLfhLnfLYjF
 1/t+lkrDa/0pWWnRf+oIiGBH5bbfh7XrF+G1HEaeJcbUyQLw4aqUcCdvqoQqZOTNg1Lv6GT
 9XDsBUhZfegwYgMrQULgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253917>

Add the helper function xgetcwd(), which returns the current directory
or dies.  The returned string has to be free()d after use.

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
index bc1bfb8..e297fa9 100644
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
+	if (strbuf_add_cwd(&sb))
+		die_errno("unable to get current working directory");
+	return strbuf_detach(&sb, NULL);
+}
-- 
2.0.2
