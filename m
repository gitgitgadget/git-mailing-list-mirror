From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Thu, 10 Sep 2009 11:25:35 +0200
Message-ID: <200909101125.35451.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302>
 <200909081436.30761.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 11:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlfuR-0008GU-WC
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 11:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbZIJJZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 05:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbZIJJZg
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 05:25:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53329 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755311AbZIJJZf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 05:25:35 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPR00F1B0UP62B0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Sep 2009 11:25:37 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPR004EA0UNZ920@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Sep 2009 11:25:37 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.10.91216
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <200909081436.30761.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128102>

On Tuesday 08 September 2009, Johan Herland wrote:
> On Tuesday 08 September 2009, Johannes Schindelin wrote:
> > On Tue, 8 Sep 2009, Johan Herland wrote:
> > > Algorithm / Notes tree   git log -n10 (x100)   git log --all
> > > ------------------------------------------------------------
> > > next / no-notes                4.77s              63.84s
> > >
> > > before / no-notes              4.78s              63.90s
> > > before / no-fanout            56.85s              65.69s
> > >
> > > 16tree / no-notes              4.77s              64.18s
> > > 16tree / no-fanout            30.35s              65.39s
> > > 16tree / 2_38                  5.57s              65.42s
> > > 16tree / 2_2_36                5.19s              65.76s
> > >
> > > flexible / no-notes            4.78s              63.91s
> > > flexible / no-fanout          30.34s              65.57s
> > > flexible / 2_38                5.57s              65.46s
> > > flexible / 2_2_36              5.18s              65.72s
> > > flexible / ym                  5.13s              65.66s
> > > flexible / ym_2_38             5.08s              65.63s
> > > flexible / ymd                 5.30s              65.45s
> > > flexible / ymd_2_38            5.29s              65.90s
> > > flexible / y_m                 5.11s              65.72s
> > > flexible / y_m_2_38            5.08s              65.67s
> > > flexible / y_m_d               5.06s              65.50s
> > > flexible / y_m_d_2_38          5.07s              65.79s

[snip]

> > - I'd love to see performance numbers for less than 157118 notes.
> > Don't get me wrong, it is good to see the worst-case scenario in
> > terms of notes/commits ratio.  But it will hardly be the common case,
> > and I very much would like to optimize for the common case.
> >
> >   So, I'd appreciate if you could do the tests with something like
> > 500 notes, randomly spread over the commits (rationale: my original
> > understanding was that the notes could amend commit messages, and
> > that is much more likely to be done with relatively old commits that
> > you cannot change anymore).
> 
> Ok. I will try to test that.

Here are the results of the 500-notes-in-kernel-repo test:

Algorithm / Notes tree   git log -n10 (x100)   git log --all

next / no-notes                 4.83s             64.78s

before / no-notes               4.84s             64.76s
before / no-fanout              4.98s             64.89s

16tree / no-notes               4.84s             64.61s
16tree / no-fanout              4.92s             64.68s
16tree / 2_38                   4.85s             64.45s
16tree / 2_2_36                 4.85s             64.63s

flexible / no-notes             4.84s             64.82s
flexible / no-fanout            4.91s             65.01s
flexible / 2_38                 4.85s             64.93s
flexible / 2_2_36               4.85s             64.63s
flexible / ym                   4.83s             64.63s
flexible / ym_2_38              4.86s             64.72s
flexible / ymd                  4.91s             64.74s
flexible / ymd_2_38             4.91s             64.56s
flexible / y_m                  4.86s             64.76s
flexible / y_m_2_38             4.86s             64.71s
flexible / y_m_d                4.86s             64.73s
flexible / y_m_d_2_38           4.84s             64.50s

I don't like the noise level in the second column ('git log --all'). Then 
again, I don't find that column very interesting (it's mostly there to 
verify that we don't have any abysmal worst-case behaviours in the notes 
code).

The first column is fairly nice and tidy, though. At a first glance it shows 
pretty much the same results as the 157000-notes table previously posted. 
Obviously the abysmal performance of no-fanout is gone (500 notes in a 
single tree object is not _that_ bad), although a 2/38-fanout is still a 
better choice for 500 notes (but 2/2/36 does not provide any additional 
improvement).

>From this we can start to guess that the threshold for moving from no fanout 
to 2/38 is somewhere below 500 notes, while the theshold for moving from 
2/38 to 2/2/36 is between 500 and ~157000 notes (probably much closer to 
157000 than to 500; I wouldn't be surprised if ~256 entries per level turns 
out to be good a threshold).

The date-based fanout performs on par with the SHA1-based fanout, although 
it's hard to say anything conclusively when the numbers are as close as 
this. However, the ymd and ymd_2_38 fanout probably show signs of too much 
overhead (too many levels) at only 500 notes. This is not surprising.

My gut feeling tells me that moving from 'no-fanout' to either '2_38' or 
'ym' is a good idea at ~256 notes. Then, if we went with '2_38', we'd have 
to switch to '2_2_36' at ~64K notes (i.e. when each /38 level reaches ~256 
notes) However, it seems that with 'ym', we could stick with it for much 
longer before having to consider switching to a different fanout alternative 
(probably 'ym_2_38' or 'y_m_d').


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
