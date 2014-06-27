From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Fix: wrong offset for CET timezone
Date: Fri, 27 Jun 2014 10:51:45 +0200 (CEST)
Message-ID: <339300321.129156.1403859105924.JavaMail.zimbra@dewire.com>
References: <1403790812-29174-1-git-send-email-mailing@franzoni.eu> <166360487.125996.1403820532765.JavaMail.zimbra@dewire.com> <CAF3z5=m5Ac5qWuXNXZaRqfDjbmt37qHjbj6YxkaE12VYsZegcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alan Franzoni <username@franzoni.eu>,
	schwab@linux-m68k.org
To: Alan Franzoni <mailing@franzoni.eu>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:51:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Rt0-0005hm-55
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 10:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaF0Ivw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2014 04:51:52 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:36647 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbaF0Ivv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 04:51:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id D475F8155D;
	Fri, 27 Jun 2014 10:51:49 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7mIrFHnXfAWq; Fri, 27 Jun 2014 10:51:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 576B1815E4;
	Fri, 27 Jun 2014 10:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e4eqrNCN2f6v; Fri, 27 Jun 2014 10:51:46 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 4227C8155D;
	Fri, 27 Jun 2014 10:51:46 +0200 (CEST)
In-Reply-To: <CAF3z5=m5Ac5qWuXNXZaRqfDjbmt37qHjbj6YxkaE12VYsZegcg@mail.gmail.com>
X-Originating-IP: [80.252.171.62]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF30 (Mac)/8.0.7_GA_6020)
Thread-Topic: wrong offset for CET timezone
Thread-Index: EMaG2s2GDZUex4C5oGiwCcmzl043cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252543>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Alan Franzoni" <mailing@franzoni.eu>
> Till: "Robin Rosenberg" <robin.rosenberg@dewire.com>
> Kopia: git@vger.kernel.org, "Alan Franzoni" <username@franzoni.eu>, s=
chwab@linux-m68k.org
> Skickat: fredag, 27 jun 2014 10:24:23
> =C3=84mne: Re: [PATCH] Fix: wrong offset for CET timezone
>=20
> On Fri, Jun 27, 2014 at 12:08 AM, Robin Rosenberg
> <robin.rosenberg@dewire.com> wrote:
> > 1 hour in winter and 2 in summer, although some standards seem to s=
ay
> > that summer time is really called CEST, computers apply DST to CET =
in
> > summer.
> >
> > $ TZ=3DUTC date
> > Tor 26 Jun 2014 22:08:01 UTC
> >
> > $ TZ=3DCET date
> > Fre 27 Jun 2014 00:08:05 CEST
>=20
> Like Andreas pointed out, this seems an implementation detail. CET is
> still +1, while CEST is +2.

I mentioned that myself...=20
=20
> If you take a look at the official IANA tzdata:
>=20
> http://www.iana.org/time-zones/repository/releases/tzdata2014e.tar.gz
>=20
> For europe, it's something like "std: CET" and "dst: CEST".
>=20
> The current doc is not correct either; we should write something like
> "either +1 or +2 depending on DST" (there seems to be a 2dst as well
> which gets +3 offset);

I knew there gotta be a catch. I don't think glibc is advanced enough
to provide two different summer times for the same TZ.

> Usually the best way of handling timezones is to use the proper
> location format (e.g. TZ=3D'Europe/Rome') and then letting the system
> pick the proper offset; we might say something like ' "Europe/Rome"
> which is +1 in winter ' in the doc, but I'd say that's nitpicking.

Probably is. I think mentioning that CET can be either +1 or +2 is
enough.=20

+ For example CET (here), which is nominally 1 hour ahead of UTC is enc=
oded=20
+ as `+0100`, but when summer savings apply, CET is two hours ahead and=
 encoded
+ as `+0200`).

-- robin
