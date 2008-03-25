From: Jan Hudec <bulb@ucw.cz>
Subject: Auto detaching head options (Re: Working copy revision and push
	pain)
Date: Tue, 25 Mar 2008 20:25:52 +0100
Message-ID: <20080325192552.GC4857@efreet.light.src>
References: <alpine.LSU.1.00.0803231401340.4353@racer.site> <47E658D3.1060104@jwatt.org> <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com> <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com> <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Watt <jwatt@jwatt.org>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeEnz-0003Mb-2M
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759385AbYCYT0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759368AbYCYT0L
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:26:11 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:46679 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758928AbYCYT0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:26:03 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id DF9B157512;
	Tue, 25 Mar 2008 20:26:01 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id gb59cGlSQ966; Tue, 25 Mar 2008 20:25:59 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id CF50C57384;
	Tue, 25 Mar 2008 20:25:56 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JeEmO-0001TJ-8B; Tue, 25 Mar 2008 20:25:52 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803231658460.4353@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78210>

On Sun, Mar 23, 2008 at 17:00:12 +0100, Johannes Schindelin wrote:
> On Sun, 23 Mar 2008, Jonathan Watt wrote:
> > As I said, I don't want to update the files in the working copy. Seems 
> > like a different issue to me.
> 
> I understood that.  *yawns*
> 
> But I tried to tell you (unsuccessfully, it seems) that this is not 
> desirable to all users, and therefore it would be a horrible, horrible 
> idea to force the behaviour on other people you seemed to try to force on 
> other people.

The proponents of this (and I also) think, that meaning of HEAD is, or rather
should be, "the revision your work tree is derived from". If you think it
should be defined otherwise, can you please say how, so the merits of the
definitions can be discussed?

Note, that that definition implies that HEAD makes no sense for bare
repository. I think HEAD indeed does not make sense there, but you may of
course provide different definition where it does.

Also I believe that it would be very useful to have a ref defined "the
revision your work tree is derived from", be it HEAD or not. It would:
 - make the behaviour of push to non-bare repository defined.
 - make additional work trees for a repository (created by
   contrib/workdir/git-new-workdir) safe (the mechanizm could than be an
   option for submodules).

I see two ways to add something to keep track of work tree base version:

1. Make HEAD a special kind of ref, that would contain *both* the symbolic
   name *and* sha1. It would behave as symbolic as long as the sha1 values
   match and as detached when they don't.

   This should actually be relatively small code change, because it would be
   confined to update-ref, symbolic-ref and revparse. It would however be
   quite significant change to the repository format.

2. Create a new special ref BASE? (WORKTREE?), with the right semantics.

   The code change would be a bit more invasive here, as more commands would
   be affected (though I hope the commands share internal code so it would
   only be one checkout and one commit path). It would be smaller change to
   the repository format. It would, however, more stick out, because to find
   out which branch you will commit to would require looking at both HEAD and
   BASE.

   It would really be similar to the revision number in index proposal,
   except less invasive and I actually believe there is a case (some form of
   checkout or reset), where we want to read-tree, but not change this ref.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
