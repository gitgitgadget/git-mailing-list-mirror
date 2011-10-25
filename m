From: Jim Meyering <jim@meyering.net>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 18:37:19 +0200
Message-ID: <87sjmhauyo.fsf@rho.meyering.net>
References: <20111024201153.GA1647@x4.trippels.de>
	<201110251550.22248.trast@student.ethz.ch>
	<87y5w9ayoa.fsf@rho.meyering.net>
	<201110251800.28054.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	<git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIk0L-0006N6-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab1JYQh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 12:37:29 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:41038 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab1JYQh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 12:37:28 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 6B613D48260
	for <git@vger.kernel.org>; Tue, 25 Oct 2011 18:37:21 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 56D796008E;
	Tue, 25 Oct 2011 18:37:19 +0200 (CEST)
In-Reply-To: <201110251800.28054.trast@student.ethz.ch> (Thomas Rast's message
	of "Tue, 25 Oct 2011 18:00:27 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184219>

Thomas Rast wrote:
> Jim Meyering wrote:
>> Thomas Rast wrote:
>> > [GCC moves access to a file-static variable across pthread_mutex_lock()]
>>
>> Thanks for the investigation.
>> Actually, isn't gcc -O2's code-motion justified?
>> While we *know* that those globals may be modified asynchronously,
>> builtin/grep.c forgot to tell gcc about that.
>
> I'm somewhat unwilling to believe that:

You're right to be skeptical.
I should have stuck with "using volatile works around the problem for me".
The real problem seems to be in glibc, with its addition of
the "leaf" attribute to those synchronization primitives:

  http://bugzilla.redhat.com/747377#c22
