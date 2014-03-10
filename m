From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 5/7] merge: fix GIT_EDITOR override for commit hook
Date: Mon, 10 Mar 2014 19:49:35 +0100
Message-ID: <1394477377-10994-6-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HE-0005To-4E
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbaCJSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:49:59 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:60765 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbaCJSt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:57 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so8801105wgh.16
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9x2NQIQbIuBAFZ+2+AnI3jbO0/+EI9vUTPMBspr00MA=;
        b=Gwz6x/DDC4cq8r/0/sny2wQt2LfwpkjOFR7tzSujU+e6q6YUgY6E/D9WInlgfVtwxR
         vPOsGQ5/xzdoP3a99O7V7WyuBGrfJnBXIW+gPBui/SKLlC4Rd42OrhiRywisWrM+b5U2
         V8fKkMSyoJh/cQRXlCHsT9v/hSjqAGG5R30LVuW+lpZf6XOwvymY1ylyv3MNQkUBF2dM
         hPK39vinqO3zaRP2JSsohl5bwWgNq8zqkBJoYkXdn1feonn5oNvtqFctRdy1Pn6nthEE
         D5GD/q7nWbCKQznQS2whHVhXnc28gc8v/RjRRhR/JazGUb0AxYqG2u2CEdZGa0YABaAU
         1bjw==
X-Received: by 10.194.63.236 with SMTP id j12mr7100513wjs.5.1394477396071;
        Mon, 10 Mar 2014 11:49:56 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id bm8sm54382804wjc.12.2014.03.10.11.49.54
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243789>

Don't set GIT_EDITOR to ":" when calling prepare-commit-msg hook if the
editor is going to be called (e.g. with "merge -e").

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 67f312d..b11a528 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,7 +821,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	write_merge_msg(&msg);
-	if (run_commit_hook(1, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path("MERGE_MSG"), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
-- 
1.9.0
