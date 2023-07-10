Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D6BC0015E
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjGJVNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGJVMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:48 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90733E49
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-57688a146ecso61915677b3.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023563; x=1691615563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yky4hiMB8h603Qn4mYJPfEoeCxbIkWslKnjo8LiP6xs=;
        b=KqZ4nXMaXG5cHxTO5xLic8FXUi2LMJZ1Tu9JB3qNopKUOufMhUhgIC2t7gG8pf98DO
         0Fvr9pyU6I1ldJ7mbvxUxg81ZTTaEsaBiGF9Qtqy1rZ57asEAxyJ/4Q+lmwk4npCgT6q
         bSx6n7GQ5eIfb8JF2+U8grYOdickOrHGmBbhcvlgqrxI4llW+DyDkGV4UjNMdWgLuWwy
         BqTVrr5MbYem23Kdnuly7tfilnwqlB4E435I4glJVWCeWOc7NP6oU/T1Hl/412w9p3AB
         8jB2tXjfv4RMgkDJzOL8LLyqJzbn43C3H2HRX8oDi2u2No7tHGnZrt/fGbt9T6XeMaRL
         gnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023563; x=1691615563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yky4hiMB8h603Qn4mYJPfEoeCxbIkWslKnjo8LiP6xs=;
        b=HUIcqwJiAjweb8/nCG9JLCi8OIimCLgPCjR0A99iivP/6RyU+WE5PoRRYhhzd5Ef1B
         V1+0+n3xu9g7v+3ukQ0SYC9Al4IuHVZvH4em514aggHMKoxglr/kqD5eNdhyM0QsZTdQ
         lwJhqvUkROHbBQXwMeTKCSUxWqKhQN2RGiM80eXPKAxohRxvt2b+KAup44qdXxPdkMdL
         IfLJ1uHhlVSpKlJT2MnJ9/JDCkVNcHSJwmQWUuFzvsGWca/m0Bj1yB7PeGi4aBOEooxx
         /Uo0V+pg/hwvGXwURLCd3M+gj9t+q3GOfJktm2tOnODZswaMnVSBzIiFJhHIXea7OfxG
         R4kA==
X-Gm-Message-State: ABy/qLZQFBB0onzYJruvkFFhI1t5jmmktQMotgFmlUsvuEZ+NMfuhWnv
        kQZmfU8vUvIwj7CGR4vWUtlsBCQhsOJFA9BAgyd2mQ==
X-Google-Smtp-Source: APBJJlFuIFjRSmTOy+pzpQiJaYNgmTQUTsFNxAkXoJ0rIBaLVBakHhwts91n3TIFcCMtj7GUZowR2w==
X-Received: by 2002:a0d:e208:0:b0:579:16e0:b1bf with SMTP id l8-20020a0de208000000b0057916e0b1bfmr12107665ywe.12.1689023563687;
        Mon, 10 Jul 2023 14:12:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x125-20020a0dd583000000b00579df9098e3sm190954ywd.38.2023.07.10.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:43 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 14/16] builtin/receive-pack.c: avoid enumerating hidden
 references
Message-ID: <96aada36f9b7322ea408d1a49f94e051265596f0.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
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
 builtin/receive-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56e8b4e6af4..90aedb97cc8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -339,7 +339,9 @@ static void write_head_info(void)
 {
 	static struct oidset seen = OIDSET_INIT;
 
-	for_each_ref(show_ref_cb, &seen);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
+				 hidden_refs_to_excludes(&hidden_refs),
+				 show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
-- 
2.41.0.343.gdff068c469f

