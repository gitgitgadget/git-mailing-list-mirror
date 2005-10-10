From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git.sh: quote all paths
Date: Mon, 10 Oct 2005 11:26:38 +0200
Message-ID: <20051010092638.GC18009@diku.dk>
References: <20051010085259.GA18009@diku.dk> <7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 11:27:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOtvl-000721-He
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 11:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJJJ0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 05:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVJJJ0k
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 05:26:40 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:20216 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750710AbVJJJ0k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 05:26:40 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 7F42B6E1983; Mon, 10 Oct 2005 11:26:25 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3B0526E1932; Mon, 10 Oct 2005 11:26:25 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id DE85660FBE; Mon, 10 Oct 2005 11:26:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9881>

This makes it handle spaces in paths.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

Junio C Hamano <junkio@cox.net> wrote Mon, Oct 10, 2005:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > Support installing to paths including spaces.
> > Remove any old .exe files so ln will succeed.
> >
> 
> This is not a complaint but I am just wondering if:
> 
> > -	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
> > +	$(INSTALL) -d -m755 "$(DESTDIR)$(bindir)"
> 
> this is the right way to quote things.  I suspect it might be
> the responsibility of the user to quote them if she chooses to
> set bindir or DESTDIR to a funky value, like this:
> 
>     $ make bindir="'My Documents\Programs'"
> 
> Because depending on how funky the values of bindir and DESTDIR
> are, we cannot say double-quote you are giving them is even the
> right quoting (think double-quote itself as part of the name).

Yeah, ok, it could end up very wrong. I hope that this patch is
acceptable. I've tested it lightly, and the core commands seems to work,
there might be other git scripts that needs to be changed.

> The other "$X" change to cmd-renames is a good change (I thought
> I heard HPA talking about that; maybe he sent one to me and I
> dropped it on the floor by mistake, I dunno).  Thanks.

I also sent a 'disguised' patch in <20051005131631.GA9442@diku.dk> ...

---
diff --git a/git.sh b/git.sh
index 7400c16..19f89d8 100755
--- a/git.sh
+++ b/git.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 cmd=
-path=$(dirname $0)
+path=$(dirname "$0")
 case "$#" in
 0)	;;
 *)	cmd="$1"
@@ -12,13 +12,13 @@ case "$#" in
 		exit 0 ;;
 	esac
 	
-	test -x $path/git-$cmd && exec $path/git-$cmd "$@"
+	test -x "$path/git-$cmd" && exec "$path/git-$cmd" "$@"
 	
 	case '@@X@@' in
 	    '')
 		;;
 	    *)
-		test -x $path/git-$cmd@@X@@ && exec $path/git-$cmd@@X@@ "$@"
+		test -x "$path/git-$cmd.exe" && exec "$path/git-$cmd.exe" "$@"
 		;;
 	esac
 	;;
-- 
Jonas Fonseca
