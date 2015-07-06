From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/23] checkout: make --to unconditionally verbose
Date: Mon,  6 Jul 2015 13:30:48 -0400
Message-ID: <1436203860-846-12-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGN-0008Tb-EX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbbGFRcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:54 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35833 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbGFRbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:40 -0400
Received: by igcqs7 with SMTP id qs7so15121442igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZT1v4XNoG0nqVUCPVUxBnqIyl8P0YOoTq+/wX97fW7c=;
        b=j2ZAxwrRRpVxxkpRp/KbRfP2vSIEENJvqFm7YQgfF67yVCvfmd4b8LzPjdYp/7VPLt
         0nPQ5cC9lB3iBcLtEKXJB5F/WgDut+4Nc+qWIuvBWWSHn4z98XwIK5aDj3VJS0KTIGNF
         Vz66ipAD741srgxLL27lh59QWac/N5Pf0ZCyxggf+OLKZj/RTvuQysxapRv68zmebWxR
         D55raOrKPHBCOQdBP/2YFwn05LSHHJQwRfX24WpZMJHurD7wqIIFxHdK8z2YdsfYmBJD
         QW57j4knxYObBO43tr1NKrsgQmFgyETMJS8h3RqZAzRJp+sganyVNXh2X7cwYZqt9OQg
         BLiw==
X-Received: by 10.50.114.5 with SMTP id jc5mr43615171igb.43.1436203899894;
        Mon, 06 Jul 2015 10:31:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273429>

prepare_linked_checkout() respects git-checkout's --quiet flag, however,
the plan is to relocate "git checkout --to" functionality to "git
worktree add", and git-worktree does not (yet) have a --quiet flag.
Consequently, make prepare_linked_checkout() unconditionally verbose to
ease eventual code movement to worktree.c.

(A --quiet flag can be added to git-worktree later if there is demand
for it.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 134b6d6..90bb3cd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -936,8 +936,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts)
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
 
-	if (!opts->quiet)
-		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
 	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-- 
2.5.0.rc1.197.g417e668
