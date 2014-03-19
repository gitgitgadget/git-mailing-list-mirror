From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [GSoC 2014]diff: Imported dir.h and renamed read_directory()
Date: Tue, 18 Mar 2014 21:19:42 -0400
Message-ID: <CAPig+cTkZPCMo6smKie4ZJP-Xu4rAFw6yPY-PYqs2Pniyww7MQ@mail.gmail.com>
References: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 02:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ5Aa-0002Tn-3U
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 02:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813AbaCSBTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 21:19:44 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:43841 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758682AbaCSBTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 21:19:43 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so21344972ykr.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 18:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IyNsnOgR/1k0gmpr6UupzIZeqz8CJ9ZcLI3rPQU6IIA=;
        b=ZlnSX2Q3yt3lPE2igO9IED4AFfx3LbZ1/x7Ux+be4qDR/J3Cpn90h6oZdHzpi0OcBD
         /7y7gp6drW1HtDaVC3Ygnt2qL1EDtMKYJFdTgEEM0003I1F1cbQNkp9U3mTZyTIRn8MB
         /uiXqXXHb0zR4U0BoxmO0ux14SyH69SXvkoxDngBYyFjfDW0ZcUgQSq6BDY4pQgLmgFS
         NdqK2rnJWmRkLYetJzFxkjWzqddIkxgGICLvY7Q28DVbrzqFoVlsIoZloR3Yq7nKWYnK
         jj7m8rsFgmKInSVIGzjGLHSOs+MHnG0aHYuyrbcX7iKezXtD6XDjyDbe/8a9A2rtvpd1
         FVgQ==
X-Received: by 10.236.31.138 with SMTP id m10mr22406424yha.55.1395191982594;
 Tue, 18 Mar 2014 18:19:42 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 18:19:42 -0700 (PDT)
In-Reply-To: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
X-Google-Sender-Auth: RprVL9UONqoOJc0mTv6PRyvXpbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244404>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Tue, Mar 18, 2014 at 8:35 PM, Brian Bourn <ba.bourn@gmail.com> wrote:
> Subject: diff: Imported dir.h and renamed read_directory()

Use imperative voice: "import dir.h and rename read_directory()"

> this was done in order to implement the GSoC
> Micro project for diff-no-index.c

This commentary won't be relevant to anyone reading the commit message
months or years from now. Place it below the "---" line following your
sign-off.

> this is the
> first patch importing dir.h, for the use of
> is_dot_or_dotdot(), and renaming
> read_directory() to read_directory_contents()
> in order to deal with the conflicting function
> in dir.h

Since this preparatory change and the one which will follow are so
closely related, they should be submitted together as a two-patch
series.

The commit message itself it somewhat rambling. It would be clearer if
you could explain the problem precisely, then the solution. Perhaps
something like this:

    It would be desirable to replace manual checking of "." or ".."
    in diff-no-index.c with is_dot_or_dotdot(), which is defined in
    dir.h, however, dir.h declares a read_directory() which conflicts
    with a (different) static read_directory() defined in
    diff-no-index.c. As a preparatory step, rename the local
    read_directory() to avoid the collision.

> Signed-off-by: Brian Bourn <bab2177@columbia.edu>
> ---
>
> I plan on applying to GSoC 2014
>
>  diff-no-index.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..ba915af 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -10,13 +10,14 @@
>  #include "blob.h"
>  #include "tag.h"
>  #include "diff.h"
> +#include "dir.h"
>  #include "diffcore.h"

dir.h is not needed for this patch, so including it here only confuses
matters. Include it instead when it is actually required by the
follow-up patch which uses is_dot_or_dotdot().

(Was it intentional to place the new #include between diff.h and
diffcore.h? Just being curious; it's not particularly important.)

Other than this, the patch looks sane.

>  #include "revision.h"
>  #include "log-tree.h"
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int read_directory_contents(const char *path, struct string_list *list)
>  {
>   DIR *dir;
>   struct dirent *e;
> @@ -107,9 +108,9 @@ static int queue_diff(struct diff_options *o,
>   int i1, i2, ret = 0;
>   size_t len1 = 0, len2 = 0;
>
> - if (name1 && read_directory(name1, &p1))
> + if (name1 && read_directory_contents(name1, &p1))
>   return -1;
> - if (name2 && read_directory(name2, &p2)) {
> + if (name2 && read_directory_contents(name2, &p2)) {
>   string_list_clear(&p1, 0);
>   return -1;
>   }
> --
> 1.9.0
