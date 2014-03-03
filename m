From: Guanglin Xu <mzguanglin@gmail.com>
Subject: [PATCH v4] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon,  3 Mar 2014 14:36:21 +0800
Message-ID: <1393828581-65523-1-git-send-email-mzguanglin@gmail.com>
Content-Type: text/plain; charset="utf-8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 07:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKMUX-0007T4-US
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 07:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbaCCGgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 01:36:41 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:55098 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbaCCGgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 01:36:41 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so3337616pdb.28
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:content-type;
        bh=sIRO0BFwr6kbEsTEj8tk6pk7uU8JoZi0hkbBc7Rq9TA=;
        b=lXhIft8l2wu1k3ItUs9GP5cpbhKrsAiOsTkYvjvnDUR3BHeNHlfDDR+RN9jyW50wg4
         sMR3M2l1mPxkwUNtIv3HtpymLrlE0evbpFPb8/FzrMgDP8dsCr+OkWGA68U5zWLAdSMd
         naDY9kpoLVhTbKOOM22/5DHiKkOhtFr2MhCUYlEOZllF+r6oEhLxcm4bVg7psbeBorNw
         pQhIBxIJIFf7feFxmJbDy1f1bQAPoWv9iCRN+XfPpvne2yIkZ90Z5nM0S38yi6NiUulk
         kKWF+Fdgy+Xkg42N3qIKnYCUASIJfN+pLoCvR5M0nYZr9uEowVqxlTTLHmCn/dITLwlj
         y+zg==
X-Received: by 10.68.237.228 with SMTP id vf4mr4261305pbc.131.1393828600735;
        Sun, 02 Mar 2014 22:36:40 -0800 (PST)
Received: from localhost.localdomain ([113.107.25.71])
        by mx.google.com with ESMTPSA id cz3sm32314886pbc.9.2014.03.02.22.36.37
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Mar 2014 22:36:39 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243178>

to avoid a magic code of 11.

Helped-by: Sun He <sunheeh...@gmail.com>
Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
Helped-by: Jacopo Notarstefano <jaco...@gmail.com>

Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
---

This is an implementation of the idea#2 of GSoC 2014 microproject.

 branch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..4eec0ac 100644
--- a/branch.c
+++ b/branch.c
@@ -49,8 +49,12 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	const char *shortname = skip_prefix(remote ,"refs/heads/");
+	int remote_is_branch;
+	if (NULL == shortname)
+		remote_is_branch = 0;
+	else
+		remote_is_branch = 1;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.9.0
