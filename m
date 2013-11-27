From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 15/28] fetch: add --update-shallow to get refs that
 require updating .git/shallow
Date: Tue, 26 Nov 2013 20:53:52 -0500
Message-ID: <CAPig+cRMj_RY53--OLDmonZLzhzf0Cu+JrDc8LAicSn5QGKNyQ@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 02:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlUKI-0001Pm-53
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 02:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab3K0Bx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 20:53:57 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38364 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab3K0Bxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 20:53:54 -0500
Received: by mail-lb0-f174.google.com with SMTP id c11so4960464lbj.5
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 17:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Ug+VOv1yq4qWR9+zS4dQCyNDSjdb91A8ydV8pX0thko=;
        b=OHTqzSgMM92+wW7jAVvcksPHazeO72mCxaA5oL3EAC7LxbORJJCDiuvtbJJumjklF6
         asOCn8IQDDQ+uvQa34tnEaPn1nLkuppwQb9O8OLVTxXffNeQZafpYCLOFdWMxbkakJNk
         538be8zqbDyqz2PLONk2wHHKkVrFi/IC5JU2ZietPhntOCK6e54qT86yioF7YGshzts9
         hmz5/Zm/QK+vQRaHCKdu9mYuJE+RCaFq5UCUnDyY+fWJYde/+4S+3PDURD5qBNipqj1u
         SSh6EHOb3SfgULSOzVTNA2DYSI7XXTvYMWQTBAj6RF9lVeZXtRkKE7NjAQKaXbNYV7P6
         VoHQ==
X-Received: by 10.152.28.161 with SMTP id c1mr426169lah.24.1385517232806; Tue,
 26 Nov 2013 17:53:52 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Tue, 26 Nov 2013 17:53:52 -0800 (PST)
In-Reply-To: <1385351754-9954-16-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: dqNRsxZiDHetxbQTsrt-1DXWg1E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238403>

On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
> index e011ead..95b6313 100755
> --- a/t/t5536-fetch-shallow.sh
> +++ b/t/t5536-fetch-shallow.sh
> @@ -141,4 +141,26 @@ EOF
>         )
>  '
>
> +test_expect_success 'fetch --update-shallow' '
> +       (
> +       cd notshallow &&
> +       git fetch --update-shallow ../shallow/.git refs/heads/*:refs/=
remotes/shallow/* &&
> +       git fsck &&
> +       git for-each-ref --format=3D"%(refname)" |sort >actual.refs &=
&

Exit status of git-for-each-ref could be lost down the pipe.

> +       cat <<EOF >expect.refs &&
> +refs/remotes/shallow/master
> +refs/remotes/shallow/no-shallow
> +EOF
> +       test_cmp expect.refs actual.refs &&
> +       git log --format=3D%s shallow/master >actual &&
> +       cat <<EOF >expect &&
> +6
> +5
> +4
> +3
> +EOF
> +       test_cmp expect actual
> +       )
> +'
> +
>  test_done
