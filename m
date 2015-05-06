From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 5/7] git-commit: replace use of home_config_paths()
Date: Wed,  6 May 2015 16:01:02 +0800
Message-ID: <1430899264-18447-4-git-send-email-pyokagan@gmail.com>
References: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:02:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuHY-0007yn-HX
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbbEFICN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:02:13 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33604 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEFICG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:02:06 -0400
Received: by pacwv17 with SMTP id wv17so2520754pac.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DCtugaEu23rBAzufpdK2g3hYHE97xPjkvdUauzij228=;
        b=a5E1nIaEKm9Ao93Pz3oLHJxHWUAmhB8rycEfKLTYeFdIQ5bM4ajjN/IN1dW69xxJf3
         R7ufTikew7xVVDdKskxos7AgVlFcNxQxDfsB4zzAgvdsPbgqckCg5xXuSurezvUy3Sym
         O3EXfIaIGp3cqMO/qxFKDiTByVVkyDKx98HoW1p2uxlbh7Ch24p4pDPzHh5hoCQxrULO
         w7puKjAAmltX2TaOSRP4dGov6zo/os4FiqEP/s7Ivq3cGXqucTEkEn0UtS2ngNaHretF
         b3SwcyywQSNT02b4yJ3uo0vRUaydgY3M/WEj9VOCefPapj2aiadfZOj9HdVm2bpVDuyP
         XCFQ==
X-Received: by 10.66.186.142 with SMTP id fk14mr58940577pac.74.1430899325498;
        Wed, 06 May 2015 01:02:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id cy5sm1074571pdb.85.2015.05.06.01.02.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 May 2015 01:02:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
In-Reply-To: <20150421040627.GA5415@yoshi.chippynet.com>
References: <20150421040627.GA5415@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268459>

Since home_config_paths() combines two distinct functionality already
implemented by expand_user_path() and xdg_config_home(), and hides the
home config file path ~/.gitconfig. Make the code more explicit by
replacing the use of home_config_paths() with expand_user_path() and
xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Re-sending the patch series. There are no changes.

 builtin/commit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index da79ac4..c2ebea4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1398,12 +1398,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 static const char *implicit_ident_advice(void)
 {
-	char *user_config = NULL;
-	char *xdg_config = NULL;
-	int config_exists;
+	char *user_config = expand_user_path("~/.gitconfig");
+	char *xdg_config = xdg_config_home("config");
+	int config_exists = file_exists(user_config) || file_exists(xdg_config);
 
-	home_config_paths(&user_config, &xdg_config, "config");
-	config_exists = file_exists(user_config) || file_exists(xdg_config);
 	free(user_config);
 	free(xdg_config);
 
-- 
2.1.4
