From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 2/5] reset: add option "--keep" to "git reset"
Date: Tue, 19 Jan 2010 05:28:47 +0100
Message-ID: <201001190528.47414.chriscool@tuxfamily.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org> <20100102053934.30066.85625.chriscool@tuxfamily.org> <7viqbk8evw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:26:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX5fR-0007Pi-JD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 05:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0ASE0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 23:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173Ab0ASE0G
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 23:26:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53869 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638Ab0ASEZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 23:25:54 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0FBBC81805D;
	Tue, 19 Jan 2010 05:25:44 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2571C818039;
	Tue, 19 Jan 2010 05:25:42 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7viqbk8evw.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137422>

On samedi 02 janvier 2010, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The purpose of this new option is to discard some of the last commits
> > but to keep current changes in the work tree.
> >
> > The use case is when you work on something and commit that work. And
> > then you work on something else that touches other files, but you don't
> > commit it yet. Then you realize that what you commited when you worked
> > on the first thing is not good or belongs to another branch.
> >
> > So you want to get rid of the previous commits (at least in the current
> > branch) but you want to make sure that you keep the changes you have in
> > the work tree. And you are pretty sure that your changes are
> > independent from what you previously commited, so you don't want the
> > reset to succeed if the previous commits changed a file that you also
> > changed in your work tree.
> >
> > The table below shows what happens when running "git reset --option
> > target" to reset the HEAD to another commit (as a special case "target"
> > could be the same as HEAD) in the cases where "--merge" and "--keep"
> > behave differently.
>
> I think this new option is unrelated to "--merge"; iow, the only relation
> to it is that it is an option to the same command "git reset", so it is
> related but it is related the same way and to the degree as "--mixed" is.
>
> Thinking about it even more, if the number of commits you are resetting
> away is zero in your use case (i.e. target is HEAD), shouldn't this new
> mode of operation degenerate to "--mixed"?  So in that sense, it might
> make sense to contrast it with "--mixed".
>
> But let's try not to contrast it with anything else, and see how well it
> stands on its own. 

Ok, I removed parts of the commit messages that contrasted it 
with "--merge".

[...]

> > The following table shows what happens on unmerged entries:
> >
> > working index HEAD target         working index HEAD
> > ----------------------------------------------------
> >  X       U     A    B     --keep  (disallowed)
> >  X       U     A    A     --keep   X       A     A
>
> In a sense, this is consistent with the above; the local change attempted
> happens to be an unmerged result.
>
> But it is inconsistent with the intended use case you presented, which
> leaves no room for unmerged entries to enter in the index to begin with.
> It might be safer to error out on any unmerged entry in the index.  I
> dunno.

Yeah I agree it might be safer, so I added a patch to disallow using --keep 
when there are unmerged entries.

Thanks,
Christian.
