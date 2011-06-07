From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Tue, 7 Jun 2011 12:07:49 +0200
Message-ID: <BANLkTi=eC37opWnN4nmC5AP66M+m5nZ86Q@mail.gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org>
 <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com> <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
 <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com> <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theo Niessink <theo@taletn.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 12:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTtD9-0004Hc-QE
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 12:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab1FGKIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 06:08:31 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:55343 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab1FGKIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 06:08:30 -0400
Received: by pxi2 with SMTP id 2so3544514pxi.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=olFVS3/uUdvuEhdcJFa1F/HaPXwYq0bTA71dVx5oglU=;
        b=Lbtki1X3xncOJ/1K6kBdOw3OYnlVFADI5fplvea4augNHQCFktGeB8S2b4IUC+CYJK
         hxrsMv1Z6KQJl+Nd+8r5kSe1U32o9dEGlRvDrn/KBg4T/3kn3WxIy0/1lOq+8A4AWg18
         pSqhwfpbTQ5Pfz/llKUcO4XX1csTXCOHq83ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=pX2UQ8xyjMwC5X+oTMVEses/xlv10a+85DxF+f2kxi84XqWcLE/S3z2+/lFMSj+75v
         9uUu61fQSJfjPWFAJWrz9IRr6ppjZxiniSn4kyImsf9tMQe95C3GAwmGRii4vbHnYdJF
         ipoDr2TqIMROWDeAD+CWsaO6wtA9NvQdhi4GY=
Received: by 10.68.68.106 with SMTP id v10mr25217pbt.115.1307441309429; Tue,
 07 Jun 2011 03:08:29 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Tue, 7 Jun 2011 03:07:49 -0700 (PDT)
In-Reply-To: <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175190>

On Tue, Jun 7, 2011 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>> Nitpick: If you already know that c !=3D '\0' and !is_dir_sep(c), t=
hen why do
>>> continue? It will check for '\0' and is_dir_sep(c) again, but you a=
lready
>>> know that both ifs will be false. So you could just as easy jump st=
raight to
>>> c =3D *path++, which IMHO also makes the code easier to follow:
>>
>> Very good point, thanks for noticing. I just rewrote the logic from
>> switch/case to if/else, but with the rewrite these redundant compare=
s
>> became more obvious. I think your version is better, indeed.
>
> Let's not add an unnecessary goto while at it. =A0How about this on t=
op
> instead?
>
> =A0read-cache.c | =A0 13 +++----------
> =A01 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 31cf0b5..3593291 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -784,16 +784,9 @@ int verify_path(const char *path)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_dir_sep(c)) {
> =A0inside:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D *path++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (c) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '/': case '\0':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '.':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ver=
ify_dotfile(path))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((c =3D=3D '.' && !v=
erify_dotfile(path)) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_dir_sep(c) |=
| c =3D=3D '\0')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D *path++;
> =A0 =A0 =A0 =A0}

This change the "c =3D=3D '.' && verify_dotfile(path)"-case to eat the =
'.'
character without testing it against is_dir_sep, which is exactly what
we want. The other cases return 0, as they used to. Good.

Indeed, this is a cleaner approach. Thanks!
