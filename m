From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/7] Re: Problems with Git's "perl" userdiff driver
Date: Sat, 21 May 2011 13:53:14 -0500
Message-ID: <20110521185314.GA10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 20:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrIs-0003b9-Ur
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab1EUSx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:53:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44111 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1EUSxY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 14:53:24 -0400
Received: by iyb14 with SMTP id 14so3661067iyb.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3G1xqWBVp22DBRtje6JE9PX2NnuqntQntZKisQh09D8=;
        b=Npe87gKYKD2gSfNc3KrcDUM0dx3Je38H2e4K55zIa+xyZ0ybJuz2oTczLThyo4pa26
         DJpWvGhB0TFDPwC0nSpMubEei9hEvW3Qqa5a4sryejazr8fe8PQxhUP/eCbcVdNqgYVk
         NSmowq2lKHoMgfIL/UZhqpN2eDMjtlRWY8TcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RgIfpjmeDlQiiniWeLRxnBYqIbsGKtvprIQ5Yog9kTIx9rMpGKB4lyBenzrW05cLvy
         P/Bosfyv47t2hbKGeVh9LK8iPlXVZWaKoer/U4Qtr+PZWpmzHo2rA49qxBLN5xJItNxw
         ydfp/WXSU7BVjsn04walAfU010me+/fixIKIc=
Received: by 10.42.243.7 with SMTP id lk7mr5854730icb.191.1306004003360;
        Sat, 21 May 2011 11:53:23 -0700 (PDT)
Received: from elie ([69.209.78.180])
        by mx.google.com with ESMTPS id c6sm2064439ibj.4.2011.05.21.11.53.19
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174166>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The POD rule doesn't work properly. I suspect it has to be:

Thanks.  Some context is here (thanks to Thomas for his notes/full
branch).

 http://thread.gmane.org/gmane.comp.version-control.git/164184

Quick thoughts before fixing them:

>     "^=3Dhead[0-9] .*",
>
> Instead of the current:
>
>     "^=3Dhead[0-9] ",

Good catch.

> And actually it applies very badly to POD in general, since the "sub"
> rule will be tried first, so e.g. in Perldoc we'll often end up
> finding some "sub" example halfway up the file, instead of the =3Dhea=
d1*
> or =3Ditem* section a few lines up.

I have another worry of the same kind.  If my source file consists of
multiple packages (like git-svn.perl does), then the "package" rule
can be useful for getting bearings in a diff:

	diff --git a/git-svn.perl b/git-svn.perl
	index dc66803..74d8612 100755
	--- a/git-svn.perl
	+++ b/git-svn.perl
	@@ -4000,7 +4000,6 @@ package SVN::Git::Fetcher;
	 use strict;
	 use warnings;
	 use Carp qw/croak/;
	-use File::Temp qw/tempfile/;
	 use IO::File qw//;
	 use vars qw/$_ignore_regex/;

But as soon as "git diff" encounters a subroutine, that replaces the
context.  It seems that the --show-function mechanism works best for
files structured such that every line has a scope, with no nesting:

	sub foo {
		... lines of foo come here ...
	}

	sub bar {
		... lines of bar come here ...
	}

and does not cope as well with nested scopes or lines that do not
fall in any scope.

The upshot is that all these patterns should be anchored at the left
margin for now, and it might be worth considering teaching userdiff to
push and pop scopes so that lines outside the innermost scope are
correctly attributed, as in the last two lines below:

	package Foo::Bar::Baz

	=3Dhead1 NAME

	Foo::Bar::Baz - well-documented frobber

	=3Dcut

	use strict;
	use Qux::Quux;

That would also take care of your example of

	=3Ditem B<something>

	Use it like so:

		sub example {
			something else;
		}

	... more documentation that should be attributed to the =3Ditem,
	not the sub ...

> And it looks like the regex only catches:
>
>     sub foo {
>     }
>
> Not:
>
>     sub foo
>     {
>     }

Yep, that seems worth fixing, too.  Patches follow, with a few unrelate=
d
cleanups thrown in.  These patches are based against "maint" for no
particular reason.  Bugs and improvements welcome, of course. :)

Jonathan Nieder (7):
  t4018 (diff funcname patterns): make .gitattributes state easier to
    track
  t4018 (diff funcname patterns): make configuration easier to track
  t4018 (diff funcname patterns): minor tweaks
  userdiff/perl: anchor "sub" and "package" patterns on the left
  userdiff/perl: match full line of POD headers
  userdiff/perl: catch subs with brace on second line
  tests: make test_expect_code quieter on success

 t/t4018-diff-funcname.sh |  148 ++++++++++++++++++++++++++++++++++++--=
-------
 t/test-lib.sh            |    7 +-
 userdiff.c               |   22 ++++++-
 3 files changed, 139 insertions(+), 38 deletions(-)
