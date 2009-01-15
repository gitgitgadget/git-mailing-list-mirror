From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Thu, 15 Jan 2009 16:35:29 +0100
Message-ID: <20090115153529.GA13961@neumann>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	<7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 16:52:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUWI-0004ek-69
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbZAOPus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754723AbZAOPus
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:50:48 -0500
Received: from francis.fzi.de ([141.21.7.5]:43280 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754817AbZAOPur (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:50:47 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jan 2009 10:50:47 EST
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 16:35:28 +0100
Content-Disposition: inline
In-Reply-To: <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 15 Jan 2009 15:35:28.0943 (UTC) FILETIME=[E4E4C3F0:01C97726]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105842>

On Wed, Jan 14, 2009 at 04:43:14PM -0800, Junio C Hamano wrote:
> I've always had trouble with the instruction we give for splitting on=
e
> commit into two using the interactive rebase in the documentation, as=
 it
> always had a strong "Huh?" effect on me when it suddenly starts talki=
ng
> about doing a "git reset HEAD^"; I suspect your change may improve th=
is
> situation quite a bit.

I think we might want do differentiate editing a commit (modifying
either the commit message or the patch or both) or splitting a commit.

The first is served well with the current 'edit' rebase command IMHO.
I don't really see the point of the additional 'git reset --soft
HEAD^'.

 * If you want to edit the commit message only, then you are
   better off with 'git commit --amend', because it preserves the
   previous commit message.  But with 'git reset --soft HEAD^' and
   'git commit' the commit message is "lost"; you have to use 'git
   commit -c ORIG_HEAD' instead, which is not that straightforward
   (and we don't have completion support for it).

 * If you want to modify the patch, too, then you would have to use
   'git add' anyway, regardless of whether there was a 'git reset
   --soft HEAD^', or not.  The only benefit of that 'reset' I'm seeing
   is that in that case 'git diff --cached' would show all the changes
   that would be committed; without the 'reset' 'git diff --cached
   HEAD^' is needed.

   But I'm not sure whether that benefit would offset the confusion of
   one more rebase command with just slightly different meaning.

=46or the second we could introduce a new rebase command like 'split',
which would do the same as 'edit' but would also perform that 'git
reset HEAD^' mentioned in the documentation automatically.  Or perhaps
it could be called 'divide', since the 's' abbreviation for 'split' is
already taken by 'squash'.  (Or maybe use capital 'S' for 'split'?
might be confusing...)


Regards,
G=E1bor
