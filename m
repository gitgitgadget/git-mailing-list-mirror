From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 10:21:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003270959110.694@xanadu.home>
References: <20100326215600.GA10910@spearce.org> <4BAD3C6E.4090604@gmail.com>
 <20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
 <alpine.LFD.2.00.1003262125120.694@xanadu.home>
 <20100327013443.GE10910@spearce.org>
 <alpine.LFD.2.00.1003262142121.694@xanadu.home>
 <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_g88DO9BWaPl8mdA1yz7NpQ)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 15:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvWtj-0008Le-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 15:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab0C0OVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 10:21:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30004 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab0C0OVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 10:21:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZY00KYA2JU4860@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Mar 2010 10:21:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143334>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_g88DO9BWaPl8mdA1yz7NpQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 27 Mar 2010, Scott Chacon wrote:

> Hey,
> 
> Sorry it's taken me a bit - I'm traveling right now.
> 
> On Fri, Mar 26, 2010 at 6:56 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > > Given that GitHub has blessed the world with this corruption,
> >> > > we may need to modify JGit to accept it.
> 
> Well, shouldn't it accept it just because CGit accepts it?  Isn't that
> an incompatibility in implementation?

CGit fsck complains about it.  This should be sufficient a clue to 
avoid such things.

> >> But GitHub's approach here seems to be "Meh, its fine, don't worry
> >> about it".
> 
> That isn't really my approach, I actually thought I had fixed this a
> while ago.  It seems to be a pretty understandable mistake, since
> ls-tree and cat-file -p both output zero padded modes and it is only
> an issue on trees with subtrees, obviously, so we don't see it all the
> time at GitHub.  I have fixed this and it's in the queue for
> deployment which should be in the next few days (I gotta get home
> first).

Thanks.

> > It's up to GitHub to fork Git then, and while at it stop calling it Git
> > compatible.  Really.  If we start to get slack about the pack format
> > like this then every Git reimplementation du jour will make similar
> > deviations except in different directions and we'll end up with a mess
> > to support.
> 
> Really?  It's not the pack format - we use stock Git servers and
> almost always have.  It's the tree writing when someone edits a file
> inline - I was writing out zero-padded trees. And, it _is_ Git
> compatible - CGit only issues a warning, and that only if the
> circumstances align such that we write a tree with a subtree, which
> again is pretty rare.  There are only a handful of projects like this
> and in all CGit circumstances makes no practical difference.

It is still damn important to those with an interest in pack format 
improvements that only one way of creating a tree object exists, 
especially as we stamp a SHA1 hash on it.  Whatever we do with the tree 
encoding in the future, it is essential that the canonical expression of 
any tree object be unambiguous and always produce the same hash.

> > My stance has always been that the C Git is authoritative with regards to
> > formats and protocols.  It's up to Github to fix their screw-up.
> 
> It is fixed and will be deployed soon, but really, there is no reason
> to be snippy.  It is a simple and minor mistake effecting very few
> repositories (maybe 100 out of 730k), and the only reason it's an
> issue at all is that JGit is not following the authoritative CGit
> implementation of basically ignoring it.

But again CGit's fsck is not ignoring this discrepancy.  And if the CGit 
core is otherwise silently accepting it then it is a mistake.

> Also, if we're all concerned about "Git reimplementation du jour"
> deviations, then we need to focus on libifying Git so there isn't a
> need for such re-implementations.  I'm hoping to help with a possible
> GSoC project on libgit2, but the lack of a linkable library will
> ensure that re-implementations in nearly every useful language will
> continue.

Don't get me wrong.  I'm not against Git reimplementations per se, as 
long as they rigorously implement the exact format and protocol from 
CGit.  In that sense it is important that the CGit fsck and verify-pack 
tools be exploited on objects/packs produced by alternate Git 
implementation systematically to find such issues.


Nicolas

--Boundary_(ID_g88DO9BWaPl8mdA1yz7NpQ)--
