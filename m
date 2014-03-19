From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3][GSOC] diff: use is_dot_or_dotdot() instead of strcmp()
Date: Wed, 19 Mar 2014 17:15:53 -0400
Message-ID: <CAPig+cT5TMHoLDeavsV89Mopgd59rUBFF8QUj68zbX6ZDNZE7g@mail.gmail.com>
References: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
	<1395228230-10189-2-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:16:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNqF-0001OA-DD
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbaCSVPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:15:54 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:54705 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbaCSVPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:15:54 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so9285956yha.13
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=djEWPkPvDXEJ3u4h1RLNWZ8/8dmrJrLDKkUIoqwEMKk=;
        b=SpLCr70ws38mQiH+9ABL7Hc/sJoJs9920rIHp7qNG7gmnyKjllrm2IZP4QyttzbJQE
         xK41pWinWjg+18+XeGUaPxbie8qUEYmAz9TwFI7adda5jkTdnvnY2LN/HDCx88YUFQEo
         9EcCdqfchiW813BbPLT/L8EKoqFgLLHdQv2JoRlalF7raBkkaUToUkWl5vljzp29CdrV
         FHPMzjga4dPI+UoDpwvbjSWhVMwHwkyq6JEkkKJA6S6o39pSvgeuhQVClcwPZFNyuer1
         8PK2gs0pIK5CGwHmG/hKwIandRFx10kRXiEAHO4oiHPuKfToCW4pbSZsuEpKPSNtQJBr
         XDrQ==
X-Received: by 10.236.102.39 with SMTP id c27mr53895528yhg.26.1395263753224;
 Wed, 19 Mar 2014 14:15:53 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 14:15:53 -0700 (PDT)
In-Reply-To: <1395228230-10189-2-git-send-email-sh19910711@gmail.com>
X-Google-Sender-Auth: RbWeZQrri9n2-_JQhTIDGojnMvk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244495>

On Wed, Mar 19, 2014 at 7:23 AM, Hiroyuki Sano <sh19910711@gmail.com> wrote:
> Subject: diff: use is_dot_or_dotdot() instead of strcmp()

You probably meant 'diff-no-index' rather than 'diff'.

You could make the subject a bit more explanatory by saying:

    use is_dot_or_dotdot() instead of a manual "."/".." check

> The is_dot_or_dotdot() is used to check if the string is either "." or "..".

It's pretty obvious what this function does, so it's not necessary to
explain it.

> Include the "dir.h" header file to use is_dot_or_dotdot().

Including dir.h is a obvious requirement of using is_dot_or_dotdot(),
thus also does not require explanation.

Otherwise, the patch looks fine.

> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  diff-no-index.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 20b6a8a..8e642b3 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -11,6 +11,7 @@
>  #include "tag.h"
>  #include "diff.h"
>  #include "diffcore.h"
> +#include "dir.h"
>  #include "revision.h"
>  #include "log-tree.h"
>  #include "builtin.h"
> @@ -25,7 +26,7 @@ static int get_path_list(const char *path, struct string_list *list)
>                 return error("Could not open directory %s", path);
>
>         while ((e = readdir(dir)))
> -               if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> +               if (!is_dot_or_dotdot(e->d_name))
>                         string_list_insert(list, e->d_name);
>
>         closedir(dir);
> --
> 1.9.0
>
