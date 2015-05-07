From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 05/12] t5520: test --rebase failure on unborn branch
 with index
Date: Thu, 7 May 2015 09:32:22 -0700
Message-ID: <CAGZ79kY7gstS1xPcNu4HqmmXA+qg9BKpXZwaHeQ91n7vL2Sa-g@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:32:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOit-0001fi-JU
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbbEGQcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:32:24 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37982 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbbEGQcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:32:22 -0400
Received: by igbhj9 with SMTP id hj9so50440584igb.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LQDDH5B6yCQWagncs9XppSZMM21ezZZS15tbXn+7egk=;
        b=P8krYpRqq+NiKvK6yGYsCjT+vDQhmiiVxAE5GjEPy4N4sDxVkTPig/fqi6qDyRoL+U
         qPTcOu8FPBuT9XYbdXM6b3HGxC4jim4vjFwjQp/6Q5+q02BfFIPoQzoEUk7vWD1j5jrF
         PqR4DoNz3S5n/1KJd+mYOah8E5T83I03slPZtCbYbXQyiJ4I8OVsMfITlNWTDDIz7QSQ
         GFWDJTGfAYweTmvHjWtV7i8Zl3iqkyOAlffb0jbf26uIlySOUOlFj+qKrMX8tbJo464F
         kzHPaohC6GAeNvxwEqQCFtrX6o9d5aSbp/n8iHJ4j02u/Hid9C0kB3ZfUzYTb60QbLHB
         kwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LQDDH5B6yCQWagncs9XppSZMM21ezZZS15tbXn+7egk=;
        b=eP/LZweMl5nNdoiNFxYbxZNUDMFt4cAYhCIGnhqYmLS4zLKfq3GE9YaIfJYrRFtx2x
         5scHMzcHMz7LiKsoCWZ0qnht9WJhCbDk61+bB1hPm7jjF1aoAkjgBk61ccv9jT3zfXJE
         uJuTy9nLnN3rD1w4YvnihnczhTZNLJFCcYbR0MOgQ6qalEH/lXOB7ynaBfQZu+bBEHlC
         1wigkcynffQUoTV/dCSe2gL/p6ciUr8JxJS8I/gou6JmiNyF/WlWDSoGPRkHxmRoBhjT
         B3jx4HYIMtiSxcJ/YC1R9zrrnGgS91Rz7dwUoPAKWzmzxebO7OG+gWob5LBKYXQh8rZH
         yO7g==
X-Gm-Message-State: ALoCoQllIo8UILwkvXp2GpLJ/vfXFpMhP+gdTPKd7BCPjYjChVvYx5C9XWJZXOKvp+q19JrqRKZS
X-Received: by 10.107.170.226 with SMTP id g95mr6016597ioj.2.1431016342267;
 Thu, 07 May 2015 09:32:22 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 7 May 2015 09:32:22 -0700 (PDT)
In-Reply-To: <1430988248-18285-6-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268545>

On Thu, May 7, 2015 at 1:44 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Commit 19a7fcbf (allow pull --rebase on branch yet to be born) special
> cases git-pull on an unborn branch in a different code path such that
> git-pull --rebase is still valid even though there is no HEAD yet.
>
> This code path still ensures that there is no index in order not to lose
> any staged changes. Implement a test to ensure that this check is
> triggered.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     * Test for error message.
>
>     * Ensure that when git-pull does not modify the index.
>
>     * Moved test_when_finished
>
>  t/t5520-pull.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 05a92a2..9107991 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -415,6 +415,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
> +       test_when_finished "rm -rf empty_repo2" &&
> +       git init empty_repo2 &&
> +       (
> +               cd empty_repo2 &&
> +               echo staged-file >staged-file &&
> +               git add staged-file &&
> +               test "$(git ls-files)" = staged-file &&

I think usually people use

    git ls-files >actual
    echo staged-file >expected && # you have this already in your 2nd
    # line in the paragraph
    test_cmp staged-file actual

to make debugging easier as you can inspect the files (actual, expected)
after the test has failed.

Personally I don't mind the difference as when it comes to debugging
using the test suite I haven't found the silver bullet yet.


> +               test_must_fail git pull --rebase .. master 2>../out &&
> +               test "$(git ls-files)" = staged-file &&
> +               test "$(git show :staged-file)" = staged-file
> +       ) &&
> +       test_i18ngrep "unborn branch with changes added to the index" out
> +'
> +
>  test_expect_success 'setup for detecting upstreamed changes' '
>         mkdir src &&
>         (cd src &&
> --
> 2.1.4
>
