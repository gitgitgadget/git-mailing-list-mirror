From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/10] config: Disallow --getcolor* and other actions.
Date: Tue, 17 Feb 2009 15:52:53 +0200
Message-ID: <1234878776-13250-7-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-6-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPo-0001sQ-Ha
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbZBQNx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbZBQNx2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:28 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51922 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZBQNx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:27 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so4067593bwz.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uLUDlZAlntVKuKXPeNUL8S/4CAp6nZv8dwiR7Gh/NTw=;
        b=UjdBkpJXL3axNtEvC/S5fiHTQ/BwnxAnNDQK8OUrXaL0mklj6RAbSD5Tk0P5HBdL4V
         g4RPZG9Lvy8kStW1RC1qBkU4RgbdRkQhlURkkm8KW0MPMk73GUDj8fNH0h4C6cdY3Amu
         3Oiof0khYgFcnfSo4V4jUlvn7ph2DHl1yEvNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oAlB9GXQaizTG26yQ2o1/KFAym6W6IDytLBdavjGwLQ3SD10V83F0IFwY4cW2c3NKZ
         aRRQCkdeqgDng7n+Hh6V5nEFH0OPX/phWGLsv97gSX4WfogywSLMfQe5gHh/Wm6EtEgM
         XHLDyPVa8HK2bF3GFl73xPPbUHauuVSOFlxPo=
Received: by 10.223.106.69 with SMTP id w5mr1867625fao.17.1234878805890;
        Tue, 17 Feb 2009 05:53:25 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id q9sm3291712gve.27.2009.02.17.05.53.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:25 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110378>

From: Junio C Hamano <gitster@pobox.com>

So that --get and --get-colorbool are diagnosed as errors.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 45b4a9f..8ee0cd9 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -40,6 +40,8 @@ static int end_null;
 #define ACTION_EDIT (1<<10)
 #define ACTION_SET (1<<11)
 #define ACTION_SET_ALL (1<<12)
+#define ACTION_GET_COLOR (1<<13)
+#define ACTION_GET_COLORBOOL (1<<14)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
@@ -339,6 +341,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		key_delim = '\n';
 	}
 
+	if (get_color_slot)
+	    actions |= ACTION_GET_COLOR;
+	if (get_colorbool_slot)
+	    actions |= ACTION_GET_COLORBOOL;
+
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
@@ -432,10 +439,10 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		if (ret == 0)
 			die("No such section!");
 	}
-	else if (get_color_slot) {
+	else if (actions == ACTION_GET_COLOR) {
 		get_color(argv[0]);
 	}
-	else if (get_colorbool_slot) {
+	else if (actions == ACTION_GET_COLORBOOL) {
 		if (argc == 1)
 			stdout_is_tty = git_config_bool("command line", argv[0]);
 		else if (argc == 0)
-- 
1.6.1.3
