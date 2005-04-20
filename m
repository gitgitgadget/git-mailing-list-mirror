From: Steven Cole <elenstev@mesatop.com>
Subject: Re: Possible problem with git-pasky-0.6.2 (patch: **** Only garbage was found in the patch input.)I
Date: Wed, 20 Apr 2005 17:15:00 -0600
Message-ID: <200504201715.00058.elenstev@mesatop.com>
References: <200504201706.09656.elenstev@mesatop.com> <20050420231212.GN19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:15:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOPF-0005bE-E9
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDTXTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVDTXTK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:19:10 -0400
Received: from taco.zianet.com ([216.234.192.159]:40460 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261830AbVDTXTD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:19:03 -0400
Received: (qmail 75849 invoked from network); 20 Apr 2005 23:19:02 -0000
Received: from 216-31-65-218.zianet.com (216.31.65.218)
  by 0 with SMTP; 20 Apr 2005 23:19:02 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <20050420231212.GN19112@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 April 2005 05:12 pm, Petr Baudis wrote:
> Dear diary, on Thu, Apr 21, 2005 at 01:06:09AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
> > After getting the latest tarball, and make, make install:
> > 
> > Tree change: 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea322221
> > *100755->100755 blob    a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67->74b4083d67eda87d88a6f92c6c66877bba8bda8a     gitcancel.sh
> > Tracked branch, applying changes...
> > Fast-forwarding 55f9d5042603fff4ddfaf4e5f004d2995286d6d3 -> a46844fcb6afef1f7a2d93f391c82f08ea322221
> >         on top of 55f9d5042603fff4ddfaf4e5f004d2995286d6d3...
> > patch: **** Only garbage was found in the patch input.
> > 
> > This may be a harmless message, but I thought I'd bring it to your attention.
> 
> This _is_ weird. What does
> 
> 	$ git diff -r 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea32222
> 
> tell you? 

[steven@spc git-pasky-0.6.2]$ git diff -r 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea32222
Index: gitcancel.sh
===================================================================
--- f29be8140c5f1175052ec96ad2fa2b2901fd6ba5/gitcancel.sh  (mode:100755 sha1:a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67)
+++ 2e1f16579fdcd9cd5d242f53a3cfaad52ac5d207/gitcancel.sh  (mode:100755 sha1:74b4083d67eda87d88a6f92c6c66877bba8bda8a)
@@ -13,6 +13,19 @@
 [ -s ".git/add-queue" ] && rm $(cat .git/add-queue)
 rm -f .git/add-queue .git/rm-queue

+# Undo seek?
+branch=
+[ -s .git/blocked ] && branch=$(grep '^seeked from ' .git/blocked | sed 's/^seeked from //')
+if [ "$branch" ]; then
+       echo "Unseeking: $(cat .git/HEAD) -> $(cat ".git/heads/$branch")"
+       if [ -s ".git/heads/$branch" ]; then
+               rm .git/HEAD
+               ln -s "heads/$branch" .git/HEAD
+       else
+               echo "ERROR: Unknown branch $branch! Preserving HEAD." >&2
+       fi
+fi
+
 rm -f .git/blocked .git/merging .git/merging-sym .git/merge-base
 read-tree $(tree-id)





> What if you feed it to patch -p1? 
I haven't done that yet, awaiting response to above.

> What if you feed it to git  
> apply?
> 
> Thanks,
> 
Your're welcome.  I'll do the "git patch -p1 <stuff_from_above" if that's what's needed,
same with git apply.  Corrrections to syntax apprceciated.
Steven
