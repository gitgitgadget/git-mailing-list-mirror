Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900781F42D
	for <e@80x24.org>; Mon, 28 May 2018 14:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161579AbeE1OZt (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 10:25:49 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36345 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161843AbeE1OZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 10:25:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so5251797wrm.3
        for <git@vger.kernel.org>; Mon, 28 May 2018 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=omH2qDlmhuzwuotFAH8MlLvcPTkYFcIdo67K852ia5g=;
        b=bOqQTswOrgAhPgaNv6CUhExnthXp83sYKEKvLd/DPkk5PCDAlxog94LMHV/DrBxt4o
         3YWTK+Q2b4jE9HdBSyh9KKn4nUjNZSjTH0qI1zleQX9UT6A057gZHfjsT9EJ3H2/iwq3
         ut8VFKd7l1qVcCTAIjKNX9z9s8QvhBoXb5qORlMGngbd7SDoTQphFkIdARhdo/jeBtJN
         Gbra52JFleK39Uxc9oHXHRNH76uK/+SmssYR80YUVNF4bnAuiLxcOeyhWtdHwM1SlBCV
         T9VdFAX9ISDP2GpYzDIx9LaSsnEdCkp9jjdKsX7ZBd36/F3fTd6yPgUL+DCziluXXjMM
         F9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=omH2qDlmhuzwuotFAH8MlLvcPTkYFcIdo67K852ia5g=;
        b=cqKoAbjJAIwynPRcd0Bqp8XwGoDcxILyRHdYlIDLUghg6LcbOSNWtQpNybC0/4VdGU
         FNBFu8fqbzMKYOESkM4tUOlcv4Jsq/Yew612a2vTIE/cMwCK+ri86a8LrQrMJHTLOiSX
         akzCB0mg2FdxANHjED7bU3JlmVzNfOFrEH3zI+W7e4sVvdimlt97SPum6cpJSqnsoAkH
         q2kkWwfec53C0hLGtj/Jfpb4HkMmLKtW07uVfHVktR9/WG0tc0lqqCMR0d9TwFhkszNm
         HP6hHc94JLwAO4Kb0uhRSXFQ+AT8Aya23uNaASriYmCN3oYuzVgBHb/9xzzhchtMRwHf
         3etQ==
X-Gm-Message-State: ALKqPwfh/1uo/+otR5XGO2fFmLX003yqgVaWPy3Iv1Na3L4lMurD3olA
        2OSMF8/XzgQOV65jisEgk/Y=
X-Google-Smtp-Source: AB8JxZrrxbvn9A+bmt/bTRkzYLG5060zkWGsi9Z+KdW38fLhKzAsh01jGCaBJtfwcOFwVeh4lY+wGA==
X-Received: by 2002:adf:b297:: with SMTP id g23-v6mr10087450wrd.218.1527517545466;
        Mon, 28 May 2018 07:25:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a8-v6sm19331816wrc.18.2018.05.28.07.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 07:25:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v4] Implement --first-parent for git rev-list --bisect
References: <20180528092017.19022-1-tiagonbotelho@hotmail.com>
Date:   Mon, 28 May 2018 23:25:44 +0900
In-Reply-To: <20180528092017.19022-1-tiagonbotelho@hotmail.com> (Tiago
        Botelho's message of "Mon, 28 May 2018 10:20:17 +0100")
Message-ID: <xmqqpo1fj1qv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> This will enable users to implement bisecting on first parents
> which can be useful for when the commits from a feature branch
> that we want to merge are not always tested.
>
> Signed-off-by: Tiago Botelho <tiagonbotelho@hotmail.com>
> ---
>
> This patch adds all Junio's suggestions, namely do_find_bisection() being
> broken when assigning q's weight to p if in first parent mode and q being
> not UNINTERESTING and its weight still not being known.
>
> The graph displayed in the unit tests was also changed from being top-bottom
> to be left-right in order to keep it consistent with graphs in other tests.
>
>  bisect.c                   | 45 ++++++++++++++++++++++++++++++---------------
>  bisect.h                   |  3 ++-
>  builtin/rev-list.c         |  3 +++
>  revision.c                 |  3 ---
>  t/t6002-rev-list-bisect.sh | 37 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 72 insertions(+), 19 deletions(-)

> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index a66140803..774d9a4fd 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -263,4 +263,41 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
> ...
> +test_output_expect_success "--bisect-all --first-parent" 'git rev-list --bisect-all --first-parent FX ^A' <<EOF
> +$(git rev-parse EX) (dist=1)
> +$(git rev-parse D) (dist=1)
> +$(git rev-parse FX) (dist=0)
> +EOF
> +
>  test_done

Running this test number of times gives me spurious errors.  Is the
order of these output lines unstable?  How do we "sort" these
bisect-all results?  If we are not sorting and the output depends on
happenstance, then probably we would need to compare the expected
and actual output after sorting.  Or if the output depends on
something under our control (e.g. they are related to topology and
relative commit timestamp), we probably should try to control that
"something" tighter so that we can rely on the order of the lines in
the "expect" file.

It also appears that we have "--bisect and --first-parent do not
work well together" in t6000, which also needs to be updated.  I
needed the following squashed into this patch to make "make test"
pass.

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 969e4e9e52..981198ae6e 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -96,8 +96,8 @@ test_expect_success 'rev-list can show index objects' '
 	test_cmp expect actual
 '
 
-test_expect_success '--bisect and --first-parent can not be combined' '
-	test_must_fail git rev-list --bisect --first-parent HEAD
+test_expect_success '--bisect and --first-parent can now be combined' '
+	git rev-list --bisect --first-parent HEAD
 '
 
 test_expect_success '--header shows a NUL after each commit' '
