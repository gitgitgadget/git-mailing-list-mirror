From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Tue, 07 Aug 2012 01:05:45 +0200
Message-ID: <m2pq73zkmu.fsf@igel.home>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
	<7vboio231n.fsf@alter.siamese.dyndns.org>
	<1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
	<20120806193958.GA10039@sigill.intra.peff.net>
	<1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
	<20120806213404.GA14320@sigill.intra.peff.net>
	<1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
	<20120806223113.GA16298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:06:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyWN7-0002CV-S5
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 01:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab2HFXF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 19:05:56 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59205 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756724Ab2HFXFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 19:05:55 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WrZGL6p8dz3hhVm;
	Tue,  7 Aug 2012 01:05:46 +0200 (CEST)
X-Auth-Info: 16E+AjiSaQeJGhlaPK+3h8hQrfqq3SV55shsa2jEOx4=
Received: from igel.home (ppp-93-104-137-0.dynamic.mnet-online.de [93.104.137.0])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WrZGL2m3KzbbgN;
	Tue,  7 Aug 2012 01:05:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C55CCCA2A2; Tue,  7 Aug 2012 01:05:45 +0200 (CEST)
X-Yow: BARBARA STANWYCK makes me nervous!!
In-Reply-To: <20120806223113.GA16298@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Aug 2012 18:31:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202998>

Jeff King <peff@peff.net> writes:

> The stdio behavior on Solaris is weird. If I run this sample program:
>
>   #include <stdio.h>
>   int main(void)
>   {
>     FILE *fh = fopen("/dev/tty", "w+");
>     char buf[32] = {0};
>     fgets(buf, sizeof(buf), fh);
>     fprintf(fh, "got %s\n", buf);
>     return 0;
>   }
>
> on Linux, I get:
>
>   $ ./a.out
>   foo        <-- me typing
>   got foo    <-- program output
>
> On Solaris, I get:
>
>   $ ./a.out
>   foo        <-- me typing
>   foo        <-- ???
>   got foo    <-- program output

That's not a bug, you need to flush or seek when you want to switch
between read to write.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
