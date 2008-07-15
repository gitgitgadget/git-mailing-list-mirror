From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Tue, 15 Jul 2008 04:25:53 +0000
Message-ID: <20080715042553.GD2432@spearce.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:26:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIc7p-0005UF-4a
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbYGOEZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 00:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYGOEZy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:25:54 -0400
Received: from george.spearce.org ([209.20.77.23]:60683 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYGOEZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:25:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7C99F3836B; Tue, 15 Jul 2008 04:25:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88518>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> > 
> > What is $COMP_WORDBREAKS set to in your shell?  In mine it
> > appears to be:
> > 
> > 	" \"'@><=;|&(:"
> 
> Ahhah. Indeed. I don't have the ':'.
...
> Umm, if so, git should just set it in the completion script, no?

OK, so it turns out not having : in COMP_WORDBREAKS is a very common
case that we should somehow deal with, to aid our users.

I'm concerned about just setting COMP_WORDBREAKS back to the default
in the git completion script because then we get into an ordering
game with the profile scripts, don't we?  If git completion sources
before the gvfs script we don't get our COMP_WORDBREAKS setting.

I think we may need to do two things.

If COMP_WORDBREAKS doesn't contain a :, try to reset it to include
one when the script is sourced.  This may "fix" git completion but
make gvfs completion act differently, resulting in a thread on the
gvfs lists.  ;-)

If COMP_WORDBREAKS doesn't contain : during a completion event than
we need to do what your original patch asked, which is to include
"$ref:" in the prefix, so the ref isn't lost.

At least we understand the problem now, finally.  I'll try to write
up a patch for it tomorrow.  Unfortunately packing to move has been
really sucking up my time lately.
 
-- 
Shawn.
