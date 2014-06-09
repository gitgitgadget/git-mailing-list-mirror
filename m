From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 06/19] builtin/branch: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:25 -0700
Message-ID: <85cfb1d4cafce87e134d4329ccecad745eb5c39e.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vt-0000e8-WE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbaFIWUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:46 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60163 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWUo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:44 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so5475373pbc.15
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h04k45MV/XIrum29sJBRIWFNuKmEBBrVs/rSCpkp7IQ=;
        b=G8M5nOpwxCAkXUves3alqm71H2mtK/jckZrT5HaaesuWziWEcPz/wBXF+TMzQ9rmHE
         YmSe03vMmeSepxuIvJzgwAz033zrJ+33BnjS0h7GquonKTAf2WUDPf4jv6g9JTatD4Zf
         DPWSVMSvYMx2Ds+JoWUwRQuNXn7POmuFQ/Kkubg34NHeeZ5k+rI6Bp+qoCLKL+koq93u
         u3DTfKvxEDDUsHeCLNpV256Y8BB7g847wNjVu1ABNCRzdQvstwpnwUWbYIqmPiXSxY+D
         rKCFgKrbIS08HCBb9ZoP/yTska9TZbn0LmnFRVTss5bHUzfr7oZ7o5DESyCnuOMf/l06
         uaSg==
X-Received: by 10.68.139.36 with SMTP id qv4mr7486818pbb.82.1402352444309;
        Mon, 09 Jun 2014 15:20:44 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qq5sm65838491pbb.24.2014.06.09.15.20.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:43 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:40 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251113>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/branch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2d1c57c..ad641b6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -984,8 +984,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "branch.%s.merge", branch->name);
+		strbuf_setf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
-- 
2.0.0.592.gf55b190
