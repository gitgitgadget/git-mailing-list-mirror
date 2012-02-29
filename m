From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: use {asterisk} in rev-list-options.txt
 when needed
Date: Wed, 29 Feb 2012 16:38:09 -0500
Message-ID: <20120229213809.GC628@sigill.intra.peff.net>
References: <1330443348-5742-1-git-send-email-cmn@elego.de>
 <20120228194551.GC11725@sigill.intra.peff.net>
 <87hayar25i.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 29 22:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2rE1-0001wp-2o
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 22:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab2B2ViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 16:38:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33430
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084Ab2B2ViL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 16:38:11 -0500
Received: (qmail 27895 invoked by uid 107); 29 Feb 2012 21:38:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 16:38:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 16:38:09 -0500
Content-Disposition: inline
In-Reply-To: <87hayar25i.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191859>

On Wed, Feb 29, 2012 at 12:03:53AM +0100, Thomas Rast wrote:

> > Anyway, that is not a problem with your patch. :) I confirmed that the
> > bug happens in my version of the toolchain, and your fix works (I also
> > tried using `*`, but backtick does not suppress markup.
> 
> Actually it would, if it weren't for our use of '-a no-inline-literal'.
> Which we are using because the "backticks do not interpret {stuff}"
> feature was introduced in a backwards-incompatible way in asciidoc
> 8.4.1, see 71c020c (Disable asciidoc 8.4.1+ semantics for `{plus}` and
> friends, 2009-07-25).
> 
> Some googling tells me the distros are currently at
> 
>   openSuSE         8.4.5   (local)
>   Debian (stable)  8.5.2   packages.debian.org
>   Fedora           8.4.5   admin.fedoraproject.org/pkgdb/
>                            (but I can't discern whether it's actually in there...)
>   Arch             8.6.6   www.archlinux.org/packages/
>   Ubuntu 11.10     8.6.4   packages.ubuntu.com
> 
> so perhaps the time has come to remove that switch?

Looks like asciidoc 8.4.1 was introduced almost exactly 3 years ago. So
yeah, I'd be OK with breaking compatibility if it means the sources
become more readable[1]. It would be nice if there were an option (like
"-a inline-literal") that older versions could set, but I don't think it
exists. However, people on old systems always have the option of
pulling the pre-rendered documentation, which is what I assume people on
ancient proprietary systems do (or they just go without manpages).

We should also consider dropping the ASCIIDOC7 define in the
Documentation Makefile, too (it would be broken by the switch to inline
literals, and it is also ancient at this point). I wonder if we can also
drop some of the older docbook compatibility options. Even Debian
stable[2] is on docbook 1.75, which is beyond the Makefile's table of
which version needs which options. The last version to need any options
was docbook 1.72, which is from 2007.

The first step, though, would be auditing the whole Documentation
directory for escaped text inside inline literals (i.e., `{asterisk}`
would have to go back to `*`). Which does not sound like a fun job.

-Peff

[1] The documentation for asciidoc claims that inline literals will not
    expand anything except "special characters". From what I understand
    of special characters, that does not mean stuff like "*", which
    would still be literal, but rather that "<" would be expanded into
    "&lt;" when formatting to XML or HTML. So I think it would do what
    we want.

[2] I usually use Debian stable as my gold standard of "old". But
    actually, RHEL5 will continue to get critical and security fixes
    until 2014, and is on an older toolchain. They are not likely
    to be picking up the latest git to package, of course, but there
    might still be devs on it who would install git from source. But I
    think we can be a little more cavalier about backwards compatibility
    in the doc toolchain because pre-rendered versions are available.
