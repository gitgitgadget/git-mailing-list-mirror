From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: fix for "gitk <ambiguous-name> --"
Date: Wed, 4 Jul 2007 20:44:21 +1000
Message-ID: <18059.31237.286280.566140@cargo.ozlabs.ibm.com>
References: <20070703202301.GA24071@informatik.uni-freiburg.de>
	<Pine.LNX.4.64.0707032248570.4071@racer.site>
	<alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
	<Pine.LNX.4.64.0707032353330.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:44:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62LZ-00066f-Ke
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 12:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbXGDKob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 06:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbXGDKob
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 06:44:31 -0400
Received: from ozlabs.org ([203.10.76.45]:45110 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596AbXGDKoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 06:44:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9D49BDDEFE; Wed,  4 Jul 2007 20:44:29 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0707032353330.4071@racer.site>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51591>

Johannes Schindelin writes:

> If you have an ambiguous ref, i.e. a file in the working directory bears
> the same name, you have to use "--" at the end to disambiguate ref from
> file. This works with "git rev-list". Make it work with gitk, too.

This means that if you do "gitk rev -- file" we will end up with two
"--" in the git rev-list command that gitk does.  I think we actually
want the patch below.

Junio: there seems to be an inconsistency between git rev-list and git
rev-parse here.  If a name is both a filename and a ref, git rev-list
will give a fatal error but git rev-parse will take it as a ref.

Paul.

diff --git a/gitk b/gitk
index d509145..502a01a 100755
--- a/gitk
+++ b/gitk
@@ -87,10 +87,7 @@ proc start_rev_list {view} {
 
     set startmsecs [clock clicks -milliseconds]
     set commitidx($view) 0
-    set args $viewargs($view)
-    if {$viewfiles($view) ne {}} {
-	set args [concat $args "--" $viewfiles($view)]
-    }
+    set args [concat $viewargs($view) "--" $viewfiles($view)]
     set order "--topo-order"
     if {$datemode} {
 	set order "--date-order"
