Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E2C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 21:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjDQVKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQVJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 17:09:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CF4C16
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:09:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso15472882pjb.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765793; x=1684357793;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd7yn5Mtepw+0xN50/Egi2QBnZI9n5J7sBLbXlCa3zQ=;
        b=KmhynfylXEW5fZy+1+O3Pt4aeXKsrl2lby31/lVO5QS2ZuYg6f2yQ8cHcuBF6wXvsy
         X9LyGf+oXRTSH3krYMmUSTI4Ibsyev1QgVr9IsavzSyI08x+xK7uahRz0HaPmv5zrZTr
         hymkCbtlDPQm5MXgkebt7kJuCpyKFJijYY8LtXbUNQwczIhlDRPtKAmeFNKJpg+WkWX4
         awll5yM138/uCeyUcd7fLyAEwxgK1mQr2Sywm2yg2BGMC276vblgwbzawQD/DTSQPhXi
         lClBU54clB/IaRgHWSGpuFeVgZ9/j2iMTDmEvqrdqOB/bxMuHszDxl+WsDrs707CrHuU
         8QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765793; x=1684357793;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fd7yn5Mtepw+0xN50/Egi2QBnZI9n5J7sBLbXlCa3zQ=;
        b=Pwxh+q1SGdo0cF4xzXUHvBljvhN/iOspMwg/S7bHbB7vrvhsREQsuJyodTstT99p4y
         frt32i5/RldAV5nDzls3DSoFW9KC+pzE1mcPR2aT+2bUyEwiOhAhA5tpMkCLLk1v0JR4
         zqQucSF41dfvGC80vaxmGpywviO44v7TC4Vxc+6s+oxk+AbtpPns6LIpidLh92p5sU3J
         5LAGcg2pXqWj3pGDYqHcBRIXFv6h4lPSn8OGBKmAiSjl1CANcq0qadbw5AxtjCjL+0X/
         lI7NAS4mxwbUfqcfY+5F0SxRzA3rvjhxu48my3mXCJ/TlOLZsrKF9sO9CvPcM0BEKaDx
         XXFg==
X-Gm-Message-State: AAQBX9eMl0beFwB2Ha8tC8XP9TtQuGmNtCtnCKS4rhykA4Y7KdNUPabX
        4YMCosay7t2IXkHW7Q1hdlMyBsnf4Fg=
X-Google-Smtp-Source: AKy350bOJTEM4G4QJsKCE8siYF7k6l8e9H4lPBQFhRHdguncnfmWoOnpuCM3QfolHkXHqJIQq4TK3w==
X-Received: by 2002:a17:90b:3a8a:b0:237:b5d4:c0cc with SMTP id om10-20020a17090b3a8a00b00237b5d4c0ccmr15984000pjb.39.1681765793334;
        Mon, 17 Apr 2023 14:09:53 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a088e00b0023cfdbb6496sm9310159pjc.1.2023.04.17.14.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:09:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
        <20230417093255.31079-3-jacobabel@nullpo.dev>
Date:   Mon, 17 Apr 2023 14:09:52 -0700
In-Reply-To: <20230417093255.31079-3-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Mon, 17 Apr 2023 09:33:44 +0000")
Message-ID: <xmqq8reqkyfz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

>  test_expect_success 'add --quiet' '
> +	test_when_finished "git worktree remove -f -f another-worktree" &&
> +	test_when_finished cat actual >&2 &&

I doubt that this redirection does anything you expect it do.
Doesn't it redirect the standard output that is emitted by the
test_when_finished shell function when it registers another
test_cleanup scriptlet to the standard error, and when test_cleanup
is indeed run, wouldn't "cat actual" send its output to the standard
output?

No, I am not suggesting to write the line as:

	test_when_finished "cat >&2 actual" &&

>  	git worktree add --quiet another-worktree main 2>actual &&
>  	test_must_be_empty actual

The reason why I do not suggest "fixing" the above is because
test_must_be_empty, when fails, does this:

        test_must_be_empty () {
                test "$#" -ne 1 && BUG "1 param"
                test_path_is_file "$1" &&
                if test -s "$1"
                then
                        echo "'$1' is not empty, it contains:"
                        cat "$1"
                        return 1
                fi
        }

i.e. it sends the contents of "actual" to the standard output
already.  When it succeeds, of course "actual" is empty, and there
is no point in showing its contents.

So "sh t2400-*.sh -x -i" already shows "cat actual" output.  Try
the attached patch on top of this one and running it would show
the above message shown by test_must_be_empty and the contents of
the file 'actual'.  "git worktree remove" fails and your "cat" in
the test_cleanup does not even trigger, by the way.

There may be cases where having something like this might help, but
running the test with "-x" is not it---that case is already covered
by what test_must_be_empty gives us, I think.

 t/t2400-worktree-add.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/t/t2400-worktree-add.sh w/t/t2400-worktree-add.sh
index 9bc3db20e4..814642c8ae 100755
--- c/t/t2400-worktree-add.sh
+++ w/t/t2400-worktree-add.sh
@@ -329,9 +329,12 @@ test_expect_success 'add --quiet' '
 	test_when_finished "git worktree remove -f -f another-worktree" &&
 	test_when_finished cat actual >&2 &&
 	git worktree add --quiet another-worktree main 2>actual &&
+echo foo >>actual &&
 	test_must_be_empty actual
 '
 
+exit
+
 test_expect_success 'local clone from linked checkout' '
 	git clone --local here here-clone &&
 	( cd here-clone && git fsck )

