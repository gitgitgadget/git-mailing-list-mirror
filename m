From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/7] worktree.c: rewrite mark_current_worktree() to avoid strbuf
Date: Wed, 11 May 2016 02:16:44 -0400
Message-ID: <CAPig+cSB4LQn=a7=+8cdEC=_N7J=v2YyBULn-QFwgDj3+1zm6w@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141553.22967-1-pclouds@gmail.com>
	<20160510141553.22967-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 08:16:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0NRy-00086w-M2
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 08:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbcEKGQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 02:16:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34996 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcEKGQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 02:16:45 -0400
Received: by mail-io0-f196.google.com with SMTP id i75so3966716ioa.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 23:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=svaswGgv0wW7qGMjULdBRGLx5JItrTu1ja4wPcfeMok=;
        b=PLLRIeIwwAXtr3uF2Yq0feIVRq9MJiI7Oo7UM+Vu6q3bCL9Ct0zg6YdhvFrtB0Onoq
         HubyWVq6UOtllU+z5mMbILsXGlplZk8QZjBQo1PnWajwYLHs82A0MopfYohaQD9kTF7b
         3j/cABFxCVa8a9KgrCKwMYCex7fONzQga8Yq1pE4ZvxVqqqELTZr6vHPhDQMUMGMhUnh
         yKtcu7Av8yHyHOfDSNUQJAZy/Es4YFtB1MVXAEDTK+YED119aMQGPyoYhh5veRcGOAaw
         02aLrtrayk0o5Jv7qDlMVGuLGNpnO0VDXUBQP+E6lJNceRHYXtlDn2AcYu6KpatTfw3x
         KIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=svaswGgv0wW7qGMjULdBRGLx5JItrTu1ja4wPcfeMok=;
        b=PULp0VYMwCnsqllKaRo3i/vjW9HbA8druedkYmbqOoWrMacfUF0Izqkf9ahVudOFoH
         50mkI6EWJNgZOLLDBKyNzRXLwFUJa7Hn8JS1e4k2O9rhokmRv19+4fviy7LqZ2+5yNtT
         HIqUBTZQZLzHOKzxswjltNcl0hNTqxidZ0h8oHF2uSzCYez48+kwsayNDcLw7VbsbsiL
         Oyiu0Z64KPBbwAIXxGBoB1VisROjPWdnlt7BD2tDdVo5VbWlnE3ldZzH21t52f0gnvuC
         WZXgHw8wpEy3pg7stuyriWbT1BSe60DiTnKlS9RrGkpCAuvs1FHu55LbmJsUodWppyUq
         tbRw==
X-Gm-Message-State: AOPr4FVhmKlKV7BIVTrelreO6Brt/UmQn3Gc7FQOohSJkfN8XoVBQeAHSWaiNZNVS9Ygpg99bexNQboBslb8rQ==
X-Received: by 10.107.132.66 with SMTP id g63mr2025096iod.34.1462947404825;
 Tue, 10 May 2016 23:16:44 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 23:16:44 -0700 (PDT)
In-Reply-To: <20160510141553.22967-2-pclouds@gmail.com>
X-Google-Sender-Auth: UEorBwqtHEHfgGC2UZEBxXn-y9M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294229>

On Tue, May 10, 2016 at 10:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> strbuf is a bit overkill for this function. What we need is call

s/is call/is to call/

> absolute_path() twice and make sure the second call does not destroy =
the
> result of the first. One buffer allocation is enough.

The patch itself looks good.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -153,21 +153,19 @@ done:
>  static void mark_current_worktree(struct worktree **worktrees)
>  {
> -       struct strbuf git_dir =3D STRBUF_INIT;
> -       struct strbuf path =3D STRBUF_INIT;
> +       char *git_dir =3D xstrdup(absolute_path(get_git_dir()));
>         int i;
>
> -       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
>         for (i =3D 0; worktrees[i]; i++) {
>                 struct worktree *wt =3D worktrees[i];
> -               strbuf_addstr(&path, absolute_path(get_worktree_git_d=
ir(wt)));
> -               wt->is_current =3D !fspathcmp(git_dir.buf, path.buf);
> -               strbuf_reset(&path);
> -               if (wt->is_current)
> +               const char *wt_git_dir =3D get_worktree_git_dir(wt);
> +
> +               if (!fspathcmp(git_dir, absolute_path(wt_git_dir))) {
> +                       wt->is_current =3D 1;
>                         break;
> +               }
>         }
> -       strbuf_release(&git_dir);
> -       strbuf_release(&path);
> +       free(git_dir);
>  }
