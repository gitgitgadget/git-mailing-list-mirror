From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Using VC build git
Date: Mon, 10 Aug 2009 16:29:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101609170.8324@intel-tinevez-2-302>
References: <1976ea660908100656u57407131h83761329468607a8@mail.gmail.com> <alpine.DEB.1.00.0908101606220.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 16:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaVt7-0007bY-Ab
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbZHJOaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbZHJOaC
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:30:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:55435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753516AbZHJOaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:30:00 -0400
Received: (qmail invoked by alias); 10 Aug 2009 14:30:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 10 Aug 2009 16:30:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19f2eVk57FfXXqOwsGawHVLaMA87ptWocY5vO6w2B
	MRfglTMx6fRlGa
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0908101606220.8324@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125449>

Hi,

On Mon, 10 Aug 2009, Johannes Schindelin wrote:

> Please, we have _high_ standards in git.git, and I really do not want to 
> have to take anything to Junio that does not fulfill that standard.

To elaborate:  if I see something like this in the --stat:

 contrib/vcbuild/include/zlib.h        | 1357 +++++++++++++++++++++++++++++++++
 contrib/vcbuild/lib/zlib.lib          |  Bin 0 -> 104148 bytes

... I know already that there is no way this can make it into git.git.  
There just is not.

Also, if the first commit says nothing else than "Rebase to v1.6.4", it 
is pretty obvious to me that I will not sign off on that (and I just guess 
that is the very reason you did not sign off on that, either).

Further, putting anything into contrib/ that really belongs into contrib/ 
is not cutting it, either.

And I am pretty astonished that mingw.[ch] is touched, as VC is definitely 
not MinGW32.

Changing 1000+ lines of libgit.vcproj in almost every commit is also 
something I really do not look upon favorably.

Finally, if _no single_ commit message says _anything_ about the reasons 
why you had to change code outside of vcbuild/, I am only puzzled.

Now, I want to give you a pretty clear idea what has to be done if this is 
going into 4msysgit.git, ever, because you obviously spent a lot of time 
on it, and other people want it, too:

- changing "open" to "_open" in mingw.c is a no-no-no.  If you need to use 
  "_open" in VC, then define "open" in the compile flags for mingw.c, but 
  leave code that is not written for VC alone.

- introducing trailing whitespace is usually a sign of not caring enough 
  about clean and neat code.  So just don't do it.

- making link() fail on MinGW32 just to be able to compile it with VC is 
  outright rude against all people who use a free and open compiler 
  instead of a closed one.

- changing an "_snprintf" to "_vsnprintf" in vcbuild/porting.c without 
  anything else is a clear and loud sign that the code before was broken, 
  and that you fix a faulty patch in a later patch.  This is not how we do 
  things in git.git.  We fix the proper patch before the patch series is 
  accepted into mainline.

- violating the coding style -- even if it is in your VC-specific part -- 
  is not an option.  You need to fix the coding style.

- violating the coding style in files that are not VC-specific is not an 
  option at all.  You really need to fix it.

- changing the default editor from "vi" to "notepad2" will break almost 
  every existing Git user's setup.  That is just inexcusable.

Note: these comments are _just for the last_ of your 5 patches.

Just a brief comment on the 4th patch, because I really do not want to 
spend more time on this round of patches: spelling the opendir() function 
as "open dir" function in the commit message is misleading, to say the 
least, and moving code that was added in a previous patch in the same 
patch series just shows that it was a mistake to begin with.  Besides, 
don't move anything into mingw.c if MinGW32 does not need it.

Hth,
Dscho
