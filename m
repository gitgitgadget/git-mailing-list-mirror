From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 9 Oct 2013 18:20:40 +0800
Message-ID: <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: "Paolo G. Giarrusso" <p.giarrusso@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 12:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTqtD-0005eD-RA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 12:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab3JIKVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 06:21:03 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46768 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab3JIKVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 06:21:02 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so1310488ieb.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MtB9OaAQNEitBhKsrhmZgZJqpPAqSeZKOODx3gZa0vI=;
        b=qsq9ECQYLtt305FG5wZKNXvS/1D17rBlIsYhkSgnmh5aeCFWcifv5J0RKgKvFlBSFZ
         06D9BW7b4Xvq3hLR5AdSWK6jWJqXcg1pLz/YwfkErr7veRHnrA6mdIKhwXqD52NkCPoM
         2AP+1jl2VSrcrUqshnKc6bvQMWiL125bTMVAwtibdwbxDvXv5l35OFwJMU7h2fdRpQPI
         v+vZuL7II6wPYLW0xwLRSOGl2tizIoi5TxrXOBtvN13Ho8YTj9nXjcEjhDgS64Owac1m
         zGGbxKr+pVCxGHrDDOifRy740mn8N9lD7kIgBqKw9uJRdGFBOBwiOc6BHp9nX/2U3HEn
         sh0g==
X-Received: by 10.50.118.105 with SMTP id kl9mr1380729igb.3.1381314061004;
 Wed, 09 Oct 2013 03:21:01 -0700 (PDT)
Received: by 10.64.226.195 with HTTP; Wed, 9 Oct 2013 03:20:40 -0700 (PDT)
In-Reply-To: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235803>

On Wed, Oct 9, 2013 at 11:57 AM, Paolo G. Giarrusso
<p.giarrusso@gmail.com> wrote:
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7d7af03..ebfb78f 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -592,7 +592,9 @@ cmd_split()
>         eval "$grl" |
>         while read rev parents; do
>                 revcount=$(($revcount + 1))
> -               say -n "$revcount/$revmax ($createcount)
> "
> +               if [ -z "$quiet" ]; then
> +                       printf "%s" "$revcount/$revmax ($createcount)
> " >&2
> +               fi

Reviewers might wish to know that "say" in git-subtree is defined as

        say()
        {
                if [ -z "$quiet" ]; then
                        echo "$@" >&2
               fi
        }

Hence the "if" and the redirect.

-- 
Cheers,
Ray Chuan
