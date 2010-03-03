From: Jeff King <peff@peff.net>
Subject: Re: 3 failures on test t9100 (svn)
Date: Wed, 3 Mar 2010 12:23:02 -0500
Message-ID: <20100303172302.GA10168@coredump.intra.peff.net>
References: <20100302194518.GA12942@vidovic>
 <20100302212806.GA21413@coredump.intra.peff.net>
 <20100303005804.GA17120@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Mar 03 18:23:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmsHx-0006Zn-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 18:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab0CCRXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Mar 2010 12:23:08 -0500
Received: from peff.net ([208.65.91.99]:45800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab0CCRXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 12:23:06 -0500
Received: (qmail 13182 invoked by uid 107); 3 Mar 2010 17:23:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Mar 2010 12:23:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Mar 2010 12:23:02 -0500
Content-Disposition: inline
In-Reply-To: <20100303005804.GA17120@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141459>

On Wed, Mar 03, 2010 at 01:58:04AM +0100, Nicolas Sebrecht wrote:

> >   GIT_TEST_CMP=3D'diff -u'
> >   test_cmp() {
> >     $GIT_TEST_CMP "$@"
> >   }
> >=20
> > which _should_ split the "diff -u" on whitespace.
>=20
> I've tried with these exact lines without more success.

That's weird. Can you test this in each of your shells:

  foo() {
    echo "in foo, arg=3D$1"
  }
  VARIABLE=3D'foo bar'
  $VARIABLE

It should print "in foo, arg=3Dbar". If it doesn't, then the shell is
broken.

Also, can you confirm that you aren't setting SHELL_PATH in the Makefil=
e
(or in your environment) when building and testing git?

>   $ ls -ld $(which sh)
>   lrwxrwxrwx 1 root root 4 f=C3=A9vr. 13  2009 /bin/sh -> bash
>   $ bash --version
>   GNU bash, version 3.2.39(1)-release (x86_64-pc-linux-gnu)

I have this same version of bash on my Debian stable box, and it passes
the test I outlined above. So perhaps there is something more subtle
going on.

> That said, I did the svn tests because sometimes I have reproductible
> errors with 'git svn fetch' or 'git svn clone'. I'm not sure how both
> problems could be related... git-svn is a Perl script. The given mess=
age
> for this one is "error: died with signal 11" from what I remember (bu=
t
> I'm sure about the "signal 11" part).

I doubt they are related. This test_cmp problem is a problem in the tes=
t
harness, but it may be masking actual problems by giving false
negatives.

-Peff
