Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003CC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 06:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbiBSGf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 01:35:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiBSGfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 01:35:25 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E76DD968
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:35:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p9so19900964ejd.6
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=l3l1bXhe+uRNyFsTj89QPYOlzZzW4SGbiIHSoHI5d4w=;
        b=nGy+HSqt8khhXuRx0Sir6/246sRRBuA91A5F7MpWnacunlTQWKed6EslB9t2k6XreW
         USsc9vjzxs9jrAfvrLmricCzmMb0/5sfsuHShj6GlHTbTciCEAkLv+upCi0H08IwE/a3
         IVplgY3v48QT4KLI5h5F9tlpjqySK7LPOg4z1S2VBcwHqId16X2lGm33CGBjiuuBKj7v
         kf+yFmEdp+J3m8UrYX2zc3B9s5npMwEfyfno2aZLYjDrzxhk7kJRmVJo4y8TnztJOUOY
         /y7asw0++RbaK5MKNuW3iwR+qnU8DQi9+DzWGWXfssJSPrHBj+Fz7J2S10ZxhSCnIAqe
         PYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=l3l1bXhe+uRNyFsTj89QPYOlzZzW4SGbiIHSoHI5d4w=;
        b=AUK7WO6EPUSCstAtkRoTyv+hC62HoDkETTnnklvDyYYOPzp6Q7OI+IAhRJyw9VVlx6
         he495z7EJv1Y3jXfLJ6Cvpm/mvzEN1mImj5qK1HsmPS4W8QwDaSZgninjZjVwLvzREMr
         Av7A5iCVi47y8q2aJ2G9F5TW+mvirMofrpS1woQZKjQq485kMNmQYXr/AfgcClfCLeEn
         VT/u06q1gNMZXqxv7b5CijmtJeF8pgY69OrrGp20McvwMOd1akHGGhb1upeFaRQ8C2uZ
         T8RLd8ZHFjm4PAAao87SRJk5i3nr4fy90GawwwnR3oJPvnTotMJcggCKWqaEyvT4xntI
         UpxA==
X-Gm-Message-State: AOAM531OPJyodosLrn86Esu4V3ggmA93AQRfCVBRq1EOnUsNB4q92kG3
        dchJsirA5ubP4lkAkRcILOZraz6wmPl1nw==
X-Google-Smtp-Source: ABdhPJyIJ97T03QixPXcrR83SzD2uIHoan9izf+/qXHrP+ZyrRJoGeI2Q21yWvJDz0l874pc1d0eNA==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr8671251ejc.635.1645252504541;
        Fri, 18 Feb 2022 22:35:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q10sm2932123ejn.3.2022.02.18.22.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 22:35:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLJKh-004pqW-7Y;
        Sat, 19 Feb 2022 07:35:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v10 3/4] cat-file: add remove_timestamp helper
Date:   Sat, 19 Feb 2022 07:33:52 +0100
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
 <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
 <bf74b6cd75bd886c1b5954693beeaccdfd2e51ec.1645208594.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bf74b6cd75bd886c1b5954693beeaccdfd2e51ec.1645208594.git.gitgitgadget@gmail.com>
Message-ID: <220219.86a6ene548.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> maybe_remove_timestamp() takes arguments, but it would be useful to have
> a function that reads from stdin and strips the timestamp. This would
> allow tests to pipe data into a function to remove timestamps, and
> wouldn't have to always assign a variable. This is especially helpful
> when the data is multiple lines.
>
> Keep maybe_remove_timestamp() the same, but add a remove_timestamp
> helper that reads from stdin.
>
> The tests in the next patch will make use of this.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t1006-cat-file.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 145eee11df9..2d52851dadc 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -105,13 +105,18 @@ strlen () {
>  }
>  
>  maybe_remove_timestamp () {
> -    if test -z "$2"; then
> -        echo_without_newline "$1"
> -    else
> -	echo_without_newline "$(printf '%s\n' "$1" | sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//')"
> -    fi
> +	if test -z "$2"; then
> +		echo_without_newline "$1"
> +	else
> +		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
> +	fi
>  }
>  
> +remove_timestamp () {
> +	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
> +}
> +
> +
>  run_tests () {
>      type=$1
>      sha1=$2

I may have missed some previous discussions, but is there a reason this
echo_without_newline dance is needed? At this point this on top passes
all tests for me on both dash and bash:

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2d52851dadc..8266a939f99 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -104,18 +104,19 @@ strlen () {
     echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
 }
 
-maybe_remove_timestamp () {
-	if test -z "$2"; then
-		echo_without_newline "$1"
-	else
-		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
-	fi
-}
-
 remove_timestamp () {
 	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
 }
 
+maybe_remove_timestamp () {
+	if test -n "$2"
+	then
+		echo "$1" | remove_timestamp
+		return 0
+	fi
+
+	echo "$1"
+}
 
 run_tests () {
     type=$1

The move is another comment, if we're adding a remove_timestamp() let's
define it before maybe_remove_timestamp() which uses it, even though in
this case we can get away with it...
