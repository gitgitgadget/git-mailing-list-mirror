From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] rebase -i: write better reflog messages for start
Date: Mon, 10 Jun 2013 21:52:12 +0530
Message-ID: <1370881332-9231-4-git-send-email-artagnon@gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4pe-0005MA-98
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab3FJQU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:20:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41025 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3FJQU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:20:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1567983pab.39
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wlATOnC8kSwMy6AmYTh6x1gMxMFxrcWvFNQ0ejjVe/c=;
        b=GDB8bLSCdrRvxKJsyzIRv4YYkeV5/qYpCvkjDhybMnIxIX5fZnNi7gL0EkRbf4Cckr
         G+Quse/WZGrbGIIjyc9kt2CBTZIpj/Wh+mQG4kXc08vNAi31cVXl/ReEPW1BWswvoYtf
         YF2bJeY32oKHFpleMGuHmi2H8na0p5cKGXEUwXfbZeNcm4pGz5UggcvmpiRolMOleLMg
         ZUwRyHO+8mcYdRs6C8rRQb221zY18tTryxSQRuWumbmd1h59LC5fO4eyiTWR7KCiJjAE
         bXcgwtWlAEL4/UGGHNXFla04xlfcKD04wVLxHLP+avxGqi41Ypj9b4K1fM6YTnhSzveV
         LEFQ==
X-Received: by 10.66.149.5 with SMTP id tw5mr14830782pab.87.1370881226733;
        Mon, 10 Jun 2013 09:20:26 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id 6sm10895528pbn.45.2013.06.10.09.20.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 09:20:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.254.g60f9e5b
In-Reply-To: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227317>

Invoking 'git rebase -i' writes the following line to the reflog at the
start of the operation:

  rebase -i (start)

This is not very useful.  Make it more informative like:

  rebase -i (start): checkout master

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5822b2c..a05a6e4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -837,6 +837,7 @@ comment_for_reflog start
 
 if test ! -z "$switch_to"
 then
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
 	output git checkout "$switch_to" -- ||
 		die "Could not checkout $switch_to"
 fi
@@ -980,6 +981,7 @@ has_action "$todo" ||
 
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
-- 
1.8.3.254.g60f9e5b
