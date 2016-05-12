From: Jeff King <peff@peff.net>
Subject: Re: t5551 hangs ?
Date: Thu, 12 May 2016 02:40:39 -0400
Message-ID: <20160512064038.GA32271@sigill.intra.peff.net>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
 <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
 <20160511173130.GA29731@sigill.intra.peff.net>
 <5f285a5f-f66a-ed35-ecf9-0fece19ee5ca@web.de>
 <20160512031628.GA2741@sigill.intra.peff.net>
 <c0f2ae7b-0a67-af75-86ca-258a58b053bd@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 12 08:40:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0kIh-0003F1-C3
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 08:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbcELGkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 02:40:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:38397 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751943AbcELGkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 02:40:42 -0400
Received: (qmail 32714 invoked by uid 102); 12 May 2016 06:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 02:40:41 -0400
Received: (qmail 7120 invoked by uid 107); 12 May 2016 06:40:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 02:40:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 02:40:39 -0400
Content-Disposition: inline
In-Reply-To: <c0f2ae7b-0a67-af75-86ca-258a58b053bd@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294394>

On Thu, May 12, 2016 at 08:21:10AM +0200, Torsten B=C3=B6gershausen wro=
te:

> This is the last log that I see:
> [...]
> ++ git -C too-many-refs fetch -q --tags

Not surprising.

> And this may be the processes :
> (Not sure, probaly need to reboot & clean ?)

If you're killing the hung test with "^C", you shouldn't need to; that
tries to clean up any processes and shut down apache.

> /bin/sh ./t5551-http-fetch-smart.sh -x
> 73459 ttys010    0:21.45 /Users/tb/projects/git/git.pu/git -C too-man=
y-refs fetch -q --tags
> 73460 ttys010    0:00.40 git-remote-http origin http://127.0.0.1:5551=
/smart/repo.git
>=20
>  ps | grep fetch
> 73540 ttys006    0:00.00 grep fetch
> 73025 ttys010    0:00.14 /bin/sh ./t5551-http-fetch-smart.sh -x
> 73459 ttys010    3:40.70 /Users/tb/projects/git/git.pu/git -C too-man=
y-refs fetch -q --tags

I'm surprised not to see fetch-pack in that list. And to see so much CP=
U
going to fetch itself. But perhaps you are simply at a different stage
in the test. 3:40 of CPU time is a lot (the whole thing runs in under a
minute on my machine).

Hmm. Switching to "pu" seems to make things slow on my machine, too, an=
d
the time all goes to fetch. So perhaps there is some recent regression
there. It should be bisectable.

-Peff
