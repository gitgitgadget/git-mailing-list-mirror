Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B482C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455F923A62
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbhAHSU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbhAHSUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:20:25 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC7C061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:19:56 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 186so9292804qkj.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bveQcunOJkxSCT3zv0ontAMC0dujyoOjcNk+R3hSVE4=;
        b=joxlJNzGDQU8Hiw36aXpscHv5pSxpay1SqxBWejTu74TQNZhwPJD3Wny6sz5oyDDDd
         sBDuGakAMHSpkxnZbxyRjl4xfAzZQR75zVw+pzXlUSZLXB144zwLL7cKEV3aCO86HZyQ
         Cke1ZwtDhhTNvuig0pyYqeupTWBlbeLK30rEGWWOyOOXn2cwweV9almfizPeWhyx96lB
         VyFzF5iryJ45c/0IoGFnBfW5js5+5vc/cY79EgD1Qjtb7yadiY1wWynq5w3ozNzos84H
         GNLuYqz/QwfSIwL+Xo5Mq3ZxetZFsu86bpJRweQaDJbQZq6gTCfRKQUWmgALTJFkMcjN
         dTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bveQcunOJkxSCT3zv0ontAMC0dujyoOjcNk+R3hSVE4=;
        b=UJ1T4RZmdRpS0YbRTT5miHyhz4M865BzhTob8n0UuzTvr4qZxBjHIPfgpjBdj3odMS
         fUnRGw4wR0C6+7Aw35kbahJVr2z9rclQ6l+xM359ZxZrVGuFl+Kz8McmQpmWF0dvy52F
         kU+Pcx+TFimLxnk21tCs1AqyFn8eyfd0j//avbnYpO0rOwilFUeWYGsy5WPMkSbEubbj
         Ua26tH/dKyUtsG/iP/hQ/d8TUP6Yd6/pexb7/Rg7/YD7jDdZZ+NpFd3/nqUirfHe3VHE
         Zip7JRr75c/8sYkkj3Ag+o1/WM4qW1rTyDCFEvNH64g4BuBect0hAd0MSU/B5F1BvT3S
         n3mA==
X-Gm-Message-State: AOAM532bA6i+9uplk9x9wO+wOoAecDnzFzMZ08psZjQ1ilSGpI8XhQsQ
        Mu+dWbRsjWPZe5B8xuhR/SDcdksyBmpzog==
X-Google-Smtp-Source: ABdhPJwxayLSuHjbe4/7lnm4FK80X/uhFcmSzB44yR1PBVEjbqi9CM07zbJIrRzzrjpEUEReFg9C5A==
X-Received: by 2002:a37:e211:: with SMTP id g17mr4977848qki.298.1610129995774;
        Fri, 08 Jan 2021 10:19:55 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id v4sm4753995qth.16.2021.01.08.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:19:55 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:19:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 0/8] pack-revindex: introduce on-disk '.rev' format
Message-ID: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is the second of two series to implement support for an on-disk format for
storing the reverse index. (It depends on the patches in the previous series
[1]).

The format is described in the first patch, but it is roughly as follows:

  - It begins with a 12-byte header, containing a magic string, a version
    identifier, and a hash function identifier.

  - It then contains a 4 * N (where 'N' is the number of objects) table of index
    positions, sorted by each object's offset within the corresponding packfile.

  - Finally, a trailer contains a checksum of the corresponding packfile, and a
    checksum of the above contents.

Since this is a large change, a new 'pack.writeReverseIndex' option is
introduced, which defaults to 'false'. When false, `*.rev` files are not
written, and Git gracefully falls back to generate each reverse index in
memory. This could optionally be tied to the "feature.experimental" option, and
eventually the defalt changed to 'true' in a couple of releases.

To test these new changes, the test suite now understands
'GIT_TEST_WRITE_REV_INDEX' to mean that 'pack.writeReverseIndex' should be
'true' everywhere. Some minor test fall-out is addressed in the sixth patch
before enabling this new mode in the seventh patch.

One option that is _not_ persued in this series is to store the (pack) offset of
each object in the `.rev` file. This would at worst triple the size of the file
(by having to store an additional eight bytes per entry), and add complexity
(like storing an extended offset table as in the `*.idx` format). An extensive
discussion about why this option was not persued can be found in the first
patch.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/cover.1610129796.git.me@ttaylorr.com/

Taylor Blau (8):
  packfile: prepare for the existence of '*.rev' files
  pack-write.c: prepare to write 'pack-*.rev' files
  builtin/index-pack.c: write reverse indexes
  builtin/pack-objects.c: respect 'pack.writeReverseIndex'
  Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
  t: prepare for GIT_TEST_WRITE_REV_INDEX
  t: support GIT_TEST_WRITE_REV_INDEX
  pack-revindex: ensure that on-disk reverse indexes are given
    precedence

 Documentation/config/pack.txt           |   7 ++
 Documentation/git-index-pack.txt        |  20 ++--
 Documentation/technical/pack-format.txt |  17 ++++
 builtin/index-pack.c                    |  67 +++++++++++--
 builtin/pack-objects.c                  |   9 ++
 builtin/repack.c                        |   1 +
 object-store.h                          |   3 +
 pack-revindex.c                         | 116 ++++++++++++++++++++--
 pack-revindex.h                         |   3 +
 pack-write.c                            | 123 +++++++++++++++++++++++-
 pack.h                                  |   4 +
 packfile.c                              |  13 ++-
 packfile.h                              |   1 +
 t/README                                |   3 +
 t/t5319-multi-pack-index.sh             |   2 +-
 t/t5325-reverse-index.sh                |  94 ++++++++++++++++++
 t/t5604-clone-reference.sh              |   2 +-
 t/t5702-protocol-v2.sh                  |   4 +-
 t/t6500-gc.sh                           |   4 +-
 t/t9300-fast-import.sh                  |   2 +-
 tmp-objdir.c                            |   4 +-
 21 files changed, 463 insertions(+), 36 deletions(-)
 create mode 100755 t/t5325-reverse-index.sh

-- 
2.30.0.138.g6d7191ea01
