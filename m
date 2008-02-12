From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 1/2] config api: Add git_config_magic_int()
Date: Tue, 12 Feb 2008 09:21:21 +0100
Message-ID: <47B15701.8040803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqP8-00033h-SI
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761240AbYBLIV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760612AbYBLIV2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:21:28 -0500
Received: from mail.op5.se ([193.201.96.20]:57915 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbYBLIV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:21:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8E4FC1F08850;
	Tue, 12 Feb 2008 09:21:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.274
X-Spam-Level: 
X-Spam-Status: No, score=-2.274 tagged_above=-10 required=6.6
	tests=[AWL=0.225, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUjJQ7sbUAUk; Tue, 12 Feb 2008 09:21:23 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 209371F0884E;
	Tue, 12 Feb 2008 09:21:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73638>

There are some values where git can reasonably guess at an
optimal value. For such occasions, this is a nifty addendum
to the config api, letting the caller specify a magic string
and a magic setting to return if the value of the variable
matches the magic string.

An example would be for threads, where 0 = auto is overly
voodoo-ish for some consumers, and typing "auto" is much
nicer and more immediately obvious.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

 cache.h  |    1 +
 config.c |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 3867ba7..1b923ad 100644
--- a/cache.h
+++ b/cache.h
@@ -623,6 +623,7 @@ extern int git_config(config_fn_t fn);
 extern int git_parse_long(const char *, long *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
+extern int git_config_magic_int(const char *, const char *, const char *, int);
 extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
diff --git a/config.c b/config.c
index 3e72778..635d92b 100644
--- a/config.c
+++ b/config.c
@@ -288,6 +288,15 @@ int git_config_int(const char *name, const char *value)
 	return ret;
 }
 
+int git_config_magic_int(const char *name, const char *value,
+			 const char *magic_value, int magic_setting)
+{
+	if (value && !strcasecmp(value, magic_value))
+		return magic_setting;
+
+	return git_config_int(name, value);
+}
+
 unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
-- 
1.5.4.rc5.11.g0eab8
