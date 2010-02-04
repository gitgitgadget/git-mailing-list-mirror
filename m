From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Dealing with many many git repos in a /home directory
Date: Thu, 4 Feb 2010 15:20:18 +0000 (UTC)
Message-ID: <loom.20100204T160327-458@post.gmane.org>
References: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com> <81b0412b1002040157r7af2a587y9cfc7189fc8ad632@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 16:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd3Vu-0002zL-7b
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 16:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360Ab0BDPUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 10:20:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:57181 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932346Ab0BDPUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 10:20:51 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nd3Vd-0002l4-Rf
	for git@vger.kernel.org; Thu, 04 Feb 2010 16:20:47 +0100
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 16:20:45 +0100
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 16:20:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100106 Ubuntu/9.10 (karmic) Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138967>

Alex Riesen <raa.lkml <at> gmail.com> writes:

> 
> On Thu, Feb 4, 2010 at 09:29, demerphq <demerphq <at> gmail.com> wrote:
> > Would i be correct in thinking that if i have to repos with an
> > equivalent  .git/objects/../..... file in them that the files are
> > necessarily identical and one can be replaced by a hardlink to the
> > other?
> 
> Yes, but you probably wont save as much as you'd like: think about the
> users
> who *do* repack their repositories. The .pack files will be all
> different.
> 


Maybe you can:

for each repo
  clone it to some place
  pack it with gc --aggressive
  take the resulting pack and move it (and the associated index) somewhere
  make in the same place a file with the same hash as the pack and extension
    keep and possibly, inside, some note about its content (e.q. what repo
    was cloned and at what state/time it was so frozen).
  ask the users to go in the .git/objects/packs dir of their private copy
    of the corresponding repo and hardlink there the .pack, .idx, .keep
    file that you have prepared
  ask the users to invoke git gc

Before actually doing that on something important, maybe wait have the
confirmation from some developer that there is not something flawed in the
approach.

Personally, I tend to use keep files a lot because I need to keep two
machines synchronized using "unison". Without keep files, large packs are
changed at every gc and the synchronization takes ages. By "freezing" a
stable subset of my objects I maintain the changing packs much smaller and
reduce the amount of data that needs to be carried over by unison to keep
the two machines in sync.
