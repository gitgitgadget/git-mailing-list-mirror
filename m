Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4879CC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjFGKm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjFGKmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:42:12 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F71FD5
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:42:06 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5689335d2b6so76381847b3.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134525; x=1688726525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8o+emfCOUVDPDpu7vdkZVw2FhYfkyaTLjACxTMDB1N0=;
        b=MO4V8nxZ9LHSQK6AEDhO3rbvFys304p+Rd2AHgvfwmrdMoIde9nBdYJjPM/XHgPQOs
         tDuRgmoE2v4BXYo1+KKaTA6MQUegVoXc+uVhVBmIGvCbb9+jZ2zZcyHOeSuKtNx/nR7Y
         nIBrKH44tU8IoxY/LqdQPLrLRYq6BEp6f/P8BwRH9I/Qe7ADg1kxuDwsTYhi8PwHulUT
         KM3Q1Pt5tA2VcIhLEGq3+kt8aphNw8cxp11D8rPAdkILizpSh0wucJeevFS6aP3fmgUf
         ZzZFoJHSoJlMWIqgKRE7tpX4hPUrFUyDeuPaf1kZAubCAocWtTjkWrFxTHqpXXMQz0jq
         WFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134525; x=1688726525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8o+emfCOUVDPDpu7vdkZVw2FhYfkyaTLjACxTMDB1N0=;
        b=ZubPXJ+7p0H61TN3aU0AKVfSgowiIoWU6J8VkWl7sNXb3ocVHblRnKtYf9479vG7h0
         fqaXi6fWXkFjKdwT6OdozIAlGgHCF0nSvZf99qv2qGoMDyNbu6f6N3andKfrJFpN1kn8
         BKfC1f6VRA6c1dDGCIXlfYm24TEF1ftNAdbJbBbGs+Wcm06JXkEWsyZCy3ypEOGihWPx
         63FDdXj19okrPgcvfZVl2i1vAURFOyGf5yuNUHO+q9jG5aIVMfNDBjJroyuBJ1CQ+I2K
         4dYD1Ktp1GBwnowRHAri07C+YGsTlSILnG+v9LOhGbbZC1y42smukazmX+tGt3sFEcOp
         zj+Q==
X-Gm-Message-State: AC+VfDwfTwRZ4FaXmhzAa8aImc5uT+k1obohpMJALMHb8x+ZeEQGEFHX
        oudg0TKo+UFV/HZ00w5qx/jfm4D2N2n5Bw9HfpomVe7G
X-Google-Smtp-Source: ACHHUZ6Q/O3nLCtZsf61mdtDtO7LgBVNOj/VFepKMhw5SgNMc9mAsffGy8AHNKeStFFrk09dXgEaSg==
X-Received: by 2002:a0d:e296:0:b0:565:c7dd:95b9 with SMTP id l144-20020a0de296000000b00565c7dd95b9mr6066312ywe.12.1686134525098;
        Wed, 07 Jun 2023 03:42:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5-20020a81d245000000b005694b0ae1c6sm4667506ywl.126.2023.06.07.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:42:04 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:42:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 14/16] builtin/receive-pack.c: avoid enumerating hidden
 references
Message-ID: <1db10b76eaa4054fb0c065fe4e15449f07e3d1c5.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
index 1a8472eddc..bd5bcc375f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -337,7 +337,8 @@ static void write_head_info(void)
 {
 	static struct oidset seen = OIDSET_INIT;
 
-	for_each_ref(show_ref_cb, &seen);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
+				 hidden_refs.v, show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
-- 
2.41.0.16.g26cd413590

