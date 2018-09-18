Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C61D1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 00:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeIRFqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 01:46:47 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43170 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeIRFqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 01:46:46 -0400
Received: by mail-qt0-f182.google.com with SMTP id g53-v6so126675qtg.10
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 17:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uw6VhvT8JpUjo81wQQLtPjIxB0PcIKIOhsUM9qxFxU0=;
        b=l0yrzA192JCYsf8lXxnUvvHikkzPITaSEWdI2BPfiGsusvA83R/HI09CsxUVnML5GQ
         wiRVGSqIscEPhwDlm9JWCjakwPaKAqglN3xza1iopqHTAYc4IEZ/gMzz1WzThYQZX2gq
         55xUrx0HNcMWRDqbGhAFjl/tYwlPvOAON/0LsNo70/ZUjEDKrconpe09iMMrX5i2z17q
         QEh1VU0I8tG4pvnIDwnQwVQCVTP9MfkE0ZvrKnXf5XhMrJpgMlfsb+7LoSjq2WuEs0tT
         YW3au6rDG1mHKAI3vSdocQRtvruYj21zYxFDc2DDBy4ocEr1W4Qtih/fMe09ZuODttOk
         XrKw==
X-Gm-Message-State: APzg51BNeODUDqHEgc32+aD9oT9hi+Tk0sdmbTxqVp3HBfOpfzEMSPro
        RNoDNhs5glwcFvlz26kWi6NIBNaJabpzU/0Ti/s=
X-Google-Smtp-Source: ANB0VdYBUImxkJUEr62fHfqpY0eI1cfhZScnaAXZ0x1Qvz+Hd3CxLGYaTqi4Ijvh6IxprYN0NiAFoZyyv81tWnBOzDI=
X-Received: by 2002:a0c:e292:: with SMTP id r18-v6mr19783500qvl.62.1537229818230;
 Mon, 17 Sep 2018 17:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com>
In-Reply-To: <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Sep 2018 20:16:46 -0400
Message-ID: <CAPig+cSzddcS+8mx=GMbJ5BP+=fPtza+7UdA5ugN+83NuOHyiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] CodingGuidelines: add shell piping guidelines
To:     matvore@google.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:24 PM Matthew DeVore <matvore@google.com> wrote:
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> @@ -163,6 +163,35 @@ For shell scripts specifically (not exhaustive):
> + - In a piped sequence which spans multiple lines, put each statement
> +   on a separate line and put pipes on the end of each line, rather
> +   than the start. This means you don't need to use \ to join lines,
> +   since | implies a join already. Also, do not indent subsequent
> +   lines; if you need a sequence to visually stand apart from the
> +   surrounding code, use a blank line before and/or after the piped
> +   sequence.
> +
> +       (incorrect)
> +       [...]
> +       (correct)
> +       echo '...' > expected

Existing tests seem to favor the name "expect" over "expected", so
perhaps use that instead.

    $ git grep '>expect\b' -- t | wc -l
    2674
    $ git grep '>expected\b' -- t | wc -l
    1406

> +       git ls-files -s file.1 file.2 file.3 file.4 file.5 |
> +       awk '{print $1}' |
> +       sort >observed

This is not a great example since it flatly contradicts the very next
bit of advice added by this patch about not placing a Git command
upstream in a pipe. Perhaps come up with an example which doesn't
suffer this shortcoming.

I've seen the advice earlier in the thread of not indenting the
sub-commands in a pipe, but I find that the result makes it far more
difficult to see which commands are part of the pipe sequence than
with them indented, so I'm not convinced that this advice should be in
the guidelines. (But that just my opinion.)

> + - In a pipe, any non-zero exit codes returned by processes besides
> +   the last will be ignored. If there is any possibility some
> +   non-final command in the pipe will raise an error, prefer writing
> +   the output of that command to a temporary file with '>' rather than
> +   pipe it.

It's not so much that we care about losing a non-zero exit code (which
might be perfectly acceptable depending upon the context) but that we
care about missing a Git command which outright crashes. So, it might
make sense to make this text more specific by saying that ("exit code
indicating a crash" and "Git command") rather than being generic in
saying only "exit code" and "command".

Also, what about expression like $(git foo) by which a crash of a Git
command can also be lost? Do we want to talk about that, as well?
