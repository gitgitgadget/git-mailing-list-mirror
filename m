Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D7CCA479
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242463AbiF1IT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244117AbiF1ITD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751792DAB6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:17:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 136so6215832pfy.10
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I++DIHmJyVPgJ9Ugs+/TvU2JN3bKx7WGDPOYDPwkYOo=;
        b=U5KvfOK355FZ9gOat5WqlEprRof55CK6IHLKuu+sMeo3Xr9XC8+j5fuM18rrUVNHLd
         AI5aZBC3cJnxvRk7CWScZ0/8LiQwes3VwYewH/k5PkNGv0gBa7sXjMjsYXVAI/8z4pIa
         8Ue2jq4Z5kEK9HJkgKw1SuosF0I+VB/TERzNWCV3WeDzSeTcHnKgeEZ4AfzHBrJLjo5X
         hconEk8CPboOOVONMsKMqTMTm4wVxhge0vMmJA9v/zoovvaYu/Cel5REwnkDhnVD9T3n
         3/V43PzGHhrsrf30G4WZA4X8Y2oav4NDoWMUQ6NIBzzV5c4w452qQEWlskz/mhhO+OS9
         yYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I++DIHmJyVPgJ9Ugs+/TvU2JN3bKx7WGDPOYDPwkYOo=;
        b=YGpgBlkckp/dD2QunaHq4Xpo8diU40wx1HYeQybIwduZs4NeUvM/jqIo66CP8gLKUq
         +2R4sOV22ybfAQuGIcnixc7yoOXTcl9zRBeXLKXCVo+Y+RegXWEY5C+Qz0KccayWZJDg
         qahU8blmUUEjyvoYzHMflKOvpYrSTsiYcfDdJBQB4qQ3i7IxS1IXaY2pOOjZnue3Ha4F
         J4C43PpROqwsq3yqdfDnfOQYlys/FOuQAqC97XfjbZuSjCHPXiQ3ricMh4L0y9wFachp
         xGRx78irLrRXRpkfFHQB+FjNiDCTBU1oni+TC1RXXhUoRKqFe2VoPTjAMpPcr7iKc3dR
         /Vyg==
X-Gm-Message-State: AJIora+OdPF0J1ixursX6+FRbNg5tAu59NkCAZ6jrLGngEAGmQu09K2g
        ya9A5i0GA0ozlF57vDdZg5i2XMlVpUZSYbYHhYE=
X-Google-Smtp-Source: AGRyM1vXTqpZiSuovvWZt8qz338DmuEN+5gb9vVqis0XhayMqbdVrCPhrd0g2Dmrg40rz01KRmdEHQ==
X-Received: by 2002:a63:1249:0:b0:411:54ac:71a0 with SMTP id 9-20020a631249000000b0041154ac71a0mr3582368pgs.4.1656404276641;
        Tue, 28 Jun 2022 01:17:56 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016368840c41sm8551206plb.14.2022.06.28.01.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:17:56 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: [PATCH v5 0/5] tr2: avoid to print "interesting" config repeatedly
Date:   Tue, 28 Jun 2022 16:17:45 +0800
Message-Id: <cover.1656403084.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.gf3b87a33da
In-Reply-To: <cover.1655817253.git.dyroneteng@gmail.com>
References: <cover.1655817253.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4:

By Jeff Hostetler's suggestion, we can use GIT_TRACE2_CONFIG_PARAMS and
trace2.configparams to dump "interesting" config values to the trace2 log.
So I drop the commit [5/5] 'bitmap: add trace2 outputs during open "bitmap"
file' in v4.

Then I found if a config key exist multiple config values in different scope
the trace2 log will print the value repeatly but not only print the final
active value, so a new commit "avoid to print "interesting" config repeatedly"
is appended in v5.

Finally, compared with [3/5] in v4, commit "pack-bitmap.c: retrieve missing
i18n translations" fix every place which was missing translation in pack-bitmap.c.

Thanks.

Teng Long (5):
  pack-bitmap.c: continue looping when first MIDX bitmap is found
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: using error() instead of silently returning -1
  pack-bitmap.c: retrieve missing i18n translations
  tr2: avoid to print "interesting" config repeatedly

 pack-bitmap.c    | 105 ++++++++++++++++++++++++-----------------------
 trace2/tr2_cfg.c |   9 +++-
 2 files changed, 61 insertions(+), 53 deletions(-)

Range-diff against v4:
1:  d8dfe53dd4 < -:  ---------- pack-bitmap.c: make warnings support i18N when opening bitmap
-:  ---------- > 1:  589e3f4075 pack-bitmap.c: continue looping when first MIDX bitmap is found
-:  ---------- > 2:  b6b30047fc pack-bitmap.c: rename "idx_name" to "bitmap_name"
2:  917551f2b5 = 3:  82d4493a6e pack-bitmap.c: using error() instead of silently returning -1
3:  8735ae9979 < -:  ---------- bitmap: add trace2 outputs during open "bitmap" file
-:  ---------- > 4:  065b7c9ccb pack-bitmap.c: retrieve missing i18n translations
-:  ---------- > 5:  f3b87a33da tr2: avoid to print "interesting" config repeatedly
-- 
2.35.1.582.gf3b87a33da

