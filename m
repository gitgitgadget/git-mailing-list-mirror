From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Signing by StGIT broken
Date: Fri, 18 Jan 2008 04:51:53 +0100
Message-ID: <20080118035153.GA12149@diana.vm.bytemark.co.uk>
References: <1199933596.21499.15.camel@dv> <20080110074252.GA18629@diana.vm.bytemark.co.uk> <1200113883.26841.18.camel@rd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 04:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFiHc-0001Ba-5t
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 04:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYARDwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 22:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbYARDwP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 22:52:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3197 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYARDwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 22:52:15 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JFiGn-0003IX-00; Fri, 18 Jan 2008 03:51:53 +0000
Content-Disposition: inline
In-Reply-To: <1200113883.26841.18.camel@rd>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70960>

On 2008-01-11 23:58:03 -0500, Pavel Roskin wrote:

> On Thu, 2008-01-10 at 08:42 +0100, Karl Hasselstr=F6m wrote:
>
> > On 2008-01-09 21:53:16 -0500, Pavel Roskin wrote:
> >
> > > "stg edit --sign" is not working anymore. It was working in versi=
on
> > > 0.14.
> >
> > Thanks for the report and the detailed analysis. I'll write a test
> > and fix it (but not quite immediately, so feel free to beat me to
> > it).
>
> The fix below appears to work (thus making it a self-signing patch
> :)) but with my modest Python experience it absolutely needs to be
> reviewed. I don't even know how to wrap the long line without making
> it look misleading.

It works by virtue of avoiding passing None to parse_patch(), which
expects a string object. So the fix is correct.

There are two ways to do line breaking in Python:

  1. Break the line between a pair of parentheses. That way, the
     parser knows that the line can't possibly end here:

       foo(1, 2, 3,
           4, 5, 6)

       x =3D { 'foo': 5,
             'bar': 17 }

  2. As a last resort, you can end a line with backslash:

       x =3D 1 + 2 + 3 \
           + 4 + 5 + 6

     But you should never use this. Insert a pair of otherwise
     redundant parentheses instead:

       x =3D (1 + 2 + 3
            + 4 + 5 + 6)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
