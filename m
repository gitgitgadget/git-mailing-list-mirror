From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] completion: avoid ls-remote in certain scenarios
Date: Sat, 1 Jun 2013 23:55:47 +0530
Message-ID: <CALkWK0nXPA7Rhcp1Reb0oBMXmW5SkL7zhy1786L9CjE74x7xTg@mail.gmail.com>
References: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 20:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiqVc-0002CI-BW
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 20:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab3FAS03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 14:26:29 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:40432 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab3FAS01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 14:26:27 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so6672967ief.26
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+cpoXkixk3+0UV1+2APFEy8EmT3Gm/pDxVfQZxPaxb4=;
        b=P+bxHjYq6GucAmbTywfGLqbsJ9ZseUMSqJAriKF6pFfMLYgIRI1Xike3TgsakzZd3K
         vvmJ6OXrsqFNZCVE92BB1aOSrA2+exSU19UcYxNJq2z2yR9U5NnRpKKdw41ZhR7U15dg
         3ZFRst5U5CwE9D4qUiIOIb45Jc1CnTUPzWMTnrKXPlfSXtL01pqwnvGIsYrXWl5nVukg
         DHC3OI/YIyTSChX5WFaeVaeC6bgCJaTC2dPep6nAXpSu0hnJOTxHn0X+7HVdi0XnFuK4
         xxPpMJaENjToua9vxe3OCYiz/9h6JSlv8EH1hvnUBWzOAeC1WVkAWONJp69dbK+eZpmy
         gmow==
X-Received: by 10.50.41.99 with SMTP id e3mr4243690igl.104.1370111187430; Sat,
 01 Jun 2013 11:26:27 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Sat, 1 Jun 2013 11:25:47 -0700 (PDT)
In-Reply-To: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226145>

Felipe Contreras wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1c35eef..2ce4f7d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -427,14 +427,8 @@ __git_refs ()
>                 done
>                 ;;
>         *)
> -               git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null | \
> -               while read -r hash i; do
> -                       case "$i" in
> -                       *^{}) ;;
> -                       refs/*) echo "${i#refs/*/}" ;;
> -                       *) echo "$i" ;;
> -                       esac
> -               done
> +               echo "HEAD"
> +               git for-each-ref --format="%(refname:short)" -- "refs/remotes/$dir/" | sed -e "s#^$dir/##"

Yeah, this patch makes sense overall.  I'm curious as to what role
ORG_HEAD had to play originally, and why it's absent now.
