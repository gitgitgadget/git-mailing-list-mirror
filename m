From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] pretty: add conditional %C?colorname
 placeholders
Date: Sun, 25 Apr 2010 23:26:42 -0400
Message-ID: <20100426032642.GA14421@coredump.intra.peff.net>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <20100426021347.GA29669@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:26:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6EyB-0004xy-M1
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab0DZD0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:26:46 -0400
Received: from peff.net ([208.65.91.99]:44468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab0DZD0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:26:45 -0400
Received: (qmail 2696 invoked by uid 107); 26 Apr 2010 03:26:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 23:26:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 23:26:42 -0400
Content-Disposition: inline
In-Reply-To: <20100426021347.GA29669@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145781>

On Sun, Apr 25, 2010 at 09:13:47PM -0500, Jonathan Nieder wrote:

> This is nice because in certain situations (e.g. different background
> colors), the default colors might not be suitable.  As an example of
> this, the =E2=80=98commit =E2=80=99 line of =E2=80=98git log=E2=80=99=
 output uses color.diff.commit.
>=20
> So it would be nice to be able to use %C(diff.commit) and
> automatically use the right color, if color is enabled.

=46WIW, I like this idea very much. And it would be a bit more natural =
for
%C(diff.commit) to respect diff.color, whereas we could perhaps keep
%Cred as "always on" for backwards compatibility.

However:

> Why not make %C always check?  I can understand that it would be
> annoying when first trying to use %C.  On the other hand, it would be

I am a little nervous that we would be breaking scripts that pipe the
colorized output for later display to the user. Right now doing
something like[1]:

  log=3D`git log --format=3D%Cred%h`
  test "x$log" !=3D x && echo "foo: $log"

colorizes, but we would be breaking it. And for new values like
%C(diff.commit), we are not breaking anything (because it is a new
syntax), but a script like the one above may want to convert, and there
is no way to say "respect the color _config_, but don't respect
isatty(1)". Saying "--color" doesn't work, because it overrides the
color config. We can cheat a little with GIT_PAGER_IN_USE, but that wil=
l
have funny interactions with pager.color.

[1] Yes, I know this snippet is contrived, but it seems within the real=
m
of possibility. git-add--interactive reads the diff output in both
regular and color forms, though it takes some care to look at the user'=
s
config and decide whether to show the color.

-Peff
