From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND] [PATCH] fix gitk with lots of tags
Date: Tue, 18 Apr 2006 11:38:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181132440.3701@g5.osdl.org>
References: <20060406203637.GA15009@blackbean.org> <20060418180614.GA31543@blackbean.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 18 20:39:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVv6H-0005GZ-4E
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWDRSis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWDRSis
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:38:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932270AbWDRSir (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 14:38:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3IIcXtH013367
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 11:38:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3IIcW5R020898;
	Tue, 18 Apr 2006 11:38:33 -0700
To: Jim Radford <radford@blackbean.org>
In-Reply-To: <20060418180614.GA31543@blackbean.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18869>



On Tue, 18 Apr 2006, Jim Radford wrote:
> 
> I've gotten no reposnse from Paul on this patch[1].  If it seems ok to
> you, would you mind putting it in your queue for him?  I hate to see
> gitk die with "argument list too long" messages.  They're so 640k.

Don't do this patch. It's wrong.

However, this simpler patch might be ok.

It just depends on the fact that git-rev-list can parse everything that 
git-rev-parse used to do these days, and thus the git-rev-parse call 
really isn't needed any more (and if that isn't true for some odd 
argument, we should make it true).

So the only thing we need to do is to add the "--default HEAD" thing to 
the front of the argument list.

		Linus

---
diff --git a/gitk b/gitk
index 87e7162..5d95779 100755
--- a/gitk
+++ b/gitk
@@ -19,16 +19,7 @@ proc gitdir {} {
 proc parse_args {rargs} {
     global parsed_args
 
-    if {[catch {
-	set parse_args [concat --default HEAD $rargs]
-	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
-    }]} {
-	# if git-rev-parse failed for some reason...
-	if {$rargs == {}} {
-	    set rargs HEAD
-	}
-	set parsed_args $rargs
-    }
+    set parsed_args [concat --default HEAD $rargs]
     return $parsed_args
 }
 
