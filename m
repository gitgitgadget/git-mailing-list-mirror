From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] diff-no-index.c: rewrote read_directory() to use
 is_dot_or_dotdot() function.
Date: Wed, 19 Mar 2014 05:51:39 -0400
Message-ID: <CAPig+cQynpEEg6NU08FX1ZHGGwU+xVDyUYEVNx9vogh6L1_QzA@mail.gmail.com>
References: <1395217910-7506-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 10:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQDA0-0004FO-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 10:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617AbaCSJvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 05:51:40 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:42041 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259AbaCSJvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 05:51:39 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so8238087yho.18
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=18YIAouEp3KS/ZzZIwH7/uVEi8W9RgHZxGzcKpJgjns=;
        b=EbXV2q4EcyDAv/NczJ0+24h4v6PN9JHIcXUwZ2agp3SADGnZ9r1fnDi6OpWUz3OqSy
         vgjJ/jRIlaP2Rq0nYh6jYy9jE8OZGfBbMRPk6x+j5p1K2wQIiCe+w+Rim0RdClze6d4T
         TTrfBX5zJRo4VUJUKkOyUZoWNN8jb1aaJWvtPZD4PKJrKeJk5epR/Ey0VGshmEr37aLR
         m2cp02O9+imrOP/8+4rLY42HbFpYDCn5TBmvbcwj7FLU/RuBcDTb9w06xmzwaEYY3ll0
         TchLK9EbCkMhIrvEaEk4B0l4yVEN8HMecNO2llvXlvxIejVToSZOcLoPLu//qqQGLIn1
         cjnw==
X-Received: by 10.236.139.70 with SMTP id b46mr25088916yhj.63.1395222699332;
 Wed, 19 Mar 2014 02:51:39 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 02:51:39 -0700 (PDT)
In-Reply-To: <1395217910-7506-1-git-send-email-mandrei.dinu@gmail.com>
X-Google-Sender-Auth: NlbaJx4Y_LJ9lbpynEh1gUSbAGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244426>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Wed, Mar 19, 2014 at 4:31 AM, Andrei Dinu <mandrei.dinu@gmail.com> wrote:
> Subject: diff-no-index.c: rewrote read_directory() to use is_dot_or_dotdot() function.

Use imperative tone: "rewrite" instead of "rewrote". The subject is a
bit long. Try to keep it to 65-70 characters. You might instead say:

    diff-no-index: replace manual "."/".." check with is_dot_or_dotdot()

> is_dot_or_dotdot() verifies if the name of the directory sent as parameter to this function is the same with '.' or '..' and returns 0 if that is true.

Wrap commit message to 65-70 characters.

> There is unnecessary to iterate each character of the char* argument and verify it with strcmp because if there is a match that is at the beginning of chars.

You may be able to drop most or all of this text. A subject such as
the one suggested above probably conveys enough information to explain
and justify the patch without having to say anything more.

> Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>
>
> I plan on applying to GSoc 2014

This commentary about GSoC won't be interesting to people reading the
commit message months or years from now, so place it after the "---"
line just below.

> ---
>  diff-no-index.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..83cdbf7 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,6 +16,15 @@
>  #include "builtin.h"
>  #include "string-list.h"
>
> +static int is_dot_or_dotdot(const char *path)
> +{
> +    if (path[0] == '.' && path[1] == '\0')
> +        return 0;
> +    else if (path[0] == '.' && path[1] == '.' && path[2] == '\0')
> +        return 0;
> +    return 1;
> +}

Git already defines an is_dot_or_dotdot() function. Is there a reason
you chose to implement your own?

It is very unusual for a function asking "is this true" to return
false when the condition is true, and vice versa. It is not a good
idea to break expectations in this fashion.

>  static int read_directory(const char *path, struct string_list *list)
>  {
>         DIR *dir;
> @@ -25,7 +34,7 @@ static int read_directory(const char *path, struct string_list *list)
>                 return error("Could not open directory %s", path);
>
>         while ((e = readdir(dir)))
> -               if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> +               if (is_dot_or_dotdot(e->d_name))
>                         string_list_insert(list, e->d_name);
>
>         closedir(dir);
> --
> 1.7.9.5
