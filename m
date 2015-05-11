From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 6/6] cmd-list.perl: ignore all lines until [commands]
Date: Mon, 11 May 2015 02:59:21 -0400
Message-ID: <CAPig+cRSPENt8QamfSOSgVFf_nmRKnfYkiOpf09WR=6--fLaEw@mail.gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431191856-10949-7-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 08:59:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrhgW-0005SO-73
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 08:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbEKG7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2015 02:59:24 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38250 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbEKG7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 02:59:22 -0400
Received: by igbhj9 with SMTP id hj9so62626279igb.1
        for <git@vger.kernel.org>; Sun, 10 May 2015 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Kqnk0u+McZA/snoI7Mbdd2u/DtFnzdLG5rUkcF2d7w4=;
        b=HGuz+pwcVrm5xOhY12yJadc741C2rw/3y1ejfL3bh0kE82lpq3HN7PMGLgg+bnQw61
         Ug5/DofJdRV2SS2nMvDATc1Dsa3Wd/B10RPgdRk+ubDJoJw5F9xgwhYSYgyXSqJGFIsE
         kOJ3xPIKvTgGXKcC5nrT3hqYcrFbBpJ7Y5TEOF7ctnuF/KNGrevO/Ln8U+jAhKPrfhs8
         +GHU4f3BDr+ymyxw+Pn6QurNHlBUKJuwwK5yJ+LNwF5HWkj4RkMaMu035bs/tkuEILbz
         mpOch8+rTwlJ+Pu2ClBlmMzAhdmcltkS8xA3GQX3qIQ+JB7ZJii/wHtLTaH+2mypQY4L
         J4bA==
X-Received: by 10.42.146.202 with SMTP id k10mr9532909icv.34.1431327561689;
 Sun, 10 May 2015 23:59:21 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 10 May 2015 23:59:21 -0700 (PDT)
In-Reply-To: <1431191856-10949-7-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: kqfwJNS7nWCsV2ZQq0nJC2kXw-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268763>

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> command-list.txt contains a [common] block that should be ignored
> by the Documentation checker cmd-list.perl.
>
> Filter out this block before the actual processing of the command lis=
t.
>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.per=
l
> index 04f9977..d581378 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -38,8 +38,14 @@ sub format_one {
>         }
>  }
>
> +my @filtered =3D ();
> +while (<>)
> +{

Style: while (<>) {

> +       push (@filtered, $_) unless 1../^\[commands\]/;
> +}

Why collect the lines into @filtered when you could instead merely
skip the unwanted ones outright?

    while (<>) {
        last if /^\[commands\]/;
    }

And, then you don't need to touch the following 'for' loop at all.

>  my %cmds =3D ();
> -for (sort <>) {
> +for (sort @filtered) {
>         next if /^#/;
>
>         chomp;
> --
> 2.4.0
