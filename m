From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the
 temporary buffer
Date: Tue, 17 Dec 2013 19:56:59 +0100
Message-ID: <CALWbr2xmBXHaxb89665ub_cS8mFxf0C6tJnhBsdnUnX7DoCPfw@mail.gmail.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
	<1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:57:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VszpJ-0005m6-RK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab3LQS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:57:00 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44318 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab3LQS5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:57:00 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so7216442pde.27
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VCV6qbw6GK3m01Kjkedd8ZKIa2u6qL4IUVZfTHKCHGA=;
        b=TdgQnKKHYuLXQRyfG29I9hkn7fQKXLRQntHtCGQ7Wt8NOeljHA9NVVZd5HqJVhQ7Or
         5m/idZLdO7EyhUX1bV7MQADleipKZebwjhapwonIqSCE3EXU5dMm2sD335+HN7hhfCgj
         GuEU6wba4AMbw6JWnaBYQak2llCRIAkVezUC9MRSPFhq1TWpDJWawWg8y/T9HxhUKwQr
         yDTPS1q07fQbPte6uzWvKuLpIgddVQ8apDkPuyMpmGRz+CDZQHno7xPKQEsOxBgotEo/
         ruOQNmtrqqOqCSo6V4uzn9oQJ61eYZYhDbISPUa3nU5Q/kfWGY140D2cH2BvB7jXqP/K
         Npvw==
X-Received: by 10.68.212.163 with SMTP id nl3mr29372664pbc.25.1387306619377;
 Tue, 17 Dec 2013 10:56:59 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Tue, 17 Dec 2013 10:56:59 -0800 (PST)
In-Reply-To: <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239400>

On Tue, Dec 17, 2013 at 2:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Dimension the buffer based on PATH_MAX rather than a magic number, and
> verify that the path fits in it before continuing.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> I don't think that this problem is remotely exploitable, because the
> size of the string doesn't depend on inputs that can be influenced by
> a client (at least not within Git).
>
>  builtin/prune.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 6366917..ae34d04 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -96,7 +96,9 @@ static void prune_object_dir(const char *path)
>  {
>         int i;
>         for (i = 0; i < 256; i++) {
> -               static char dir[4096];
> +               static char dir[PATH_MAX + 1];
> +               if (strlen(path) + 3 > PATH_MAX)
> +                       die("impossible object directory");
>                 sprintf(dir, "%s/%02x", path, i);
>                 prune_dir(i, dir);
>         }
> --
> 1.8.5.1

Obviously correct,

Thanks,
Antoine,
