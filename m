From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] fast-export: don't segfault when marks file cannot be opened
Date: Sun, 28 Mar 2010 00:42:48 -0500
Message-ID: <1269754968-24961-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Pieter de Bie" <pdebie@ai.rug.nl>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 07:43:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvlHb-000769-Vi
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 07:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab0C1FnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 01:43:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63910 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab0C1FnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 01:43:19 -0400
Received: by gwaa18 with SMTP id a18so3417282gwa.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 22:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WnzjrdaX5u9PcEBunZJkBgmK0m93L+aXLoIY0OoVPws=;
        b=uwZRO1hs3Y+LsYV1X1Oyrg4gJ1MJDKMZ3nWIzjShItH+aYQOs8fBPBBmmRNj69BCH2
         aQss0EjDgcvJcT2aa8t7GY58m2ovAaB7SeIP0kIWPZ6tCPy0eGulfEPOqdKCuCGNFfbl
         iexYoyKuoPK/oQXSUJD7ldaqmyHbfA2m8vupQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Uhd5qQpx8m+3WYpXig3hYcCi9kIKzyVhOwUvWBpQeQsLl29mgJNeccdpNWQ2pnELgn
         RQDB4SWkWmXSoixyC5832kCMxaNag/KGggz5LQLz2oKkwxkEK8XFqALA0MarFqNmGrEU
         smJIoNkddpJa0d8wKZkOWblqVbRtlTNnjKxko=
Received: by 10.101.10.26 with SMTP id n26mr5267547ani.73.1269754998243;
        Sat, 27 Mar 2010 22:43:18 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 21sm2561405iwn.7.2010.03.27.22.43.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 22:43:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.333.g70ce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143377>

The error function only prints an error message, resulting in a
segfault if we later on try to fprintf to a NULL handle.

Fix this by using die_errno instead.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This has been proken ever since this functionality was added in
  df6a7ff7 (add importing and exporting of revision marks) on
  Jun 11 2008 by Pieter de Bie (cc-ed). All other error calls
  seem to be appropriate.

  This should probably be applied to maint?

 builtin/fast-export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b0a4029..963e89b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -503,7 +503,7 @@ static void export_marks(char *file)
 
 	f = fopen(file, "w");
 	if (!f)
-		error("Unable to open marks file %s for writing.", file);
+		die_errno("Unable to open marks file %s for writing", file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
-- 
1.7.0.2.333.g70ce.dirty
