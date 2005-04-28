From: Linus Torvalds <torvalds@osdl.org>
Subject: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 11:28:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 28 20:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRDfN-0005e0-Az
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 20:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVD1S2B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 14:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVD1S07
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 14:26:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:62148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262209AbVD1S0o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 14:26:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SIQfs4027510
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 11:26:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SIQeU8032668;
	Thu, 28 Apr 2005 11:26:41 -0700
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Right now my major gripe with cogito is "cg-log" (which is actually the 
only command I use right now, everything else I just do by hand with the 
raw git archive) is that bash is being an ass about SIGPIPE, and when I 
only look at the top part of the log, ie I do something like:

	torvalds@ppc970:~/src/cogito> git log | head

it spews out the ten first lines of the log, and then it spews about a 
million lines (well, 20, but anyway) of crap:

	/home/torvalds/bin/cg-log: line 87:  6338 Done                    echo -n $color$key $rest
	      6339 Broken pipe             | sed "s/>.*/> ${pdate/+0000/$tz}/"
	/home/torvalds/bin/cg-log: line 87:  6328 Done                    cat-file commit $commit
	      6329 Broken pipe             | while read key rest; do
	    case "$key" in 
	        "author" | "committer")
	            if [ "$key" = "author" ]; then
	                color="$colauthor";
	            else
	                color="$colcommitter";
	            fi; date=(${rest#*> }); sec=${date[0]}; tz=${date[1]}; dtz=${tz/+/}; lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec); pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"; if [ "$pdate" ]; then
	                echo -n $color$key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"; echo $coldefault;
	            else
	                echo $color$key $rest $coldefault;
	            fi
	        ;;
	        "")
	            echo; sed -re '
	                                        / 
	*Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
	                                        s/./    &/
	                                '
	        ;;
	        *)
	            echo $colheader$key $rest $coldefault
	        ;;
	    esac;
	done

which is just incredibly annoying, since it makes the ten lines I actually 
_wanted_ to get scroll off the screen..

Damn bash. What's the magic incantation that says SHUT UP!?

		Linus
