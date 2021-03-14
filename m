Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582AAC43381
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E6764EEE
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhCNQzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:55:40 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:34092 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233977AbhCNQzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 12:55:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 6CF2DDB4;
        Sun, 14 Mar 2021 17:55:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615740913; x=1617555314; bh=IPruyQ1PWTsDjE//YwH
        vI+dhSh+OYH35Ej+wb61WaGo=; b=ZZ67vd+AhTEgIP8pKg7lekarfcP8w1XiVKd
        RMiGve8oOwaBHIAEHAG0E/Tu9yIaZOkTnmz453i1IiRXIaqgPaNtyCDPQDrDgM7H
        Qte17glm9NU3RPDQ6oL281/pbdWB86Da4Ewzg/NTOiDohlgaG84bdmpt1bPnzS2R
        TME9aaWcN6q6F0aCeMCpZCd0V8MI5U4CqtqUdAOjSZ+5ON0CLMy5fsprM27cdFBY
        kG+MfocoJzMt6UMLwWUlrAdWQ/nqec/w0SP06RE2hvdo08X+NVwBv6n5LgWqfec3
        ADUsDEXKKWv4pWWJsogbPX1Cr1dI1/HJrrLR24Y2X7ue/TkIn2vHw25eHf0wWPe1
        5jeIhWLHsNgKX9MlU2ZPfHLFVBW6FVcwh6mb9AMtTPV81LhDY47eg4Ht2qEzeidK
        BKUnmgrCkIb+mQ/4wPx0B3EGrjVizd6GMIyReRKeS6DpMQmq1ZkGBwGVTPf/7NQp
        VO6CN3fIiX7iNcaNEZ5jj9wNvr4DHzfYr+LdrMF8GJ2cyGKnyJJnzKRlmfUYLqRQ
        wE4ZA+GknWc6N7ugj18Hyvz4J+rwRnW5Vl7jJnUcKry/9Flk4nSJEdr/aJL8orbA
        DR7/KZ8bpnKUYzXJbbHiQkog1UQjTQigrlS1rF8BtV9KlHqKlWDbJdVUHwfaQ3U2
        jr7lXaU0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iVNtAYXh7_hc; Sun, 14 Mar 2021 17:55:13 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 79D70B00;
        Sun, 14 Mar 2021 17:55:13 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id EA168B1F;
        Sun, 14 Mar 2021 17:55:11 +0100 (CET)
Subject: Re: [PATCH 0/7] Fix all leaks in t0001
To:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <xmqqk0qh5v7v.fsf@gitster.c.googlers.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <a36441d6-4d9d-1cee-9227-272d5332f889@ahunt.org>
Date:   Sun, 14 Mar 2021 17:55:09 +0100
MIME-Version: 1.0
In-Reply-To: <xmqqk0qh5v7v.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2021 19:57, Junio C Hamano wrote:
> "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> hand: fixing or suppressing these leaks should make it easier to spot leaks
>> that have more significant user impact (it's entirely plausible that no real
>> impactful leaks exist).
> 
> Even if there is no leaks that matter exist now, to help maintain
> that state, suppressing false positives would be useful, provided if
> such checkers are run sufficiently often.

Expanding on my thoughts in response to Peff's comments regarding 
running leak checking under ASAN: I'm wondering whether it would be 
acceptable to piggyback leak-checking on top of the existing ASAN test runs:

- It looks like people are already running tests with ASAN from time to
   time - enabling leak checking there would add leak-checking coverage
   without having to run LSAN separately (this would have to be
    restricted to those tests that are leak-free - more on that below).
- I also saw some discussion around enabling ASAN in CI, although I
   don't think that went anywhere yet [1]. I'd be interested in trying to
   pick that up - ASAN seems quite valuable by itself, and running it
   in CI would be a simple way to also get leak-checking in CI.
   (Again, this would have to be limited to known leak-free tests.)

(I'm planning to run some benchmarks to see how much enabling 
leak-checking with ASAN actually costs - I'm assuming it's fairly cheap 
if you're already running ASAN, but I'd like to verify that.)

As to the mechanics of enabling leak-checking with ASAN: test-lib.sh 
currently completely disables ASAN's leak-checking. Instead we could add 
a simple allowlist, to enable leak-checking for those tests that don't - 
Fix LSAN crashleak - this needn't be much more complex than:

  $TEST_NUMBER <= highest_leak_free_test

I.e. something like this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a65..cf9f1ad827 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -41,7 +41,13 @@ GIT_BUILD_DIR="$TEST_DIRECTORY"/..
  # the noise level. This needs to happen at the start of the script,
  # before we even do our "did we build git yet" check (since we don't
  # want that one to complain to stderr).
-: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
+if test $TEST_NUMBER -le 10
+then
+    DETECT_LEAKS=1
+else
+    DETECT_LEAKS=0
+fi
+: ${ASAN_OPTIONS=detect_leaks=$DETECT_LEAKS:abort_on_error=1}
  export ASAN_OPTIONS

  # If LSAN is in effect we _do_ want leak checking, but we still

(This would also require moving TEST_NUMBER a bit earlier in
  test-lib.sh.)

[1] 
https://public-inbox.org/git/20170710155831.3zxijp7bvbquvlau@sigill.intra.peff.net/
