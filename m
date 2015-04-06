From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 17/25] list-files: add file modification options -[admADM]
Date: Mon, 6 Apr 2015 17:34:58 -0400
Message-ID: <CAPig+cSXj47+EzvNC0HOpDD5OM7y7mbzu+dp_fFEgN+9-fuEyw@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:35:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEfh-00062y-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbbDFVfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:35:00 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36652 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFVfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:35:00 -0400
Received: by lbbqq2 with SMTP id qq2so20271287lbb.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=kzbgfP4DobF6CzCR4F3CZWPI1Dr78S5gqsMCEU35tzg=;
        b=mqlC8LbbXhdhtPPAZFK/4VZJNScs5j9P0QnhBNS6GPABSkjSzsGT90FmZ5bBfVX+x2
         KakfkdS7mfzYuKfQgZbBSONwjs+EMu5Gyf1A0Hr06DYvZ6mCjogEbSLF7OLmC0VX2ZYy
         TLcOtpS3mu0JM1okgrEIGZd4BaLkoTLfJzqdubuH4XMrOfqO9rmHstK69XCj/cpZFa/Y
         lYEZ3fqqPhVVxxpsG6kWsZCByab04tUv+4g5PdsrdTxwGvnwr84yVIs8maSqYHNWzhnP
         KMFC1eRR5aNXrXvcC1DC9U6l5nm5g27BUoqBHQEy0rvuKZ0HWSvv0QAKpRoZVnudI8+u
         EalA==
X-Received: by 10.112.173.41 with SMTP id bh9mr15036348lbc.107.1428356098866;
 Mon, 06 Apr 2015 14:34:58 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:34:58 -0700 (PDT)
In-Reply-To: <1428328354-14897-18-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: zSI_aaS4d2w6SIkI_IUU69f1OjE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266885>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/wt-status.c b/wt-status.c
> index cdbc8d7..ba9b56c 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -537,9 +537,11 @@ static void wt_status_collect_changes_index(stru=
ct wt_status *s)
>         rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
>         rev.diffopt.format_callback =3D wt_status_collect_updated_cb;
>         rev.diffopt.format_callback_data =3D s;
> -       rev.diffopt.detect_rename =3D 1;
> -       rev.diffopt.rename_limit =3D 200;
> -       rev.diffopt.break_opt =3D 0;
> +       if (!s->no_rename) {

Double-negatives are difficult. Perhaps call this 'detect_rename'?

> +               rev.diffopt.detect_rename =3D 1;
> +               rev.diffopt.rename_limit =3D 200;
> +               rev.diffopt.break_opt =3D 0;
> +       }
>         copy_pathspec(&rev.prune_data, &s->pathspec);
>         run_diff_index(&rev, 1);
>  }
> diff --git a/wt-status.h b/wt-status.h
> index 283a9fe..dc94f35 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -55,6 +55,7 @@ struct wt_status {
>         int relative_paths;
>         int submodule_summary;
>         int show_ignored_files;
> +       int no_rename;
>         enum untracked_status_type show_untracked_files;
>         const char *ignore_submodule_arg;
>         char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
> --
> 2.3.0.rc1.137.g477eb31
