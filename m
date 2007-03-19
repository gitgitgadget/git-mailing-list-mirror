From: Nicolas Pitre <nico@cam.org>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 11:20:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191116181.18328@xanadu.home>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org>
 <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org>
 <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org>
 <20070319032130.GF11371@thunk.org> <20070319035351.GI20658@spearce.org>
 <alpine.LFD.0.83.0703182355570.18328@xanadu.home>
 <20070319062525.GH11371@thunk.org> <7vzm69ivfg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 16:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTJfD-0001U9-Bx
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 16:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966015AbXCSPUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 11:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966014AbXCSPUr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 11:20:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9825 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966015AbXCSPUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 11:20:46 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF500H3MPAC5S50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 11:20:37 -0400 (EDT)
In-reply-to: <7vzm69ivfg.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42626>

On Sun, 18 Mar 2007, Junio C Hamano wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
> > Right, but if the branch being pointed to is pointed to by HEAD I
> > would argue that the reflog for HEAD should be updated, since
> > operations that reference HEAD will see a new commit, and and it will
> > be confusing when "git reflog" shows no hint of the change.
> >
> > Of couse, if the branch being pushed to isn't one which is pointed by
> > HEAD, of course HEAD's reflog shouldn't be updated.
> 
> If we were to do this properly, we probably would need to
> restructure the reflog update code for the HEAD in a major way.
> "git-update-ref refs/heads/foo $newvalue" when HEAD points at
> branch 'foo' currently does not update HEAD reflog because the
> current definition of HEAD reflog is (as Nico mentioned) log of
> changes made through HEAD symref.  Instead, we would need a
> reverse lookup every time any ref is updated to see if that ref
> is pointed by any symbolics ref and update the reflogs of those
> symbolic refs.  This is expensive to do in general, though,
> because there is no backpointer to list of symbolic refs that
> point at a non-symbolic ref.

But practically speaking... is there that many cases where a branch is 
updated directly instead of the operation performed through HEAD?

We identified one case which is a push to a non bare repo.

If those cases are very few (and they _should_ be very few) then we 
might simply cheat a little and update HEAD separately in those cases.


Nicolas
