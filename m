From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 20/25] list-files: preload index
Date: Mon, 6 Apr 2015 17:35:50 -0400
Message-ID: <CAPig+cTfSvCyfRB9TiEd8X8KT=--iU3sJyWrH9xSPk0mwAo-Pw@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEgZ-0006ee-AS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbbDFVfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:35:54 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33484 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbDFVfw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:35:52 -0400
Received: by layy10 with SMTP id y10so28741540lay.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=QTk6LUIkivg4LkCMZRd6HJNUwLGYoQeBSGbi2/48cuY=;
        b=uemghoYFGpYjQd35HGswVP70yZuR7tzd3MSFD7WGHP3leXNLpYbranhnyfUExYSjx3
         Hx9kQvppSer42dEATiJH+x9LBrvvanonx5PsXfXwmvAF50LzLy3mq42xLKZcRIOWbXVq
         Ffqw7RX2+1DFNdzEQPOsbsI0JSHMvhj4UpQ8+Ux7i8wgIvC6wMfmI+UtzlE2Awpd5puI
         YgSPQsuiFjGLAhjfzcSDOYqRh8kgxBO7YS2UFjExC1uhv2IrFmAYEIKv4F4taa5IeUUs
         /SHlLSMMdlpS4Q63bjz5pG9N4ZRCtJlnN6pDYZjalcqZ8WKFysItGRy2XXba96lOO+IR
         HUcw==
X-Received: by 10.112.146.129 with SMTP id tc1mr14990951lbb.27.1428356150692;
 Mon, 06 Apr 2015 14:35:50 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:35:50 -0700 (PDT)
In-Reply-To: <1428328354-14897-21-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: I8gmi5jqtOHLlvdh22xuDK1hDmk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266887>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Try to reduce refresh time. Note that we still need another
> read_cache() at top top, before parse_pathspec() because this

s/top top/the/top/

> *_SLASH_CHEAP needs the index loaded.
>
> One day read_index() should be improved to notice that the on-disk
> version is the same as the one in memory and skip I/O entirely..

s/\.\.$/./

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/list-files.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 31c2336..948b8e6 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -529,6 +529,7 @@ int cmd_list_files(int argc, const char **argv, c=
onst char *cmd_prefix)
>         recursive_pathspec.max_depth =3D -1;
>         finalize_colopts(&colopts, -1);
>
> +       read_cache_preload(&recursive_pathspec);
>         refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
>                       &recursive_pathspec, NULL, NULL);
>
> --
> 2.3.0.rc1.137.g477eb31
