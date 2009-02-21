From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B v4 2/5] git config: don't allow multiple config file locations
Date: Sat, 21 Feb 2009 02:49:26 +0200
Message-ID: <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag5X-0007JC-E1
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbZBUAtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754365AbZBUAtj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:17898 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbZBUAti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:38 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1029303fkf.5
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HF/AW5AyFOSwuJHWhMzqaKkL6Ns/WXQHzgXG9JOtiE8=;
        b=JPsmqD0HSD4npw8OEQssl9W8/1/qjCwIUbFNn3TToVe9PCvTlXuHcsmlqf0/zZluYw
         0Wg9MLaPHKkY9gd+QKhqq7qRtYX4itMC/rXF8Ros2FSOyRcbw4EnQr9vh+GWkifnHKtz
         lmP2F3mGLrpKxvsyDNpJOImoztvLg7IgsFE+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ha9/8g9zbtiJFict2MlEEuxWwHCexeKyd8Rl6v1xe54E3z2JXkvgIaTzKtQRm6dyJK
         69KUynEaIAI5aWf/RvOJazWwUsZwgZUttwM00YJEUOBPKr6ZmCBCxhshnEnWwHR8SJkK
         3usxpNuw8agVM6cfIFY+WL4g4JLRW/GMp+AxI=
Received: by 10.181.238.16 with SMTP id p16mr477207bkr.112.1235177375960;
        Fri, 20 Feb 2009 16:49:35 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p17sm5715796fka.30.2009.02.20.16.49.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:35 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110913>

Either --global, --system, or --file can be used, but not any
combination.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 302846e..876eb0e 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -315,6 +315,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (use_global_config + use_system_config + !!given_config_file > 1) {
+		error("only one config file at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (use_global_config) {
 		char *home = getenv("HOME");
 		if (home) {
-- 
1.6.1.3
