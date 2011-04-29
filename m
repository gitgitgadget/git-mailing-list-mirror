From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] git-cvsimport: normalize hostname for password lookup
Date: Fri, 29 Apr 2011 15:09:51 +0200
Message-ID: <m2oc3pxkyo.fsf_-_@igel.home>
References: <ipckgd$krd$2@dough.gmane.org> <m2sjt1xpfj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcin =?utf-8?Q?Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 15:10:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFnSK-0007rl-TH
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 15:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942Ab1D2NJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 09:09:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43911 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756960Ab1D2NJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 09:09:55 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 9EC5C1C00585;
	Fri, 29 Apr 2011 15:09:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 9B6241C00120;
	Fri, 29 Apr 2011 15:09:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 4IUDn5kWCFo7; Fri, 29 Apr 2011 15:09:52 +0200 (CEST)
Received: from igel.home (ppp-93-104-140-6.dynamic.mnet-online.de [93.104.140.6])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 29 Apr 2011 15:09:52 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 148C8CA29C; Fri, 29 Apr 2011 15:09:51 +0200 (CEST)
X-Yow: Can I have an IMPULSE ITEM instead?
In-Reply-To: <m2sjt1xpfj.fsf@igel.home> (Andreas Schwab's message of "Fri, 29
	Apr 2011 13:33:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172452>

When looking up the pserver password in .cvspass normalize the hostname
part of the address by converting it to lowercase.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 git-cvsimport.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bbf327f..046fe32 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -249,6 +249,8 @@ sub conn {
 
 		# if username is not explicit in CVSROOT, then use current user, as cvs would
 		$user=(getlogin() || $ENV{'LOGNAME'} || $ENV{'USER'} || "anonymous") unless $user;
+		# Normalize hostname for lookup in .cvspass
+		$serv = lc $serv;
 		my $rr2 = "-";
 		unless ($port) {
 			$rr2 = ":pserver:$user\@$serv:$repo";
@@ -263,6 +265,8 @@ sub conn {
 				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
 				while (<H>) {
 					chomp;
+					# FIXME: entries without version prefix
+					# may need to be normalized
 					s/^\/\d+\s+//;
 					my ($w,$p) = split(/\s/,$_,2);
 					if ($w eq $rr or $w eq $rr2) {
-- 
1.7.5


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
