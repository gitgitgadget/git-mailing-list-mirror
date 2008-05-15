From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 15 May 2008 07:51:59 +0200 (CEST)
Message-ID: <alpine.OSX.1.10.0805150748590.2650@cougar>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 07:52:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwWOE-0003fG-Uq
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 07:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbYEOFvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 01:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbYEOFvl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 01:51:41 -0400
Received: from mailer.zib.de ([130.73.108.11]:65480 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbYEOFvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 01:51:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m4F5pIMF026821;
	Thu, 15 May 2008 07:51:24 +0200 (CEST)
Received: from cougar (brln-4db91ab5.pool.einsundeins.de [77.185.26.181])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4F5pHrM000536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 May 2008 07:51:18 +0200 (MEST)
In-Reply-To: <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (OSX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82182>

On Wed, 14 May 2008, Junio C Hamano wrote:

> 
> For 1.5.6.
> 
> * sp/ignorecase (Sun May 11 18:16:42 2008 +0200) 4 commits
>  - t0050: Add test for case insensitive add
>  - t0050: Set core.ignorecase case to activate case insensitivity
>  - t0050: Test autodetect core.ignorecase
>  - git-init: autodetect core.ignorecase
> 
> This unfortunately seems to break on natively case sensitive filesystems.


>From 92ec8c8a12cdc45a69f6612af340a8ce50976ab1 Mon Sep 17 00:00:00 2001
From: Steffen Prohaska <prohaska@zib.de>
Date: Thu, 15 May 2008 07:19:54 +0200
Subject: [PATCH] t0050: Fix merge test on case sensitive file systems

On a case sensitive filesystem, "git reset --hard" might refuse to
overwrite a file whose name differs only by case, even if
core.ignorecase is set.  It is not clear which circumstances cause this
behavior.  This commit simply works around the problem by removing
the case changing file before running "git reset --hard".

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystem.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 0e33c4b..c5360e2 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -72,6 +72,8 @@ $test_case 'rename (case change)' '
 
 $test_case 'merge (case change)' '
 
+	rm -f CamelCase &&
+	rm -f camelcase &&
 	git reset --hard initial &&
 	git merge topic
 
-- 
1.5.5.1.349.g99d0
