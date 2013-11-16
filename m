From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] transport: Catch non positive --depth option value
Date: Sat, 16 Nov 2013 09:58:58 +0700
Message-ID: <CACsJy8BQr_9YEZq=ydz44w=9d8d5XpBDTLeXNnui7AVrMuDd3A@mail.gmail.com>
References: <5283A380.9030308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 03:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhW6w-0001Dv-B8
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 03:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab3KPC7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Nov 2013 21:59:31 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:35047 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab3KPC73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Nov 2013 21:59:29 -0500
Received: by mail-qe0-f51.google.com with SMTP id t7so2731998qeb.38
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 18:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=Osz6jtMi/v7UEItKZCeMMACUUFk6EWnnw3CXZRxwDEs=;
        b=Ihzgyl6vrRSWZXBbd2vbdBFMLJ21UbXZksVmXm1+/vlhvjZCIjhi8w/rklntDqWAcR
         OEPYCivd6NWuBfqimhgzAwhI5ojNrSvIqOhUJo5VRwyceI8mJU9dbD5qyW2GGya5N3Su
         0GaSVkJ9iQ8N7jpYVZFvZtqTqfKrsygcAVC9+b8GHX/r61vRyDeES+U+XMHbDL9I5MgU
         unYr1PrQMsay5iqTMIT+mC2F3PJZel5zTqm8z0ib4Ix7u+ZKAxT/+RY6uY0sVOYtEzAN
         Ajsumv4xahFaBcJVKMBdEHerc2zExSP8epnt1Uzv0cpwOWwn7r1pSisvRv8CZSvGY5m2
         iueg==
X-Received: by 10.224.114.81 with SMTP id d17mr15977080qaq.18.1384570769039;
 Fri, 15 Nov 2013 18:59:29 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Fri, 15 Nov 2013 18:58:58 -0800 (PST)
In-Reply-To: <5283A380.9030308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237920>

On Wed, Nov 13, 2013 at 11:06 PM, "Andr=C3=A9s G. Aragoneses"
<knocte@gmail.com> wrote:
> Instead of simply ignoring the value passed to --depth
> option when it is zero or negative, now it is caught
> and reported.
>
> This will let people know that they were using the
> option incorrectly (as depth<0 should be simply invalid,
> and under the hood depth=3D=3D0 didn't mean 'no depth' or
> 'no history' but 'full depth' instead).

'full depth' may be confusing (is it --unshallow?). Other than that
the patch looks fine.

>
> Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index 7202b77..edd63eb 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -483,6 +483,8 @@ static int set_git_option(struct git_transport_op=
tions
> *opts,
>                         opts->depth =3D strtol(value, &end, 0);
>                         if (*end)
>                                 die("transport: invalid depth option =
'%s'",
> value);
> +                       if (opts->depth < 1)
> +                               die("transport: invalid depth option =
'%s'
> (non positive)", value);
>                 }
>                 return 0;
>         }
> --
> 1.8.1.2



--=20
Duy
