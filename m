From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Mon, 24 Mar 2014 18:11:37 -0400
Message-ID: <20140324221137.GJ13728@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <532D58B5.1080309@web.de>
 <20140324213342.GE13728@sigill.intra.peff.net>
 <5330ABBE.3080106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSD5t-0007Jy-6m
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbaCXWLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 18:11:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:46200 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875AbaCXWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:11:39 -0400
Received: (qmail 11138 invoked by uid 102); 24 Mar 2014 22:11:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 17:11:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 18:11:37 -0400
Content-Disposition: inline
In-Reply-To: <5330ABBE.3080106@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244892>

On Mon, Mar 24, 2014 at 11:03:42PM +0100, Ren=C3=A9 Scharfe wrote:

> >If the result is all-zeroes, can we check for that case instead? I
> >suppose that will eventually create a "trap" at midnight on January =
1st
> >of the year 0 (though I am not sure such a date is even meaningful,
> >given the history of our calendars).
>=20
> Makes sense. That would be "Sun Jan 0 00:00:00 1900", however -- days=
 are
> 1-based and years 1900-based in struct tm.

Oh right, I was stupidly forgetting about being 1900-based.

> Since a zeroth day is invalid, would this suffice:
>
> 	if (!tm || !tm->tm_mday) {
>=20
> (Yes, I'm lazy. :)

That looks perfect (and I like that it is quick to check, too, since
this case should be extremely rare).

-Peff
