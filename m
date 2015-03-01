From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git: make was_alias non-static
Date: Sun, 1 Mar 2015 18:44:20 -0500
Message-ID: <CAPig+cQdFSjN55o7E_F-Xr4HCax+JwzxYG90N0n4UXxe3yxNcg@mail.gmail.com>
References: <1425192531-11951-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 00:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSDXD-0007lE-2s
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 00:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbbCAXoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 18:44:22 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:47002 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbCAXoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 18:44:21 -0500
Received: by yhzz6 with SMTP id z6so12960104yhz.13
        for <git@vger.kernel.org>; Sun, 01 Mar 2015 15:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zHPocTEI2qGmRQF2yb+t8a8j1UZijDqMrTz1q8lGm04=;
        b=v6AIOme6cgOtmD2phWdCgyhUx3XB0/SteBdCOPrjRTVf5ZtNDKitQP2MKKlA5XJVPC
         GSZeh/+thx51xD6OOtatvVXw/Z+rPsKZ0aaVo02SLREyfyY3+KtrPKhMf0+9+k34fDF+
         92zZ5OwarJxbriMJT3sLPB7XGtcH0vOapVVYlJF76cBHD9keC80VsnzAx3DF4fWqMVgr
         7qTZFEB00xbvJqdoQxWBeUYYXqE11+dcb8+b+f1azxgs4lmcRJuN6fnZ9w7rPD/VM9pU
         8B+6kKDILH4AEWWHAJT0eYjuV2V8lLSrsyeXtibsIO95nUAyHWFgOzeyprQ7l9kfe5qc
         zlrA==
X-Received: by 10.170.136.19 with SMTP id d19mr25330259ykc.2.1425253460320;
 Sun, 01 Mar 2015 15:44:20 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 1 Mar 2015 15:44:20 -0800 (PST)
In-Reply-To: <1425192531-11951-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: zXUdhulkv1mAmhfVaq1o6Xwwais
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264568>

On Sun, Mar 1, 2015 at 1:48 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> 'was_alias' variable does not need to store it's value each iteration in the
> loop, anyway this variable changes it's value with run_argv. So it does not
> need to be static.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  git.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index 1780233..b8b6520 100644
> --- a/git.c
> +++ b/git.c
> @@ -682,7 +682,7 @@ int main(int argc, char **av)
>
>         while (1) {
>                 static int done_help = 0;

'done_help' could receive similar treatment by dropping 'static' and
moving it outside the 'while' loop. Doing so would make the logic
easier to understand.

> -               static int was_alias = 0;
> +               int was_alias = 0;

No need for the 0 initialization since 'was_alias' is being assigned
immediately below.

>                 was_alias = run_argv(&argc, &argv);
>                 if (errno != ENOENT)
>                         break;
> --
> 2.3.1.422.ge618558.dirty
