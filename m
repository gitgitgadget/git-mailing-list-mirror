From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/18] fsck: allow upgrading fsck warnings to errors
Date: Mon, 22 Dec 2014 23:39:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222333340.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <c70409e8e6a42bdc7cacd19cbd49d5d1adbedd1a.1418055173.git.johannes.schindelin@gmx.de> <xmqq4mt3idho.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222259070.21312@s15462909.onlinehome-server.info>
 <xmqqbnmv8h6c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-434808080-1419287989=:21312"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Bdv-0000Pu-GR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbaLVWjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:39:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:50200 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbaLVWjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:39:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lp3Qu-1XQWtl1dvo-00evWF;
 Mon, 22 Dec 2014 23:39:49 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnmv8h6c.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:L7QveNmOYKSobsARAUzVK7eJWfIIf40WmZwCe/zsqisogSAPEQB
 gmIrrO+UZ7mrswa3ywgiugef5zsxvWXMlXxKkObePKMeX5Wft6NqcP9rnmqm2Q/6a6At3m+
 1bdtnYJM6BUI+jjwF/hJSztcYGyN/7Q5ZwmwPCte1r3hPZEQswVacQbMupx0V8/SqPdNyuY
 D3/N+uzpQgerfnvkWhmGA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261688>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-434808080-1419287989=:21312
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Wed, 10 Dec 2014, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >>=20
> >> > The 'invalid tag name' and 'missing tagger entry' warnings can now b=
e
> >> > upgraded to errors by setting receive.fsck.invalid-tag-name and
> >> > receive.fsck.missing-tagger-entry to 'error'.
> >>=20
> >> Hmm, why can't all warnings promotable to errors, or are the above
> >> two mentioned only as examples?
> >
> > Those were the only ones that were always shown as warnings but never
> > treated as errors.
>=20
> Sorry but I don't quite understand this comment; I suspect the root
> cause might be that we have different mental models on these
> tweakable error severities.
>=20
> Because I come from the school "To these N kinds of events you can
> independently assign different (i.e. info, warn, error) outcomes",
> moving the FIRST_{INFO,WARNING,...} position in the array would only
> affect what happens by default, never hindering the user's ability
> to tweak (in other words, there is no linkage between "now you can
> tweak" and the order of events in the list, the latter of which only
> would affect what the default severity of each event is).

We agree on this mental model.

The only problem this patch tries to fix is that the warnings about a
missing tagger and about invalid tag names were never leading to an error.
They were purely printed, but then ignored. So what this patch does is to
add "if (err) return err;" handling for those two warnings.

As a consequence, the ordering of message IDs needs to be fixed because
the non-fatal warnings were ordered alphabetically before, but now the
non-fatal warnings are extracted so that we can give them the appropriate
FSCK_WARN by defauly =E2=80=93 even in the git-receive-pack case.

In other words, the value assigned to those two warnings was completely
ignored before, which was the reason why it did not matter that we
assigned them to report FSCK_ERRORs in the git-receive-pack case before:
they were still only printed out and never stopped any tag from entering
the host's repository.

I could change the ordering in the patch that introduces the message IDs,
of course, but it would be even more puzzling if those two messages, of
all, were not ordered alphabetically with the others.

Ciao,
Dscho
--1784107012-434808080-1419287989=:21312--
