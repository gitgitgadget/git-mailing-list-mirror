From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] t5000: test long filenames
Date: Mon, 20 May 2013 15:55:38 -0400
Message-ID: <CAPig+cTitT9Z+2pxeNh3dXi4b7X738qpkUnEmTi2yvQoCPtHqA@mail.gmail.com>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1369043909-59207-7-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 20 21:55:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeWBQ-0001Xg-12
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 21:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023Ab3ETTzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 15:55:42 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35562 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978Ab3ETTzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 15:55:40 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so6996173lbf.0
        for <git@vger.kernel.org>; Mon, 20 May 2013 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iSEs5hEv2B5AQamWNpq+afkxNgQM//zyisw9WJHfL+U=;
        b=rlLcJeAg+lkCg4tCA9RNAW+5ts6zgl9srevvxQSBast0kGnnCgZkr0Oyv2Jg3teMQ7
         Ig/5mwvmpfD9hSwaMNeLnCZusUXlz6UGEYnV0oTX4otq+ZFpXk3mlLHJGwTu7FLeEVJS
         FIBZXRNoVSUZzz3TGSW/FEHkTGybb6FiANjYP+TdDuW5HRVHa2gPV139PWMJJjCZUy2h
         Zdmkdgn+C+kP1BTh4X8mrqH2eO/m/E8AZAW9SqFH3Pf3Wx9K92KJ1ViCR9BE9Pthwg36
         H50yx2igY5PFzNeh3GmNITvsN1js7QcL87x4R5rN7NxyPN3Q4xiqfoy64cPlKuvK6iBj
         1CBQ==
X-Received: by 10.112.133.137 with SMTP id pc9mr28144384lbb.74.1369079738452;
 Mon, 20 May 2013 12:55:38 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Mon, 20 May 2013 12:55:38 -0700 (PDT)
In-Reply-To: <1369043909-59207-7-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Google-Sender-Auth: BVO88gUXGuNaaBblRlyMbHNvV5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224977>

On Mon, May 20, 2013 at 5:58 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index a1f35d2..c2023b1 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -40,6 +66,24 @@ check_tar() {
>                 (mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
>         '
>
> +       test_expect_success TAR_NEEDS_PAX_FALLBACK ' interpret pax he=
aders' '

s/' interpret/'interpret/

> +               (
> +                       cd $dir &&
> +                       for header in *.paxheader
> +                       do
> +                               data=3D${header%.paxheader}.data &&
> +                               if test -h $data -o -e $data
> +                               then
> +                                       path=3D$(get_pax_header $head=
er path) &&
> +                                       if test -n "$path"
> +                                       then
> +                                               mv "$data" "$path"
> +                                       fi
> +                               fi
> +                       done
> +               )
> +       '
> +
>         test_expect_success ' validate filenames' '
>                 (cd ${dir_with_prefix}a && find .) | sort >$listfile =
&&
>                 test_cmp a.lst $listfile
> @@ -54,6 +98,8 @@ test_expect_success \
>      'populate workdir' \
>      'mkdir a &&
>       echo simple textfile >a/a &&
> +     ten=3D0123456789 && hundred=3D$ten$ten$ten$ten$ten$ten$ten$ten$=
ten$ten &&
> +     echo long filename >a/four$hundred &&
>       mkdir a/bin &&
>       cp /bin/sh a/bin &&
>       printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
> diff --git a/t/t5000/pax.tar b/t/t5000/pax.tar
> new file mode 100644
> index 0000000000000000000000000000000000000000..d91173714991fded560fc=
d6a8aaec6aa6ec7f5e8
> GIT binary patch
> literal 10240
> zcmeIy%?g4*5Ww+0_Y^*X&3@?Sp?k+(L29F*2+YXGPl*s(6d@sk|6W#S)Sdakm@c<v
> zvkB!sRJT<7LN5=3Deb5OG`X;<!?>h^Yh?xL+x+Gv-HHCB5i+IVkN(#%@Lz{l>lx~$rg
> z2GWzmuipCRCcpUG2dyNR`g93vZSz%O3b*p9Sn-k>pDo&KIhx%KXMfulr%w}@f7;`7
> zyU`e%|L&jgG5=3DzmO1_@SxRf~Zp8x84t>bJTc^pGH_qWm2pU!{O2LS{SKmY**5I_I{
> l1Q0*~0R#|0009ILKmY**5I_I{1Q0*~0R#|00D->}cmml}KZ5`O
>
> literal 0
> HcmV?d00001
