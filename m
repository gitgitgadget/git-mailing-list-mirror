From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 11:42:24 -0700
Message-ID: <7vabw6j5db.fsf@assigned-by-dhcp.cox.net>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk>
	<20070514183931.GC23090@fieldses.org>
	<20070515042200.GA10884@coredump.intra.peff.net>
	<20070515045044.GB2805@fieldses.org>
	<20070515050808.GA11745@coredump.intra.peff.net>
	<20070515152457.GC6794@fieldses.org>
	<20070515153513.GA26944@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 20:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho1yi-0001Y0-1S
	for gcvg-git@gmane.org; Tue, 15 May 2007 20:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbXEOSm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755806AbXEOSm1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 14:42:27 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33656 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbXEOSm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 14:42:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515184226.UGRO22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 14:42:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zWiR1W00E1kojtg0000000; Tue, 15 May 2007 14:42:25 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47363>

Jeff King <peff@peff.net> writes:

> On Tue, May 15, 2007 at 11:24:58AM -0400, J. Bruce Fields wrote:
>
>> ... Yes.  But actually, the Content-Type header is from
>> git-format-patch:
>> 
>> $ git format-patch --stdout 12806b^..12806b |head
>> From 12806b65b0d1faec249002c51b871775dc344a47 Mon Sep 17 00:00:00 2001
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Date: Thu, 10 May 2007 12:36:15 +0200
>> Subject: [PATCH] Add a birdview-on-the-source-code section to the user
>> manual
>> Content-Type: text/plain; charset=utf-8
>> Content-Transfer-Encoding: 8bit
>
> Ah, interesting. I had checked that, but my test didn't produce those
> headers. It seems we only produce them if there are non-ascii characters
> in the commit message (and I just checked with an arbitrary commit).
>
> So really, this (totally untested) one-liner should fix it:
>
> diff --git a/commit.c b/commit.c
> index 922437f..5669c2f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1065,6 +1065,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
>  			int sz;
>  			char header[512];
>  			const char *header_fmt =
> +				"MIME-Version: 1.0\n"
>  				"Content-Type: text/plain; charset=%s\n"
>  				"Content-Transfer-Encoding: 8bit\n";
>  			sz = snprintf(header, sizeof(header), header_fmt,
>
>
> Providing that nobody objects to sticking that extra header in
> format-patch's output (but of course only when we actually have
> non-ascii data). It's technically required if we want the output to be a
> valid MIME message, but most things are unlikely to care (except vger's
> apparently picky MTA).

Thanks; I think this is a sane thing to do.
