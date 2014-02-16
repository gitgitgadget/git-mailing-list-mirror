From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] commit: add --cleanup=scissors
Date: Sat, 15 Feb 2014 22:44:53 -0500
Message-ID: <CAPig+cSwU5CEBZX7sBJnSvUo=sx=uC5qJx+9UwikqYWSgM7wMw@mail.gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
	<1392521840-21628-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 04:45:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEsf9-0007P7-Rl
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 04:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbaBPDoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 22:44:54 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:59427 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaBPDoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 22:44:54 -0500
Received: by mail-yh0-f54.google.com with SMTP id z6so13061803yhz.41
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 19:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=rTNiSlOXVWNnjdbgFQhgW/qEADEIAzBlH6nvjN/JnP8=;
        b=OhuBAL0v/Iqd4xOMTunYBp8xqtjqb1ypc7x/1C2lK/5WGKYdOovQKfASbks39dOmGn
         99SsZseP6dt4mt0+DH7z5kfbw/gGtvTfApwRZbCm6xdS8kLBZ0eVKqcqtadLVid0yd1h
         oNWhb3QGzCuHEB8kbhaN3aDpIpBF8hbJT5m6ktmPVfsrIFFyyYR33kbcuOC/6uifLb+k
         610aqeihAQHIXFckVpu05La9iyLTMYdsgVksxbHtk1TbjHhrKMjHLzNqHiO2DcrpfNER
         BNo/fSHklIdiEkY4upE4aRhgvyXQytytnBEwLsaf0RPFyvPLBe8PbfRFyT9X6o1HHTRh
         /zKw==
X-Received: by 10.236.7.100 with SMTP id 64mr17172057yho.23.1392522293243;
 Sat, 15 Feb 2014 19:44:53 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sat, 15 Feb 2014 19:44:53 -0800 (PST)
In-Reply-To: <1392521840-21628-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: QtXwGSh7Be-OdgHtdkpN_nky-qQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242212>

On Sat, Feb 15, 2014 at 10:37 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Since 1a72cfd (commit -v: strip diffs and submodule shortlogs from th=
e
> commit message - 2013-12-05) we have a less fragile way to cut out
> "git status" at the end of a commit message but it's only enabled for
> stripping submodule shortlogs. Add new cleanup option that reuses the
> same mechanism for the entire "git status" without accidentally remov=
e

s/remove/removing/

> lines starting with '#'
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 1a7616c..98f976a 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -176,7 +176,7 @@ OPTIONS
>  --cleanup=3D<mode>::
>         This option determines how the supplied commit message should=
 be
>         cleaned up before committing.  The '<mode>' can be `strip`,
> -       `whitespace`, `verbatim`, or `default`.
> +       `whitespace`, `verbatim`, `scissors` or `default`.
>  +
>  --
>  strip::
> @@ -186,6 +186,11 @@ whitespace::
>         Same as `strip` except #commentary is not removed.
>  verbatim::
>         Do not change the message at all.
> +scissors::
> +       Same as `whitespace`, except that everything from the line
> +       "`# ------------------------ >8 ------------------------`"

Would it make sense to be more explicit and say that the 'cut' line is
also removed?

    Same as `whitespace`, except that the line
    `# ------------------------ >8 ------------------------`
    and all lines following it are removed ...

> +       is truncated if the message is to be edited. "`#`" could be

s/could/can/

> +       customized with core.commentChar.
>  default::
>         Same as `strip` if the message is to be edited.
>         Otherwise `whitespace`.
