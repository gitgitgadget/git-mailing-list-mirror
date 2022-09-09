Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B187ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 20:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiIIUFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiIIUFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 16:05:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8F2CCBF
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 13:04:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 145so2650604pfw.4
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=0D2dYGXnQ09MJWZK7fwRuYZLK6GGMbAmoH6GRNMo3K8=;
        b=czBLrf95v64ndEwoL39XzybMgGzGbdatNCxxQOX60l0gaLzythF6fZYnzmCeWCv0aM
         1bSHwdWUrwoNWt71yb/Oop+r/jiNdphlLzJWESPV0COqjPasjR8LzOlx/h0UK9R0Imyo
         4V9V6pbwweLY4/3YCN0ClDcfKOhZuo3sMTLsr+9T6805F/XhBu9gThCgnKODmDf1Mris
         UFsn7ORtdhkdMw0mgU/9fZ6MGz1rt4IgVkxSciLNDpsK2mArHLBxKp8huVo0i0dIaAJC
         +3SePa/OlJidz4v+GpcYiWpcIx2jF7p5y1oOIKSeu1gLyerEaTHbWOLIM6YWR1yO6nhH
         CUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=0D2dYGXnQ09MJWZK7fwRuYZLK6GGMbAmoH6GRNMo3K8=;
        b=Vhx0CIVxU1cRoiwRNnCQIokzmSxDHvfisfH5QUH0f41KZ+Dx3Oq+2aPlEDK/pKhcZ/
         OpnZTJ6/6y8rKLQHqwGqN4Tflf/3w9wHAZNesUC75mkWIsmH1FZdoKVzyzSbyQO8AvEh
         df+Gwaqfvx8fByesN5Co565d4URZ7c3KoPOixA0FZZsc9lIa3v+04KsxkwgmusGBG8eq
         qjfW3f1av2MhPQC5tZ8JloNjDBVmn4zS76yPqhYmlB4xddo2aK+wi9DJD+Bi1JXFm+1+
         jPxxJNWBPWNRXMMWAuTqsOe6pGYIJVE/OsbwI9D5Qsb47AaQawnk+0ZxQq1CI8tU0Dxp
         SABQ==
X-Gm-Message-State: ACgBeo3BfyRUpBOoouOeN1zSk3AT4BAmOYC0M0slRhxBfDv8v2fZEG5B
        wqfB/koIqbxS6jXzRx/7BKi7s4dD1dk=
X-Google-Smtp-Source: AA6agR6u9zeKnWD1KXxMrFwZESxi64Xm1AHhzdN21zxDFemSwQ3hyflozBQQfUqtd1SZlBaXZwPx1g==
X-Received: by 2002:a63:124f:0:b0:438:834a:f84f with SMTP id 15-20020a63124f000000b00438834af84fmr5004550pgs.319.1662753896980;
        Fri, 09 Sep 2022 13:04:56 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n7-20020aa79847000000b0052d417039c2sm121936pfq.133.2022.09.09.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 13:04:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, peff@peff.net,
        vdye@github.com
Subject: Re: [PATCH v2] builtin/mv.c: fix possible segfault in add_slash()
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
        <20220909194458.264735-1-shaoxuan.yuan02@gmail.com>
Date:   Fri, 09 Sep 2022 13:04:56 -0700
In-Reply-To: <20220909194458.264735-1-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Fri, 9 Sep 2022 12:44:58 -0700")
Message-ID: <xmqqo7voiaaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> A possible segfault was introduced in c08830de41 (mv: check if
> <destination> is a SKIP_WORKTREE_DIR, 2022-08-09).
>
> When running t7001 with SANITIZE=address, problem appears when running:
>
> 	git mv path1/path2/ .
> or
> 	git mv directory ../
> or
> 	any <destination> that makes dest_path[0] an empty string.
>
> The add_slash() call could segfault when dest_path[0] is an empty string,
> because it was accessing a null value in such case.

Terminology.  The relevant preimage is

>  	size_t len = strlen(path);
> -	if (path[len - 1] != '/') {

An access to path[-1] is an out-of-bounds access.

> Change add_slash() to check the path argument is a non-empty string
> before accessing its value. If the path is empty, return it as-is.

That is not wrong per-se, but...

> Explanation:

... you'd need this funny label here.  If this is where your
explanation begins, what was the reader reading before it? ;-)

The logic would flow more naturally if you added your "explanation"
material between "what is wrong in the current code" and "what to do
to fix it", perhaps like so:

	... could segfault when path argument to it is an empty
	string, because it makes an out-of-bounds read to decide if
	an extra slash '/' needs to be appended to it.

	As add_slash() is used to make sure that a valid pathname to
	a file in the given directory can be made by appending a
	filename after the value returned from it, if path is an
	empty string, we want to return it as-is.  The path to a
	file "F" in the top-level of the working tree (i.e.
	path=="") is formed by appending "F" after "" (i.e. path)
	without any slash in between.

	So, just like the case where a non-empty path already ends
	with a slash, return an empty path as-is.


> diff --git a/builtin/mv.c b/builtin/mv.c
> index 2d64c1e80f..3413ad1c9b 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -71,7 +71,7 @@ static const char **internal_prefix_pathspec(const char *prefix,
>  static const char *add_slash(const char *path)
>  {
>  	size_t len = strlen(path);
> -	if (path[len - 1] != '/') {
> +	if (len && path[len - 1] != '/') {
>  		char *with_slash = xmalloc(st_add(len, 2));
>  		memcpy(with_slash, path, len);
>  		with_slash[len++] = '/';

Yup.  It cannot be seen in the patch but the post-context of this
hunk just returns path as-is, which is what we want to happen.

Thanks.
