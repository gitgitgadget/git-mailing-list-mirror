From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH V2] TIG: Fix to reinstate proper operation with no arguments
Date: Sun, 28 Jul 2013 21:23:00 -0400
Message-ID: <CAFuPQ1L336HsJdtpL9OOA9+2MDNqZQa6nVu9-kYUhdnCVn13dw@mail.gmail.com>
References: <51EFC8B1.20405@gmail.com> <1374670227-15677-1-git-send-email-n1xim.email@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 03:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3cBa-0001sx-JM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 03:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3G2BXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 21:23:34 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37211 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab3G2BXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 21:23:22 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8225015obc.34
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=V9axmgKHkKXO0v1UICGzGRG6noObQdcIwK/T4Lb8Sf8=;
        b=T8zl6MC/jIdbq6+Abq+BnXwnVFqlou2e587n11BMu1wIkJEk8hM5snQ1ffBA5FVq5c
         xd9ur9YOumYfzFYYU4HH5sswUbK0jpJR1wS8Ot7xjD//fERqq/B3QDv8L5r40Dg3u6/2
         fRk3vFkDMg1T1ZOScXoiudtmLuXta7wdIfADiWW8mBVJSBwr37h5fgBAWq/hr4yge+it
         9YDSXDXi6TR46zjXICkZ/y97j9s/8QtpPLGKgGzh3DBqLO+W954PMpffNmwJcPGd4C7j
         okIcWjgUZKVD4lLG6XOgGNgy4umv14dYUcl6WEQceSKMnFY7CEJcLPpMM0z2DlR9x0e3
         Buiw==
X-Received: by 10.182.43.138 with SMTP id w10mr3175642obl.82.1375061001058;
 Sun, 28 Jul 2013 18:23:21 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Sun, 28 Jul 2013 18:23:00 -0700 (PDT)
In-Reply-To: <1374670227-15677-1-git-send-email-n1xim.email@gmail.com>
X-Google-Sender-Auth: IT1epPQS81lq1tRiL5EsC2QqWTM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231270>

On Wed, Jul 24, 2013 at 8:50 AM, Drew Northup <n1xim.email@gmail.com> wrote:
> This time, knowing for sure now that format->buf is not being used in
> the extant code path for any other purpose, I went ahead and
> initialized the whole thing to be sure that we don't find any other
> ghosts hiding in that buffer between uses. Just initializing the
> first byte fixes the near term problem but does not prevent the buffer
> initialization issue that this bug highlighted from rising up again
> later on.

Thanks applied with minor tidyup.

> diff --git a/tig.c b/tig.c
> index ba9ba98..c65bc43 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -3104,8 +3104,12 @@ format_expand_arg(struct format_context *format, const char *name)
>  static bool
>  format_append_arg(struct format_context *format, const char ***dst_argv, const char *arg)
>  {
> +       int i;

Added space after the declaration.

>         format->bufpos = 0;
>
> +       for (i = 0; i < SIZEOF_STR; i++)

Changed this to use sizeof(format->buf) instead.

> +               format->buf[i] = 0;
> +
>         while (arg) {
>                 char *next = strstr(arg, "%(");
>                 int len = next ? next - arg : strlen(arg);
> --
> 1.8.0
>

-- 
Jonas Fonseca
