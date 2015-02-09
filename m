From: Matt Korostoff <mkorostoff@gmail.com>
Subject: Re: [PATCH] contrib/completion: suppress stderror in bash completion
 of git remotes
Date: Mon, 9 Feb 2015 16:00:12 -0500
Message-ID: <CAMZO7dL-ENGmjt4J-rb5y2yVOFGVQKXdh3UB5krnJyfU5M=6xw@mail.gmail.com>
References: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:00:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvRe-00051F-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760898AbbBIVAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:00:34 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:45198 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbbBIVAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:00:33 -0500
Received: by mail-qc0-f179.google.com with SMTP id r5so3429825qcx.10
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 13:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=IJSFBuU/iH9YMkHTGX5ZbmfzKINvHFocIFe6vvSDSMo=;
        b=V+51T8iXRlH/d/8znIwLhbRQUubWqq/lMh6j+MnZZlA3seA9zc+elhUxM0zmnv3Tsg
         vgCNfPmCkNTtDBcvLpjydDy81Av6PvAIjv78FK8HTquA55ESP3d5quPgMUrRRgoOzIRr
         q1t0WVW/S75CXjHKxdjCZCywOCzgfBHvjQRnJ2agw1vlLXS61AHWX5iWVJ1Sz7ou2LCp
         6K2Z+JJ28qf0C3LRh/sybbESxYXG5Mx/qRWwlRUGtZ4I9qN0xrzQLTJqtXEMFV9/Pc4w
         GRq/9qNm07/8ZAFJ+h6rqx/9DXJDlq5Dc2ln5JeCJXYzn5IctSo/z7ZmtwKqD8ZsYMtJ
         232g==
X-Received: by 10.140.102.100 with SMTP id v91mr43043671qge.29.1423515632963;
 Mon, 09 Feb 2015 13:00:32 -0800 (PST)
Received: by 10.140.89.167 with HTTP; Mon, 9 Feb 2015 13:00:12 -0800 (PST)
In-Reply-To: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263599>

Here are some screen shots demonstrating the issue I'm describing here:

before this patch:
https://cloud.githubusercontent.com/assets/1197335/6108333/1f3b10fa-b040-11e4-9164-3c7769dae110.gif

after this patch:
https://cloud.githubusercontent.com/assets/1197335/6108340/3878cad0-b040-11e4-9994-dcd5c4d62bba.gif

On Mon, Feb 9, 2015 at 3:58 PM, Matt Korostoff <mkorostoff@gmail.com> wrote:
> In some system configurations there is a bug with the
> __git_remotes function.  Specifically, there is a problem
> with line 415, `test -d "$d/remotes" && ls -1 "$d/remotes"`.
> While `test -d` is meant to prevent listing the remotes
> directory if it does not exist, in some system, `ls` will
> run regardless.
>
> This results in an error in which typing `git push or` + `tab`
> prints out `ls: .git/remotes: No such file or directory`.
> This can be fixed by simply directing stderror of this line
> to /dev/null.
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2fece98..72251cc 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -412,7 +412,7 @@ __git_refs_remotes ()
>  __git_remotes ()
>  {
>         local i IFS=$'\n' d="$(__gitdir)"
> -       test -d "$d/remotes" && ls -1 "$d/remotes"
> +       test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
>         for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
>                 i="${i#remote.}"
>                 echo "${i/.url*/}"
> --
> 1.7.10.2 (Apple Git-33)
>
