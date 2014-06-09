From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 16/19] submodule: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:35 -0700
Message-ID: <95dbf96f18d28535eef05cd384656cb5122a37d7.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wZ-00019E-A4
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbaFIWV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:26 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:47534 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:25 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so5509044pbc.12
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1Kh+0GUrxXrzJcgq+Mmj/STnmAnDygGvWDvlMoGjiak=;
        b=KCZB190ZwbXTrpsADTDrQT3PaamqfZ7m+Ev1l0JGHjRGXbJrYnDqnOkYqQ/T5psgai
         1gJDAEYBBg25ixqR8ff864+Qjfh7Fbh3nzIEWTumBgHq/ydNaZ33iH1c5lejuF92CNxT
         Ie9W0uXwPNbaQir8obABEPPu2WatzdykSeSfzN5A2sRMyKYYwi3Vi3pbarUYzN0RqeBQ
         Op6m0+/+vG7mz3chZq0JVlEYbE21DPsdX+zMGB5jcJL+5pTVgGT3WrClSowic+PJcx0K
         MgtZeTmLeUcGLQ2YZsS2IqXcx0skWiLbVqdgmGlmAlnU6rcHdf40s0wioS6qOPPU2LuC
         SkFA==
X-Received: by 10.66.146.72 with SMTP id ta8mr1145604pab.150.1402352484641;
        Mon, 09 Jun 2014 15:21:24 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id gr10sm65755204pbc.84.2014.06.09.15.21.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:23 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:20 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251124>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 submodule.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3402af6..878cc48 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1324,13 +1324,12 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	const char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
-	strbuf_addf(&file_name, "%s/.git", work_tree);
+	strbuf_setf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, 1, "gitdir: %s\n",
 		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", real_git_dir);
+	strbuf_setf(&file_name, "%s/config", real_git_dir);
 	if (git_config_set_in_file(file_name.buf, "core.worktree",
 				   relative_path(real_work_tree, real_git_dir,
 						 &rel_path)))
-- 
2.0.0.592.gf55b190
