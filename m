Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FB11F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbeACBMf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:12:35 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34066 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeACBMe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:12:34 -0500
Received: by mail-io0-f177.google.com with SMTP id q188so575973iod.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcURbIiEvfB/l67MWn/rUp3aUaVfK4k/nfOv4MzYgzc=;
        b=acxHSs60NWlh3TvU7vkhuRxqyQ9flQCZOe7ttqtmP6+FbSC2nKsTitkembVRurbTKZ
         5r1Y8ADzcJZVxT83Xq56z4lZEMCsPodEWW8ecQEkKm057gCkhlRuq+XUOhHtRq4ohBDU
         dui/i9LFV4RKgCQLdTcEsj/q+B8NTiJTbkrCTDTU2IKY4o+90cvSEyqPw5PuQeHmADHz
         /EIQEq43T6h2ryl+sMN6amPAYZQ+fjDX5mKoMfLdefFG/G4TBv6b2MfY3nd2uYehYVkA
         fXixSbTxUbscY5qFey+bevuifVcRFlJUuStC3wvxrWpsMHcgTY8eIifOsUniig+g0vsF
         RpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcURbIiEvfB/l67MWn/rUp3aUaVfK4k/nfOv4MzYgzc=;
        b=tQVb42f9OgEbDzKZ7KIClFrl/AbYHsViccr/k6exz6YRMjMLM0TeYphokSBnQuKfWA
         hHJhOpKjLzpia8NlQ42/DlOwf9S47Q9WIlfk0lpTN4SmGZIxy6OFjF0c2aUVOjde2F64
         INx/W8pEmEfZ3ZdeYyj7G/kF1WRO0pm7HX2zbEkK0j+BODypL/mviAMaSlrIqMVW6HZQ
         aeA2NhCA1gDKdkOFziJL1KmQ/q+otLJsY650HKI1D5xCs8sP9rmDEz7gJnwPGaTCOSFl
         7DMYv4TJGrq5depjWtRQCLjjO7OWZ1kpVKr+lWBDN7Iu0qdicJw6pJZzSC6xvscm0mjY
         Lt/A==
X-Gm-Message-State: AKGB3mK94mTOpwVh9vlwLvFbAPLP6kdU7WmTXXnoWRjwPJwSxT+36yh6
        e/SQIG9VXK8Bu8tdZ0ZASDHF2w==
X-Google-Smtp-Source: ACJfBouZYKkqewt1YQV/wzvrRGwqQyxKJsC2Oj+aYSv4fXhuCNYIR8DFEeFOi4XjZ81SKAP8waRlBA==
X-Received: by 10.107.107.13 with SMTP id g13mr2191437ioc.263.1514941954031;
        Tue, 02 Jan 2018 17:12:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f207sm50568ita.26.2018.01.02.17.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 17:12:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCHv3 0/5] Fix --recurse-submodules for submodule worktree changes
Date:   Tue,  2 Jan 2018 17:12:21 -0800
Message-Id: <20180103011226.160185-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for review of this series!
The only change in this version of the series is

--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2140,7 +2140,7 @@ int oneway_merge(const struct cache_entry * const *src,
                                update |= CE_UPDATE;
                }
                if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
-                   !verify_uptodate(old, o))
+                   o->update && !verify_uptodate(old, o))
                        update |= CE_UPDATE;
                add_entry(o, old, update, 0);


v2:
I dropped the patch to `same()` as I realized we only need to fix the
oneway_merge function, the others (two, three way merge) are fine as
they have the checks already in place.

The test added in the last patch got slightly larger as now we also test for
newly staged files to be blown away in the submodule.

v1:

The fix is in the last patch, the first patches are just massaging the code
base to make the fix easy.

The second patch fixes a bug in the test, which was ineffective at testing.
The third patch shows the problem this series addresses,
the fourth patch is a little refactoring, which I want to keep separate
as I would expect it to be a performance regression[1].
The first patch is unrelated, but improves the readability of submodule test
cases, which we'd want to improve further.

Thanks,
Stefan


Stefan Beller (5):
  t/helper/test-lazy-name-hash: fix compilation
  t/lib-submodule-update.sh: clarify test
  t/lib-submodule-update.sh: Fix test ignoring ignored files in
    submodules
  unpack-trees: oneway_merge to update submodules
  submodule: submodule_move_head omits old argument in forced case

 submodule.c                         |  4 +++-
 t/helper/test-lazy-init-name-hash.c |  2 +-
 t/lib-submodule-update.sh           | 19 +++++++++++++++++--
 unpack-trees.c                      |  3 +++
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.15.1.620.gb9897f4670-goog

