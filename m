From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Improve tag checking in fsck and with
 transfer.fsckobjects
Date: Thu, 11 Sep 2014 16:20:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409111616380.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info> <xmqq7g1bgp5r.fsf@gitster.dls.corp.google.com> <xmqqsijzf9ij.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 16:20:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS5EV-0000EH-GG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 16:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaIKOUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 10:20:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:56484 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbaIKOUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 10:20:17 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Mb8HX-1XmDLQ2BD9-00Kgsv;
 Thu, 11 Sep 2014 16:20:15 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqsijzf9ij.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:kZEMPijKpurkdR7dRloRaFjj5DFXMK32BnMUoslFLB1PLLHAlt6
 wh63eq00g/FFh1nyy+vogM+MqUatCkouUKUONjD/8PGm6LcKMS0BUci6FWjfCu3I+eeA+IJ
 UytVge+lUet76R6OObLKaIMH6RapB1aKjpS/AnnXsKhBzujbja0qW9uENAw0bWURmYofFYI
 z7SNMZhklaElHnSQKqBYA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256838>

Hi Junio,

On Wed, 10 Sep 2014, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> This patch series introduces detailed checking of tag objects when calling
> >> git fsck, and also when transfer.fsckobjects is set to true.
> >>
> >> To this end, the fsck machinery is reworked to accept the buffer and size
> >> of the object to check, and for commit and tag objects, we verify that the
> >> buffers contain an end of header (i.e. an empty line) to guarantee that our
> >> checks do not run beyond the buffer.
> >
> > Overall they looked sensible and I am trying to queue them on 'pu'
> > for today's pushout.
> >
> > Thanks.
> 
> I was expecting to see interesting interactions with the "oops, fsck
> was not exiting with non-zero status in some cases" fix by Peff with
> the patch 5/6 of this series that adds two new tests to t1450, but
> because the breakage in these two cases are both only warning-events
> and not error-events, I didn't prefix "git fsck" with test_must_fail
> after all.

There were a couple of issues, thanks for pointing out that I missed
something. Short story: hash-object, fsck *and* pack-objects parse tag
objects as they are encountered. Therefore, it would be a bit hard to test
because we would have to emulate broken hash-object and pack-objects to
generate a pack containing an invalid tag object.

As a compromise, I now test for the warnings to make sure that the code
path is triggered, but do not explicitly test with a pack that would make
index-pack --strict *fail*.

Okay?

Ciao,
Dscho

P.S.: I squashed your changes in slightly modified form.
