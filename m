From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Fri, 16 Jan 2009 13:10:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161305520.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org> <20090115153529.GA13961@neumann> <7vvdsgql17.fsf@gitster.siamese.dyndns.org> <bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com> <20090115225912.GL9794@neumann>
 <7v3afkqcnt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 13:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNnXu-0003UU-BQ
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 13:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842AbZAPMKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 07:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757421AbZAPMKF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 07:10:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:44596 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753307AbZAPMKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 07:10:04 -0500
Received: (qmail invoked by alias); 16 Jan 2009 12:10:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 16 Jan 2009 13:10:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qLlleQd8qTiJ3BB+oQBTgQGzbzlaCkRUPJmALqf
	D78LbM0csFfQNo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3afkqcnt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105945>

Hi,

On Thu, 15 Jan 2009, Junio C Hamano wrote:

>  (2) making completely unrelated commits on top of the state "edit" gave
>      you; this inserts a new commit in the sequence.
> 
>  (3) first "reset HEAD^", commit selected parts of the difference in one
>      commit, commit the reaminder in another commit; this splits the
>      commit the machinery just picked into two.
> 
> By the way, "rebase --continue" codepath has extra code that does
> something magical when the index does not match the HEAD commit.  I
> suspect what it does makes sense only in the originally intended usage
> sequence (i.e. "edit" stops, you want to do "commit --amend" and then
> "rebase --continue" but somehow you forgot to commit everything).
> 
> How well does that logic work when the user wanted to do (2) or (3) above,
> and happened to have the index unclean when s/he said "rebase --continue"?
> Does it do something nonsensical?

AFAICT the special handling is the only sane way to cope with (2) and (3), 
if it is the special handling that I am talking about:

If the current HEAD differs with the HEAD just after dropping to the 
shell, rebase --continue will _not_ just commit with the recorded 
information and continue.

The intended effect is that when you split a commit and continue with 
uncommitted changes, it will not just go ahead and call an editor with the 
original commit message: this message is now likely wrong.

It will only call an editor with the original message as a convenience 
when you did changes, but did not commit at all before continuing.  Just a 
convenience I found quite useful.

Ciao,
Dscho
