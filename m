From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Mon, 24 Nov 2014 18:14:34 -0500
Message-ID: <CAPig+cQ=Ea2K0AJRu62q1w2tGmN1kgZ15oc3kHisSo3gpuU6=Q@mail.gmail.com>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:14:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2q7-0006J3-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbaKXXOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 18:14:35 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:47605 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaKXXOe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 18:14:34 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so5145446yhl.23
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 15:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2ykpi/oJBaIs42X6XqPDSH4ZGNfdhtPVypqMtDU4dWE=;
        b=Yiq9ualN0aG03CD8I5l7JYYc5mWsaYB5K71bWwuPNlDzT1q8UuQVivHieZwQAb8Ne5
         bbg8g7r5IJBMYm77thZjrZgXv1CLIyZw0+3cXy3TeRBLjA7UnC0mOxPCBZXeXHG/72wD
         oyGWC80o3oOR0hJTQv3q5w8/jGx5MfY3fSTiw7sBfP1ptjzmnTmRoDEkGvevW8xruvuX
         3iEfszLUcK7xijhOl6Q3f4xSzvuTWoMjQjaG6K2ZBCjSfkhRVhOt8MhogGNszL0JLqpB
         TH5CRNzti4osuLYTMteFQsUC9wbHaaIHJsChvJd+QlGb8khMRQlMSEhR9HG8qhY4Dleb
         hmKQ==
X-Received: by 10.170.134.72 with SMTP id a69mr23128598ykc.103.1416870874196;
 Mon, 24 Nov 2014 15:14:34 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Mon, 24 Nov 2014 15:14:34 -0800 (PST)
In-Reply-To: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
X-Google-Sender-Auth: 6oxdhiGWKvhpyrgD5mP-bk-QhoY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260169>

On Mon, Nov 24, 2014 at 6:21 AM, =C3=98ystein Walle <oystwa@gmail.com> =
wrote:
> When a commit is amended a pre-commit hook that verifies the commit's
> contents might not find what it's looking for if for example it looks=
 at
> the differences against HEAD when HEAD~1 might be more appropriate.
> Inform the commit hook that --amend is being used so that hook author=
s
> can do e.g.
>
>     if test "$1" =3D amend
>     then
>         ...
>     else
>         ...
>     fi
>
> to handle these situations.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index 984889b..be97676 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -136,4 +136,18 @@ test_expect_success 'check the author in hook' '
>         git show -s
>  '
>
> +# a hook that checks if "amend" is passed as an argument
> +cat > "$HOOK" <<EOF
> +#!/bin/sh
> +test "\$1" =3D amend
> +EOF

write_script would be the modern way to create this hook.

> +
> +test_expect_success 'check that "amend" argument is given' '
> +       git commit --amend --allow-empty
> +'
> +
> +test_expect_success 'check that "amend" argument is NOT given' '
> +       ! git commit --allow-empty

You probably want test_must_fail rather than '!' [1].

> +'
> +
>  test_done
> --

[1]: http://thread.gmane.org/gmane.comp.version-control.git/259871/focu=
s=3D260092
