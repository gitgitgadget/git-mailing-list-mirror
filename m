From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Rewrite the diff-no-index.c
Date: Mon, 17 Mar 2014 05:13:38 -0400
Message-ID: <CAPig+cRjGonML5NLyv3eqsKuM45O+whVCOQKNdj-E=zW9mRy4g@mail.gmail.com>
References: <1394973858-16505-1-git-send-email-ubuntu2012@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: ubuntu2012@126.com
X-From: git-owner@vger.kernel.org Mon Mar 17 10:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPTcQ-0007Nv-7l
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 10:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaCQJNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 05:13:41 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:61467 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaCQJNj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 05:13:39 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so4895987yhz.22
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=zHEqC+51JsEIKAN/hevJbszWkbK3RD/8KQWhEEDkwNw=;
        b=LftTITM2lWbnHGMjlIWhc+7OBMraWW3kbq2S/8vz8T+cd7YD5gOoX74cN4vbSSecUp
         dh/j8zKZ4/ZOoQxVZ++dBy51szcibIYbTz/zN8nUKpkdh6dAGOn64JtYNm8xNb4BdFs5
         O6obeQ+rQZg2b56V/UvdWhsDwlsWjtBdpBcReJaDu1+o+ywwiXRSJ8l//v4IkD//RuVG
         PXZETdKtdAtotk3UArIXTbjeoo27EeAKCaftcEkiGNmVO9GEmiZtWUDGZ1I+E5rYv9uV
         PqbpN8PDJZYhad4dueQdpi8RP9SF9kYc8tsSMwbQbLIJ1T+jOZsBz+Kl+uV0lPF8eUIl
         iNpQ==
X-Received: by 10.236.177.100 with SMTP id c64mr24684929yhm.30.1395047618868;
 Mon, 17 Mar 2014 02:13:38 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 02:13:38 -0700 (PDT)
In-Reply-To: <1394973858-16505-1-git-send-email-ubuntu2012@126.com>
X-Google-Sender-Auth: cvFYFm0WtAkcqw5dMIS4yHqm5P4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244233>

Thanks for the resubmission. Comments below...

On Sun, Mar 16, 2014 at 8:44 AM,  <ubuntu2012@126.com> wrote:
> From: =E6=B2=88=E6=89=BF=E6=81=A9 <ubuntu2012@126.com>
> Subject: [PATCH] Rewrite the diff-no-index.c

This is your second version of the patch, so you should say [PATCH v2].

Most patches rewrite something, so "rewrite" in the subject does not
convey much. Better would be to explain what the patch does. For
instance:

    Subject: diff-no-index: replace manual "." & ".." check with
is_dot_or_dotdot()

> I am sorry for that I send this agian.Last patch I have some error.(M=
aybe this time will like the previous).It is apply for GSOC

This commentary is relevant to the ongoing email conversation but does
not belong in the commit message, so you should place it below the
"---" line after your sign-off.

> Signed-off-by: =E6=B2=88=E6=89=BF=E6=81=A9 <ubuntu2012@126.com>
> ---

This is where you would place commentary. It is also good etiquette to
tell reviewers what changed in this version of the patch and to
provide a link to the previous version, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244093

>  diff-no-index.c |    5 +++--
>  dir.h           |    3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..1fb0c0f 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -3,13 +3,14 @@
>   * Copyright (c) 2007 by Johannes Schindelin
>   * Copyright (c) 2008 by Junio C Hamano
>   */
> -
> +#define EXIT

This change is non-obvious and should be explained in the commit
message, otherwise reviewers will not understand its purpose.

In fact, you are doing this because you want to omit the declaration
of read_directory() from dir.h when it is included in this file to
avoid conflict with the (different) read_directory() implementation in
this file. This is an ugly way to solve the problem. Renaming
read_directory() in this file would be a much cleaner solution (but
should be done as a separate preparatory patch).

>  #include "cache.h"
>  #include "color.h"
>  #include "commit.h"
>  #include "blob.h"
>  #include "tag.h"
>  #include "diff.h"
> +#include "dir.h"
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "log-tree.h"
> @@ -25,7 +26,7 @@ static int read_directory(const char *path, struct =
string_list *list)
>                 return error("Could not open directory %s", path);
>
>         while ((e =3D readdir(dir)))
> -               if (strcmp(".", e->d_name) && strcmp("..", e->d_name)=
)
> +               if (is_dot_or_dotdot(e->d_name))

This logic is backward. Keep in mind the return value of strcmp() and
then think carefully about the expression 'strcmp(...) &&
strcmp(...)'.

>                         string_list_insert(list, e->d_name);
>
>         closedir(dir);
> diff --git a/dir.h b/dir.h
> index 55e5345..c0e45c8 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -138,8 +138,9 @@ extern int match_pathspec(const struct pathspec *=
pathspec,
>  extern int within_depth(const char *name, int namelen, int depth, in=
t max_depth);
>
>  extern int fill_directory(struct dir_struct *dir, const struct paths=
pec *pathspec);
> +#ifndef EXIT
>  extern int read_directory(struct dir_struct *, const char *path, int=
 len, const struct pathspec *pathspec);
> -
> +#endif

See above.

>  extern int is_excluded_from_list(const char *pathname, int pathlen, =
const char *basename,
>                                  int *dtype, struct exclude_list *el)=
;
>  struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char=
 *pathname, int len);
> --
> 1.7.9.5
