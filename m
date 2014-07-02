From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 07/19] rebase -i: The replay of root commits is not shown with --verbose
Date: Wed,  2 Jul 2014 19:47:59 +0200
Message-ID: <b1ecef042cd18a0251199429e4efb969b085d5fe.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Ofj-0006xe-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbaGBRuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:05 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:45887 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbaGBRts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:48 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so954587wib.9
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OcQ1KQLkuLdF0bSbGG/KuYVaFKRCldWmN7FfROwu1PE=;
        b=zMI14JhaChXcUtn/UHMEepDKOWnHNIGAX9sAIDjCN+LwfhMVq2jPoIrwDnbnS1BLVm
         +GXCjUodehGJm8jF6KrWscCwN5SrhocqeZvnSLLXXpVCvn4+vzct5ztvlmWaIcTVpMkR
         WYu3LUJHTYMldzUJR0WINmVaqJuvtwWYiWv6iCVzixhTU8rJNrlbbY5oljWzWsDaHP+N
         1tZnoXu/liJU01m8968X+1FGlHi3XVmwBzmkWdzUtcGRLw13kro6dAbiaZWG3aPaUxJ2
         0AWhEyRFFODjkDrH9fhAM2O1G48csFUgSI+tkwBI8psDtIdvpyC9CQKHr8KQKLzWNJWQ
         JDJw==
X-Received: by 10.194.191.162 with SMTP id gz2mr20662656wjc.89.1404323387328;
        Wed, 02 Jul 2014 10:49:47 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252813>

The command line used to recreate root commits specifies the
erroneous option `-q` which suppresses the commit summary message.
However, git-rebase--interactive tends to tell the user about the
commits it creates, if she wishes (cf. command line option
`--verbose`). The code parts handling non-root commits or squash
commits all output commit summary messages. Do not make the replay of
root commits an exception. Remove the option.

It is OK to suppress the commit summary when git-commit is used to
initialize the authorship of the sentinel commit because the
existence of this additional commit is a detail of
git-rebase--interactive's implementation. The option `-q` was
probably introduced as a copy-and-paste error stemming from that part
of the root commit handling code.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0af96f2..ff04d5d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -511,7 +511,7 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty \
-				   --amend --no-post-rewrite -n -q -C $1 \
+				   --amend --no-post-rewrite -n -C $1 \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-- 
2.0.0
