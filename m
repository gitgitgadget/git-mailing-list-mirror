From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] rebase -i: fix skip_unnecessary_picks() to respect core.commentchar
Date: Sun, 18 Aug 2013 13:12:49 -0400
Message-ID: <1376845970-31204-2-git-send-email-sunshine@sunshineco.com>
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
	id 1VB6XY-0006Tl-1Z
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab3HRRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 13:13:12 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:39962 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab3HRRNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 13:13:10 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so4355786oag.36
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YI5U8BADxjOQ3O54Pzg/i+DCMi3d9Nhy/VdBXTdXBNs=;
        b=humBUz8MlZve/8JWC51NGCDuW3c3TMTuMSwLyXMXZ8LRM4Dy2yU/QTMtOYEMxK9Eit
         Dz5jt7R8+WgtezPwTgJVKqTkdSl4BtnggO96TotaEX/CA6ZKEF1P40/rxGtucvsHK9cY
         wMweV6UtLF4T86oN5NnbrnkW1pBQ74byJbQOfeE/IjuU1/gvrZdW/bVVLZC8XQnoZkEv
         VtkXuONbfuHl+FDUGp+M59UGXmqdOsaAU4zxFmyXbxNdbZvcD+dGj4BH7nTuoTapBvNz
         9s66lkBh55pBNveiwFqrV5cFciaK5KtQpc0/FZM9zogjfc3DhWRCZ9yXpkiOLoaEDcG5
         V24Q==
X-Received: by 10.60.39.169 with SMTP id q9mr48067oek.79.1376845989807;
        Sun, 18 Aug 2013 10:13:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id uz16sm9244405obc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 10:13:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.500.gc3113b0
In-Reply-To: <1376845970-31204-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232484>

eff80a9fd990de36 (Allow custom "comment char", 2013-01-16) added general
core.commentchar support but forgot to update git-rebase--interactive to
respect it.  180bad3d10fe3a7f (rebase -i: respect core.commentchar,
2013-02-11) addressed this oversight but missed one instance of
hard-coded '#' comment character in skip_unnecessary_picks(). Fix this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Suitable for 'maint'.

 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ea11e62..3733312 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -671,7 +671,7 @@ skip_unnecessary_picks () {
 				;;
 			esac
 			;;
-		3,#*|3,)
+		3,"$comment_char"*|3,)
 			# copy comments
 			;;
 		*)
-- 
1.8.4.rc3.500.gc3113b0
