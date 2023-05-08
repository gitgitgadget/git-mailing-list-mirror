Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0E4C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjEHWBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjEHWAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:36 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7CC93CA
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a2691637bso76215937b3.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583232; x=1686175232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5e9AE+0n2v0CbPbkLsydiTTp1m/H7ePHit13Sy0o89g=;
        b=sS2HTpJCle+kc0cM/9VhXC3024muXNwTyEs3VM6AMU68xvX2LQ8/YKIYZrHC/r6znj
         r1iZAo1nGKTnRQIdKCa3d1YyTVUo/oWRlzBQW+BK5Fy8MvLNnlDtQEtb6oj3jECXJQXw
         j2/Gjz5EZm0IzAQvvESXhYQ8me3VQNI4yc0MihEKZB007yuU8uSEfSqRBjZ2ejjyqdbE
         8les0rv7TKIJpgkwspo2Nm3sMAA0veTSyUVlDhgnVEYnOKAJ0ZDJP3Tthd8+nf3UNopI
         HPK9PkQTdxdyEE/rtH6sPIj7MIMB6JMtv9CLXx3kv4FX/gItf5Ndq6MvjfH/8RtsDkIv
         +xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583232; x=1686175232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5e9AE+0n2v0CbPbkLsydiTTp1m/H7ePHit13Sy0o89g=;
        b=Qzhwmxn7RUb9V0ZKiHEDeVSp9ixkQobpc41jHdau7bGOzn7qP6G7srm/L1jgq31nH3
         IRrVK7rH14hBnXZ4HRGyfFh2FiM6M+Qtrf9JViNuoTZMJ9QMbb/9culdlUodQXpPeB3w
         IzjrQ10USmgA5QHW5tKedJ1sV59xKGElf9popj5AXo5JiH83KmCdhGsjoggkraCNvjZ3
         ldhBqgnJkkTz28gZCXxx1ap64KvQgzQOtV54INkbyucW5EmFPGt+Q5kP3KoebSTqv1Id
         sbmHBhpNJW1yyR650QAqy9uH7WFh/l2Hp/7Quoa4I8q2LtIqq2NqD2m4J+rYtoeWXefl
         KvWQ==
X-Gm-Message-State: AC+VfDzaVSpwRcTPqNlvXbBlWWJveAR9uWu5FljkCBOKp5+FwX6hsnuf
        E7vxPQsjWqTaHwsu/K+DoBG6u96NDHxopXVBGW88DQ==
X-Google-Smtp-Source: ACHHUZ7+FUBEjc+nBqf67+9BRDq6U/1Jr07fMBY4UuHgtaNhD4BWj0VfjXBLpwDKtbWZPAtSteoh3A==
X-Received: by 2002:a81:6008:0:b0:54f:8b56:bb3 with SMTP id u8-20020a816008000000b0054f8b560bb3mr13101365ywb.5.1683583232111;
        Mon, 08 May 2023 15:00:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l4-20020a81d544000000b0055b46dac76esm2792843ywj.116.2023.05.08.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:31 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/15] builtin/receive-pack.c: avoid enumerating hidden
 references
Message-ID: <7d3383083db80cab6ee022508c4ec0dbec698b26.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that `refs_for_each_fullref_in()` has the ability to avoid
enumerating references matching certain pattern(s), use that to avoid
visiting hidden refs when constructing the ref advertisement via
receive-pack.

Note that since this exclusion is best-effort, we still need
`show_ref_cb()` to check whether or not each reference is hidden or not
before including it in the advertisement.

As was the case when applying this same optimization to `upload-pack`,
`receive-pack`'s reference advertisement phase can proceed much quicker
by avoiding enumerating references that will not be part of the
advertisement.

(Below, we're still using linux.git with one hidden refs/pull/N ref per
commit):

    $ hyperfine -L v ,.compile 'git{v} -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git'
    Benchmark 1: git -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git
      Time (mean ± σ):      89.1 ms ±   1.7 ms    [User: 82.0 ms, System: 7.0 ms]
      Range (min … max):    87.7 ms …  95.5 ms    31 runs

    Benchmark 2: git.compile -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git
      Time (mean ± σ):       4.5 ms ±   0.2 ms    [User: 0.5 ms, System: 3.9 ms]
      Range (min … max):     4.1 ms …   5.6 ms    508 runs

    Summary
      'git.compile -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git' ran
       20.00 ± 1.05 times faster than 'git -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git'

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 064df74715..b954bcf802 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -336,7 +336,8 @@ static void write_head_info(void)
 {
 	static struct oidset seen = OIDSET_INIT;
 
-	for_each_ref(show_ref_cb, &seen);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
+				 hidden_refs.v, show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
-- 
2.40.1.477.g956c797dfc
