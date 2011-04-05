From: David Fries <david@fries.net>
Subject: Re: Git exhausts memory.
Date: Mon, 4 Apr 2011 21:22:35 -0500
Message-ID: <20110405022235.GA4414@spacedout.fries.net>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
 <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
 <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:34:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6w5x-0000VW-UA
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab1DECeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:34:12 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:48331 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab1DECeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:34:12 -0400
X-Greylist: delayed 688 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Apr 2011 22:34:11 EDT
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p352Mava024699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 4 Apr 2011 21:22:36 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p352MZv1024698;
	Mon, 4 Apr 2011 21:22:35 -0500
Content-Disposition: inline
In-Reply-To: <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Mon, 04 Apr 2011 21:22:37 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170863>

On Mon, Apr 04, 2011 at 09:57:01PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Mon, Apr 4, 2011 at 7:52 PM, Alif Wahid <alif.wahid@gmail.com> wrote:
> > Hi Nicolas,
> >
> > On 4 April 2011 01:18, Nicolas Pitre <nico@fluxnic.net> wrote:
> >>
> >> Something you can try is to simply tell Git not to attempt any delta
> >> compression on those tar files using gitattributes (see the man page of
> >> the same name).
> 
> Should we change the default to not delta if a blob exceeds predefined
> limit (say 128M)? People who deliberately wants to delta them can
> still set delta attr. 1.8.0 material maybe?

I think it would be better to define it in terms of available memory.
Something like the minimum of system memory or address space, and
delta up to X amount of that (it might be good to leave off swap to
reduce trashing).  There has to be a better way than a straight 128MB
default.

The number which works on my 8GB desktop is going to kill the computer
in the trunk of my car with 48MB of ram.  I've actually seen a 700 MB
repository fail with `git-gc --aggressive` on a system with 4GB of ram
because it ran out of memory, it only worked by leaving off the
--aggressive option.

> > Seems to have worked. Both git-gc and git-repack appear to be less
> > memory hungry now and do actually run to completion without failure.
> >
> > Thanks for your help.
> -- 
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
David Fries <david@fries.net>    PGP pub CB1EE8F0
http://fries.net/~david/
