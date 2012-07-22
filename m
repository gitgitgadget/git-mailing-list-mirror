From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Sun, 22 Jul 2012 21:43:20 +0200
Message-ID: <87629fvaxz.fsf@thomas.inf.ethz.ch>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
	<7vwr23zb65.fsf@alter.siamese.dyndns.org>
	<20120717082452.GC1849@tgummerer.surfnet.iacbox>
	<500C1AA9.4000306@dewire.com>
	<7vfw8jsk5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	<trast@student.ethz.ch>,
	JGit Developers list <jgit-dev@eclipse.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:43:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St23v-0003JD-VB
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 21:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab2GVTnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 15:43:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16226 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab2GVTnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 15:43:25 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 22 Jul
 2012 21:43:16 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 22 Jul
 2012 21:43:21 +0200
In-Reply-To: <7vfw8jsk5o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 22 Jul 2012 11:52:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201857>

Junio C Hamano <gitster@pobox.com> writes:

> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>
>> A note on how JGit would work here. Java has none of the fields
>> that constitute statcrc. I guess we would write zero here when
>> creating new entries. Git could recognize that when checking status
>> and simply assume "clean" unless mtime or st_size says otherwise.
>
> Even though it may not be the end of the world, that is certainly
> bad. Recording the constituent fields separately without the statcrc
> microoptimization, thereby not shaving a handful of bytes per the
> index entry, is not the end of the world either in the same sense,
> which leads us to question the benefit we would be getting from such
> a change.

Hum, I'm a bit lost now.

What is the status quo?  I take it JGit does not have any of ctime, dev,
ino etc., and either leaves the existing value or puts a 0.  Which is
not different from either leaving the stat crc in place, or putting a 0.
Except that IIUC, putting a 0 in both cases means forcing a refresh once
C git comes along (or some other reader that knows about the fields).

So if we want to keep the safety net, a magic "I don't know" value would
indeed be a good idea.  But I don't see how what Robin said constitutes
an argument in favor of splitting stat_crc into its fields again?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
