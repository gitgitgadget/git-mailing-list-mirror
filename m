From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: libxdiff and patience diff
Date: Mon, 3 Nov 2008 19:17:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0811031904130.9116@alien.or.mcafeemobile.com>
References: <20081104004001.GB29458@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 04:27:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxCZK-0007ry-QZ
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 04:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYKDDZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 22:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYKDDZt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 22:25:49 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:41080 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYKDDZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 22:25:49 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2008 22:25:49 EST
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2B683D> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 3 Nov 2008 22:17:43 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <20081104004001.GB29458@artemis.corp>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100026>

On Tue, 4 Nov 2008, Pierre Habouzit wrote:

> Hi Davide,
> 
> I've been working tonight, trying to make libxdiff support the patience
> diff algorithm, but I've totally failed, because I _thought_ I
> understood what xdl_split was doing, but it appears I don't.
> 
> 
> [ For the readers playing at home, the patience diff algorithm is
>   explained after my sig. ]
> 
> 
> What I did is to:
> (1) add a flag to the xenv in xdl_split that says that I want a
>     patience "split".
> (2) Then in xdl_split, if that bit is set, I compute the longest common
>     subsequence from the patience diff.
> (3) for each split it computes I call xdl_recs_cmp on that interval.
> 
> 
> What I thought it would achieve is that I force some boundaries at which
> libxdiff _must_ resync. Though, it seems that for some reason it doesn't
> work, probably because the "ha" stuff and the boundaries absolutely
> don't work the way I thought it did.
> 
> So where is the place I should do that ? I suspect it should be
> partly in xprepare.c but I'm a bit stuck right now.
> 
> 
> Any pointer on how the stuff in xprepare.c and xdiffi.c work would help
> greatly, it's really not self-evident to me :)

What makes you think it'd self-evident to me? :)
Seriously, I forgot stuff I wrote the last month, this is way beyond my 
memory limits.
You definitely need to look at xprepare.c, especially at xdl_trim_ends() 
and xdl_cleanup_records(). Lines are re-arranged in indexes, and this 
might screw up your logic if you're not prepared for it.
What xdl_split() does, is find the start of an LCS and return the 
coordinate. Then xdl_recs_cmp() does the box reducing (first two "for" 
loops) and different-lines marking (first and second "if").



- Davide
