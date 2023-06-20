Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6137FEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjFTOWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjFTOWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A16172C
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:16 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57040e313c5so69932427b3.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270936; x=1689862936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3by6/czLgiueqV4iTTYEqyA+ERKqJdZTfoT+yM9FgV4=;
        b=EaYAX4MRMfAGf/nv5CuypkHEZKjXcwSp8sO4BsX/dbEjbYCDPa/hO9J8qWnjsgm8Gk
         YoPbqLWwpUW17YY0NPp2Xphvd4ZVm/uZ+BD4LXw7pnmDOA4vn2Vl1XpcC03ZMc3l1QiP
         ze/57N35dnXge9VHI8Q9GHqdXM9/sHGv7VqEmdElmW4jwNfLXW12k6XKyI+H+6T3rbE+
         J4BawXuD5QL8D/WaVdMMSa9IFuyiKp6qWd7hywgdGCHqoYIqvjZlx72lcPEdiyk+8jvY
         b9NKu3gsO42z/eYnpqc0drirGY94fFDUXjFsTszUKwg4Xg0LOezsdGsIkcN0uqaIaj2z
         f+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270936; x=1689862936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3by6/czLgiueqV4iTTYEqyA+ERKqJdZTfoT+yM9FgV4=;
        b=iQ19s6JSD5ovym5SPNo+1eysPpplFWhpw6eFoSRxCPVi0/kY2bg0EiULdICl/+G1FP
         UA5Hg4cPnxbCUqc/ynZEZhV3KrFjw0F5whCNec7jygUnkSUpUOiKGi+NpATUhgtT7D2p
         ksIXcGd3MetnyM3IDAvQ2hll8d5cPtGXwY3FUVnC6YpSt1Ovp8BKFuww7Bp6mhmMRdtH
         aNf3JrNTMz4s/oMPBTT8RUyj9zPGvY9EhS7SMgB5mVIWSM3R+mHM/B3IGB8x/l3gZU35
         M4hFXgltmZN29ZD4g2I1jrdk+AWYs17D1HygSUiUz3NGQq/aJJc3bb3RbDK7c1mLjXfu
         Gmnw==
X-Gm-Message-State: AC+VfDxpbGyAmcYAItsf4RWjfk41r6YWHxOeWCxxcUIqB0Zp6aMgDSbC
        Mvf7NETtZMB3Ca3BDnQATH/YMppsvlu4VGF/EO46JPEr
X-Google-Smtp-Source: ACHHUZ72vdRi9MBIz26rR3YVhTPj5g38o2mni+be48uAMroVjckFu0rer8Hi+R8orkqMhFcPb5dkTQ==
X-Received: by 2002:a81:a191:0:b0:56d:50a:c0bb with SMTP id y139-20020a81a191000000b0056d050ac0bbmr18720542ywg.25.1687270935950;
        Tue, 20 Jun 2023 07:22:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u143-20020a818495000000b00569e0490babsm522959ywf.16.2023.06.20.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:22:15 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:22:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 14/16] builtin/receive-pack.c: avoid enumerating hidden
 references
Message-ID: <49c665f9f8f889373570ee94f6041e8bd89076cf.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
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
2.41.0.44.gf2359540d2

