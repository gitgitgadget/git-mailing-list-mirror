From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoc PATCH 1/3] diff-no-index.c: rename read_directory()
Date: Thu, 20 Mar 2014 19:53:13 -0400
Message-ID: <CAPig+cS4ScFQhMEkWigay1oi6X=6H7JC7LoxW6U4g9AWyR37=g@mail.gmail.com>
References: <1395345164-5239-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:53:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmm1-0004Mc-TP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760093AbaCTXxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:53:16 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:46899 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760012AbaCTXxO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:53:14 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so1699330yha.31
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Iv8WxC6DUEpeJ9fGzoimljdWiRL7T24QK8o7dIBgiSg=;
        b=u36RGZH0pxWt6eg0an0wjinQ1CmJmdKR/hydHLEvtxyeimp/y0yapvaEHiJQsNneaq
         lPptY73ejmSQ8ZJbHhetZS8F70RJUAlG8J9ZKH4NbWYIBFoZxq1LifkyTrHWHgHzD4eX
         U8FBYeZ/OeLRY0qVL8oIlRPiAYUFMlM4feARtFP2o0AeZZnLXJuYabY38u/hXfniJoAv
         DcoEILM6xduV9EXUwO10z4kkm8VCjUH5MRoq7QNAVJ/Wv4S4f/CO8OJ++ucsul9+7FJk
         Agl5lQRvC0zJUFW8NMMoMcRp0rS/3Md18NSrP8U3n39nwcnPUFUmUaaYZMei+LkMUGXG
         6/cQ==
X-Received: by 10.236.110.77 with SMTP id t53mr23185546yhg.78.1395359593453;
 Thu, 20 Mar 2014 16:53:13 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 16:53:13 -0700 (PDT)
In-Reply-To: <1395345164-5239-1-git-send-email-mandrei.dinu@gmail.com>
X-Google-Sender-Auth: s9znnZn0uPE6Rft19Q8yuntHmmU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244621>

On Thu, Mar 20, 2014 at 3:52 PM, Andrei Dinu <mandrei.dinu@gmail.com> wrote:
> Avoid the conflict between read_directory() from diff-no-index.c and
> read_directory() from "dir.h"

This message is lacking a bit of information. Since diff-no-index.c
does not presently include dir.h, the reader is left to wonder why you
need to resolve a non-existent conflict. You should explain that
diff-no-index.c will soon be including dir.h, which is why the
function must be renamed. You might say something like:

    A subsequent patch will include dir.h in diff-no-index.c to
    access is_dot_or_dotdot(), however, dir.h declares a
    read_directory() which conflicts with a (different)
    read_directory() defined in diff-no-index.c. Rename
    diff-no-index.c's read_directory() to avoid the conflict.

> Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>
>
> ---
>
>  I plan on applying to GSOC 2014
>
>  Submit again on the list for an older bug that I solved, to show you that
>  I received your feedback and I reviewed my code, numbering and partitioning
>  patches style. Thank you!

Unfortunately, all three patches arrived in a single email message,
which is undesirable. It's a good idea to try sending patches to
yourself first (using "git send-email") to make sure that everything
comes through okay; then send to the list.

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..5e4a76c 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int read_directory_path(const char *path, struct string_list *list)
>  {
>         DIR *dir;
>         struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>                 int i1, i2, ret = 0;
>                 size_t len1 = 0, len2 = 0;
>
> -               if (name1 && read_directory(name1, &p1))
> +               if (name1 && read_directory_path(name1, &p1))
>                         return -1;
> -               if (name2 && read_directory(name2, &p2)) {
> +               if (name2 && read_directory_path(name2, &p2)) {

The patch looks reasonable. The name is a bit odd, but not terribly important.

>                         string_list_clear(&p1, 0);
>                         return -1;
>                 }
> --
> 1.7.9.5
>
>
> From d54129eacb45b307dacf2b7afebd1da40df17047 Mon Sep 17 00:00:00 2001
> From: Andrei Dinu <mandrei.dinu@gmail.com>
> Date: Wed, 19 Mar 2014 17:42:08 +0200
> Subject: [GSoc PATCH 2/3] diff-no-index.c: read_directory_path() use
>  is_dot_or_dotdot().

You can drop the "." from the end of this line.

> Implement code so read_directory_path() use is_dot_or_dotdot() from "dir.h"
> instead of strcmp().

You're not really implementing any code, so this is a bit misleading,
and you don't need to explain that it's from dir.h since that's
obvious from the fact that you are including dir.h You might say
instead:

    Use is_dot_or_dotdot() instead of manually checking against "."
    or "..".

> Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>
>
> ---
>
>  I plan on applying to GSOC 2014
>  diff-no-index.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 5e4a76c..2d1165f 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -15,6 +15,7 @@
>  #include "log-tree.h"
>  #include "builtin.h"
>  #include "string-list.h"
> +#include "dir.h"
>
>  static int read_directory_path(const char *path, struct string_list *list)
>  {
> @@ -25,7 +26,7 @@ static int read_directory_path(const char *path, struct string_list *list)
>                 return error("Could not open directory %s", path);
>
>         while ((e = readdir(dir)))
> -               if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> +               if (!is_dot_or_dotdot(e->d_name))

Looks fine.

>                         string_list_insert(list, e->d_name);
>
>         closedir(dir);
> --
> 1.7.9.5
>
>
> From 4843ad23675047163211c68434517c097435ebb7 Mon Sep 17 00:00:00 2001
> From: Andrei Dinu <mandrei.dinu@gmail.com>
> Date: Wed, 19 Mar 2014 18:01:55 +0200
> Subject: [GSoc PATCH 3/3] fsck.c: fsck_tree() now use is_dot_or_dotdot().

Drop "now" and the ".".

> Rewrite fsck_tree() to use is_dot_or_dotdot() from "dir.h" instead
> of calling twice strcmp().

No need to explain that it is from dir.h.

> Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>
>
> ---
>
>  I plan on applying to GSOC 2014.
>
>  fsck.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 64bf279..82a55ab 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -6,6 +6,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "fsck.h"
> +#include "dir.h"
>
>  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>  {
> @@ -171,10 +172,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>                         has_full_path = 1;
>                 if (!*name)
>                         has_empty_name = 1;
> -               if (!strcmp(name, "."))
> -                       has_dot = 1;
> -               if (!strcmp(name, ".."))
> -                       has_dotdot = 1;
> +               if (is_dot_or_dotdot(name))
> +                       if (name[1] == '\0')

On this project it probably would be more idiomatic to say !name[1].

> +                               has_dot = 1;
> +                       else
> +                               has_dotdot = 1;

Overall, however, this change does not really make the code clearer.
It probably would be best to drop this patch from your submission.

>                 if (!strcmp(name, ".git"))
>                         has_dotgit = 1;
>                 has_zero_pad |= *(char *)desc.buffer == '0';
> --
> 1.7.9.5
