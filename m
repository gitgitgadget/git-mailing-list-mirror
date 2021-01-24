Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F6C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18F122B2C
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 13:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhAXN5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 08:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbhAXN45 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 08:56:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519EC06174A
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 05:56:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f1so12011322edr.12
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=kB/e2XhUE1urA6MCYhw6/cwzpQijcq1Y1RTgNKU112M=;
        b=E40XOWkw9fu9x4NTUnlaoSHg9DUwJ5jDKN3MLmLVEuX95tvfE8wGXmQQH5lL09yyB7
         9sgPCcIcGM+YYfsMZ+WDv40SE8e01ajiLyH9z1zPU2Xzv0es+hnMppE++k5cZ54JOhLv
         kk+i9BX0cQcfU8+8Ix2ZOwF0QQipIXY0Kq0/2XcV1iEKeNo5Z4W/FV5uJ1g/InYjv3qZ
         C+dJ4rh2T85ucVdDuJmzjAoxo2SAFeV9JFC/90GbfZgCuvD9tCqZMQKR1ifceROb/ghI
         3ooZ+9G5CS5kCUYrzw1jo948uQod0Ly+3m5HcmJ0T7l9p/+01hS3yEDL3pivclsCBE8g
         tiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=kB/e2XhUE1urA6MCYhw6/cwzpQijcq1Y1RTgNKU112M=;
        b=eiuC+DrHQTN4eHaGIZPF8iKY01MM5VC51u5eXgi5z4Ul3rXJhI3Y1GzVF/t9KnboVT
         Zz73hHRz3QUXH5/GY7caEh7sjQmy8Gy0EH1eihsvjSmcfcMcJ2BDJ2Q8PEfKHM1aMkr2
         8mt1hGCd0bw3odKrQs6KI36hySefM6Zrpcg8pKVYIprOLEEf6n5ZqLmOwZAVycsnsqdQ
         vFSOjfOAYToiqzB9ZC7zG02h7Ej0MzakuZrfP0Ka4umJjBvvVUZTX1EXqgE4sB30wlP3
         mypg/hsrJkYTGBqdu3Lzyayp6x2uj+jgeLs69WCecuFTVieI7bwNL7V6MkA5bUzcsstN
         o+Pg==
X-Gm-Message-State: AOAM531AE3EBsdQHxv9meIF8xsPvbngIGEhejsBmIH3kGe1tHK1HIk2V
        NzwBBYrTiggEPmhAtzRM6TM=
X-Google-Smtp-Source: ABdhPJybeIJpwiXby5C0DRKlkHrpa0qwHTE8YNx39nmeLwUjwChNnpzdxMVuOT8JPRh4S5S9rkYSZA==
X-Received: by 2002:a05:6402:1155:: with SMTP id g21mr17810edw.279.1611496575348;
        Sun, 24 Jan 2021 05:56:15 -0800 (PST)
Received: from cpm12071.local ([79.140.115.149])
        by smtp.gmail.com with ESMTPSA id w3sm691921eja.52.2021.01.24.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 05:56:14 -0800 (PST)
References: <20210123154056.48234-1-mirucam@gmail.com>
 <20210123154056.48234-2-mirucam@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
In-reply-to: <20210123154056.48234-2-mirucam@gmail.com>
Message-ID: <gohp6kv9bml9qc.fsf@gmail.com>
Date:   Sun, 24 Jan 2021 14:56:13 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Nice work on this series.

I have one comment on this series regarding a behavior diff between the
C and shell version, and small comment about style, see below.

Miriam Rubio writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_log()` shell function in C and also add
> `--bisect-log` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
>
> Using `--bisect-log` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 22 +++++++++++++++++++++-
>  git-bisect.sh            |  7 +------
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 709eb713a3..a65244a0f5 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -904,6 +904,18 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
>  	return bisect_auto_next(terms, NULL);
>  }
>  
> +static enum bisect_error bisect_log(void)
> +{
> +	int fd, status;
> +	fd = open(git_path_bisect_log(), O_RDONLY);
> +	if (fd < 0)
> +		return BISECT_FAILED;
> +
> +	status = copy_fd(fd, STDOUT_FILENO);
> +	close(fd);
> +	return status ? BISECT_FAILED : BISECT_OK;
> +}
> +

In the shell version, when we are not bisecting it the `git bisect log`
command will `die` with the text "We are not bisecting." which state to
the user that a bisect is not yet started. The shell version does that
by checking if the `$GIT_DIR/BISECT_LOG` file doesn't exists or it's
an empty file as the following code snippet copied from the shell
version that is remove by this patch:

   test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"

This seems to be "missing" from the new C version implemented by this
patch and perhaps we should add it. I'm not sure whether this change was
intentional and I'm missing some context here of why we are dropping
the message, if that's the case I apologize in advance. But, IMHO
outputting the error message provides a better user experience as it
would be obvious that the user forgot to `git bisect start` instead of
silently failing.

With that said, perhaps an obvious way of implementing is to use
`is_empty_or_missing_file()`, much like `bisect_replay()` does it in the
[2/7] patch on this series, and return the same error message from
the shell version:

-- >8 --
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a65244a0f5..ce11383125 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -907,7 +907,12 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 static enum bisect_error bisect_log(void)
 {
        int fd, status;
-       fd = open(git_path_bisect_log(), O_RDONLY);
+       const char* filename = git_path_bisect_log();
+
+       if (is_empty_or_missing_file(filename))
+               return error(_("We are not bisecting."));
+
+       fd = open(filename, O_RDONLY);
        if (fd < 0)
                return BISECT_FAILED;
-- >8 --

Although I compiled and did small test on the above code snippet, don't
trust it blindly and perform your own test and judge whether this is the
best way to implement this shortcoming.

>
> @@ -210,7 +205,7 @@ case "$#" in
>  	replay)
>  		bisect_replay "$@" ;;
>  	log)
> -		bisect_log ;;
> +		git bisect--helper --bisect-log || exit;;

Style: just a minor change to add a space between `exit` and `;;`.

-- 
Thanks
Rafael
