From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH v3] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 13:30:23 +0800
Message-ID: <CAJr59C09sued4KJf+Gfp10yyD8NtXOKAjV0SZGbVw=Pn4hNZ7A@mail.gmail.com>
References: <1393813495-9079-1-git-send-email-mzguanglin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Guanglin Xu <mzguanglin@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 06:30:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKLSQ-0002R5-RL
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 06:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbaCCFaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 00:30:25 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:50999 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaCCFaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 00:30:24 -0500
Received: by mail-wg0-f48.google.com with SMTP id b13so2581239wgh.31
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=5/XAaQnKauwRKbWUF8FDR1NiOR91noU+6/fKr6SPJjk=;
        b=LURVXaD92M+1qaJtIHg08zoXTmV3EkwLLmfosfb2wZehjwVkPolZr/hOfeZyngJeY0
         j0k9GsS9yGxN929S1O677p6SnpviFTbEsIEMdKFDv7VSXl1l98CDDKmFQh11lcxXZ5+n
         FoTK11yQ8dUhz0GIoNEB/mQ0i5xFccNVEUEJ+GFUif9E2VVpAXN/WaTFwtCECLmCOPR2
         9PtCr1KzGMQAgFMrRC93HaYtHBu4D6AqpR4lNWUfuJdkRqjvuNHh8qw0QkDXU2MFiZuU
         guYGZHYn05wEQ6aHxMiEHXig/s5l1amffsRLi/Gj/dvu91tqQ5IEIThgZSxRBO/DcPix
         mx8A==
X-Received: by 10.194.59.210 with SMTP id b18mr2905737wjr.60.1393824623437;
 Sun, 02 Mar 2014 21:30:23 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sun, 2 Mar 2014 21:30:23 -0800 (PST)
In-Reply-To: <1393813495-9079-1-git-send-email-mzguanglin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243175>

2014-03-03 10:24 GMT+08:00 Guanglin Xu <mzguanglin@gmail.com>:
> to avoid a magic code of 11.
>
> Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
> Helped-by: Jacopo Notarstefano <jaco...@gmail.com>
> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
> ---
>
> This is an implementation of the idea#2 of GSoC 2014 microproject.
>
>  branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..3e2551e 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,7 +49,7 @@ static int should_setup_rebase(const char *origin)
>
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> -       const char *shortname = remote + 11;
> +       const char *shortname = skip_prefix(remote ,"refs/heads/");

Maybe it is more proper to avoid the test of remote_is_branch, by
testing shortname instead.
And add the comment "skip_prefix only return NULL when refs/heads/ is
not the prefix of remote"

>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Cheers,
He Sun
