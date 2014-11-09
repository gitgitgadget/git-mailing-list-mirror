From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 22/22] untracked cache: guard and disable on system changes
Date: Sat, 8 Nov 2014 22:39:01 -0500
Message-ID: <CAPig+cRNpgBNr0cT6P-tsMc3McyC4aC7czcQYz0P+9_uSpkZSw@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1415439595-469-1-git-send-email-pclouds@gmail.com>
	<1415439595-469-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 04:39:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnJLI-00084x-C6
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 04:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbaKIDjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 22:39:04 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:49563 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaKIDjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 22:39:03 -0500
Received: by mail-yk0-f177.google.com with SMTP id 142so3194788ykq.22
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 19:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Bv9sUtyNVl88X1x+ky9wNMcitqF3VH3W/ljbFbYwg8g=;
        b=NtVLX81zNNhPtGEmEEaE3rvJKd+AdNtKT2ulANbqDsPjbwM0HqaCwbPscR9XbH5hBI
         UU3Me4BLUyk7oPWmExKr7MKB8JJM4drOXZw474LLibIxm7tr5HDC0wiVvkTU1mgJRcTb
         /c83NMsE1O+XxSqg3a0vWfBuCjo8d8gWGIV1alOXTIY2yPuxn57F676BOutNoJRGCsxl
         HCphD9wTNnkFuju1xeLbd4UgekRPyapG5PbvpVnCpoRjP/c7umrc1OqgBU4GKSG8GMtN
         YDjVoIAsPb4MCG7In5otRICNKO17kqIq2GHcvRvV62lW8ZIO63iPApA8CS6OW3h1d4S0
         a4ww==
X-Received: by 10.236.18.131 with SMTP id l3mr20430124yhl.167.1415504341870;
 Sat, 08 Nov 2014 19:39:01 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sat, 8 Nov 2014 19:39:01 -0800 (PST)
In-Reply-To: <1415439595-469-23-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 2PQ-p7nucmqgvNXzRFoy2oGfVG0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 8, 2014 at 4:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> If the user enables untracked cache, then
>
>  - move worktree to an unsupported filesystem
>  - or simply upgrade OS
>  - or move the whole (portable) disk from one machine to another
>  - or access a shared fs from another machine
>
> there's no guarantee that untracked cache can still function properly=
=2E
> Record the worktree location and OS footprint in the cache. If it
> changes, err on the safe side and disable the cache. The user can
> 'update-index --untracked-cache' again to make sure all conditions ar=
e
> met.
>
> This change does not cover all bases, you can fool it if you try
> hard. The point is to stop accidents.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.=
c
> index 710441e..25d855d 100644
> --- a/test-dump-untracked-cache.c
> +++ b/test-dump-untracked-cache.c
> @@ -44,6 +44,7 @@ int main(int ac, char **av)
>  {
>         struct untracked_cache *uc;
>         struct strbuf base =3D STRBUF_INIT;
> +       setup_git_directory();

What is this change about? Is it related to the rest of this patch?

>         if (read_cache() < 0)
>                 die("unable to read index file");
>         uc =3D the_index.untracked;
> --
> 2.1.0.rc0.78.gc0d8480
