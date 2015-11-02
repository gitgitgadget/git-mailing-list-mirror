From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] setup: do not create $X/gitdir unnecessarily when
 accessing git file $X
Date: Mon, 2 Nov 2015 15:01:47 -0500
Message-ID: <CAPig+cTKGtVoNr32C7XfZsKYs3Rhchb1Xrr3YEhJuie1tfa9Vw@mail.gmail.com>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
	<1446491306-13493-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Mike Rappazzo <rappazzo@gmail.com>, kyle@kyleam.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:01:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtLIf-0005EU-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbbKBUBt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 15:01:49 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35969 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbKBUBs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 15:01:48 -0500
Received: by vkex70 with SMTP id x70so91807252vke.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=D3MdKDHF1ynsOoK9VfhZgzfhyX6FRTctmPiCUAaXqNA=;
        b=xGzInla04yUwBEHCwBssY++lfMiPxe5uuiztJeMAfhBUCB7YT5YuwGQuV5OqXIe/Hr
         9CIOGg8ujp4sGG2ncrKwx4knMOhuBFKxqLUS+d75UgQRU5f3uMaZw7fPJYecVg+yT0uj
         7E5cFYa3J5GjRabp8K894ro9V/VInqEIWp0AHVGm2B/W+FgU8z4Cejcpdw6aVe55L9Z0
         U1myt7EYbEwzqxsFKHdfi5YCyMMCDUh8f3BTxqpr80HfxSfRmIAxN2SegFM1rJ+b+WB2
         NUmdmHdZ6tLqLI/ItUBPyQ5wJhfnYZokA1B2WTUmskGx5oqKkaWjNMJqgy5iVC+SLzM4
         DCBg==
X-Received: by 10.31.2.193 with SMTP id 184mr16200290vkc.151.1446494507742;
 Mon, 02 Nov 2015 12:01:47 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 2 Nov 2015 12:01:47 -0800 (PST)
In-Reply-To: <1446491306-13493-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 8E9AKsA2Fwd1CiGP7LeIi1ZTEr4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280713>

On Mon, Nov 2, 2015 at 2:08 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> $X/gitdir is created, or refreshed, in order to keep a linked worktre=
e
> from being pruned. But while git file is used as the foundation for
> linked worktrees, it's used for other purposes as well and we should
> not create $X/gitdir in those cases.
>
> Tighten the check. Only update an existing file, which is an
> indication this is a linked worktree.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> @@ -99,6 +99,13 @@ test_expect_success 'check rev-list' '
> +test_expect_success '$REAL/gitdir is not created on ordinary git fil=
e' '
> +       echo "gitdir: $REAL" >expected &&
> +       test_cmp expected .git &&
> +       git status &&
> +       ! test -f "$REAL"/gitdir

Minor: test_path_is_missing() might convey the intention a bit more cle=
arly.

> +'
