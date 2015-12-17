From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Thu, 17 Dec 2015 10:37:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512171035580.6483@virtualbox>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de> <CAPig+cQzCHtyVs47=ASs5V2BSV7gpVszbdTFydiRhnz3gtD2Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 10:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9V0E-0008LW-3R
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 10:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbbLQJhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 04:37:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:54269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbbLQJhb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 04:37:31 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M5cpk-1aOr5V4Amm-00xd9O; Thu, 17 Dec 2015 10:37:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cQzCHtyVs47=ASs5V2BSV7gpVszbdTFydiRhnz3gtD2Qw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:IFkXv0wvbk8AbdnA0/iEuf2zbKMNshJej3Vgz5krQHNcG9osrsJ
 nF891b94CdnwzYS+Vcf0saL28tIhu27vFXXvXPIcaYLPq1s8XVSatCP5DYCoOlJ9wri0S9N
 I7WmJTW3pC0VOo5hR3NU3lFkwHGUsjHNItiXhXgU6pBg05QcDQ3LxM/hYW/+HJfkF+lisl2
 +MC2fq5wfdjtY13oXfzXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hDHv3m/1ji0=:GLK+RAuH8KeEKCuOuwH/EP
 JXKQq7OZkhnwpD9CjkdwACyiaFn8gVPJUQ3CtdS/wKSlH5cK8SZKjTZhqk5So1b2oHxCAodGH
 f9NoGjTIE9mifUPfNqP9chOnH0SxHzOv2mam0athU/Ey1hD0Nl5KNf/qZNkmF1pM4K8SRF2lo
 T3Hb1Mq4mMAd7MCKShZ1BBZpyRwJZ56P5o0h8MsjiGLf2gdB8Kj5DTbrweahQUir5LluI+r7O
 Pj4f9K5XdQ52556pRnFEqtJiC34d7jFudfXStGp//0IgemQVeGhDyg307T/f0b45nUl62Sx2I
 8V9InXGLmbRQSvDkEq6Doqc/G4mD8uMSeCAL5fDOtmhIHu6UiMh2zX2kFxDo/RNYtr4b6XZvb
 wAQLsx/rsU4bKCqJcE3qyRfz1nJGrEmeZcG3HFP4pQU+LKEWU63eP2W9kSSa3gIJaK8NSuPRN
 p/Byjj1v4wqSY1t2vQS74MgiktM22KUik71v47atteSvrlK1A57pTeAjVxsCdkondcL7DpCqU
 QWBsweDq+IltyGmVBe/kTZTnXgDJ0jh9mcZb+g3f2sHpV7YmGyF1wm1OXxV6/cgkw3pdPcb6s
 ehrdV8b/T1oplm2urMgHKT3V7oJwFq4topsI/1fuJsGRDnJsajwpFciv1028VdyVs8NMjCyeN
 vejoJAEEAmEvxmxu6prgsEDEWoeOCi/Z7nzKN4sD4PocIQdofPVEx5VWzGNmdFCPgXGtsevu8
 0eTxjkuvCubin6K9xcBCaodgsmPdPnx6M6tCY+w40YLHMxKOOfuaN+J0UZtXRGpEcnlJRc5U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282644>

Hi Eric,

On Wed, 16 Dec 2015, Eric Sunshine wrote:

> On Wednesday, December 16, 2015, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > @@ -210,6 +210,24 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
> > +static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
> > +{
> > +       ssize_t result = write(fd, buf, len);
> > +
> > +       if (result < 0 && errno == EINVAL && buf) {
> 
> Here, errno is EINVAL...
> 
> > +               /* check if fd is a pipe */
> > +               HANDLE h = (HANDLE) _get_osfhandle(fd);
> > +               if (GetFileType(h) == FILE_TYPE_PIPE)
> > +                       errno = EPIPE;
> > +               else
> > +                       errno = EINVAL;
> 
> Does any of the code between the outer 'if' and this point clobber
> errno, or are you merely assigning EINVAL for robustness against
> future changes?

Yes, it is proofing the code against future changes. And TBH I did not
even bother to check whether _get_osfhandle() or GetFileType() can modify
the errno value, since I *really* wanted to make sure that errno is either
EPIPE or EINVAL in this execution path.

Ciao,
Dscho
