From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] transport-helper.c: fix check for size_t < 0 v2
Date: Sat, 5 Mar 2011 00:16:26 +0100
Organization: -
Message-ID: <20110305001626.3b6c507d@absol.kitzblitz>
References: <20110304202834.2e74d56d@absol.kitzblitz>
	<AANLkTimc_iLDXxrV=tfZc+_dCkpx6897Lh8sZxkwbgDo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:18:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PveGK-0007ip-8d
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 00:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab1CDXSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 18:18:15 -0500
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:42570 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587Ab1CDXSO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 18:18:14 -0500
Received: from absol.kitzblitz (85-127-41-184.dynamic.xdsl-line.inode.at [85.127.41.184])
	(authenticated bits=0)
	by webhosting01.bon.m2soft.com (8.13.8/8.13.8) with ESMTP id p24Mx1UF011140;
	Fri, 4 Mar 2011 23:59:02 +0100
In-Reply-To: <AANLkTimc_iLDXxrV=tfZc+_dCkpx6897Lh8sZxkwbgDo@mail.gmail.com>
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Claws Mail (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168475>

'bytes' is unsigned of type size_t, and can't be negative.
But the assigned write() returns ssize_t, and -1 on error.
For testing < 0, 'bytes' needs to be of a signed type.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
* Piotr Krukowiecki <piotr.krukowiecki@gmail.com>:
> You are right that, but the fix should be to use ssize_t not  plain "int".
> (udt_do_read() correctly uses ssize_t)

Indeed, thanks. Here's a version with ssize_t.
Testsuite did not regress at my place.

 transport-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4e4754c..ba06b70 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -973,7 +973,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
  */
 static int udt_do_write(struct unidirectional_transfer *t)
 {
-	size_t bytes;
+	ssize_t bytes;
 
 	if (t->bufuse == 0)
 		return 0;	/* Nothing to write. */
-- 
1.7.3.4
