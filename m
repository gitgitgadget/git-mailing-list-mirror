From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Mon, 18 May 2015 23:15:36 +0800
Message-ID: <CACRoPnQKge+3gCnO79yTZHxyPE=XgCONApWPF7Ue7DSxr0E7Og@mail.gmail.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 18 17:15:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMlb-0008QH-8n
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbbERPPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:15:38 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:35115 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbbERPPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:15:38 -0400
Received: by labbd9 with SMTP id bd9so225394007lab.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uE48aX3XC8piEtj4F17QosYIeCiFVBR9QWWmJuvdhJA=;
        b=TyUmSCYoTiKiK9USPH5CYfyzh3XPdXHX/r9VS9JUogrTR5P9J7nvwuA4iOqRU9QEgL
         teH3085+r3hw+b7aCJoPiW9ICXgbs+vo+kPO/FtenfMnoWxNKO0tzZcC7NtLt3NQTVdD
         YpCHpk2dHIyzXxImrV1kW3yqIWa6VE4Q2vZsX8/57+yiJAS66xD3QqHjUTbx6gl0dAoj
         7AE2AoTXtZtJm5cPAXa+IhIJxILMsqXqqf70ye9xyRtcJwIAoZYo2/Wli8MlOzjMP4KN
         87D0uscGlhH5+C3WB21XkL7g7WBsjLmM38uuqBqP24i/H5MmTqfaLV6xXgfp4rfe607g
         bjZw==
X-Received: by 10.152.18.194 with SMTP id y2mr15044057lad.74.1431962136279;
 Mon, 18 May 2015 08:15:36 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 18 May 2015 08:15:36 -0700 (PDT)
In-Reply-To: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269276>

Just a mental note to myself,

On Mon, May 18, 2015 at 9:39 PM, Paul Tan <pyokagan@gmail.com> wrote:
> diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
> index 8cccecc..eebb8c9 100755
> --- a/t/t5524-pull-msg.sh
> +++ b/t/t5524-pull-msg.sh
> @@ -17,6 +17,9 @@ test_expect_success setup '
>                 git commit -m "add bfile"
>         ) &&
>         test_tick && test_tick &&
> +       echo "second" >afile &&
> +       git add afile &&
> +       git commit -m "second commit" &&
>         echo "original $dollar" >afile &&
>         git add afile &&
>         git commit -m "do not clobber $dollar signs"
> @@ -32,4 +35,18 @@ test_expect_success pull '
>  )
>  '
>
> +test_expect_failure '--log=1 limits shortlog length' '

Ugh ><

s/test_expect_failure/test_expect_success/

Will respond to the other reviews tomorrow (it's bedtime in SGT).

> +(
> +       cd cloned &&
> +       git reset --hard HEAD^ &&
> +       test "$(cat afile)" = original &&
> +       test "$(cat bfile)" = added &&
> +       git pull --log=1 &&
> +       git log -3 &&
> +       git cat-file commit HEAD >result &&
> +       grep Dollar result &&
> +       ! grep "second commit" result
> +)
> +'
> +
>  test_done
> --
> 2.1.4

Thanks,
Paul
