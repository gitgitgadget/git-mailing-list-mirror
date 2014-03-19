From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3][GSOC] diff: rename read_directory() to get_directory_list()
Date: Wed, 19 Mar 2014 06:04:20 -0400
Message-ID: <CAPig+cR4564tsCO0U9HWNF9JZk64oFjx=nAWq+1QpGWSUn7Acg@mail.gmail.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 11:04:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQDMI-0007w4-24
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 11:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbaCSKEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 06:04:21 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:49264 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbaCSKEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 06:04:20 -0400
Received: by mail-yh0-f52.google.com with SMTP id c41so8202143yho.25
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m1ggIhWmRrAV4iZen4amI2jPCPuVOdFvuzoHhTkOjcU=;
        b=0sUkEZfVcYORehTy1pAlRMSk+8wvG7rhnp71fE7K8lZAuJqNBZnd3JEC6OQcDmwFnu
         u00PX/rmJ2gydoccstyba0m30ln3qotcedCLtHGTh/OqkIlo0VIQV0PBKwv1cU2gyMHE
         GPdGAQtBI9mhpV3yIuViHj2Srdy7PzITN1zSofqYsETXKAuymRrh2eMZjD1kFrmPP7US
         t35D8OHZ9m3LNNJU6DzEsTL0RTxIYlrbQ9+23M73HrxeYQ13UYAHUVRW85jWE5SXX0VT
         yWcWvCCTxMaWkMmiX0soxlNAFgonwCjBmUxsvy6FCxF3DOFUyve6DxHJTG6LQIY231Is
         MU6g==
X-Received: by 10.236.0.97 with SMTP id 61mr1170517yha.121.1395223460205; Wed,
 19 Mar 2014 03:04:20 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 03:04:20 -0700 (PDT)
In-Reply-To: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
X-Google-Sender-Auth: W6ArkEN-IIOUVMq9RElJpbNdG98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244427>

On Mon, Mar 17, 2014 at 5:30 PM, Hiroyuki Sano <sh19910711@gmail.com> wrote:
> Including "dir.h" in "diff-no-index.c", it causes a compile error, because
> the same name function read_directory() is declared globally in "dir.h".
>
> This change is to avoid conflicts as above.

This explanation is slightly lacking. Since dir.h is not currently
included by this file, a person reading this patch may wonder why you
need to avoid conflict where there is none. Adding a short sentence
saying that a subsequent patch will include dir.h in order to access
is_dot_or_dotdot() can avoid such confusion.

> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  diff-no-index.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..1ed5c9d 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int get_directory_list(const char *path, struct string_list *list)
>  {
>         DIR *dir;
>         struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>                 int i1, i2, ret = 0;
>                 size_t len1 = 0, len2 = 0;
>
> -               if (name1 && read_directory(name1, &p1))
> +               if (name1 && get_directory_list(name1, &p1))
>                         return -1;
> -               if (name2 && read_directory(name2, &p2)) {
> +               if (name2 && get_directory_list(name2, &p2)) {
>                         string_list_clear(&p1, 0);
>                         return -1;
>                 }
> --
> 1.9.0
