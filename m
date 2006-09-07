From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 17:45:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061737040.27779@g5.osdl.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
 <44FF5C27.2040300@gmail.com> <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
 <44FF6586.8080206@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:45:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL813-0002FN-G0
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbWIGApK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWIGApJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:45:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161034AbWIGApI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 20:45:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k870j2nW004759
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 17:45:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k870j1ng001409;
	Wed, 6 Sep 2006 17:45:02 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44FF6586.8080206@gmail.com>
X-Spam-Status: No, hits=-0.507 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26581>



On Wed, 6 Sep 2006, A Large Angry SCM wrote:
> 
> > Btw, that "keeping the ordering it had" part I'm not convinced we actually 
> > enforce. That would depend on the sort algorithm used by "qsort()", I 
> > think. So there might be room for improvement there in order to keep 
> > things in recency order.
> 
> qsort() is not stable.

Well, quicksort isn't, but a lot of systems don't actually use quicksort 
to implement qsort() - despite the name.

I think, for example, that glibc uses a merge-sort when there are lots of 
entries (to avoid any potential bad behaviour with quicksort), and that 
should be stable. But I didn't actually check..

In fact, I didn't even think of this issue originally, but it might 
actually be worthwhile doing our own sort, exactly because we'll otherwise 
have different systems generating different pack-files due to issues like 
this.

So even if we don't actually _care_ whether the sorting is stable or not, 
we might well care that we always get the same results, regardless of what 
C library we have.

> > Is there any way to get zlib to just generate a suggested dictionary from 
> > a given set of input?
> 
> The docs suggest "no".

Oh, well.

			Linus
