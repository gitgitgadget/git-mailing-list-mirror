Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA3C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBJco (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBBJcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050934AA4E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3249436wma.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLl3iotmEXrODFZBlyjQ/A4gBvz5d+C62Gu6s1nyDI8=;
        b=IxJFTv+b/svY6TBvT/hKybrj/jVBaQqMtCOMJd5ydMB3fa3O9gCUQZ8zENcYoWEVqo
         iRMkd7ov5SAd7MaUrOqOhT1CjYqxFmQAEwy+VtxVML3oKTdG9kGHRGdm6D/5MrkGSAJv
         /pU6N653CdtU4BRKhHGn/cthEzyfJ381ctGJojrrEfOfvMpaCOTp24GKL8u00ZfaZwKr
         QYQNAr7siwkcLMWEINhgy+CwpAs7qdwQ3FCI2dy14coaMUCmyGJ8q5J+mG7WAugOK7YW
         mGNK2/QwGRt2p6TU/V2va9957Cknae2B1A6wkmKnIf2oYvz+TJUQFS2SfdiM6N28ll2v
         4qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLl3iotmEXrODFZBlyjQ/A4gBvz5d+C62Gu6s1nyDI8=;
        b=X8ZJyB+bRU+oQjOgmbdUiII6d3ZD6pKx+sKwHtYnIwbX7GaSSAHnKgeg7kFz/NmFfi
         +EBrOogV34Q1c1tAxVfO+TEMvs97k5XPLlO4SCPTpBYyGwJ7UDF9dLklQuNu39FAmLEk
         VKN0bZDYxvdxMa3K0B4ldvCez2M+EKzvl0x3Ak+9mj2fQ/npOjHrvFsg5EZO7Y2HBgdH
         se+egaX6UHHZRELhuw3TN66f+Jklp5d4g2CIyzX6Mob1e/mqLcAwBT2HUnQ7Gppgdqp9
         FPYhJ3lpJDFw+21Ec2RUXkludRlXt5su3/T0QXqc/fdRv+1kC/BSidhndrjupsJLowY/
         TDug==
X-Gm-Message-State: AO0yUKWmlDmmzZF+ctfyp4sRkTUL47OtoPR6VdfP1v1pFxqvPiHKmyyP
        RtEEa6KML3AOVimsWhIc5ipz1L3TZL9m8kCJ
X-Google-Smtp-Source: AK7set/AOWn6nySSzpAx3uVbQcnKYMa3/jGuEAdqkARK5N/bi9Rc8yzFSw7RPzhxuIjNrya0E3EYMQ==
X-Received: by 2002:a05:600c:3ba5:b0:3d3:4007:9c88 with SMTP id n37-20020a05600c3ba500b003d340079c88mr5791852wms.18.1675330359124;
        Thu, 02 Feb 2023 01:32:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/9] git archive: use gzip again by default, document output stabilty
Date:   Thu,  2 Feb 2023 10:32:20 +0100
Message-Id: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in
https://lore.kernel.org/git/a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com/
changing the default "tgz" output method of from "gzip(1)" to our
internal "git archive gzip" (using zlib ) broke things for users in
the wild that assume that the "git archive" output is stable, most
notably GitHub: https://github.com/orgs/community/discussions/45830

Leaving aside the larger question of whether we're going to promise
output stability for "git archive" in general, the motivation for that
change was to have a working compression method on systems that lacked
a gzip(1).

As the disruption of changing the default isn't worth it, let's use
gzip(1) again by default, and only fall back on the new "git archive
gzip" if it isn't available.

The later parts of this series then document and test for the output
stability of the command.

We're not promising anything new there, except that we now promise
that we're going to use "gzip" as the default compressor, but that
it's up to that command to be stable, should the user desire output
stability.

The documentation discusses the various caveats involved, suggests
alternatives to checksumming compressed archives, but in the end notes
what's been the policy so far: We're not promising that the "tar"
output is going to be stable.

The early parts of this series (1-2/9) are clean-up for existing
config drift, as later in the series we'll otherwise need to change
the divergent config documentation in two places.

CI & branch for this at:
https://github.com/avar/git/tree/avar/archive-internal-gzip-not-the-default

Ævar Arnfjörð Bjarmason (9):
  archive & tar config docs: de-duplicate configuration section
  git config docs: document "tar.<format>.{command,remote}"
  archiver API: make the "flags" in "struct archiver" an enum
  archive: omit the shell for built-in "command" filters
  archive-tar.c: move internal gzip implementation to a function
  archive: use "gzip -cn" for stability, not "git archive gzip"
  test-lib.sh: add a lazy GZIP prerequisite
  archive tests: test for "gzip -cn" and "git archive gzip" stability
  git archive docs: document output non-stability

 Documentation/config/tar.txt           | 29 +++++++-
 Documentation/git-archive.txt          | 96 +++++++++++++++++++-------
 archive-tar.c                          | 78 ++++++++++++++-------
 archive.h                              | 11 +--
 t/t5000-tar-tree.sh                    |  2 -
 t/t5005-archive-stability.sh           | 70 +++++++++++++++++++
 t/t5562-http-backend-content-length.sh |  2 -
 t/test-lib.sh                          |  4 ++
 8 files changed, 231 insertions(+), 61 deletions(-)
 create mode 100755 t/t5005-archive-stability.sh

-- 
2.39.1.1392.g63e6d408230

