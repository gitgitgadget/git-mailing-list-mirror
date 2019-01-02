Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DF91F770
	for <e@80x24.org>; Wed,  2 Jan 2019 18:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfABS4w (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 13:56:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38597 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfABS4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 13:56:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so28562122wml.3
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6HdpG+BLdp1deSOiBA8DZdgPDCMXiUKQQbL+8PeNKQw=;
        b=s4Q8mMRzwQG7WGz5SilSqx6q74R2NnjM413FTqhsA1jxGHiM9tYy1rQ7iIIyzK/r+y
         F840ZIsJminfy5TMfbyGNC38Ilm92XYjjAhCVvwxiiF15shZvVO+0pqo+R8QayN1JWN3
         86t2kBv3yLUpGY8tFwwWp5dPgGp0aDZMBpJE4mPu/KWVbo0HBFfsfK8icPdV3PfwLPUT
         UN+z070Cvs4r6ynUWjaBOZdLiSt5tavMMbQHs7+nXkD4+3sZU6kqfCDQQqH4sycMQA6y
         o35ISZ2taO0fXCBl/RVo/o0Tc5bG72SZkUHaIGIHEOMyhCLGq5OtGRQkCdwTNGlaQ082
         mV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6HdpG+BLdp1deSOiBA8DZdgPDCMXiUKQQbL+8PeNKQw=;
        b=CbHMWY2pmfEujH96JYb4v37AswzfUDgdLVM4I6s48z0svHpYCFXILw42d/qCs50EBm
         sZ2B6JdLsWaqCFox8W7lrxYx1Yij3cW/lgJRf9c0hrlvYcBS12onE54ADAe/1YZwLJTS
         pqUEexU3G6NbW40q1d+AeTZDIIK81Qed6uFirB0RsRQPaF84iq7s/xxLjTAGjpvrn/+f
         WM+J2Pqm7UVUd986NxRAVd84kkuWS4qC+v4hHtiOEPRlNNCHNXrmtSeNrKETAKN5bbI0
         8+wK7l47jy7/uz1KMIWYdKSFGu5CLPZptP9PxCtjpzCGey3AIks5BI+6R5BQKa8vSxGl
         V3Wg==
X-Gm-Message-State: AJcUuke4w687gxnJ/p5OS00iZbIz01FJ8gBi2dAwShvCTXabvbWt4Jrp
        kXF6XLetTrmtnan/Qes7CtE=
X-Google-Smtp-Source: ALg8bN4N0z7eY9TmhRWGHCSTAtSCdRfBAhJzysdMpedc7XQ/kaOgV9vtxCwx6m7mPIblRSAKFZDueA==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr4017995wmk.44.1546455409041;
        Wed, 02 Jan 2019 10:56:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q9sm58979743wrp.0.2019.01.02.10.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 10:56:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with --no-index
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
Date:   Wed, 02 Jan 2019 10:56:45 -0800
In-Reply-To: <20181220002610.43832-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 20 Dec 2018 00:26:10 +0000")
Message-ID: <xmqqr2dukhw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_expect_success SYMLINKS 'diff --no-index --literally with symlinks' '
> +	test_write_lines a b c >f1 &&
> +	test_write_lines a d c >f2 &&
> +	ln -s f1 s1 &&
> +	ln -s f2 s2 &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/s1 b/s2
> +	--- a/s1
> +	+++ b/s2
> +	@@ -1,3 +1,3 @@
> +	 a
> +	-b
> +	+d
> +	 c
> +	EOF
> +	test_expect_code 1 git diff --no-index --literally s1 s2 >actual &&
> +	test_cmp expect actual
> +'

This is good as a goal, but the implementation seems to be overly
eager to dereference any symlink or non-regular file found in any
level of recursion.  The use case presented as the justification in
the proposed log message, and the explanation in the documentation,
suggests that only the paths given from the command line are treated
this way.

It may make sense to do this as two orthgonal flags.  Dereference
symlinks and named pipes given from the command line is one use
case.  Dereference any symlinks encountered during recursion is
another.  And the latter might be useful even inside a repository
as an option, even though the former would never make sense unless
running in --no-index mode.

Thanks.


