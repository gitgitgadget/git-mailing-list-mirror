From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git config: error when editing a repo config and not being in one
Date: Thu, 30 Apr 2009 01:25:39 +0300
Message-ID: <1241043939-29013-1-git-send-email-felipe.contreras@gmail.com>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 00:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIGA-00044H-RI
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761742AbZD2WZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761703AbZD2WZq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:25:46 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42924 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761724AbZD2WZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:25:44 -0400
Received: by fxm2 with SMTP id 2so1479077fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KiuyUWanvC29zCvL2m/9Nng0FqAQ0wlIQHEb+nTK538=;
        b=GLQiRl3XzLMB/bRELn/+q6zdyu100DVenh8mYPpAJ6pJHUuYWy0enbGXTtIU0B0F9F
         jw9RavylaoZfatPE8o1Nc9TwG71VJqn3gyQPn9ZY5slE4kvBxtM9PYisk21/GY70nxwV
         5cHG0NeSw+fVGeEjhTQ3WMVk56i5Ai9Ub3Aw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rXatiWL3P0OIRzCYCPNhCCpUYSZONYyJgGI027k8m+RjlxGG39Wby6OjM796g/mx80
         PFgHcaVE2wrr/swH9aqYlaMcEbrdDCh90ivjHPVrIykP92GSCZzv0RTQ0pTYkwNlX8IL
         HF3cxkFT4cAwjUHjdOqUND7nFiHOugE6r+yCI=
Received: by 10.86.31.18 with SMTP id e18mr1152942fge.72.1241043942924;
        Wed, 29 Apr 2009 15:25:42 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l12sm2277020fgb.9.2009.04.29.15.25.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 15:25:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.12.gb7937.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117967>

Let's throw an error on this specific case. If the user specifies the
config file, he must know what he is doing.

Teemu Likonen pointed this out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index d8da72c..6e936e1 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -390,6 +390,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (actions == ACTION_EDIT) {
 		check_argc(argc, 0, 0);
+		if (!config_exclusive_filename && !is_inside_git_dir())
+			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
 			      config_exclusive_filename : git_path("config"),
-- 
1.6.3.rc3.12.gb7937.dirty
