From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Adding color to git diff output.
Date: Tue, 11 Apr 2006 18:03:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604111801270.14565@g5.osdl.org>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
 <7virpf4sg4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
 <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 03:03:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTTlr-0001Cd-Mi
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 03:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWDLBDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 21:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWDLBDn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 21:03:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWDLBDm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 21:03:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3C13btH018097
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Apr 2006 18:03:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3C13aA7018835;
	Tue, 11 Apr 2006 18:03:36 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18625>



On Tue, 11 Apr 2006, sean wrote:
> 
> What I have is a script ~/bin/gitcdiff:
> 
> #!/bin/sh
> tty -s <&1 || exec cat
> colordiff | less -RS
> 
> And then setting GIT_DIFF_PAGER="~/bin/gitcdiff".  When piping to a file 
> it just uses cat, but when the output is a terminal device it uses the 
> colordiff.
> 
> I thought about integrating that logic into git-diff.sh, but i'm not sure
> it's always appropriate.

Yeah, that's close to what I'd have suggested:

		Linus

----
diff --git a/git-diff.sh b/git-diff.sh
index dc0dd31..f0bea80 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -69,4 +69,8 @@ case "$rev" in
 	;;
 esac
 
+if [ "$GIT_DIFF_PAGER" ] && tty -s <&1; then
+	cmd="$cmd | $GIT_DIFF_PAGER"
+fi
+
 eval "$cmd"
