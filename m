Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD11C678D5
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 03:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCIDAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCIDAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 22:00:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E71C7DD
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 19:00:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x34so878142pjj.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 19:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678330814;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGRyEJEVxOeEjpNKEd6cp7+YxqhBNF7dh0KVB62kR1g=;
        b=Zy5YhmwMrHt4kL+sJRRHevhUX/68LW6/GpMFENtE+bpNw93q/zaoS6YlutTVpR+s9p
         rEfcfqh4OoU4hFJEadV8mZXEQfX7gosRvEItA3CI9JtXENYNearxVgPicw0ZP0iWtrFI
         3KZQKEQqlp+KuCricpvAmTiScaPhMp6M7uWcs75ESYz+vcdQ1aSPBvYEpeopH6idK576
         qwPlVppNizZ3zfcp73bg9YCuMAa77652zietghUUigTEc3LftglMc/PMblfTpb52QsxH
         cxvcPMSxdyMaL5e2vw/WpSLsdGkJvTBRZsrdhc/dh6g2o0fM3A4LnBlwVZ4kWKmzesq5
         MIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678330814;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DGRyEJEVxOeEjpNKEd6cp7+YxqhBNF7dh0KVB62kR1g=;
        b=k405TiPNJf4QMXR/PTNxx9c0tTafJrq6EzevOE0t5JlMNwMAKBBAIK+MHWJVe+ITrr
         15pDfYYBpWXxWbZassE3DdFVAkwIVJquTWN/7yi25CskE9ShCoNHAp7M0r9bRnsy1XzV
         qhCm/+FYfIO+xCco4TpBYXf+mEwcu3zgoFph/vsY3mobx04mch/5vPL+i69E9Cm60hG9
         EsAfQn4JuQmdR8rMwPwwDYfHRd/pMtl2/KTf8dZ79hWuFNUt2+7rvLUSiF+7dMZirdtA
         ljSFi0IBB4nM+H0uFVQ7yBKX1DL4f3uDlf7Zdm8n31wttW7QLcb2fBYQDIGSJdkxVeRH
         V45g==
X-Gm-Message-State: AO0yUKXncRfoXjnX2Du9EwerB+gmKzc8A1l1oA6XvGnndGvXOseB0LtS
        nkHlguvGk1fEqEWJwIvGYk0=
X-Google-Smtp-Source: AK7set9BwUlHaYRPfAPcG0/UsepGF0Z9Nh7tra0KQq7Vj5aViVMOgzxaUXssatgNJ9a+KACnB07dYQ==
X-Received: by 2002:a17:902:db05:b0:19d:90f:6c50 with SMTP id m5-20020a170902db0500b0019d090f6c50mr24400422plx.58.1678330813641;
        Wed, 08 Mar 2023 19:00:13 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kc12-20020a17090333cc00b00196217f1219sm10463350plb.70.2023.03.08.19.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 19:00:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v3 1/2] t1092: add tests for `git diff-files`
References: <20230307065813.77059-1-cheskaqiqi@gmail.com>
        <20230309013314.119128-1-cheskaqiqi@gmail.com>
        <20230309013314.119128-2-cheskaqiqi@gmail.com>
Date:   Wed, 08 Mar 2023 19:00:12 -0800
In-Reply-To: <20230309013314.119128-2-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Wed, 8 Mar 2023 20:33:13 -0500")
Message-ID: <xmqqlek6pr2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> +	! test_file_not_empty sparse-checkout-out &&

If you looked at existing uses of this test helper, you probably
wouldn't have written this.

    $ git grep -e test_file_not_empty t/t[0-9]\*.sh | wc -l
    34
    $ git grep -e '! test_file_not_empty' t/t[0-9]\*.sh | wc -l
    0

This is because test_file_not_empty is designed to fail loudly with
a complaint when the given file is empty.  Its implementation reads
like so:

        # Check if the file exists and has a size greater than zero
        test_file_not_empty () {
                test "$#" = 2 && BUG "2 param"
                if ! test -s "$1"
                then
                        echo "'$1' is not a non-empty file."
                        false
                fi
        }

In the successful case in your test, you expect the file to be empty
(I didn't check if it should be empty or not---I am just taking your
word for it).  It means that the "! test_file_not_empty" is expected
to keep complaining that it is NOT a non-empty file.

Not very nice, no?

Perhaps test_must_be_empty is what you wanted to use.

> +	! test_file_not_empty sparse-index-out &&
> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	! test_file_not_empty sparse-checkout-out &&
> +	! test_file_not_empty sparse-index-out &&
> +
> +	# file present on-disk with modifications
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git diff-files &&
> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	test_file_not_empty sparse-checkout-out

Now, are we happy if the file is not empty and has any garbage in
it?  Don't we know what the list of different paths are and what the
common output between the two should look like?

In general "as long as it is not empty, any garbage is fine" is a
poor primitive to use in tests, unless (1) we are testing output
that is deliberately designed to be unstable, or (2) we know the
program that produces output will always show an empty result when
it fails in any way.

> +'
> +
>  test_done

Thanks.
