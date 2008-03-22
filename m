From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] t0050: Set core.ignorecase case to activate case
 insensitivity
Date: Sat, 22 Mar 2008 23:01:39 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803222250330.21118@cougar>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 23:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdBnD-0000sY-KR
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 23:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbYCVWBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 18:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbYCVWBm
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 18:01:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:59988 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbYCVWBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 18:01:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2MM0o2N001634;
	Sat, 22 Mar 2008 23:00:51 +0100 (CET)
Received: from cougar (brln-4db938fa.pool.einsundeins.de [77.185.56.250])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2MM0kxr018379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 23:00:49 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77857>

Case insensitive file handling is only activated by
core.ignorecase = true.  Hence, we need to set it to give the tests
in t0050 a chance to succeed.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystem.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

On Sat, 22 Mar 2008, Linus Torvalds wrote:

>  - I made this all conditional on
> 
> 	[core]
> 		ignorecase = true
> 
>    because obviously I'm not at all interested in penalizing sane 
>    filesystems. That said, I also worked at trying to make sure that it's 
>    safe and possible to do this on a case-sensitive filesystem in case you 
>    are working on a project that doesn't like case-sensitivity, so the 
>    "git status" and "git add ." kind of operations won't add aliases

With this commit applied test 2 of t0050 passes.  This is the minimal
change to make t0050 useful.  Eventually test_expect_failure should be
replaced with test_expect_success.

    Steffen

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 3fbad77..cb109ff 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -34,6 +34,7 @@ test_expect_success 'see if we expect ' '
 
 test_expect_success "setup case tests" '
 
+	git config core.ignorecase true &&
 	touch camelcase &&
 	git add camelcase &&
 	git commit -m "initial" &&
-- 
1.5.4.4.613.gaa46e5
