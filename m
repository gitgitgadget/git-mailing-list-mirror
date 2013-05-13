From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] stash: tweak error message in store_stash ()
Date: Mon, 13 May 2013 18:15:53 +0530
Message-ID: <1368449154-21882-6-git-send-email-artagnon@gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs7G-0003rq-PM
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab3EMMo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62426 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab3EMMo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:27 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so4611841pad.15
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cY+k+zO8y+q4DEJGd4N4H5RqRj18yAjg+/pEB0QDqn0=;
        b=gpbZxOhUgLotYwsD7mgSO8nn7sZ6kfZ3ns/crzaftO90xRlrWGQCDfnXPbB9+nvdEk
         VYfyuuq29Glf3OBAYA/VYb85vMavhl1cPhbuej7fD7+sxnLn2bl7FZxKKvg77KYU0VZe
         wwK+92mTUQdC4o3dCBukNEL+gdp4R1KsHsWeeRDGvaA4/UNDhNbchlfuX3aeAkb/J7Q6
         hbk5aT28Zma9DPaEaGAuppHcRm4kn/9mTUqRpZxrc2xsZJVr+9XTdjaMc4YHRYQZUQHF
         f1fEZCk2LgBldchuSIEFlsK0kKUb7WvXjL71Hamn8FTmMuBIVwIHeP2Ey4yFBPHvrkQ6
         MPGQ==
X-Received: by 10.66.145.67 with SMTP id ss3mr29889980pab.18.1368449066706;
        Mon, 13 May 2013 05:44:26 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224128>

When the update-ref invocation fails, store_stash currently prints:

    Cannot save the current status

This is not very useful for diagnosing the problem.  Instead, print:

    Cannot store 688268c4254ca5dc6e2effa83bae4f0dbbe75e5b

so we can inspect the object and analyze why the update-ref failed.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1d483f5..24d72fc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -167,7 +167,7 @@ store_stash () {
 	# Make sure the reflog for stash is kept.
 	: >>"$GIT_DIR/logs/$ref_stash"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
-	die "$(gettext "Cannot save the current status")"
+	die "$(gettext "Cannot store $w_commit")"
 }
 
 save_stash () {
-- 
1.8.3.rc1.57.g4ac1522
