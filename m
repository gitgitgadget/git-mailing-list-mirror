From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 3 Mar 2014 18:03:55 -0500
Message-ID: <CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:04:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbtx-0006rM-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbaCCXD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:03:57 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:48023 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaCCXD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:03:56 -0500
Received: by mail-yk0-f170.google.com with SMTP id 9so12304517ykp.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pjHMJMzkyw0wZ4fPWUceiNwW5wpyRN/BZdR5vBwEiMw=;
        b=wZ74qH1n7ZeoMkxhyq+IZCzJN4WAjpInlq9Yti9a/w37Tw1BCmvs9MoXBeiJxh4gXY
         DnzEHqc1OjE6b2EnOuzZIrOG1hmEhvl5OxreKg6sAB8dXe6/c420qk8GFOwNUcFB1DHg
         Ra1V0TJoOihKT5Ujk29fBjsmobYTAjhZBCGas/VQ/gRCVuJkIiCCmS9/1gJ8G3RAvJAA
         K4/aVymNTfGiPp+L/5YpUs+708AcYgnqldvk97xyrM7rQj5W4aZ+A8pBQOgNd4iUi1Tw
         hY4dXx2K3Uxbpltso0Y6E0FHSwCQ2+cG6nuhzWfq6+lrxmlJXf2U/JmuUsnAmxIMCo39
         21tw==
X-Received: by 10.236.129.198 with SMTP id h46mr24902815yhi.17.1393887835537;
 Mon, 03 Mar 2014 15:03:55 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 15:03:55 -0800 (PST)
In-Reply-To: <1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
X-Google-Sender-Auth: EgMiUCB2yUHWb6IY-aR3-M5vUuU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243301>

On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> This is a counterpart to GIT_SKIP_TESTS.  Mostly useful when debugging.

To be grammatically similar to GIT_SKIP_TESTS, perhaps name it GIT_RUN_TESTS?

> ---
>  t/README      |   15 +++++++++++++++
>  t/test-lib.sh |    8 ++++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/t/README b/t/README
> index caeeb9d..f939987 100644
> --- a/t/README
> +++ b/t/README
> @@ -187,6 +187,21 @@ and either can match the "t[0-9]{4}" part to skip the whole
>  test, or t[0-9]{4} followed by ".$number" to say which
>  particular test to skip.
>
> +Sometimes the opposite is desired - ability to execute only one or
> +several tests.  Mostly while debugging tests.  For that you can say
> +
> +    $ GIT_TEST_ONLY=t9200.8 sh ./t9200-git-cvsexport-commit.sh
> +
> +or, similrary to GIT_SKIP_TESTS
> +
> +    $ GIT_TEST_ONLY='t[0-4]??? t91?? t9200.8' make
> +
> +In additiona to matching against "<test suite number>.<test number>"

s/additiona/addition/

Plus the other typos already mentioned by Philip...

> +GIT_TEST_ONLY is matched against just the test numbes.  This comes
> +handy when you are running only one test:
> +
> +    $ GIT_TEST_ONLY='[0-8]' sh ./t9200-git-cvsexport-commit.sh
> +
>  Note that some tests in the existing test suite rely on previous
>  test item, so you cannot arbitrarily disable one and expect the
>  remainder of test to check what the test originally was intended
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 89a405b..12bf436 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -464,6 +464,14 @@ test_skip () {
>                 fi
>                 skipped_reason="missing $missing_prereq${of_prereq}"
>         fi
> +       if test -z "$to_skip" && test -n "$GIT_TEST_ONLY" &&
> +               ! match_pattern_list $this_test.$test_count $GIT_TEST_ONLY &&
> +               ! match_pattern_list $test_count $GIT_TEST_ONLY
> +       then
> +               to_skip=t
> +               skipped_reason="not in GIT_TEST_ONLY"
> +       fi
> +
>         case "$to_skip" in
>         t)
>                 say_color skip >&3 "skipping test: $@"
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
