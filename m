From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] t9821: use test_config
Date: Thu, 3 Sep 2015 09:04:19 -0400
Message-ID: <CAPig+cTzeUKiFVvdsGBvvUg+9qOw6RWHdzuTgQRTWm5w0CeRcQ@mail.gmail.com>
References: <1441272887-72633-1-git-send-email-larsxschneider@gmail.com>
	<1441272887-72633-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 15:04:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXUBn-0004ve-BH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 15:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbbICNEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 09:04:21 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34989 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbbICNEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 09:04:21 -0400
Received: by ykek143 with SMTP id k143so42221782yke.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6LM+h3nDJj9y6W23clAPwG8xxpW4o0g7Yg/uJxfnjlM=;
        b=eeRPykYkRRh7jfpT7T5vPjboHORtXrkSTwtFiXFNdg94XhqrwO1oxxhFBo3iCFgwvj
         nyW9/VySfSbkzwt5TqRN0tAvPXu7Vpo9sxJ1z2A7NM05NnUMqNEgAvxU2O81QOBM0vRc
         sylZqBgsdNerUEU+/+Xd73RrJwUGIVOilvxvyVVN3Uwk2V025xclQiQy1HgZkmdmrs+3
         z2JKKJDxQXRNN3AXhjFyeIukxtgS2AYbVDq408y1TUnp5OkUpANc7OgkcDDVkbW+heNL
         l/jLVhUg6xeQCuaHtdu4mN2cEurWGY+6/yDHkl93tK+9NRk187Twzyl7rvg6FEFi6hRo
         wr5w==
X-Received: by 10.13.202.80 with SMTP id m77mr41656384ywd.166.1441285460024;
 Thu, 03 Sep 2015 06:04:20 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Thu, 3 Sep 2015 06:04:19 -0700 (PDT)
In-Reply-To: <1441272887-72633-2-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: rOLLjq-MFxpMfFHnIFF0DwZ8ATc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277199>

On Thu, Sep 3, 2015 at 5:34 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
> index 81e46ac..5a26fec 100755
> --- a/t/t9821-git-p4-path-variations.sh
> +++ b/t/t9821-git-p4-path-variations.sh
> @@ -45,7 +45,7 @@ test_expect_success 'Clone root' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase false &&
> +               test_config core.ignorecase false &&

test_config ensures that the config setting gets "unset" at the end of
the test, whether the test succeeds or not, so that subsequent tests
are not affected by the setting. However, in this case, since the $git
repository gets recreated from scratch for each test anyhow, use of
test_config is superfluous. In fact, it may be slightly
contraindicated since it could mislead the reader into thinking that
state is carried over from test to test. (Not a big objections, but
something to take into consideration.)

>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 # This method is used instead of "test -f" to ensure the case is
>                 # checked even if the test is executed on case-insensitive file systems.
> @@ -67,7 +67,7 @@ test_expect_success 'Clone root (ignorecase)' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase true &&
> +               test_config core.ignorecase true &&
>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 # This method is used instead of "test -f" to ensure the case is
>                 # checked even if the test is executed on case-insensitive file systems.
> @@ -91,7 +91,7 @@ test_expect_success 'Clone root and ignore one file' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase false &&
> +               test_config core.ignorecase false &&
>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 # We ignore one file in the client spec and all path cases change from
>                 # "TO" to "to"!
> @@ -113,7 +113,7 @@ test_expect_success 'Clone root and ignore one file (ignorecase)' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase true &&
> +               test_config core.ignorecase true &&
>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 # We ignore one file in the client spec and all path cases change from
>                 # "TO" to "to"!
> @@ -133,7 +133,7 @@ test_expect_success 'Clone path' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase false &&
> +               test_config core.ignorecase false &&
>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 cat >expect <<-\EOF &&
>                 to/File2.txt
> @@ -149,7 +149,7 @@ test_expect_success 'Clone path (ignorecase)' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase true &&
> +               test_config core.ignorecase true &&
>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 cat >expect <<-\EOF &&
>                 TO/File2.txt
> @@ -180,7 +180,7 @@ test_expect_success 'Add a new file and clone path with new file (ignorecase)' '
>         (
>                 cd "$git" &&
>                 git init . &&
> -               git config core.ignorecase true &&
> +               test_config core.ignorecase true &&
>                 git p4 clone --use-client-spec --destination="$git" //depot &&
>                 cat >expect <<-\EOF &&
>                 to/File0.txt
> --
> 1.9.5 (Apple Git-50.3)
