From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 0/9 v2] difftool: teach command to perform directory diffs
Date: Tue, 20 Mar 2012 09:07:41 -0400
Message-ID: <CAFouetj2gME+X47EUAQTUKX_GJ8PW=cSWRj7VUdBsi91Aa9Wyw@mail.gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
	<1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
	<7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davvid@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 14:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ysU-0003oz-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 14:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab2CTNNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 09:13:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64127 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab2CTNNZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 09:13:25 -0400
Received: by gghe5 with SMTP id e5so13220ggh.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DggIjlkLNmeiwVM5n5SBBe3QqgtsBNbfjPCGtgXX5Kg=;
        b=ervjHPqUK62otFBUtsxCOI+5MFvLNg55jZR/oBNv3Ut3z7wx3mgZy8SE0F4dUqGZ+X
         SLGNDb5IVtsTaOCjcwig/mQ5fFdKQ6RgSijXNCSaBWbE6T7qr+rXrf0Gl3aZUV/yJ3x7
         gD9dkZWI9SXxEED1GObf5iLnhin3mwUtu7W6v/SvpZKyYOzboMNIVibvJi7zAB9OCxXr
         mIAWhvj0RYhTJTq4cb/xLMDqDwnbTQaM8+P4l0nyh8IcBby1dL40qBz4lKX2LoARRURu
         fJ1ztR+cs0j7bHZjnSShe1tb4elR6lxx4H6BODc+fJ6eCSGXfAJMPpvKP0ZPCdU7UzTq
         EvKA==
Received: by 10.50.212.101 with SMTP id nj5mr8715086igc.41.1332248861327; Tue,
 20 Mar 2012 06:07:41 -0700 (PDT)
Received: by 10.42.138.5 with HTTP; Tue, 20 Mar 2012 06:07:41 -0700 (PDT)
In-Reply-To: <7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193509>

I have successfully tested on:
  - Linux with Git v1.7.10-rc0 and 1
  - Windows 7 with msysgit v1.7.9

I installed cygwin Git on Windows 7, but found that 'git difftool'
would not work, even before my patches were applied.  It appears that
I need to learn more about cygwin before I can use it as a test
platform.


On Mon, Mar 19, 2012 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> =C2=A0* In [1/9], use of pass_through would mean 'git difftool' must =
be fed the
> =C2=A0 options for difftool and then options meant for underlying dif=
f
> =C2=A0 machinery. =C2=A0Is this limitation still there? =C2=A0If so, =
isn't this a
> =C2=A0 regression? =C2=A0Shouldn't it at least be advertised to the u=
sers a lot
> =C2=A0 stronger in documentation?

Both the documentation and testing has shown that 'pass_through' works
as I expected.  That is, options that difftool cares about are
extracted from @ARGV while all others are passed on to the underlying
'git diff' command.  The order of the arguments/options does not
matter.  We "use 5.008;" at the top of the script, so I believe this
change is correct and safe.  That being said, I have a limited number
of computers/configurations to test on.


> =C2=A0* In [4/9], you remove the .exe extension when running git, whi=
ch was
> =C2=A0 there since the beginning of difftool 5c38ea3 (contrib: add 'g=
it
> =C2=A0 difftool' for launching common merge tools, 2009-01-16). =C2=A0=
I think it is
> =C2=A0 safe but are Windows folks OK with this?

My testing on Windows with msysgit has shown that this change is safe.
 Also, even though I had other problems when testing on cygwin (noted
at the top of the email), the 'difftool' script was able to
successfully execute 'git diff --raw -z' without appending '.exe'.


> =C2=A0* In [6/9], the exit code in the failure case seem to be modifi=
ed from
> =C2=A0 that of the underlying "git diff" to whatever croak gives us. =
=C2=A0Is this
> =C2=A0 a regression, or nobody cares error status from difftool? =C2=A0=
I personally
> =C2=A0 suspect it is the latter, but just double-checking if you have
> =C2=A0 considered it.

In my testing, if "Git::command_noisy(('diff', @ARGV))" fails, the
exit code from 'git diff' is passed back to the terminal.  So not only
is the 'git diff' exit code echoed to the terminal, but '$?' also
contains the correct exit code.


> =C2=A0* In [7/9], difftool--helper declares SUBDIRECTORY_OK, but ther=
e doesn't
> =C2=A0 seem to be any inclusion of git-sh-setup in this script, and t=
he patch
> =C2=A0 does not have any effort to prepend $prefix to paths relative =
to $cwd.
> =C2=A0 What good does the variable do here?

This was an oversight.  It was copied over from a previous
implementation that still used ". git-sh-setup".

So the only outstanding changes that I am planning are:
  1) Remove SUBDIRECTORY_OK
  2) Add tests for the new '--dir-diff' option

Would it be better to resend the complete patches series with these
changes or just add new patches to the end?

Please let me know if I missed anything else.
