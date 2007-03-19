From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: Use merge.tool config option.
Date: Sun, 18 Mar 2007 22:32:38 -0400
Message-ID: <20070319023238.GC11371@thunk.org>
References: <11742343911678-git-send-email-jbowes@dangerouslyinc.com> <7vwt1em6gf.fsf@assigned-by-dhcp.cox.net> <3f80363f0703181811x54acb3f4n689f4fd68f5a5dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7fv-0004MG-Cp
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933686AbXCSCcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933701AbXCSCcm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:32:42 -0400
Received: from THUNK.ORG ([69.25.196.29]:34688 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933686AbXCSCcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:32:41 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT7lh-0001Ot-CK; Sun, 18 Mar 2007 22:38:41 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT7fq-0006jR-JR; Sun, 18 Mar 2007 22:32:38 -0400
Content-Disposition: inline
In-Reply-To: <3f80363f0703181811x54acb3f4n689f4fd68f5a5dbe@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42564>

It seemed to me that Junio's suggestion made the most amount of sense,
but I tinkered with the with the warning message to make it clear that
the cause of the warning was a bugus tool in the merge.tool
configuration parameter.

This has also been pushed out to git://repo.or.cz/git/mergetool.git

Junio, please pull if you approve...

					- Ted

commit d6678c28e30e836449092a2917d4b0bd6254b06c
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun Mar 18 22:30:10 2007 -0400

    mergetool: print an appropriate warning if merge.tool is unknown
    
    Also add support for vimdiff
    
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 563c5c0..7942fd0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -288,10 +288,15 @@ done
 
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
-    if test $merge_tool = kdiff3 -o $merge_tool = tkdiff -o \
-	$merge_tool = xxdiff -o $merge_tool = meld ; then
-	unset merge_tool
-    fi
+    case "$merge_tool" in
+	kdiff3 | tkdiff | xxdiff | meld | emerge | vimdiff)
+	    ;; # happy
+	*)
+	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
+	    echo >&2 "Resetting to default..."
+	    unset merge_tool
+	    ;;
+    esac
 fi
 
 if test -z "$merge_tool" ; then
