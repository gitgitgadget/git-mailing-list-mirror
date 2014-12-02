From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 2 Dec 2014 14:25:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412021421000.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info> <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
 <xmqqh9y32e36.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info> <xmqq4mu2285w.fsf@gitster.dls.corp.google.com> <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com> <xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
 <xmqqa936ohs3.fsf@gitster.dls.corp.google.com> <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info> <547DB894.4040609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1164038321-1417526705=:13845"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 14:25:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvnSC-0004gX-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 14:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbaLBNZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 08:25:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:53347 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932821AbaLBNZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 08:25:13 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MV6EP-1XNQXk189t-00YUdS;
 Tue, 02 Dec 2014 14:25:05 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <547DB894.4040609@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:gTdeNImW5PIwh/8pQc2kIdVCGnjZ288r/8E3RGYcSaQha6rmAsa
 uCa7KTGRC1ucKMTPv6lQsYt2atVBG/c02AzarYEaFzUpBSem74ZAjV/3B9cN4qnvy5D6Xdl
 o9/mLqT+c5KfMDje8WWd9BXRiNezEurlqQcN/1PLwf290AApYISs12AbvZi0ByXY5d1xhHf
 mqrQO9Zyt+gExi93TCWsg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260568>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1164038321-1417526705=:13845
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Michael,

On Tue, 2 Dec 2014, Michael J Gruber wrote:

> Johannes Schindelin schrieb am 02.12.2014 um 09:47:
>=20
> > The only sad part is that the already huge test suite is enlarged by
> > yet another extensive set of test cases (and those tests might not
> > really need to be that extensive because they essentially only need to
> > make sure that the hook is run successfully *instead* of trying to
> > update the working directory, i.e. a simple 'touch yep' hook would
> > have been enough).  It starts to be painful to run the complete test
> > suite, not only on Windows (where this has been a multi-hour endeavor
> > for me for ages already). BuildHive (CloudBees' very kind offer of
> > Jenkins CI for Open Source, integrated conveniently with GitHub)
> > already takes over an hour to run the Git test suite =E2=80=93 and Buil=
dHive
> > runs on Linux, not Windows!
>=20
> How about reusing the prerequisites feature for that? We could either
> mark the minimal tests, or mark the others similar to how we do with the
> (extra) expensive tests. Your config.mk would then determine which tests
> are executed.

In general, you are correct. And we already have the test_have_prereq
EXPENSIVE precedent.

In this particular case, I question the value of the extent of the tests:
the only thing we really need to test is that the new hook really
overrides the default behavior, not all kinds of real-world simulations
that *use* that behavior.

In other words, it is my opinion that the difference between the "touch
yep" test I demonstrated and the test originally suggested is the amount
of time it takes to run, not the extent to which the new code ist actually
verified.

Ciao,
Johannes
--1784107012-1164038321-1417526705=:13845--
