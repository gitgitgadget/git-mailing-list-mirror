From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 11:04:15 -0400
Message-ID: <20070715110415.33692142.seanlkml@sympatico.ca>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	<7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	<20070715093529.GD2568@steel.home>
	<e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	<20070715104858.GG2568@steel.home>
	<e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	<e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	<20070715083529.6855a858.seanlkml@sympatico.ca>
	<e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 17:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA5gE-0004LY-Lk
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 17:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758544AbXGOPGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758315AbXGOPGd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 11:06:33 -0400
Received: from bay0-omc1-s14.bay0.hotmail.com ([65.54.246.86]:40753 "EHLO
	bay0-omc1-s14.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758444AbXGOPGc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 11:06:32 -0400
Received: from BAYC1-PASMTP05.bayc1.hotmail.com ([65.54.191.165]) by bay0-omc1-s14.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 08:06:32 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 08:06:31 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IA5g6-0000fK-IE; Sun, 15 Jul 2007 11:06:30 -0400
In-Reply-To: <e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 15:06:31.0843 (UTC) FILETIME=[BA4DD730:01C7C6F1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Jul 2007 16:58:16 +0200
"Marco Costalba" <mcostalba@gmail.com> wrote:

> On 7/15/07, Sean <seanlkml@sympatico.ca> wrote:
> >
> > If you only look for ^\0 (ie. first position only) the parsing should
> > be okay.  Not that it helps with the performance issue you're trying
> > to address.
> >
> revisions are streamed, there is only one first revision, all the
> others are linked togheter in a big stream.

Right, but how does that alter the notion that ^\0 is the safe way to
test for the "real" NUL terminator?

> Actually I ended up looking for the character after the '\0' (if any)
> to be 'c' that is the beginning of "commit <sha> ....." but it's a bit
> hacky.

Much more hacky than just testing for ^\0.  AFAIU, the NUL is
guaranteed to come at the start of the line and _all_ other NUL
characters are guaranteed to appear somewhere else.  Your current
test will fail if a "c" happens to follow NUL in the patch text.

Sean
