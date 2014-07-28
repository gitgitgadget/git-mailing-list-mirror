From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 06/10] wrapper: add xgetcwd()
Date: Mon, 28 Jul 2014 20:29:50 +0200
Message-ID: <53D6969E.1070202@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpgZ-00040x-DD
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbaG1SaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:30:05 -0400
Received: from mout.web.de ([212.227.17.12]:53529 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbaG1S3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:29:55 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Meje0-1Ws5tn1BTk-00ODcx; Mon, 28 Jul 2014 20:29:51
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:MpMauL9IKF4WfHU/S/3Ip2Zxo703D7nLcBT+wMlociYjB6qoV6z
 ArlUHt71vxc5Om/kCRgNz04LjhmRA7TZ3o8IQ77QnIp62ar6fbK9RDDJChpjNuQgkP10lui
 Ww6DBWqcZr+P3RZ5OEcsJjwh+dOYu68cPLrLRJLmcgRwKo0yKxoXoI5Ebp7LdI32BJII0Ue
 HFG+gwsC9Y9clylNVhiFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254338>

Add the helper function xgetcwd(), which returns the current directory
or dies.  The returned string has to be free()d after use.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 1 +
 wrapper.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 26e92f1..4d6edea 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -607,6 +607,7 @@ extern int xmkstemp(char *template);
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
