From: Benny Halevy <benny@tonian.com>
Subject: [PATCH] git-remote rename should match whole string when renaming remote ref directory
Date: Mon, 26 Sep 2011 16:53:06 +0300
Message-ID: <1317045186-25206-1-git-send-email-benny@tonian.com>
Cc: git@vger.kernel.org, Benny Halevy <bhalevy@tonian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 15:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8BcX-0000sB-Vm
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 15:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab1IZNxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 09:53:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56275 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1IZNxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 09:53:16 -0400
Received: by wyg34 with SMTP id 34so5939407wyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=n71YRD7mRnc9XHbvksylXDSv0kQFCFSlNTlJnxaLpzM=;
        b=pIjT6M6j3GlgqDVpFfGRuTyb88Al8rHU0xi8HXFGgoMVHjTRD87UQv7ksk4cF4/ubx
         ua+flDqbj4RuXVyFnNP4JDrO7vJFj7yMqKJAjxMVlXE37bwIUjX7Q/o7V9hRLe1rPL1J
         kDfuwNyv4R/BTydObW2NBoz6hvL5XHewpJuUc=
Received: by 10.216.36.16 with SMTP id v16mr7817027wea.66.1317045194774;
        Mon, 26 Sep 2011 06:53:14 -0700 (PDT)
Received: from localhost.localdomain ([62.90.159.144])
        by mx.google.com with ESMTPS id f26sm31074176wbp.7.2011.09.26.06.53.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 06:53:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182111>

From: Benny Halevy <bhalevy@tonian.com>

Otherwise, with two remotes: test, test-2
	git remote rename test test-
ends up with:
	.git/refs/remotes/test-
	.git/refs/remotes/test--2

Signed-off-by: Benny Halevy <bhalevy@tonian.com>
---

By the way, I also see the old names as empty directories in .git/refs/remotes
not sure if that's a bug or a feature... :)

Benny

 builtin/remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..5443e71 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -571,7 +571,7 @@ static int read_remote_branches(const char *refname,
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
-	if (!prefixcmp(refname, buf.buf)) {
+	if (!strcmp(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref(refname, orig_sha1, 1, &flag);
 		if (flag & REF_ISSYMREF)
-- 
1.7.7.rc3.dirty
