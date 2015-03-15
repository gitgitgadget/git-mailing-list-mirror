From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH v3] log: forbid log --graph --no-walk
Date: Sun, 15 Mar 2015 09:08:57 +0800
Message-ID: <CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com>
References: <5504D5A2.2070405@norn.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, me@ikke.info,
	sandals@crustytoothpaste.net, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net
To: Manos Pitsidianakis <epilys@norn.io>
X-From: git-owner@vger.kernel.org Sun Mar 15 02:09:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWx3i-0001wA-T1
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 02:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbbCOBJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2015 21:09:28 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33542 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbCOBJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 21:09:18 -0400
Received: by pagr17 with SMTP id r17so26380960pag.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Gzr/yRjUvMEU9xxXlVZ/J6l2XE7MqrdniN5tawOxCW4=;
        b=zbXNKd85s8Cjuqg+fIZWs7pjMHox9ajCR9N9u31vT5/PgP/TwxUnelJLrVqzIbaXqU
         Bcfc9m/tEOXmIlYFVNf+QQoOl9bEDRLPnvuc/g/5kmkv79p5JMQ2d3rggNVEGlVhcbAo
         nQzbThQDILJvAln356PO+Nr7SulrsuXCMDr8tElb3EUihAIR4jP/0yQgYy8y+NON+U76
         OvPhjmKv4Ih9t0MW0a7CFhtVs7/EtANh9fJOYoQz4HlYnrc2bbB+A6wiwQ5xNdTIjqPa
         OKnwkAIlvpfEVchjrkMAh14kBFLPb4sPxmCDiwMf7IZ5Jlaj8vxJ+MrJ/y1GoZe6eGAn
         Xd5w==
X-Received: by 10.66.146.100 with SMTP id tb4mr87637834pab.104.1426381757941;
 Sat, 14 Mar 2015 18:09:17 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Sat, 14 Mar 2015 18:08:57 -0700 (PDT)
In-Reply-To: <5504D5A2.2070405@norn.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265473>

it seems that your patch could not pass t4052-stat-output.sh.

I think it would be better if you could improve the specification for
this change in Document/rev-list-options.txt

2015-03-15 8:43 GMT+08:00 Manos Pitsidianakis <epilys@norn.io>:
> In git-log, --graph shows a graphical representation of a continuous
> commit history, and --no-walk shows discrete specified commits withou=
t
> continuity. Using both doesn't make sense, so we forbid the combined =
use
> of these flags.
>
> Signed-off-by: Manos Pitsidianakis <epilys@norn.io>
> ---
> This is a microproject intended to complement my GSoC application.
>  builtin/log.c  | 2 ++
>  t/t4202-log.sh | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..5aaf964 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -155,6 +155,8 @@ static void cmd_log_init_finish(int argc, const c=
har **argv, const char *prefix,
>         memset(&w, 0, sizeof(w));
>         userformat_find_requirements(NULL, &w);
>
> +       if (rev->graph && rev->no_walk)
> +               die("--graph and --no-walk are incompatible");
>         if (!rev->show_notes_given && (!rev->pretty_given || w.notes)=
)
>                 rev->show_notes =3D 1;
>         if (rev->show_notes)
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..5d72713 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph --show-signa=
ture for merged tag' '
>         grep "^| | gpg: Good signature" actual
>  '
>
> +test_expect_success 'forbid log --graph --no-walk' '
> +       test_must_fail git log --graph --no-walk
> +'
> +
>  test_done
> --
> 2.1.4
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
