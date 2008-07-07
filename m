From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
	branch
Date: Mon, 7 Jul 2008 07:18:03 -0400
Message-ID: <20080707111803.GF31490@mit.edu>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 13:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFolq-0000AN-Lt
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 13:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYGGLSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 07:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbYGGLSa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 07:18:30 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:45486 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330AbYGGLS3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 07:18:29 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m67BI9Z7029166;
	Mon, 7 Jul 2008 07:18:09 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m67BI37a011239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Jul 2008 07:18:06 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KFojL-0007ji-GI; Mon, 07 Jul 2008 07:18:03 -0400
Content-Disposition: inline
In-Reply-To: <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87597>

On Sun, Jul 06, 2008 at 11:28:36PM -0700, Junio C Hamano wrote:
> The idea behind ORIG_HEAD is to have an anchoring point before an
> operation that moves your HEAD in a drastic way.  Think if it as a
> poor-man's reflog -- in fact it predates reflog.
> 
> That is why reset saves away the HEAD before it does its thing, so that
> you can easily say "Oops, I did not mean it -- reset ORIG_HEAD" to flip
> back to the previous state.  Both a fast-forward merge and a real merge
> can be undone by resetting back to ORIG_HEAD.
> 
> So in that sense:
> 
>  (1) ORIG_HEAD is not strictly necessary these days, because we have
>      reflogs;

True, but (and please correct me if I'm wrong) ORIG_HEAD will always
be pointing out HEAD before the user typed pretty much any git
porcelein command (which saves HEAD into ORIG_HEAD), but with reflogs,
it you have to paw through multiple HEAD@{n} to find the 'n' which
corresponds to state before executing the git plumbing command, since
multiple git plumbing commands could have updated the HEAD's reflog,
right?

One of the things that's been on my 'twoud be nice list is having an
option to "git reflog show" which prints the timestamp associated with
each reflog entry, since tools like guilt tend to create quite a few
reflog entries, and looking at the time stamps is one of the easier
ways to disentangle it.  For now what I tend to do is expand my
terminal window so it's super wide, and then look at the raw
.git/logs/HEAD file directly.

						- Ted
