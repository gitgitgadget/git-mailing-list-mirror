From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 24/26] upload-pack: split check_unreachable() in two, prep
 for get_reachable_list()
Date: Sun, 5 Jun 2016 15:43:16 -0400
Message-ID: <CAPig+cTyzA1HFt=K14UBPsKhWhHmy0WX8=tru7HQmP3m+GpGgQ@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com> <1460552110-5554-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 21:43:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9dxD-0006oj-C0
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 21:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbcFETnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 15:43:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34100 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcFETnS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 15:43:18 -0400
Received: by mail-it0-f68.google.com with SMTP id k76so4357532ita.1
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=e+c5VIPTjDtgS/PJ+9Uxsg6D5yy+FnJeIp+J7l811j0=;
        b=g8QdhwfyE/QceU2LXrXy+XPFlllfJ9Cw40VhgALHwcw0GMvush9+6POITkEZ4CIzXx
         EglQPhWiD6ta44CaPBuFpQtTqy2gEvow2ifOpDKJwqwaSR+ZHp8FI9MjSXl9h0/DjFUu
         7wlS9t7jF/Za8wFSKJunW5OMzNbmwQU9IwFl8RuKJMhr6hQpJQrHKCo93DudtVhdRSr8
         pO4p1Zg0+JEFKisuxTfEWI6sdyJ0v+a8AS2WQeyAdmoGA0pqhvHTFDbpUFfLdC2EaaaV
         zKWxAVFQ6NoHa5JzjNyiOJd3cD+zE+WSwxriojKDxqTqRO7mIEZErlpXwcxAz3DrRvNQ
         kqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=e+c5VIPTjDtgS/PJ+9Uxsg6D5yy+FnJeIp+J7l811j0=;
        b=UebMPWOm+iYmqPvM/Xv0jNjkxtSuPZrdmEKtH8ZpEsUw26kCMjTV6rH4lXKiJh7GzO
         0PZka5DyRSrLHMEi3+K9x0ZVBKQQesSGeVvAQeI1BzH8w6/gGHcQ9SkynU/hWLpsPzPm
         hNb+h7E0Zf3WRwRLAXq8vmmFNignJ+qT33rI3jHvWPhstLpbvDHyyfMRVTkl37gZRJsf
         FqZa4DHxApbdhgHswTQuV7SAoj3sTKFqa+V4mP6/otsgvVrNF+TQ+2DDns3Lfz+6id3r
         TTwg3ZeNZyjzvz1k+l0ONL+h+IArHTREmul8YLFJg9kD1LcTuzSbcTMuDliL76/bfUs0
         cQMQ==
X-Gm-Message-State: ALyK8tLpujkBJeIaT0nQfsFCJHbBvHtoYIQTgWH2BCnUB2Qerg/mPt5SkyymwoMVmKdOTnOXLQcbgysoscNeCg==
X-Received: by 10.36.29.137 with SMTP id 131mr11666640itj.84.1465155797350;
 Sun, 05 Jun 2016 12:43:17 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sun, 5 Jun 2016 12:43:16 -0700 (PDT)
In-Reply-To: <1460552110-5554-25-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: hs98VFJ6fFhMeWotwSh-HXdfIbY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296479>

On Wed, Apr 13, 2016 at 8:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -452,24 +452,24 @@ static int is_our_ref(struct object *o)
> -static int check_unreachable(struct object_array *src)
> +static int do_reachable_revlist(struct child_process *cmd,
> +                               struct object_array *src)
> @@ -487,8 +487,8 @@ static int check_unreachable(struct object_array =
*src)
>                 if (!is_our_ref(o))
>                         continue;
>                 memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEX=
SZ);
> -               if (write_in_full(cmd.in, namebuf, 42) < 0)
> -                       return 0;
> +               if (write_in_full(cmd->in, namebuf, 42) < 0)
> +                       return -1;
>         }
>         namebuf[40] =3D '\n';
>         for (i =3D 0; i < src->nr; i++) {
> @@ -496,18 +496,29 @@ static int check_unreachable(struct object_arra=
y *src)
>                 if (is_our_ref(o))
>                         continue;
>                 memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
> -               if (write_in_full(cmd.in, namebuf, 41) < 0)
> -                       return 0;
> +               if (write_in_full(cmd->in, namebuf, 41) < 0)
> +                       return -1;
>         }
> -       close(cmd.in);
> +       close(cmd->in);
>
>         sigchain_pop(SIGPIPE);

Not a new issue, but does it matter that there are early returns
before sigchain_pop()?

> +       return 0;
> +}
> +
> +static int check_unreachable(struct object_array *src)
> +{
> +       struct child_process cmd =3D CHILD_PROCESS_INIT;
> +       int i, ret =3D do_reachable_revlist(&cmd, src);
> +       char buf[1];
> +
> +       if (ret < 0)
> +               return 0;

Nit: It might be a bit easier to see what this conditional is checking
if it is closer to the code which sets 'ret'. Perhaps either:

    char buf[1];
    int i, ret =3D ...;

    if (ret < 0)

or:

    char buf[1];
    int i, ret;

    ret =3D ...;
    if (ret < 0)

>         /*
>          * The commits out of the rev-list are not ancestors of
>          * our ref.
>          */
> -       i =3D read_in_full(cmd.out, namebuf, 1);
> +       i =3D read_in_full(cmd.out, buf, 1);

s/1/sizeof(buf)/ perhaps or does that make the intent less clear?

>         if (i)
>                 return 0;
>         close(cmd.out);
