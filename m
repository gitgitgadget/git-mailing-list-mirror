From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git submodule foreach: Skip eval for more than one argument
Date: Fri, 27 Sep 2013 10:48:44 +0200
Message-ID: <CALKQrgfhUEE+E5KsAWbP_zj6tozk+V=qvNU1PX9Z73Vu8unTiQ@mail.gmail.com>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 27 10:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPTjN-0007mY-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab3I0Isx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Sep 2013 04:48:53 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:46586 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab3I0Isv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Sep 2013 04:48:51 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VPTjF-0007OT-Gg
	for git@vger.kernel.org; Fri, 27 Sep 2013 10:48:49 +0200
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VPTjF-0008Up-5i
	for git@vger.kernel.org; Fri, 27 Sep 2013 10:48:49 +0200
Received: by mail-pb0-f46.google.com with SMTP id rq2so2282175pbb.19
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 01:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=12J5blpzHBylJZrx9p30BcNe6tuHmgHBYHsRbkuyUFg=;
        b=hxlroXQdwGMdpYlmtAyoF/A0guPdPbeDzfK09uK4y7AoL7NLtAr/iJLczys8wxoOiP
         Eg+pgrKMGSY6Up+APSjwUK3zCiIsbHBNfMOcrivvVpyKN9OTx12GyaxwM5FTwE0E+UIP
         nIR5vZjHveVUGPDu2ScvUYmIKKr+DtcGq6XMbqTjiNsz4k6WRBkU9+nr7ehavqG/j4Dd
         Zavp+fOtqv2A4aHaM0vwH8Glk8Jf/0D6ldne5sd31ShYWKHflU+9RvZI/pE1DtPCa466
         V21xPr5roquNaCNPS+yti4IgLdLr2YxdmSAisdXkw7m2ZWTAKBJqLt7JqhM9XturOmKf
         3dAA==
X-Received: by 10.66.218.98 with SMTP id pf2mr10315871pac.120.1380271724810;
 Fri, 27 Sep 2013 01:48:44 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 27 Sep 2013 01:48:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235448>

On Thu, Sep 26, 2013 at 10:10 PM, Anders Kaseorg <andersk@mit.edu> wrot=
e:
> =E2=80=98eval "$@"=E2=80=99 created an extra layer of shell interpret=
ation, which was
> probably not expected by a user who passed multiple arguments to git
> submodule foreach:
>
> $ git grep "'"
> [searches for single quotes]
> $ git submodule foreach git grep "'"
> Entering '[submodule]'
> /usr/lib/git-core/git-submodule: 1: eval: Syntax error: Unterminated =
quoted string
> Stopping at '[submodule]'; script returned non-zero status.
>
> To fix this, if the user passed more than one argument, just execute
> "$@" directly instead of passing it to eval.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>

The change looks good, and the existing tests (in t7407) pass. :-)

Two comments, however:

1. Please add the use case you mention above as a new test case, so
that we can easily catch future regressions.

2. If we are unlucky there might be existing users that work around
the existing behavior by adding an extra level of quoting (i.e. doing
the equivalent of git submodule foreach git grep "\'" in your example
above). Will their workaround break as a result of your change? Is
that acceptable?


Have fun! :)

=2E..Johan

> ---
>  git-submodule.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c17bef1..3381864 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -545,7 +545,12 @@ cmd_foreach()
>                                 sm_path=3D$(relative_path "$sm_path")=
 &&
>                                 # we make $path available to scripts =
=2E..
>                                 path=3D$sm_path &&
> -                               eval "$@" &&
> +                               if [ $# -eq 1 ]
> +                               then
> +                                       eval "$1"
> +                               else
> +                                       "$@"
> +                               fi &&
>                                 if test -n "$recursive"
>                                 then
>                                         cmd_foreach "--recursive" "$@=
"
> --
> 1.8.4
>

--=20
Johan Herland, <johan@herland.net>
www.herland.net
