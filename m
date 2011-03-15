From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_path(): Free temporary buffer
Date: Mon, 14 Mar 2011 21:12:30 -0400
Message-ID: <20110315011230.GA31865@sigill.intra.peff.net>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-3-git-send-email-cmn@elego.de>
 <7v7hc1cvdt.fsf@alter.siamese.dyndns.org>
 <1300140119.4320.38.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 02:12:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzIoZ-00071H-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 02:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab1COBMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 21:12:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42296
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756493Ab1COBMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 21:12:31 -0400
Received: (qmail 16344 invoked by uid 107); 15 Mar 2011 01:13:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 21:13:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 21:12:30 -0400
Content-Disposition: inline
In-Reply-To: <1300140119.4320.38.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169042>

On Mon, Mar 14, 2011 at 11:01:53PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> > I tend to think they are Ok, but then I also tend to think one leak=
 of
> > exec-path return value in setup_path() is perfectly fine for the sa=
me
> > reason, so in that sense I don't see a point in this patch...
>=20
>  Which brings us to the matter of whether we actually care about memo=
ry
> leaks, as the processes are short-lived and the system is going to cl=
ean
> up after us. Do we, unless the leaks are huge? As there is built-in
> valgrind support in the test suite, I went in with the assumption tha=
t
> we did. It seems however that hardly any code paths free their memory=
,
> other than when using strbuf.
>=20
>  In case we don't, valgrind should be told not to bother reporting le=
aks
> (and maybe mention in some document that small leaks are not an issue=
).

Don't we already use --leak-check=3Dno in our valgrind support for the
test suite? The valgrind support is there primarily to find memory
access errors, not leaks.

It would be nice if it could find leaks, too, but there is currently a
lot of noise due to uninteresting leaks like this. I haven't looked at
valgrind's support for suppressing leak reporting, but presumably we
could build a suppression file that would drop the uninteresting ones.
We could also fix them, of course, but if they are one-time-per-program
allocations, it might not be worth cluttering the code.

-Peff
