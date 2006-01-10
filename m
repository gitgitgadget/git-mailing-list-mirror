From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Tue, 10 Jan 2006 15:49:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601101540070.26054@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net> <43C2CAED.8030304@cc.jyu.fi>
 <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net> <43C2F7E2.4090909@cc.jyu.fi>
 <43C2FE4A.50203@op5.se> <7v1wzgg9nm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 15:49:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwKoC-0004yG-4W
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 15:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWAJOtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 09:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAJOtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 09:49:09 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:13234 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751089AbWAJOtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 09:49:08 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9EE12E27C0; Tue, 10 Jan 2006 15:49:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 8DE9C98D;
	Tue, 10 Jan 2006 15:49:04 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 71C308F5;
	Tue, 10 Jan 2006 15:49:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61EA41412D2; Tue, 10 Jan 2006 15:49:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wzgg9nm.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14420>

Hi,

On Mon, 9 Jan 2006, Junio C Hamano wrote:

> Andreas Ericsson <ae@op5.se> writes:
> 
> > I have no solution to this, apart from rewriting the Makefile on the
> > fly whenever a release tarball is created.
> 
> Well, there is always an option to update the fallback version
> number hardcoded in GIT-VERSION-GEN script, but that kind fo
> defeats the whole idea of the current setup, so...

The whole idea of the current setup is working only if you have a git 
repository of git. Kind of a chicken-egg, right?

So, why not just include GIT-VERSION-FILE in the tarball, and let 
GIT-VERSION-GEN check if there exists .git or $GIT_DIR before trying its 
voodoo?

---

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 845b9dc..b65b214 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,6 +2,9 @@
 
 GVF=GIT-VERSION-FILE
 
+test -z "$GIT_DIR" && GIT_DIR=.git
+test -d "$GIT_DIR" || exit 0
+
 VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
 VN=$(expr "$VN" : v'\(.*\)')
 if test -r $GVF
