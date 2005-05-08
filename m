From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: cg-log patches
Date: Mon, 9 May 2005 01:49:36 +0200
Message-ID: <20050508234936.GA26624@diku.dk>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 01:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUvQ1-0002KH-C9
	for gcvg-git@gmane.org; Mon, 09 May 2005 01:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVEHXtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 19:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbVEHXtq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 19:49:46 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:57804 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S263014AbVEHXth (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 19:49:37 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 587986E27C6; Mon,  9 May 2005 01:49:36 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1827B6E1707; Mon,  9 May 2005 01:49:36 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5350161FDE; Mon,  9 May 2005 01:49:36 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <1742.10.10.10.24.1115573750.squirrel@linux1>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote Sun, May 08, 2005:
> commit 33762f33ee87377c0cfcea51382bad04d7c9ba8d
> 
>     Fix cg-log -f option so that a complete list of files is
>     displayed when a commit has more than one parent.

This sounds great.

>     Move the list of files so they're displayed after the
>     commit message

The reason I put it at the top was to make it more similar to GNU-style
changelogs (if there is such a style).

>     List the files in columns, instead of one big line of comma-
>     separated files.

I think that will make `-f' less usable because of the extra scrolling.

Assuming use of wc will not create more dependency nightmares and the
extra overhead is acceptable here is a patch that will wrap file listing
lines near the 80th column.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- d4119364a7fbf5a4b8f00f061e4f5d58fa4abd0e/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -64,8 +64,16 @@
 	fi
 	echo
 	$list_cmd | while read modes type sha1s file; do
-		echo -n "$sep$file"
+		echo -n "$sep"
 		sep=", "
+		if [ $(echo "$line$sep$file" | wc -c) -lt 75 ]; then
+			line="$line$sep$file"
+			echo -n "$file"
+		else
+			line="$file"
+			echo "$coldefault"
+			echo -n "    $colfiles$file"
+		fi
 	done
 	echo "$coldefault:"
 }

-- 
Jonas Fonseca
