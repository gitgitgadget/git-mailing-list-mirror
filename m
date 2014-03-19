From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3][GSOC] diff: rename read_directory() to get_path_list()
Date: Wed, 19 Mar 2014 17:15:48 -0400
Message-ID: <CAPig+cRSh5XoKKBZ6iyAwEvUf90N4Ajfp_459ME3zoBGS2h23Q@mail.gmail.com>
References: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNq6-00019Y-00
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbaCSVPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:15:49 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:42007 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbaCSVPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:15:48 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so24772729ykq.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4bjmnIzE9vRLIWdnLaJqCRGn/Q2Z45CvhutGl6QnqCA=;
        b=dkbe8R6QpQOeELdWe8xSXwM1+P/mG3mHdbBnHZicujtrT6s8oN54pP9GnTSxMKP/1W
         OF6r2q2suh9dx4g1WpFkatEoTfo36EPfgYwdzerO7BcFQ22ylDUEKiqGgmvJQSGVWAy6
         Fa7EybptmHej1DRdj/Ugc+uKtCR5ltsO/awI2O6FxLUmQY7Jn71hNcsXqZBVvapO8LVh
         TjHVzuiC3BWG7yNrhdTptRimbvZRmMiXKRbZIx9dZwrGQBp7qp5xy+Mee6XuvDWlK4Mp
         IqEXQTJOgMZY/B85yZ9M2feabkIc7DVDb7aue+SkRB6LnMRTG0AzMEktGf/I6l/7i0WZ
         lYbQ==
X-Received: by 10.236.14.196 with SMTP id d44mr44425yhd.159.1395263748278;
 Wed, 19 Mar 2014 14:15:48 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 14:15:48 -0700 (PDT)
In-Reply-To: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
X-Google-Sender-Auth: 87996wOmBLHPQuMFfGC6FmDSVVE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244494>

On Wed, Mar 19, 2014 at 7:23 AM, Hiroyuki Sano <sh19910711@gmail.com> wrote:
> Subject: diff: rename read_directory() to get_path_list()

You probably mean 'diff-no-index' here rather than 'diff'.

> Including "dir.h" in "diff-no-index.c", it causes a compile error, because
> the same name function read_directory() is declared globally in "dir.h".

It might be a bit clearer to give a hint as to why dir.h will be a problem:

    A subsequent patch will include dir.h in diff-no-index.c,
    however, dir.h declares a read_directory() which is different
    from the one defined statically by diff-no-index.c.

> This change is to avoid conflicts as above.

Good explanation, but write in imperative mood:

    Rename the local read_directory() to avoid the conflict.

> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  diff-no-index.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..20b6a8a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int get_path_list(const char *path, struct string_list *list)
>  {
>         DIR *dir;
>         struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>                 int i1, i2, ret = 0;
>                 size_t len1 = 0, len2 = 0;
>
> -               if (name1 && read_directory(name1, &p1))
> +               if (name1 && get_path_list(name1, &p1))
>                         return -1;
> -               if (name2 && read_directory(name2, &p2)) {
> +               if (name2 && get_path_list(name2, &p2)) {
>                         string_list_clear(&p1, 0);
>                         return -1;
>                 }
> --
> 1.9.0
>
