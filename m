From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: empty directories
Date: Wed, 22 Aug 2007 16:25:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh England <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Thu Aug 23 01:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INzaL-0000Pz-Ia
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 01:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762384AbXHVXZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 19:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760132AbXHVXZc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 19:25:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45238 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758826AbXHVXZc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 19:25:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MNPR9p008073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 16:25:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MNPLBA010320;
	Wed, 22 Aug 2007 16:25:22 -0700
In-Reply-To: <1187817948.5986.159.camel@beauty>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56435>



On Wed, 22 Aug 2007, Josh England wrote:
>
> The main need is for file ownership/permission, which has been touched 
> on before.  When I clone an image, I really want an *identical* clone, 
> in every way.  It seems as though git had this functionality but 
> scrapped it due to issues with umask and merge type problems?

Well, git had all permission bits, but never ownership. And yes, using 
more than the one user-x-bit ended up being totally unusable for source 
code, because of different people having different umask, so we 
effectively dropped the permission bits too (although the data format was 
retained, so we could re-introduce then with some flag that says "honor 
all permission bits, not just the x bit").

But the ownership thing we've never even tried to support, since it was so 
obviously not something that was appropriate for a distributed project. So 
if you want an identical clone with ownership and (full) permissions, you 
really do need to have some alternate way to fill in the blanks.

I've argued that ".gitattributes" may be an acceptable alternate, 
especially since ownership is often something that is less than "per 
file", and more often "has certain patterns".

> So the question is:  would there be any way to bring this functionality 
> back as a non-default configurable option?  For those of us who need the 
> functionality, we'd be more than willing to live with some of the 
> side-effects.

Full permissions might be easy enough to resurrect, but since it's still 
pointless without ownership, that really isn't even relevant.

But if .gitattributes would work, you probably could introduce both full 
permissions and ownership rules there. We read git attributes for *other* 
reasons when checking files out _anyway_, ie we need the CRLF attribute 
stuff, so adding ownership attributes would not be at all odd.

		Linus
