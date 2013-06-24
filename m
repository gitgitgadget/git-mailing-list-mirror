From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Mon, 24 Jun 2013 08:58:31 +0200
Message-ID: <CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 08:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur0jZ-00062q-4g
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 08:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab3FXG6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 02:58:37 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:54074 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab3FXG6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 02:58:36 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur0jT-000Lf4-BD
	for git@vger.kernel.org; Mon, 24 Jun 2013 08:58:35 +0200
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uqzcq-0008Pp-GH
	for git@vger.kernel.org; Mon, 24 Jun 2013 07:47:40 +0200
Received: by mail-ob0-f174.google.com with SMTP id wd20so10430607obb.19
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 23:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GNbNNiY7njn8QHvHMMh4RKZqb+OA8iPlzrgEfxyTXiY=;
        b=an8az3xm/exaLMY/W0njetkq624I4LJ6wORF3q5UaxY4pFjCoPqm2qdFt92saF521V
         bVP0E934IW9y+oiZ7XgKGR04YeFdvH7NKqyfQRanbE9bFNlMXVHQgJJ67iIbOKNgPt1w
         42tH/y9jZt2sWaM3tUU89uL7iQWqfJu3yyCzKM3WxT5QHpiCLZzHsFWS6D6u2nHtAQ7A
         QF77vvNzwiJWhiUA0FULI3Kogsp9xfTwh3B7sfo6jEFEYZeuKuJPzBvenxi8/TeHmono
         Dmev1+CVLMuPYRbWJqHPI5VwT3KCLZ54hIFwxxz5GPiwr8Bu9B/zvQiU5+ZEEFfqojee
         0big==
X-Received: by 10.60.94.72 with SMTP id da8mr10562207oeb.123.1372057111696;
 Sun, 23 Jun 2013 23:58:31 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Sun, 23 Jun 2013 23:58:31 -0700 (PDT)
In-Reply-To: <1372048388-16742-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228778>

On Mon, Jun 24, 2013 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Ramkumar Ramachandra <artagnon@gmail.com>
>
> The setup creates two bare repositories: repo1 and repo2, but
> test_push_commit() hard-codes checking in repo1 for the actual output.
> Generalize it and its caller, test_push_success(), to optionally accept
> a third argument to specify the name of the repository to check for
> actual output.  We will use this in the next patch.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5528-push-default.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index 69ce6bf..db58e7f 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -15,17 +15,19 @@ test_expect_success 'setup bare remotes' '
>
>  # $1 = local revision
>  # $2 = remote revision (tested to be equal to the local one)
> +# $3 = [optional] repo to check for actual output (repo1 by default)
>  check_pushed_commit () {
>         git log -1 --format='%h %s' "$1" >expect &&
> -       git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
> +       git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&

Isn't  ${3:-repo1} a bashism?

>         test_cmp expect actual
>  }
>
>  # $1 = push.default value
>  # $2 = expected target branch for the push
> +# $3 = [optional] repo to check for actual output (repo1 by default)
>  test_push_success () {
>         git -c push.default="$1" push &&
> -       check_pushed_commit HEAD "$2"
> +       check_pushed_commit HEAD "$2" "$3"
>  }
>
>  # $1 = push.default value
> --
> 1.8.3.1-721-g0a353d3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
