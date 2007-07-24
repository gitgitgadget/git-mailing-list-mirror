From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 13:06:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241252040.28577@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
 <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
 <46A5DF1F.2030307@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDJ9z-00089S-AX
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 14:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbXGXMGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 08:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756488AbXGXMGg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 08:06:36 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43133 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754255AbXGXMGf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 08:06:35 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 3E171B9A23
	for <git@vger.kernel.org>; Tue, 24 Jul 2007 13:06:33 +0100 (BST)
Received: (qmail 1367 invoked by uid 103); 24 Jul 2007 13:06:29 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3747. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03121 secs); 24 Jul 2007 12:06:29 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 24 Jul 2007 13:06:29 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <46A5DF1F.2030307@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53577>

On Tue, 24 Jul 2007, Marius Storm-Olsen wrote:

>>  I do not know this is an appropriate itch to scratch for a Windows
>>  developer to begin with.  The new-workdir setting *is* about
>>  symlinked .git/ metainfo space.  If somebody wants to work on a
>>  filesystem without symlink, he should not be using new-workdir but
>>  something else.  E.g. GIT_DIR + GIT_WORK_TREE, or perhaps GIT_DIR +
>>  core.worktree comes to mind.
>
> That's is definitely an option, though it seems to me that its more like 
> giving up than a finding a proper solution. In any case, it would result in 
> two completely different workflows on systems with and without symlink 
> support. I work on both, and would like my workflow to be consistent. Of 
> course I could easily add my own scripts on top to achieve this, but then 
> we're going back into h4x0r land and not making Git more 'available'.
>
> The new-workdir feature doesn't *have* to be about symlinked .git/ metainfo 
> space, but could also be about symref'ed .git/ metainfo.
> (A discussion was done in 2005s "Getting rid of symlinks in .git?", but the 
> conclusion was that it would slow it down too much? *ponder*)

Symref'ed isn't really the right term ... we're not talking about refs 
here.  You would have to basically implement symlinks _inside_ git ...

New-workdir really _is_ all about symlinks.  It already exists as a 
contrib feature - and moving it into core is (as I understand it) really 
just moving it, not redesigning.

If you were going to avoid symlinks, then probably the cleanest way would 
be to have an explict way to point at the actual repo - rather than making 
the working look like a repo if you squint hard enough.  Which sounds 
rather like it would be an extension to GIT_DIR + GIT_WORK_TREE.  I 
haven't looked at it, but it shouldn't be too hard to have a mechanism 
that automatically does GIT_DIR=<there> GIT_WORK_TREE==<here> when the 
appropriate setup is in place?  Though you would have to get it into all 
the appropriate places ...

-- 
Julian

  ---
<aav> coffee on an empty stomach is pretty nasy
<knghtbrd> aav: time to run to the vending machine for cheetos
<aav> cheetos? :)
