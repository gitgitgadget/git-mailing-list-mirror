Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E0C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiKRLrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiKRLrE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:47:04 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12012AF1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ft34so12315762ejc.12
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rku71g8QutG1SBH+pkmBoyhNFU3hbblPebv2MeqSYSs=;
        b=SBNgXgVBUHRaoxBsFYkavtU10c4N4QbGcJNuSxPSxSjKponcq01r105DG1Fysd+du1
         c1qbAbSmP3jHa6yqiWMJ+QYVaTQ9SEHUNL0oDuzK/Rt0/xqixTpQ1UDhZJk7mNn3X7Gh
         hRjpsEY9d4FBMqkfgUxpMtxRzwCRC04HdSK+RKkwml/jxhXFoe0P1RJC1UoQE86TMu5D
         CFkkv5ZLVX5MapWPMhAK1BSYHJVprCOXtEcVQFOVCeff/ErVVAsb1142+4LLiRbtWGfV
         eDzwIznR2UVzbDK+GpxCLHM18sRbsiDOOtZUzRpIIq+XcUouWhFAqT2Y9E1gxjJ9ubir
         ND+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rku71g8QutG1SBH+pkmBoyhNFU3hbblPebv2MeqSYSs=;
        b=xCrOi0pMrmLosKT16TQtG1MTAZprM3so+loAESGTF8f7/DQeQeXH8stSB5eZgogxlB
         zi54sKDKGt1Y0Ct/fkCjful8SvPh248m3HjbBDWDPXKN30roRhvM808FHrBH1ct32jqy
         AEbL9P3yy7wRetiAsbXYkgPuTCEqcAWL+bQ4EZPFdbKnJwet//2bDOKMVBZ8SZc4Es/F
         W+iRGtWaKrqoHFrt6W0OyiiFbrfinCHgYEmdwRJsPfMUoWS/JRw0KLDBqvxvW/ZRK1GB
         w6gVFGoC9Mp3LQY8VZ80Awi4+3nvhMwqTQ8OM40/QeYiTAUZbcAhX6wyuPBkhyn9GSBE
         Hleg==
X-Gm-Message-State: ANoB5pn1ZtBkR1bl9tm0K0CfU1NBMPZ/c8f+xr6K4kcNtibXW9PHvv0B
        FIGicyFTgmaxXeNk6ocjSPz+4G1G/oAzQQ==
X-Google-Smtp-Source: AA0mqf5dUb6xhQtCyYdYSbERx5UPg91/HcLS7k/+7abGzjJ+Lw6qcMotjLsrIut5FLfg1LdKv1dKmw==
X-Received: by 2002:a17:907:3907:b0:7ae:37a8:9b5c with SMTP id so7-20020a170907390700b007ae37a89b5cmr5554993ejc.241.1668772021939;
        Fri, 18 Nov 2022 03:47:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7dd48000000b004615e1bbaf4sm1705349edw.87.2022.11.18.03.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:47:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] tag: don't misreport type of tagged objects in errors
Date:   Fri, 18 Nov 2022 12:46:55 +0100
Message-Id: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1512.g9e0c09a155f
In-Reply-To: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a very long-standing issue where we'll get confused
when we parse a tag whose "type" lies about the type of the target
object.

It goes on top of Jeff King's just-submitted [1], and the two
compliment one another. See [2] for my feedback about what was left
over, which this fixes.

Currently we'll parse tags and note what the "type" claims to be. Say
a pointer to a "blob" object that claims to be a "commit" in the
envelope.

Then when we we'd try to parse that supposed "commit' for real we'd
emit a message like:

	error: object <oid> is a blob, not a commit

Which is reversed, i.e. we'd remember the first "blob" we saw, and
then get confused about seeing a "commit" when we did the actual
parsing.

This is now fixed in almost all cases by having the one caller of
parse_tag() which actually knows the type tell it "yes, I'm sure this
is a commit".

We'll then be able to see that we have a non-parsed object as
scaffolding, but that it's really a commit, and emit the correct:

	error: object <oid> is a commit not a blob

Which goes along with other errors where the tag object itself yells
about being unhappy with the object reference.

I submitted a version of these patches back in early 2021[3], this is
significantly slimmed down since then.

At the time Jeff King noted that this approach inherently can't cover
all possible scenarios. I.e. sometimes our parsing of the envelope
isn't followed up by the "real" parse.

Even in those cases we can "get it right as 4/4 here demonstrates.

But there are going to be cases left where we get it wrong, but
they're all cases where we get it wrong now. It's probably not worth
fixing the long tail of those issues, but now we'll emit a sensible
error on the common case of "log" etc.

1. https://lore.kernel.org/git/Y3a3qcqNG8W3ueeb@coredump.intra.peff.net/
2. https://lore.kernel.org/git/221118.86cz9lgjxu.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/YGTGgFI19fS7Uv6I@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (4):
  object-file.c: free the "t.tag" in check_tag()
  object tests: add test for unexpected objects in tags
  tag: don't misreport type of tagged objects in errors
  tag: don't emit potentially incorrect "object is a X, not a Y"

 blob.c                                 |  11 +-
 blob.h                                 |   3 +
 commit.c                               |  11 +-
 commit.h                               |   2 +
 object-file.c                          |   1 +
 object.c                               |  20 +++-
 object.h                               |   2 +
 t/t3800-mktag.sh                       |   1 +
 t/t5302-pack-index.sh                  |   2 +
 t/t6102-rev-list-unexpected-objects.sh | 146 +++++++++++++++++++++++++
 tag.c                                  |  22 +++-
 tag.h                                  |   2 +
 tree.c                                 |  11 +-
 tree.h                                 |   2 +
 14 files changed, 222 insertions(+), 14 deletions(-)

-- 
2.38.0.1511.gcdcff1f1dc2

