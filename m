From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 13/16] t/t5505-remote: test multiple push/pull in remotes-file
Date: Fri, 21 Jun 2013 18:53:53 -0400
Message-ID: <CAPig+cSYC4Qv8n_Ly0kWbKho77eJsGxiKZgRCE9XR668vZ92wQ@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqADV-0003XO-LO
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946223Ab3FUWx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:53:56 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:36472 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946196Ab3FUWxz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:53:55 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so8049524lab.18
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=uMF2P1EnWEXvH5R1J0soZ3eSVTQYkVBQiwdxj2rK87E=;
        b=r2RmudHTNX2yg7dseajEyL31EgXRs01OK0uZk6CfmKZKzQNyjtdT0tylSjuIygLFA6
         B1EJnTchOuabMu077SWK29VF2YDTB86WVUKi7/5fNhyu4W8nRrsbpUkgy8b8K1XJtErG
         aEEynfjSTkPCIAbW1VlgMPKgIUr0htnkzRV54/6wSLLMu80iNEkXeMc/5fXCeiQcgyXv
         LbbScPdJT3lmMXcS/5DkgWoIaplukAY9kvFfQdZFOPKNtsbS+VhTk6Q2bvc8+oq2VndW
         0ES1evcjdjHZ39MMjxqAttQjVJV5DxSgw4GP/IhRCnhNifq+y8CDj6ai/HQ2zqzdyod+
         rkZw==
X-Received: by 10.152.87.172 with SMTP id az12mr6955662lab.24.1371855233771;
 Fri, 21 Jun 2013 15:53:53 -0700 (PDT)
Received: by 10.114.161.5 with HTTP; Fri, 21 Jun 2013 15:53:53 -0700 (PDT)
In-Reply-To: <1371813160-4200-14-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: zpSMfH3eVhFHUPr67J8zTR5fscI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228669>

On Fri, Jun 21, 2013 at 7:12 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Extend the test "migrate a remote from named file in $GIT_DIR/remotes"
> to test that multiple "Push:" and "Pull:" lines in the remotes-file
> works as expected.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 06ed381..5497a23 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -684,8 +686,18 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
>                 git remote rename origin origin &&
>                 test_path_is_missing .git/remotes/origin &&
>                 test "$(git config remote.origin.url)" = "quux" &&
> -               test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
> -               test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
> +               cat >push_expected <<-\EOF

Broken &&-chain.

> +               refs/heads/master:refs/heads/upstream
> +               refs/heads/master:refs/heads/upstream2
> +               EOF
> +               cat >fetch_expected <<-\EOF

Ditto.

> +               refs/heads/master:refs/heads/origin
> +               refs/heads/master:refs/heads/origin2
> +               EOF
> +               git config --get-all remote.origin.fetch >push_actual &&
> +               git config --get-all remote.origin.fetch >fetch_actual &&
> +               test_cmp push_expected push_actual &&
> +               test_cmp fetch_expected fetch_actual &&
>         )
>  '
>
> --
