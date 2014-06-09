From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 19/19] wt-status: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:38 -0700
Message-ID: <f55b190bd776a8b2b0dd248de73c04071fa26fd2.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wk-0001IM-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbaFIWVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:38 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:65027 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:37 -0400
Received: by mail-pb0-f47.google.com with SMTP id un15so100067pbc.34
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qSWFK/saOLpoEynA2JLkinoF28tPITkgEiPhMuqEN6M=;
        b=pzUGI5fEuYYXmP5lDoBtCNdXepXj6vtBgA5/00aNSOj1e8GRPbnnnJ1Ei8wlpTwcvK
         5TutGiEDkpN21UQv8p6ncgXse+Di14VtCw33oglkv9qb4WaOG9FxbRA761xoWZ12ogxq
         HG5dfMsTs4lPCPDqEZ5r0hQREH/6xc4Dqps7x/rtNpSGu/W8XohQxa2qD2nSwdm/Ci2V
         8IyhIZdO48IqJhNM3FsaOAVEHokUGw3vl6/J5ou3kmITott7U5Ex+yzbgjSs804W8avs
         0b0TZAOaSKQQpgsIfvB/hmrA0BkuXp28n+eCPA3N7MOJ6lwcJZ+eoGLZrpcIo4fjZAIC
         oDZA==
X-Received: by 10.68.245.100 with SMTP id xn4mr6484073pbc.152.1402352496703;
        Mon, 09 Jun 2014 15:21:36 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ue7sm2712780pab.26.2014.06.09.15.21.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:35 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:32 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251127>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 wt-status.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 318a191..a89cd73 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1168,8 +1168,7 @@ static char *read_and_strip_branch(const char *path)
 	else if (!get_sha1_hex(sb.buf, sha1)) {
 		const char *abbrev;
 		abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
-		strbuf_reset(&sb);
-		strbuf_addstr(&sb, abbrev);
+		strbuf_setstr(&sb, abbrev);
 	} else if (!strcmp(sb.buf, "detached HEAD")) /* rebase */
 		goto got_nothing;
 	else			/* bisect */
-- 
2.0.0.592.gf55b190
