From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t0027: Add repoMIX and LF_nul
Date: Fri, 24 Apr 2015 16:07:39 -0400
Message-ID: <CAPig+cSFBoZ=pjvob0GEem-fzn7G_7uROgtVCViTXiXowN=AbQ@mail.gmail.com>
References: <553A9D93.60901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 22:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yljt2-0005L1-NO
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 22:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965367AbbDXUHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2015 16:07:41 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36207 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbbDXUHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 16:07:40 -0400
Received: by iebrs15 with SMTP id rs15so91675157ieb.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2aF1FBTCB4UF9Ge6S2TBGMMv37szY8+euHYK8kN12Ro=;
        b=LqV4micEK7x1FXuvXCXcUcgdCLw/uO7iVoMBQ2h/vks+EKnQpaPU3sbdP0h1uiCIxx
         vnDm+R5LpVuKX1Syk/dJ8uA9Q8PskMsrgkQ5YkGJnin8k/ZtWEDDPJqsq8qfuIIs78Sb
         NK3QD4zWOp5rRyIzbm05v+XC9oPv7YGUfpVAmyGCAEdPYlsmJNkf9IQy1+4IxtEojj4b
         b4406Ib6o7veA7hqEuRPgNzyGvikIdrb+/Br0vb74DlhDkb4xpV91OrGXoLbBlhXgCKz
         I+lieTL//lF5Dud5jG2MIUt3X389+h18xdwEOFpxuxPjMLL5qY61jFNaL+XjS9XaTiDF
         /bOQ==
X-Received: by 10.107.169.74 with SMTP id s71mr194007ioe.46.1429906059525;
 Fri, 24 Apr 2015 13:07:39 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 24 Apr 2015 13:07:39 -0700 (PDT)
In-Reply-To: <553A9D93.60901@web.de>
X-Google-Sender-Auth: NPK2DSzXhBubr3GXaqdzRlqyaSI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267754>

On Fri, Apr 24, 2015 at 3:46 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> "new safer autocrlf handling":
>   Check if eols in a file are converted at commit, when the file has
>   CR (or CLLF) in the repo (technically speaking in the index).
>   Add a test-file repoMIX with mixed line-endings.
>   When converting LF->CRLF or CRLF->LF: check the warnings
>
> checkout_files():
>   Checking out CRLF_nul and checking for eol coversion does not
>   make much sense (CRLF will stay CRLF).
>   Use the file LF_nul instead: It is handled a binary in "auto" modes=
,
>   and when declared as text the LF may be replaced with CRLF, dependi=
ng
>   on the configuration
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 810934b..2482b2c 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -71,12 +71,21 @@ commit_check_warn () {
>         attr=3D$2
>         lfname=3D$3
>         crlfname=3D$4
> -       lfmixcrlf=3D$5
> -       lfmixcr=3D$6
> -       crlfnul=3D$7
> -       create_gitattributes "$attr" &&
> +  repoMIX=3D$5

Unusual indentation.

> +       lfmixcrlf=3D$6
> +       lfmixcr=3D$7
> +       crlfnul=3D$8
>         pfx=3Dcrlf_${crlf}_attr_${attr}
> -       for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
> +       # Special handling for repoMIX: It should already be in the r=
epo
> +       # with CRLF
> +       f=3DrepoMIX
> +       fname=3D${pfx}_$f.txt
> +       echo >.gitattributes &&
> +       cp $f $fname &&
> +       git -c core.autocrlf=3Dfalse add $fname 2>"${pfx}_$f.err" &&
> +       git commit -m "repoMIX" &&
> +       create_gitattributes "$attr" &&
> +       for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nu=
l
>         do
>                 fname=3D${pfx}_$f.txt &&
>                 cp $f $fname &&
