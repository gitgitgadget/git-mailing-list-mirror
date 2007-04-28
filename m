From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Ensure test-genrandom availability for t5301/t5302
Date: Sat, 28 Apr 2007 15:36:54 -0700
Message-ID: <56b7f5510704281536u5b5751a0k504a5ec0f8a36cf7@mail.gmail.com>
References: <4633A47A.4020508@cswitch.com>
	 <7v3b2kjfji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 00:37:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhvXI-00036H-7P
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 00:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031138AbXD1Wg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 18:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031156AbXD1Wg5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 18:36:57 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:26985 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031138AbXD1Wgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 18:36:55 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1565663nzf
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 15:36:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EaaFdWdnFdQwopU13ktWjZ/XK/20nMidmeTP8g7P7XqquTnFCppsTqvFczLfhnFU4bIAsX1B6Musxduj3gZQYuBD8MAKoUVAg3L4Ojnn6SBbjg++CS+rfieFYZk3QsEx3XBCRY8DI0Rj8n9RpHU98CXmYZ6G4uLAsu3kTw2jidc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErW8cxWW2VH9Q/CNsJGBpwfVwTtlgqsZoA6woSXyuL1f/bHjfdXHC2pZG7+UzzWBTAKY3CIIpQhN0Dtmd3QCO1gWsQkEPkay4P+6RO9/sBwjHA4lrhVdpmz0/bZpSTcqpgm1x5+ljpk+NpFsLt+ocXVek7uT4/fW63DV0aQB/6M=
Received: by 10.114.80.4 with SMTP id d4mr1506529wab.1177799814890;
        Sat, 28 Apr 2007 15:36:54 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Sat, 28 Apr 2007 15:36:54 -0700 (PDT)
In-Reply-To: <7v3b2kjfji.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45798>

Either way is fine with me.
I just don't want any one to have the nasty surprise I had --
fortunately I figured it out quickly.

So you will apply your patch?

Thanks,

Dana

On 4/28/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <how@cswitch.com> writes:
>
> > Check for this as well as test-chmtime in test-lib.sh
> >
> > Signed-off-by: Dana L. How <danahow@gmail.com>
> > ---
> >  t/test-lib.sh |   13 ++++++++-----
> >  1 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index f2c6bd3..d7838fc 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -268,11 +268,14 @@ test -d ../templates/blt || {
> >       error "You haven't built things yet, have you?"
> >  }
> >
> > -if ! test -x ../test-chmtime; then
> > -     echo >&2 'You need to build test-chmtime:'
> > -     echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
> > -     exit 1
> > -fi
> > +for prog in test-chmtime test-genrandom
> > +do
> > +     if ! test -x ../$prog; then
> > +             echo >&2 "You need to build $prog:"
> > +             echo >&2 "Run \"make $prog\" in the source (toplevel) directory"
> > +             exit 1
> > +     fi
> > +done
> >
> >  # Test repository
> >  test=trash
> > --
> > 1.5.2.rc0.71.g4342-dirty
>
> As these two are very small programs, why not always build them
> upon "make all", like this?
>
> ---
>  Makefile |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 60c41fd..817f8ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -933,13 +933,17 @@ endif
>
>  ### Testing rules
>
> +TEST_PROGRAMS = test-chmtime$X test-genrandom$X
> +
> +all:: $(TEST_PROGRAMS)
> +
>  # GNU make supports exporting all variables by "export" without parameters.
>  # However, the environment gets quite big, and some programs have problems
>  # with that.
>
>  export NO_SVN_TESTS
>
> -test: all test-chmtime$X test-genrandom$X
> +test: all
>         $(MAKE) -C t/ all
>
>  test-date$X: test-date.c date.o ctype.o
>
>
>


-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
