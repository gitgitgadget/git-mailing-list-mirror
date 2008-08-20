From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Tue, 19 Aug 2008 17:03:06 -0700
Message-ID: <20080820000306.GL24212@spearce.org>
References: <20080819234433.GJ24212@spearce.org> <7vskt0woat.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 02:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVbBN-0006Ck-0X
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 02:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYHTADK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 20:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYHTADJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 20:03:09 -0400
Received: from george.spearce.org ([209.20.77.23]:60409 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYHTADI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 20:03:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0D40938375; Wed, 20 Aug 2008 00:03:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vskt0woat.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92942>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The value 1112911993 was chosen for the limit as it is the commit
> > timestamp for e83c516331 "Initial revision of "git" ...". Any
> > reflogs in existance should contain timestamps dated later than
> > the date Linus first stored Git into itself, as reflogs came about
> > quite a bit after that.
> >
> > Additionally a reflog with 1,112,911,993 record entries is also
> > simply not valid.  Such a reflog would require at least 87 TB to
> > store just the old and new SHA-1 values.  So our randomly chosen
> > upper limit for @{nth} notation is "big enough" that users will
> > not run into it by accident.
> 
> Hmm, would we want to apply that logic to replace the magic "8-digit" rule
> in date.c::match_digit()?

No.  Isn't match_digit() in the code path used by GIT_COMMITTER_DATE?
We should handle dates as far back as Sat Mar 3 01:46:40 1973 as
seconds-since-epoch to support conversion tools which bring in old
history that predates Git's inception.

If anything the reflog code should change its test to be the same
"8-digit" rule.  A reflog of 100,000,000 entries requires at least
7.9G, a threshold which isn't utterly insane (as it fits on a DVD-R)
but still is not really reasonable for current Git reflog.

-- 
Shawn.
