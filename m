From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 2/2] fmt-merge-msg: use core.commentchar in tag signatures completely
Date: Sun,  7 Apr 2013 17:25:44 +0200
Message-ID: <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrTm-0000Sq-Jp
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933918Ab3DGPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:25:56 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:50882 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933907Ab3DGPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 11:25:55 -0400
Received: by mail-ee0-f43.google.com with SMTP id e50so1987215eek.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=MRFxGK6lSxhaSCGjuli5KmlxhTOrjTkR0t7U0lI+r+c=;
        b=meE5mAYsrQ70hYpEDIYf8dqiNN6Dqxw2MrImdM8SLOu1TIXceMmNK+sc+FtJCz7NOt
         A4HMySL5PUJWtoSVWlw29uGa+X9eEpsMbxESY9RLKnmkDpW3GnUHu+cIEUzQJxdrBckU
         /ubNf0fxX//zsiwnwiUZIFkrln14t8/qzjfxPsxae58Fn0U2bc8PPG4VW7W08mqmwvdP
         NADQSd5QcYpDWZfZAnnNyuvGd6NGT8Lv/UyHDs649zVgoG3y2nvHetW+/mDtfN+kkPYr
         Ih6c1pknb5Pl3APEPx+2VHxYWFQK4xd8bAA2VBeMBkScF+tKNXid93XsFTvxTkb820Jj
         10mQ==
X-Received: by 10.15.99.201 with SMTP id bl49mr26071389eeb.43.1365348353790;
        Sun, 07 Apr 2013 08:25:53 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPS id 44sm26843884eek.5.2013.04.07.08.25.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 08:25:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.470.g21ccebe
In-Reply-To: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220318>

Commit eff80a9 (Allow custom "comment char") introduced a custom
comment character for commit messages but didn't use it completely
in the tag signature part.

This commit fixes that.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/fmt-merge-msg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 88df93a..1c04070 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -503,14 +503,18 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		} else {
 			if (tag_number == 2) {
 				struct strbuf tagline = STRBUF_INIT;
-				strbuf_addf(&tagline, "\n# %s\n",
-					    origins.items[first_tag].string);
+				strbuf_addch(&tagline, '\n');
+				strbuf_add_commented_lines(&tagline,
+						origins.items[first_tag].string,
+						strlen(origins.items[first_tag].string));
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
 			}
-			strbuf_addf(&tagbuf, "\n# %s\n",
-				    origins.items[i].string);
+			strbuf_addch(&tagbuf, '\n');
+			strbuf_add_commented_lines(&tagbuf,
+					origins.items[i].string,
+					strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&sig);
-- 
1.8.2.470.g21ccebe
