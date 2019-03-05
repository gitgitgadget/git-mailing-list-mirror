Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A631F20248
	for <e@80x24.org>; Tue,  5 Mar 2019 00:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCEASD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 19:18:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38667 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEASD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 19:18:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so845721wmf.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 16:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YAUeshhEF5S/veW23nfdwmgeeDa4HS1bCHWkbhOJb8=;
        b=eCzFRQorJQ0rRaED0aqOEFZiLewXEZ5grlAlDmqyPsqXwrcygalF8m/MJ98Z16+YhE
         kTqDmM6wOw9d8paFrQoq7GzOHYTqlHWeaTpTlKcQQEQAgLaDYKCIlUvGMfi3yoUKlG3m
         Fi2LDRLai8rpr8m8gjfQayPEhIasAD9JSDh5ye4kEprWklEB0uofW3KIikDU8ZjH6i0t
         7GOtsnWA5K0ihfc+m25DskL7i7CbAxGGK6wTvU+uRzUnX4AOmNUb+a2suPWuu9PA7o1r
         CvvHdRIJ+zQSig8gb73ljOMkQdU2nGb/LSHRE1E8y6I3CnvbKe60pjz0K3OvxW9z1kgW
         rE/g==
X-Gm-Message-State: APjAAAUULkBRWp7OuEZnnHs1NBaiAiUu+o3Ud8D6xa0Npj2z0GciKX27
        Yhy5jPUbCTqze7VZOh1Ri7mT7DmwkxCk5nyAXJM=
X-Google-Smtp-Source: APXvYqymyq0Y9F5Wic+mH7fwsREmKk5Ud9bEezcWIHw3bvOogp0QXYjAwbwyeWbRKIAGZFLn49wfs3Kj829lRqzJPy0=
X-Received: by 2002:a1c:9e4b:: with SMTP id h72mr979648wme.76.1551745081263;
 Mon, 04 Mar 2019 16:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190304120801.28763-1-rohit.ashiwal265@gmail.com> <20190304120801.28763-2-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190304120801.28763-2-rohit.ashiwal265@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Mar 2019 19:17:50 -0500
Message-ID: <CAPig+cTTJgXERud0=svc5b+ctwQxoQ6cmpiA7WHMa7TUZ37BgQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 1/3] test functions: add function `test_file_not_empty`
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 7:08 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> Add a helper function to ensure that a given path is a non-empty file,
> and give an error message when it is not.
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -593,6 +593,15 @@ test_dir_is_empty () {
> +# Check if the file exists and has a size greater than zero
> +test_file_not_empty () {
> +       if ! test -s "$1"
> +       then
> +               echo "'$1' is not a non-empty file."

Although not incorrect, the double-negative is hard to digest. I had
to read it a few times to convince myself that it matched the intent
of the new function. I wonder if a message such as

    echo "'$1' is unexpectedly empty"

would be better. (Subjective, and not at all worth a re-roll.)

> +               false
> +       fi
> +}
>  test_path_is_missing () {

Much later in this same file, a function named test_must_be_empty() is
defined, which is the complement of your new test_file_not_empty()
function. The dissimilar names may cause confusion, so choosing a name
more like the existing function might be warranted.

Also, it might be a good idea to add this new function as a neighbor
of test_must_be_empty() rather than defining it a couple hundred lines
earlier in the file. Alternately, perhaps a preparatory patch could
move test_must_be_empty() closer to the other similar functions
(test_path_is_missing() and cousins).
