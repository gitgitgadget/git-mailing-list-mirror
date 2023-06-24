Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F6EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 14:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjFXOdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXOdx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 10:33:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9271BE7
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 07:33:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5769e6a6818so3484467b3.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687617231; x=1690209231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXECYpfMolZSe6qVp8uerzvs0QTSuxcIcMDV6U1l1Zk=;
        b=MCxmbBMspPWvaodKG0Z4RUQ6kZ18xqw5hIUWDh0bVzmqofYDPiAaiO+DWEWGWiBXW5
         J96otFeixhEcjDzZZPGByk6RsNEn7Kb5ndJkgPwcNqjmlhcVX3i1PRF8fiTWX36ymMCv
         HBsM+Jc61TeHVRZmRhzjqZ/UyNZ2rKy1y39lu+855DyjENrTjtOxKVLbaJKvQ6+spxJ/
         wxiXiHtcCHRQ4vfxltDaKBMK9nMruwV+ONzGeK29n2mzh8gM6dQmwoqo/U3DNBKqF6cF
         FAgWwOYBGREDsKmK4aUjw8CnnnY1SU+Enjn1mz6rIf/dp07fE9Pl8hLvIRKxBvaZF3TU
         xFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687617231; x=1690209231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXECYpfMolZSe6qVp8uerzvs0QTSuxcIcMDV6U1l1Zk=;
        b=T67pegoPO6tbLSh9ssSzHyDLMMpp06MGMwrLKBkgRrhMtOeoW5BHADlC+4JngapcEQ
         eXILBYg1qQ51lgzGCjIAVsQ3kycXiGhC9+3hRm2x+NaVk+qYsqy5T78MJ+vTLaejTIS9
         TIXV3sGE+SHGCYXdf1IsbGJW3gpz6ely79f0fW1it5zM3Tt7gYfRc5gtWHFo3fn9w8wg
         zfuChGlqjDWtpuB8lNYpL/WRezwBbhEmHdujsnJ/8Hg2eqkUTJ3wc6o+KWr4gJ5YopLg
         paKE1QvgtnzrFeRyZmT8CD7cUEt8WkOu1js4UaAx7ID6Mrp9C3NMNT1+6y1w/HBm+tH/
         elgQ==
X-Gm-Message-State: AC+VfDx7IKyhtLwKttU3vqD85NwnmV6D3RfZyUnPIIWmzWpRX7UbGQCs
        vuynwrE9Xoycj5+zbPygJ2YltxLmbfrvvv9HYprj11eO
X-Google-Smtp-Source: ACHHUZ6hOX2xTQmXNjEMQhjwjiwbu7Vv1TCfm7FTPRXFqnYfOOq5ahEzPxZfgKh2FGrIrIBlU8C9CA==
X-Received: by 2002:a81:72c3:0:b0:56d:7c4:8be8 with SMTP id n186-20020a8172c3000000b0056d07c48be8mr23103546ywc.16.1687617230910;
        Sat, 24 Jun 2023 07:33:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q126-20020a0dce84000000b005702bfb19bfsm344837ywd.130.2023.06.24.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 07:33:50 -0700 (PDT)
Date:   Sat, 24 Jun 2023 10:33:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t7701: make annotated tag unreachable
Message-ID: <259b1b559114ab1a9a0bd7f1ad29a4cba2612ae0.1687617197.git.me@ttaylorr.com>
References: <20230624043826.GA104835@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230624043826.GA104835@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4dc16e2cb0 (gc: introduce `gc.recentObjectsHook`, 2023-06-07), we
added tests to ensure that prune-able (i.e. unreachable and with mtime
older than the cutoff) objects which are marked as recent via the new
`gc.recentObjectsHook` configuration are unpacked as loose with
`--unpack-unreachable`.

In that test, we also ensure that objects which are reachable from other
unreachable objects which were *not* pruned are kept as well, regardless
of their mtimes. For this, we use an annotated tag pointing at a blob
($obj2) which would otherwise be pruned.

But after pruning, that object is kept around for two reasons. One, the
tag object's mtime wasn't adjusted to be beyond the 1-hour cutoff, so it
would be kept as due to its recency regardless. The other reason is
because the tag itself is reachable.

Use mktag to write the tag object directly without pointing a reference
at it, and adjust the mtime of the tag object to be older than the
cutoff to ensure that our `gc.recentObjectsHook` configuration is
working as intended.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Fixes a trivial oversight from an earlier version of this patch noticed
by Peff.

Range-diff against v1:
1:  48d3c2c187 ! 1:  259b1b5591 t7701: make annotated tag unreachable
    @@ t/t7701-repack-unpack-unreachable.sh: test_expect_success 'gc.recentObjectsHook'
      	git cat-file -p $obj2 &&
      	git cat-file -p $obj3 &&

    +-	git tag -a -m tag obj2-tag $obj2 &&
    +-	obj2_tag="$(git rev-parse obj2-tag)" &&
     +	# make an unreachable annotated tag object to ensure we rescue objects
     +	# which are reachable from non-pruned unreachable objects
    - 	git tag -a -m tag obj2-tag $obj2 &&
    --	obj2_tag="$(git rev-parse obj2-tag)" &&
     +	obj2_tag="$(git mktag <<-EOF
     +	object $obj2
     +	type blob

 t/t7701-repack-unpack-unreachable.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index ba428c18a8..fe6c3e77a3 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -126,8 +126,18 @@ test_expect_success 'gc.recentObjectsHook' '
 	git cat-file -p $obj2 &&
 	git cat-file -p $obj3 &&

-	git tag -a -m tag obj2-tag $obj2 &&
-	obj2_tag="$(git rev-parse obj2-tag)" &&
+	# make an unreachable annotated tag object to ensure we rescue objects
+	# which are reachable from non-pruned unreachable objects
+	obj2_tag="$(git mktag <<-EOF
+	object $obj2
+	type blob
+	tag obj2-tag
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+	EOF
+	)" &&
+
+	obj2_tag_pack="$(echo $obj2_tag | git pack-objects .git/objects/pack/pack)" &&
+	git prune-packed &&

 	write_script precious-objects <<-EOF &&
 	echo $obj2_tag
@@ -136,6 +146,7 @@ test_expect_success 'gc.recentObjectsHook' '

 	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
 	test-tool chmtime =-86400 .git/objects/pack/pack-$pack3.pack &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$obj2_tag_pack.pack &&
 	git repack -A -d --unpack-unreachable=1.hour.ago &&

 	git cat-file -p $obj1 &&
--
2.40.1.479.g48d3c2c187.dirty
