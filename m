From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 20:57:38 +0200
Message-ID: <1115578658.8949.9.camel@pegasus>
References: <1115564550.9031.96.camel@pegasus>
	 <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus>
	 <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus>
	 <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus>
	 <20050508173003.GY9495@pasky.ji.cz> <1115574035.9031.145.camel@pegasus>
	 <20050508175156.GA9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ZcPfTviVKUmgSEZBgA0I"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 20:51:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUqrG-0007EO-KU
	for gcvg-git@gmane.org; Sun, 08 May 2005 20:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVEHS50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 14:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVEHS50
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 14:57:26 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:60333 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262917AbVEHS5P
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 14:57:15 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48IwXWX004747
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 20:58:34 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508175156.GA9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ZcPfTviVKUmgSEZBgA0I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

> > > > Sometime you don't have any other choice, because diff is not perfect.
> > > > Do you wanna apply that patch or should I change the mktemp templates
> > > > first?
> > > 
> > > It looks like it'll be most painless when I just reinvent parts of your
> > > patch here locally and you can send me patches on top of that.
> > 
> > it is your choice. I can change that if you like. My latest version
> > should apply cleanly against your current tree.
> 
> I've pushed my changes, please have a look at them. I think I've got
> everything important, but I might've forgot something.

look at the attached patch. We should use "fmt -s" to keep newlines that
are inside the commit message and there is one unneeded empty CG: line.

I also put back in the "mess", because if there is no commit message
provided via -m it gives us an initial empty line to start in. This is
the same that CVS does and it makes the life inside vi a lot more
easier.

The change (aka the "mess") looks crazy, but play with the different
situations and see what it does.

> > If you want the extra newline(s) then it is a good idea to add something
> > that strips heading and trailing empty lines from the final commit
> > message, because otherwise it will be ugly if you don't enter extra text
> > for the merge.
> 
> Isn't that what I initially suggested? :-)

But this hasn't been done so far. And I don't know any shell tool for
this job, beside some crazy awk or sed stuff. However stripspace.c from
git-tools can do this job.

Regards

Marcel


--=-ZcPfTviVKUmgSEZBgA0I
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cg-commit: needs update
Index: cg-commit
===================================================================
--- 6054af5ea0ef88077ad91131b0411dd10590b863/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -80,17 +80,23 @@
 		[ "$msgs" ] && echo "$uri"
 	done
 	echo >>$LOGMSG
+else
+	first=1
 fi
-first=1
+
 for msg in "${msgs[@]}"; do
 	if [ "$first" ]; then
 		first=
 	else
 		echo >>$LOGMSG
 	fi
-	echo $msg | fmt >>$LOGMSG
+	echo $msg | fmt -s >>$LOGMSG
 done
 
+if [ "$first" ]; then
+	echo >>$LOGMSG
+fi
+
 cat >>$LOGMSG <<EOT
 CG: -----------------------------------------------------------------------
 CG: Lines beginning with the CG: prefix are removed automatically
@@ -108,7 +114,6 @@
 		echo "CG:    $file" >>$LOGMSG
 		[ "$msgs" ] && echo $file
 	done
-	echo "CG:" >>$LOGMSG
 fi
 echo "CG: -----------------------------------------------------------------------" >>$LOGMSG
 

--=-ZcPfTviVKUmgSEZBgA0I--

