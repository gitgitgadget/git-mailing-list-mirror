From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK FIX)] gitk: Fix the "notflag: no such variable" error in --not processing.
Date: Mon, 1 Dec 2008 20:25:25 +0300
Organization: HOME
Message-ID: <200812012025.25286.angavrilov@gmail.com>
References: <4933F819.1010701@viscovery.net> <49341101.8050400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:28:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7CZA-0007jX-GF
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbYLAR0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbYLAR0z
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:26:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:51993 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbYLAR0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:26:54 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2736122ugf.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GfjEkTxO0HvqX2ymv/IE+lvoGR+xtHqmnxyHUm8d3ns=;
        b=xPQ23kRmYuA2GUDaSCxGGl9F3eIrPhUG2t9IxMM5aq1soqM6rb1SJaEu+qV2ExFn8Y
         /9Jm+GuePvYr5DdPhQ+6kPk/zGAs8fLn/iyWkCvVTjp1SMti3TNUKRiGFMKKsJsUADH2
         Wz7EAYgxPRMdf457QEE81otXCbV3cr3yAX5zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q1JS4+NkKhM9bYKONxoPPJxgOkIg5ZAi56KJmafZpAHb0fROrBtmBB9dmM2V9bFrLV
         wcLfhxHJjJyjE+Yxr56mOW9WBYpl/2bGV6j87XnrOB4P+HdII45eVmfz17w9hD502rHp
         dykXVjDHw94H/vNmYlnKtYLboBTYzoN0dCsM4=
Received: by 10.181.61.18 with SMTP id o18mr4012150bkk.24.1228152412102;
        Mon, 01 Dec 2008 09:26:52 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id d4sm1204730fga.58.2008.12.01.09.26.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 09:26:51 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <49341101.8050400@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102064>

Commit 2958228430b63f2e38c55519d1f98d8d6d9e23f3 fixed the
switch statement used in option processing, which made some of
the previously unreachable cases executable. This uncovered the
fact that the variable used in the handling of the --not option is not
initialized.

This patch initializes it. Note that actually it is also possible to
remove it completely, because currently nobody uses the value.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	On Monday 01 December 2008 19:29:53 Johannes Sixt wrote:
	> > $ git bisect view
	> > Error in startup script: can't read "notflag": no such variable
	> >     while executing
	> > "expr {!$notflag}"
	> >     ("--not" arm line 2)
	> >     invoked from within
	> > "switch -glob -- $arg {
	> >             "-d" -
	> >             "--date-order" {
	> >                 set vdatemode($n) 1
	> >                 # remove from origargs in case we hit an unknown option
	> >                 set origarg..."
	> >     (procedure "parseviewargs" line 21)
	> >     invoked from within
	> > "parseviewargs $view $args"
	> >     (procedure "start_rev_list" line 27)
	> >     invoked from within
	> > "start_rev_list $curview"
	> >     (procedure "getcommits" line 5)
	> >     invoked from within
	> > "getcommits {}"
	> >     (file "/usr/local/bin/gitk" line 10897)
	>
	> Bisection points to this commit:
	> 
	> commit 2958228430b63f2e38c55519d1f98d8d6d9e23f3

 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index f7f1776..6eaeadf 100755
--- a/gitk
+++ b/gitk
@@ -139,6 +139,7 @@ proc parseviewargs {n arglist} {
     set origargs $arglist
     set allknown 1
     set filtered 0
+    set notflag 0
     set i -1
     foreach arg $arglist {
 	incr i
-- 
1.6.0.4.30.gf4240
