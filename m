Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C2C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB7764E4E
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGOjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGOjV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 09:39:21 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25268C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 06:38:41 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d7so9474830otq.6
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 06:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dLJftGDaTepuKg/4jLvajFz3T4KngFWThWjvjqkTDkI=;
        b=KcgkQiRRkG5kWx45fkWKgYQoRcp+g3R9onLY+3lP9Ls0jjYxbrU6K5lpRf2yeaB/dF
         3sGQJzXOQy5WXojXTqFtkIJZ+tBpVajjHmdC58NxJQx8YIBwnZFFA0HhQRMIw5GxcXbE
         K8LK3C1hD6EUjcgS5NhzUB0LFaWnskX+rPAjJUnP2qeKnYFbSc9gu2QOHk+YJYsTXSbg
         HXfNf0CGa0uVR9kIPE3ObMbmj/k/GZeXKpD0C/OwoRdPemFChY0vnTGmdGrvXXSkwRDK
         UN81B8rcfpuG7GJAoddsJIY+I+0GNEp0FBGT/aDExAkYnYtKHLsoZPY4mqEPpf0qS1Fs
         Orzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLJftGDaTepuKg/4jLvajFz3T4KngFWThWjvjqkTDkI=;
        b=VnQD34TG3arTI/qFFjp5VHOLhtQsOBedvqbL3OYdxOhmU1zxQJlVHaLy425YPwfmSx
         6yZVzDyBz1XHCequaQR8A0k/0FPyXrYORaLnuUn6nJGw8jY9jPl8C2wEeg71frBZTP9B
         VtapF1+cGF687GfPOTKFox5mQsEvZRtbebp4e+8yatHxO+51HpjJaLZ9h6Jpbt9TBD5Y
         L8cNyN3wloW1o2sFRfMpw0qE8QA4kfwuA3Z6eacdArJ+Z3+loPvfyv46VrbBbuJan63i
         fj9Hi71CumaUxe8wFMZ1HA7rnEU+TVQjphECm8nDtJX5nc+FMPGIpdNaDWSYeJKBqqeg
         8tuQ==
X-Gm-Message-State: AOAM531cFw3t8OANr98fNSJ7NIkotF8GKa2sgJKzNk0xmZTXDv80mUf6
        nTjqIPGtQ9EXu2YiqoMkSH2pbWoSnd77Tg==
X-Google-Smtp-Source: ABdhPJx7cT0WPzJITEeY4jBtg5wD722fTDYWttnxfJFznaCVomS2DmFzWsnOvmp0uGZTBMGzHIlsEg==
X-Received: by 2002:a05:6830:131a:: with SMTP id p26mr9235983otq.134.1612708720058;
        Sun, 07 Feb 2021 06:38:40 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:45c1:3f2d:a11c:fe19])
        by smtp.gmail.com with ESMTPSA id x11sm765790oif.39.2021.02.07.06.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 06:38:39 -0800 (PST)
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
Date:   Sun, 7 Feb 2021 09:38:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/21 5:52 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Make use of the new find_basename_matches() function added in the last
> two patches, to find renames more rapidly in cases where we can match up
> files based on basenames.

This is a valuable heuristic.

> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28),
> this change improves the performance as follows:
> 
>                             Before                  After
>     no-renames:       13.815 s ±  0.062 s    13.138 s ±  0.086 s
>     mega-renames:   1799.937 s ±  0.493 s   169.488 s ±  0.494 s
>     just-one-mega:    51.289 s ±  0.019 s     5.061 s ±  0.017 s

These numbers are very impressive.

Before I get too deep into reviewing these patches, I do want
to make it clear that the speed-up is coming at the cost of
a behavior change. We are restricting the "best match" search
to be first among files with common base name (although maybe
I would use 'suffix'?). If we search for a rename among all
additions and deletions ending the ".txt" we might find a
similarity match that is 60% and declare that a rename, even
if there is a ".txt" -> ".md" pair that has a 70% match.

This could be documented in a test case, to demonstrate that
we are making this choice explicitly.

For example, here is a test that passes now, but would
start failing with your patches (if I understand them
correctly):

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index c16486a9d41..e4c71fcf3be 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -262,4 +262,21 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 	grep "myotherfile.*myfile" actual
 '
 
+test_expect_success 'multiple similarity choices' '
+	test_write_lines line1 line2 line3 line4 line5 \
+			 line6 line7 line8 line9 line10 >delete.txt &&
+	git add delete.txt &&
+	git commit -m "base txt" &&
+
+	rm delete.txt &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			  line6 line7 line8 >add.txt &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			  line6 line7 line8 line9 >add.md &&
+	git add add.txt add.md &&
+	git commit -a -m "rename" &&
+	git diff-tree -M HEAD HEAD^ >actual &&
+	grep "add.md	delete.txt" actual
+'
+
 test_done

Personally, I'm fine with making this assumption. All of
our renames are based on heuristics, so any opportunity
to reduce the number of content comparisons is a win in
my mind. We also don't report a rename unless there _is_
an add/delete pair that is sufficiently close in content.

So, in this way, we are changing the optimization function
that is used to determine the "best" rename available. It
might be good to update documentation for how we choose
renames:

  An add/delete pair is marked as a rename based on the
  following similarity function:

  1. If the blob content is identical, then those files
     are marked as a rename. (Should we break ties here
     based on the basename?)

  2. Among pairs whose content matches the minimum
     similarity limit, we optimize for:

     i. among files with the same basename (trailer
        after final '.') select pairs with highest
        similarity.

    ii. if no files with the same basename have the
        minimum similarity, then select pairs with
        highest similarity across all filenames.

The above was written quickly as an attempt, so it will
require careful editing to actually make sense to end
users.

Thanks,
-Stolee
