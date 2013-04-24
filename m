From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 03:19:43 -0400
Message-ID: <CAPig+cT18z7Hs70XMF99ACOs5cy2S=FTapjQO=Mb+EMYc=6hJw@mail.gmail.com>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Stelmach?= <l.stelmach@samsung.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUtzZ-0003DA-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab3DXHTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 03:19:45 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:46970 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab3DXHTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 03:19:44 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so1412305lbi.28
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R2/tWhUGXTKnclB/XqJSuwChwdLHeeLWUHJGHujkHdw=;
        b=AEk9vewxNlubqq/H/66/zrdkdzlX+fuvKeDaeGCUI8Oz8GC3dLuLe5tJOW102G/W0F
         CndII6axf21LyS1pbPXqgHjFq2f7Teq4JCNgddgQRHJmpl6JI4OoIidJ4pvnKaz/gJbt
         2PaRE0V0BsTLEas1byPz031lirSZdUeeHZ8uu9Sx6h/BetBv6ZEtU+ddAk5Cz40d2q+o
         phBc7iOi+I8ZdNk+nIuteORPfRr9vN1QNvf7EH+HxB07PUqJdNefZn+AYZNbpaVXdqpx
         UBkUTr5UqE8a/5V1WnHdPkLQA7cS3BkTGQWu/qcNL3GuKzrnnobGntIs0s3Mo0aYQbCz
         YRQg==
X-Received: by 10.152.21.229 with SMTP id y5mr17081250lae.44.1366787983222;
 Wed, 24 Apr 2013 00:19:43 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Wed, 24 Apr 2013 00:19:43 -0700 (PDT)
In-Reply-To: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
X-Google-Sender-Auth: -Rv-6VdoiWMOzG-86gSDXFFGJHo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222229>

On Tue, Apr 23, 2013 at 7:13 AM, =C5=81ukasz Stelmach <l.stelmach@samsu=
ng.com> wrote:
> Enable sending patches to NNTP servers (Usenet, Gmane).
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bd13cc8..0356635 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1174,6 +1249,18 @@ X-Mailer: git-send-email $gitversion
>
>         if ($dry_run) {
>                 # We don't want to send the email.
> +       } elsif ($email_protocol eq 'nntp') {
> +               if (!defined $nntp_server) {
> +                       die "The requires NNTP server is not properly=
 defined."

s/requires/required/

> +               }
> +               require Net::NNTP;
> +               $nntp =3D  Net::NNTP->new(email_host_string(),
> +                                       Debug =3D> $debug_net_nntp);
> +               email_auth_maybe or die $nntp->message;
> +               $nntp->post or die $nntp->message;
> +               $nntp->datasend("$header\n$message") or die $nntp->me=
ssage;
> +               $nntp->dataend() or die $nntp->message;
> +               $nntp->code eq "240" or die "Failed to send $subject\=
n".$nntp->message;
>         } elsif ($smtp_server =3D~ m#^/#) {
>                 my $pid =3D open my $sm, '|-';
>                 defined $pid or die $!;
