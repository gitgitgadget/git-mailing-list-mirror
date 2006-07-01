From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Use autoconf to write installation directories to config.mak
Date: Sat, 01 Jul 2006 15:58:13 +0200
Organization: At home
Message-ID: <e85v14$85c$1@sea.gmane.org>
References: <200606290301.51657.jnareb@gmail.com> <E1FvvuX-0002Lr-Nt@moooo.ath.cx> <e80lnq$9mi$1@sea.gmane.org> <44A51693.5020501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 01 15:58:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwfzM-0004qJ-9n
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 15:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWGAN6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 09:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGAN6H
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 09:58:07 -0400
Received: from main.gmane.org ([80.91.229.2]:32463 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750838AbWGAN6F (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 09:58:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fwfz2-0004p6-Bd
	for git@vger.kernel.org; Sat, 01 Jul 2006 15:58:04 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 15:58:04 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 15:58:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23046>

Andreas Ericsson wrote:

> This is bad, since it forces users to do one thing first and then do 
> what they're used to. Better to have the script add
> 
> -include config.mak.autogen
> 
> LAST in config.mak, unless it's already in the file and generate 
> config.mak.autogen with configure.
> 
> Since Make does things bottoms-up (much like swedish students and 
> midsummer celebrators), the previous hand-edited defaults in config.mak 
> will beat the ones in config.mak.autogen (a good thing).

That's not true, unless we use '?=' assignment in Makefile. And we _want_ to
override defaults provided in main git Makefile, so in config.mak.autoconf,
and probably in user's own config.mak we use '=' overriding assignment. So
it would be better to just add "-include config.mak.autogen" to makefile
before "-include config.mak", as in patch below.

diff --git a/Makefile b/Makefile
index ccd7c62..a37d400 100644
--- a/Makefile
+++ b/Makefile
@@ -333,6 +333,7 @@ ifneq (,$(findstring arm,$(uname_M)))
        ARM_SHA1 = YesPlease
 endif
 
+-include config.mak.autogen
 -include config.mak
 
 ifdef WITH_OWN_SUBPROCESS_PY


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
