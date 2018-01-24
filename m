Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFBF1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeAXWDw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:03:52 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43528 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932249AbeAXWDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:03:51 -0500
Received: by mail-wm0-f52.google.com with SMTP id g1so11138191wmg.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=jbxGEvDqkI94eKxe2ijWTDB6XYKw6GR+FcPlMLB3vIs=;
        b=EdKNmpgZC0AK0B1p7iP7HiY7wWKgv8nrcZcAC0p1J9JW1pMlOp1/QodRp4rFX9h5l+
         PdD0gN+5zF7JN0bfQbvmJSfSq/hiMMytaQCrnDI+Let7gOA420sdNPdd0ioPpuK/7z/w
         41xaYo2fIaPIeFf7hKf7Y1F6FmHPNjyZ3v2GyQTCLeQJmUmnfsGnFqYA06uNbEJpJwLr
         jyKKJ81bpEGqUEPMj4lOszIAjBR1DJNW7wqcJRo4nmDNz20OnYMp/fryd5rlTjeSw0jV
         b7eMzIZBuhfnhQg12/NtW/OcIwdT5xprc5sT21n8+dK9t0h9h315ywRgvvvNyRQ8PNrZ
         JpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=jbxGEvDqkI94eKxe2ijWTDB6XYKw6GR+FcPlMLB3vIs=;
        b=dZcR8nN983RTIsciAxSbNb+zNXylM4IZDfKtmRpgmOn/XzyL5qsgpELVjjEzFq5GCf
         XG9U6FGqHOIzIROX+cPznMNLGF988+ztCpkqyV4oEfv8S2ZFV68Gja46UfmMgbmyDOmG
         v3zMp6XjvWB1Fna5FqWvD1c+rLCVhXUCCC60sfutm1X+39/KrKtzubc743/gcozfl5I7
         SPd7gy+KT1zkHs3LUK3TxJIe9ugXNeA2xsK7UBOjyGSs4mPfDCMiqJyosVhsD5Fn6BN+
         FfhCBghbWWXXtkvX8M83SGouTI1dsNaPhfnJEqQzzSHyzfTRGw5yJjt10edFsxynvMxM
         Icyg==
X-Gm-Message-State: AKwxytfFObc++K1WpYBGQ2Mzt1UNpjQkSloW9xGuz/nZ8x14prHkzYE9
        aBD9TlddcTWrQbtjaJ0zvnQZBfi3
X-Google-Smtp-Source: AH8x226HK+j09qoJnONrCvSxnLm1qVqknp1p8UehSSeU9glNymiEZCWZRzKhityIqnXmBO/hbMoR4w==
X-Received: by 10.28.114.3 with SMTP id n3mr5802356wmc.124.1516831429737;
        Wed, 24 Jan 2018 14:03:49 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z71sm4297966wrc.11.2018.01.24.14.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 14:03:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Git packs friendly to block-level deduplication
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
Date:   Wed, 24 Jan 2018 23:03:47 +0100
Message-ID: <87bmhiykvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have a bunch of git repositories cloned of the same project on
the same filesystem, it would be nice of the packs that are produced
would be friendly to block-level deduplication.

This would save space, and the blocks would be more likely to be in
cache when you access them, likely speeding up git operations even if
the packing itself is less efficient.

Here's a hacky one-liner that clones git/git and peff/git (almost the
same content) and md5sums each 4k packed block, and sort | uniq -c's
them to see how many are the same:

    (
       cd /tmp &&
       rm -rf git*;
       git clone --reference ~/g/git --dissociate git@github.com:git/git.git git1 &&
       git clone --reference ~/g/git --dissociate git@github.com:peff/git.git git2 &&
       for repo in git1 git2
       do
           (
               cd $repo &&
               git repack -A -d --max-pack-size=10m
           )
       done &&
       parallel "perl -MDigest::MD5=md5_hex -wE 'open my \$fh, q[<], shift; my \$s; while (read \$fh, \$s, 2**12) { say md5_hex(\$s) }' {}" ::: \
           $(find /tmp/git*/.git/objects/pack -type f)|sort|uniq -c|sort -nr|awk '{print $1}'|sort|uniq -c|sort -nr
    )

This produces a total of 0 blocks that are the same. If after the repack
we throw this in there after the repack:

    echo 5be1f00a9a | git pack-objects --no-reuse-delta --no-reuse-object --revs .git/objects/pack/manual

Just over 8% of the blocks are the same, and of course this pack
entirely duplicates the existing packs, and I don't know how to coerce
repack/pack-objects into keeping this manual-* pack and re-packing the
rest, removing any objects that exist in the manual-* pack.

Documentation/technical/pack-heuristics.txt goes over some of the ideas
behind the algorithm, and Junio's 1b4bb16b9e ("pack-objects: optimize
"recency order"", 2011-06-30) seems to be the last major tweak to it.

I couldn't find any references to someone trying to get this particular
use-case working on-list. I.e. to pack different repositories with a
shared history in such a way as to optimize for getting the most amount
of identical blocks within packs.

It should be possible to produce such a pack, e.g. by having a repack
mode that would say:

 1. Find what the main branch is
 2. Get its commits in reverse order, produce packs of some chunk-size
    of commit batches.
 3. Pack all the remaining content

This would delta much less efficiently, but as noted above the
block-level deduplication might make up for it, and in any case some
might want to use less disk space.

Has anyone here barked up this tree before? Suggestions? Tips on where
to start hacking the repack code to accomplish this would be most
welcome.
