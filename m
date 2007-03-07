From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle: fix wrong check of read_header()'s return value
 & add tests
Date: Wed, 7 Mar 2007 06:15:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 07 06:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOoUj-00083I-8E
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 06:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbXCGFPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 00:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXCGFPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 00:15:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:44716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932773AbXCGFPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 00:15:15 -0500
Received: (qmail invoked by alias); 07 Mar 2007 05:15:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 07 Mar 2007 06:15:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1964FoSdPp66B2ohyEGCJjY4nd19MniS3VfuWlAIs
	3bQqikS+VeGp2y
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41650>

Hi,

On Tue, 6 Mar 2007, Johannes Schindelin wrote:

> +test_expect_success 'bundle 1 has only 3 files ' '
> +	cd "$D" &&
> +	sed "1,4d" < bundle1 > bundle.pack &&

I fear this would suffer the same fate as t8001, namely that some sed 
would add a newline, which is plain wrong here. This is a workaround:

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce96b4b..f895072 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -110,7 +110,7 @@ test_expect_failure 'unbundle 1' '
 
 test_expect_success 'bundle 1 has only 3 files ' '
 	cd "$D" &&
-	sed "1,4d" < bundle1 > bundle.pack &&
+	dd bs=136 skip=1 if=bundle1 of=bundle.pack &&
 	git index-pack bundle.pack &&
 	test 4 = $(git verify-pack -v bundle.pack | wc -l)
 '

Ciao,
Dscho
