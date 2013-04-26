From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 18:00:24 +0800
Message-ID: <CANYiYbFTTGds3yU+-9BL=oTXFk5X4jR_MMR3cQVE4=qPgutWEg@mail.gmail.com>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	<vpqwqrpfzez.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 26 12:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVfSA-0003JU-DT
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 12:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702Ab3DZKA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 06:00:26 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:42908 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab3DZKAZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 06:00:25 -0400
Received: by mail-we0-f169.google.com with SMTP id p43so3435213wea.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=dnyqXYA79vwzS0LNZXdboLAwyZ1v1zD2yI5iglvmUnY=;
        b=UDFR7IGGRxMRZ2qr4BWOzBkajnM3afm5aanhVww/ROGSKOsFTQEX02kswpqNHyOklZ
         audfRoNRBqbWr0y3BXoTWJhBOUHjr1UZwUJVmPEr+O6k7tN1l5Cq9lF5wrc/uai5e3Ud
         wdOkcteS8lsbgkDkP+G6c6zQDYFH5id9v52gIdwimVVrftDgI2uY64U47+2Im2O9tSDm
         CUNIL4LzaBfxdKf2VQueOJjT9p8z42lf6SOdQotskIei5RcO5ScISpjUkSWVZlVjbf73
         1n5Qao1dDVdRvjXICMbbCodMK5dIi676ixfxf80GhYWY4M0lR6ZEokNHNfm3HDxqv7vR
         po6Q==
X-Received: by 10.180.83.199 with SMTP id s7mr2874228wiy.19.1366970424282;
 Fri, 26 Apr 2013 03:00:24 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Fri, 26 Apr 2013 03:00:24 -0700 (PDT)
In-Reply-To: <vpqwqrpfzez.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222525>

2013/4/26 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Maybe we can do like this:
>>
>> 1. Set the default value of 'clean.requireForce' to false.
>> 2. Show a error message and do nothing, if there is not 'clean.requi=
reForce'
>>     setting, but the user called with a '--force' flag.
>>     ( like a transition for the change of push.default in git 2.0)
>
> Perhaps introducing a new value for 'clean.requireForce':
>
> $ git config --global clean.requireForce ask
> $ git clean
> .will remove ...
> are you sure [y/N]?
>
> The error message when clean.requireForce is unset and --force is not
> given could point the user to clean.requireForce=3Dask.

Add new value for clean.requireForce would break old git clent.

   $ git clean
   fatal: bad config value for 'clean.requireforce' in .git/config

>
> Then, maybe, later, this could become the default. But I tend to like
> the non-interactive nature of most Git commands, so I'm a bit relucta=
nt
> here. My way of doing the confirmation dialog is
>
> $ git clean -n
> would remove ...
> $ git clean -f
>

I try to put all cases in one table, but still looks weird.

    | clean.requireForce  |     git clean     | git clean --force |
    +---------------------+-------------------|-------------------|
    | TRUE                | error             | delete...         |
    +---------------------+-------------------|-------------------|
    | FALSE               | delete...         | delete...         |
    +---------------------+-------------------|-------------------|
    | unset               | confirm           | warn + confirm    |
    +---------------------+-------------------|-------------------|

Does anyone really set and use "clean.requireForce" setting?
And if there is a confirm dialog, do we need 'clean.requireForce' any m=
ore?
Or we can add a `--no-ask` option, in order to override the confirm dia=
log.


> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



--
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
