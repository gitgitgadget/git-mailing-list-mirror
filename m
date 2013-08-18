From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] rebase -i: fix core.commentchar regression
Date: Sun, 18 Aug 2013 13:12:50 -0400
Message-ID: <1376845970-31204-3-git-send-email-sunshine@sunshineco.com>
References: <1376845970-31204-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 19:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB6XY-0006Tl-IP
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab3HRRNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 13:13:15 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:42669 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab3HRRNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 13:13:12 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so3995229obb.2
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VC9Qhco+IRBiOcoOT9ku82HybNmwfEWHtdGS+st1hv4=;
        b=HnmbEWlPwCgqBE12SEB7Y24rpN/YrhIgYmCq/N0EoGxNC0uWNrgw3Fi7cSEp70XvfZ
         5I+2/WIlyBR2SmypzsC6h8ocHarE4Y51y1k8L938csN06H0WnClLuM+6QXglCSyos5Bb
         zyqKSs7CC+w+gnVy7mBUst1piNNaalsdvnUnfbdPjYU+6jThlrli2JCvJjiUEHdzaNaw
         epAJR6KQZf9iSA6RaHvQkG49e5E1BG7x+kja55D/Zwh0xh2D8GioJ6kgblB6DqZsx941
         PJ/35941K1uhiVJMYee+4zuin9j14ExymqpvBqvwU7H5wC1XBlvujeoO5gs9ZLYpBX/P
         bJog==
X-Received: by 10.182.24.105 with SMTP id t9mr27082obf.86.1376845991943;
        Sun, 18 Aug 2013 10:13:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id uz16sm9244405obc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 10:13:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.500.gc3113b0
In-Reply-To: <1376845970-31204-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232483>

9a46c25bdbf79744 (rebase: interactive: fix short SHA-1 collision,
2013-08-12) added transform_todo_ids() which assumes incorrectly that
the comment character is always '#', however, this has not been the case
since 180bad3d10fe3a7f (rebase -i: respect core.commentchar, 2013-02-11)
patched rebase -i to respect core.commentchar. Fix this regression.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Intended for 'next'.

 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3733312..f246810 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -693,7 +693,7 @@ transform_todo_ids () {
 	while read -r command rest
 	do
 		case "$command" in
-		'#'* | exec)
+		"$comment_char"* | exec)
 			# Be careful for oddball commands like 'exec'
 			# that do not have a SHA-1 at the beginning of $rest.
 			;;
-- 
1.8.4.rc3.500.gc3113b0
