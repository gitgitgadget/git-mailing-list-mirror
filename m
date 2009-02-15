From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/8] config: Disallow multiple config file locations.
Date: Sun, 15 Feb 2009 11:00:57 +0200
Message-ID: <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcuF-0000wm-Q7
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZBOJBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbZBOJBW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:01:22 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54154 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZBOJBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:01:15 -0500
Received: by mail-fx0-f20.google.com with SMTP id 13so4790431fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6EaswKB6OI/HGxS9sBhAbgqGDKBEJLorhD9ZH7+kyhk=;
        b=qCQ64MEAMz/g6nFnRcd08S4tYH90EKAkyjvamrM+fqDx9ciuj+tp4rh740CfSjpDUj
         EXaUq33HJoS5nFxTJcxyHXXyeefAmgoXIZcnSoHBnQZ1XdOeB3alIffmG+thgtlcxp66
         /CaxHiOGRPstY55t9Ebhf4osrjfNJD6vpnAZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q5afD6gDBnJHpkUX/oyGiTTZf8RR/McSswlvrBLvR3qwK8S31HN4B+xExIevlzh6nF
         wsWoGLPmL1BzzvfJ4zKDw1229EnfxVV+L9YKRu6wUXrZd6MCm//QkgSyrXTg+lLcakJb
         ZFJ4QXo/p4+ZMrQFsbV2lSQfxTAB6CVMHss1c=
Received: by 10.181.61.18 with SMTP id o18mr1473008bkk.66.1234688474911;
        Sun, 15 Feb 2009 01:01:14 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id f31sm5664755fkf.35.2009.02.15.01.01.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:01:14 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109976>

Either --global, --system, or --file should be used, but not any
combination.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 83f8b74..e744ad8 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -314,6 +314,16 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
 
+	{
+		int config_file_count = use_global_config + use_system_config;
+		if (given_config_file)
+			config_file_count++;
+		if (config_file_count > 1) {
+			error("only one config file at a time.");
+			usage_with_options(builtin_config_usage, builtin_config_options);
+		}
+	}
+
 	if (use_global_config) {
 		char *home = getenv("HOME");
 		if (home) {
-- 
1.6.1.3
