From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 08:39:27 -0400
Message-ID: <20081022123926.GA7774@coredump.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <bb6f213e0810220135hd520f78odb83414c248a15e4@mail.gmail.com> <20081022085036.GA1454@sigill.intra.peff.net> <bb6f213e0810220232p2e7fe3daoa32f46fbe5bef2ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 14:40:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksd12-0000eR-KG
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 14:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYJVMja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbYJVMja
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 08:39:30 -0400
Received: from peff.net ([208.65.91.99]:3881 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbYJVMj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 08:39:29 -0400
Received: (qmail 511 invoked by uid 111); 22 Oct 2008 12:39:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 08:39:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 08:39:27 -0400
Content-Disposition: inline
In-Reply-To: <bb6f213e0810220232p2e7fe3daoa32f46fbe5bef2ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98861>

On Wed, Oct 22, 2008 at 01:32:56PM +0400, Alexander Gavrilov wrote:

> From the output it seems that what fails is "-f cp1251 -t sjis" and
> "-f utf-8 -t sjis" (remember that blame --incremental produces its

Oh, indeed. Converting to and from utf-8 seems to work, but not between
cp1251 and sjis:

  $ iconv -f SJIS -t UTF-8 sjis.txt | sed s/SJIS/UTF8/ >test &&
  >   cmp test utf8.txt && echo ok
  ok

  $ iconv -f UTF-8 -t SJIS utf8.txt | sed s/UTF8/SJIS/ >test &&
  >   cmp test sjis.txt && echo ok
  ok

  $ iconv -f SJIS -t CP1251 sjis.txt
  Not supported SJIS to CP1251

  $ iconv -f CP1251 -t SJIS cp1251.txt
  Not supported CP1251 to SJIS

So I think it is simply a limitation of the platform with respect to the
particular encodings used. There is a similar problem in t3900, I think,
with EUCJP and ISO-2022-JP. I assume one _can_ install these encodings
for Solaris, but the admins of my box haven't done so (and this is a
production box that I can't ask for such things on).

> blame for some reason actually tries to convert to an entirely
> different encoding. If tests 4 and 5 pass, you can try adding
> --encoding=shift-jis to test 2 to check it.

Tests 2, 3, and 4 fail. Test 5 does pass.

-Peff
