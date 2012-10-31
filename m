From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 19:20:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
References: <20121029085045.GA5023@sigill.intra.peff.net> <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com> <20121029212643.GA20513@sigill.intra.peff.net> <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:21:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTcub-0005MO-Et
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 19:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935204Ab2JaSU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 14:20:57 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:52833 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933523Ab2JaSU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 14:20:56 -0400
Received: (qmail invoked by alias); 31 Oct 2012 18:20:53 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp039) with SMTP; 31 Oct 2012 19:20:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+amy5baDOap4rMyInO2ZRHUdY/A/7wIYddKEDlA6
	zqUfbrSgH9IeZH
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20121031102712.GB30879@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208846>

Hi Peff,

On Wed, 31 Oct 2012, Jeff King wrote:

> I really like some of the directions the series is taking, and as the
> maintainer, I'd like to pick it up.

Code-wise, I agree.

> But there is a big question mark for me still about how it relates to
> the work in msysgit, especially:
> 
>   - What advantages does this implementation have over the one in
>     msysgit (i.e., new features that the other one does not have)?

Disclaimer: I do not know the details (as I said, I have higher priorities
elsewhere since the remote-hg I need for everyday work continues to do its
job, and the patch series bringing Python to msysGit is more pressing,
and I will enjoy its review much more, too).

The biggest advantage seems to me that it was started later than msysGit's
remote-hg and as such could potentially exploit recent improvements in
git.git.

>   - What disadvantages? If this implementation goes into git.git,
>     the msysgit one is likely to wane in popularity. What will we be
>     losing by doing so? If the answer is not "nothing", how hard would
>     it be to port over the missing bits?

The biggest advantage msysGit's series has is that it had a fix for a
fundamental flaw in fast-export. Fast-export was intended to work
incrementally, so the incantation "git branch blub master && git
fast-export ^master blub" is expected to update the ref "blub" properly.

I just tested this with junio/next and it seems this issue is still
unfixed: instead of

	reset refs/heads/blub
	from e7510461b7db54b181d07acced0ed3b1ada072c8

I get

	reset refs/heads/blub
	from :0

when running "git fast-export ^master blub".

Having said that, we have no problem to throw away the fix that was
rejected by Junio (who wanted something much more general which I refused
to implement both due to lack of time and lack of need -- think YAGNI) and
rebase our stuff on top of whatever goes into git.git's next (or master,
we are still deciding in the msysGit project whether we should stop
tracking next).

Another thing that I really like about remote-hg as it is in msysGit is
that it was designed with extensibility in mind. It should not be too hard
to support other fast-import/export based backends using that
infrastructure. I am particularly interested in bzr myself, but there is
no day-job related project I could use as an excuse to give that project
a higher priority that the other things I am doing at the moment.

>   - The msysgit one got held up by fixes needed for fast-export. Why
>   aren't those a problem for this implementation? If we are using a
>   different strategy that avoids the issue, what are the limitations (if
>   any) of that strategy?

Junio wanted a more general solution, adding infrastructure to the
rev-list engine that I did not need -- and did not see the need for,
either -- and given the amount of time I had invested in a working
remote-hg and given that I needed it desperately for my day-job project, I
decided to just put it into msysGit and give up my hopes for it to become
official.

It has worked well in the meantime and met my needs. The only thing
missing is the support for octopus merges. But I would need that only to
satisfy my geek self: I would set up an automatic Hg mirror of git.git
itself on bitbucket.

> I have a feeling that some of those answers are buried deep within the
> discussion, but I have had a hard time following all of the back and
> forth due to the volume and tone of the discussion. Are we at a point
> now where some of the participants can try to summarize the situation?

Hopefully my attempt met your expectations.

Thank you,
Dscho
