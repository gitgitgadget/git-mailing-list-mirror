Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D71E20248
	for <e@80x24.org>; Sun, 10 Mar 2019 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfCJKDn (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 06:03:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfCJKDn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 06:03:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so1903945wrm.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 03:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cj9sndwKB1UMy3pYDTl1R6BBVNnX/Uufk0D8F49Twlc=;
        b=jfqd1+ZbMgeFI3qXYcz0tTfnlI89oXiW/O3gOsy9stGRUy15ccAZvqroyRY7KE4xvu
         WihC599+oS8PXmqbdZkYFIUnZccCirqbmpvkwDhMxk8KiJJwaK5MgjqXnll1htNu/7Bo
         RrFJzceEYudWU6WdeA5obTuDrIes8OZgukWEn0Y0OtfnqgOjCTP9IPLD/0J3zxnBe+Zb
         lnwWYOTz+8e9Wwyr3HXvMFFCvSNOUSsrZlvldEWIqzg1rFfvlYOx74Ixwb38E5ObIwDE
         i7/R+mYxaqoaPhWsz+bK/ax+Z0PPDq5L65XPeehFe0ipIrdt5vrYmkoID+GMd0hW/+8L
         ZKMQ==
X-Gm-Message-State: APjAAAWKQycCJe3Yj/9VNMhsGYDwHR5tZgE2VXA3r33FNJAjzVnLi2bz
        cF6+y8mQ3NC36vD3FMtHs9w8QLvNz9XKnZFmEbY=
X-Google-Smtp-Source: APXvYqzuw+/Inm/Ah2pnPmjfwZnehHfSAwTdhCLT+HarYgsFc4oWslbdAY7HbQNMWCod1Y9TxiFd5W2K8vQdoCGNXVs=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr16430679wrg.217.1552212221681;
 Sun, 10 Mar 2019 03:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190310080931.64134-1-ttjtftx@gmail.com> <20190310081023.64186-1-ttjtftx@gmail.com>
In-Reply-To: <20190310081023.64186-1-ttjtftx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Mar 2019 06:03:31 -0400
Message-ID: <CAPig+cQxVfZ7L=cFfgAWOzL7Equ2HsFR7si=GxBxj3-mSpCUnQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 4/5] t0022-crlf-rename: avoid using pipes
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 4:10 AM Jonathan Chang <ttjtftx@gmail.com> wrote:
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.
>
> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

All of the patches in this series are malformed. There should be a
"---" line right here below your sign-off. The "---" line is
recognized by git-am/git-apply as separating the commit message from
the actual diff(s).

> diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
> @@ -23,10 +23,10 @@ test_expect_success setup '
>  test_expect_success 'diff -M' '
>
> -       git diff-tree -M -r --name-status HEAD^ HEAD |
> -       sed -e "s/R[0-9]*/RNUM/" >actual &&
> +       git diff-tree -M -r --name-status HEAD^ HEAD >actual &&
> +       sed -e "s/R[0-9]*/RNUM/" actual >output &&
>         echo "RNUM      sample  elpmas" >expect &&
> -       test_cmp expect actual
> +       test_cmp expect output

It is a very well-established custom in Git tests for the files handed
to test_cmp() to be named "expect" and "actual", so this change is not
the most desirable. What you can do instead is:

    git diff-tree -M -r --name-status HEAD^ HEAD >output &&
    sed -e "s/R[0-9]*/RNUM/" output >actual &&

which allows you to leave the test_cmp() line alone, thus (as a bonus)
makes the patch less noisy.
