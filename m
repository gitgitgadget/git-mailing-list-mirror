From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] pre-commit: check .topdeps for valid branches
Date: Mon,  4 Oct 2010 23:18:50 +0200
Message-ID: <1286227130-8306-1-git-send-email-bert.wesarg@googlemail.com>
References: <1286226447-3390-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sR4-0000Md-Mq
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351Ab0JDVS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 17:18:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65249 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab0JDVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:18:56 -0400
Received: by bwz11 with SMTP id 11so4021588bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WKFVjVnTi9QXnha9eCVazaENQt/Z9gjx43Z1iBViM+I=;
        b=jGpBoHQcGm0OHwApQCNFliwvpQHJEoU5Go0VqvJoAGXV7nzLG4xmGrCUHhnc88zrPJ
         9EvlmmD66nyk1qE8KN4HmqMmtFiQVDHYpXhEwyalf4CVJNVeVryNATvjn//1EO85Ku3E
         msn18yM4CpZxWekTSWCkOyLPVMqiifnJXXKQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TLK+nC7lPyF6AUTt6UhhQ2aINs514hGeiRnpnXh6ZjRuXJajV/6KAhhsYzNhkzvhZG
         cEVU75ZGuglEhnFrCl1UBjACk5F8i+OgQxRYzc4VUTqeTGEU964yKal7rAzDWoLVi+d7
         ffHD4Od9fsXapk/K6arvUm58UGQ4P4mzUVUeo=
Received: by 10.204.68.145 with SMTP id v17mr7582518bki.81.1286227134650;
        Mon, 04 Oct 2010 14:18:54 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id x13sm4196570bki.0.2010.10.04.14.18.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 14:18:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286226447-3390-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158123>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index fd960a4..f6901e4 100644 hooks/pre-commit.sh
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -52,6 +52,9 @@ BEGIN      { in_hunk = 0; }
 /^[^@ +-]/ { in_hunk = 0; }
 ' |
 	while read newly_added; do
+		ref_exists "$newly_added" ||
+			die "Invalid branch as dependent: $newly_added"
+
 		# check for self as dep
 		[ "$head_" != "$newly_added" ] ||
 			die "Can't have myself as dep"
@@ -64,6 +67,3 @@ BEGIN      { in_hunk = 0; }
 		# therefore no endless loop in the cycle-check
 		no_remotes=1 recurse_deps check_cycle_name "$newly_added"
 	done
-
-
-# TODO: Verify .topdeps for valid branch names
-- 
tg: (d4c1eaf..) bw/check-valid-deps (depends on: bw/check-for-dep-cycle)
