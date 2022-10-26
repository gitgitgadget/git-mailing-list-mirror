Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51C8FA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiJZO5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiJZO45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:56:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B6103259
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l32so10397580wms.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq7wUWmn/uG/DfdjZOEAf2kWJmOjaYWw/TQl4JIq99Q=;
        b=BAS5FvIzKjnpfH5aj1NHLyZDL2SmtZsXDgxuW6er1V5Dwrxhgoly0x3Q9y9KkmIiUa
         7WtukFiO4iNIeVUPzf3gpKjrYBVe+4sEI2l+mDGNT2T7wniElImL+dg/GNdFPkYVDFhJ
         oxp/8b9gn5SKAKudfBUlGYGnH1Y6QkEYmD63wah5b94YW5qu3OHJRT7LEyTX8MrFBH7A
         nt/AprzXiSUT8VppaMTuUlDqY2QlMQJtIAMtJuELfY6TfRI6xNh9ZHqXoCakxBbmM3PF
         oqgGEn1z9hcpKVMEmymzAbfuof/ejsf3bMu2yLmSwDwUp59rzscTh5rwD2EPUTjeCvg8
         U2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq7wUWmn/uG/DfdjZOEAf2kWJmOjaYWw/TQl4JIq99Q=;
        b=SCcLltBGt8wWnu5LNdsv+S+o9bSnPFCbUvunylWTMb+aLkFn8q7hJYsE+dnIFle5J6
         LCoTNYFshj/f1dpN+1t/Mx0Tj9pn9N7SDF2XrHdwxFuV3T/aLw66KWENQdxlJGja+Siv
         bvuutNv8zcPrcoI+ltHTw94v96ZUgIyULBEe6XGt/y96l3k4bJF1zqprHTHGNul++Q17
         xHujvheJ6HJ9L5JDSZte11eVOuWBGdD71f6VBcmuily2LNf4AtBbDmdmHLf9CSv7DVec
         UmrxyUyc9GmmUe5ylqjUpl+qIQt41NYiZ/nw/nH/gs5Guj/XcURHzbrCrPvA557gtbzi
         knRg==
X-Gm-Message-State: ACrzQf1sCjdV5fhBUAyLIs4j5aGVyR7cqyrKjhh+nXaE/m/SmyfFQuLO
        mNhX+9ytqFQLWtJXOY8DclFZNVBBuzWbKA==
X-Google-Smtp-Source: AMsMyM5Czgh4Qt/nzFom8SeN0IVO4hhRRg2TTIaUkUYFrcdwbe+amCCvYPNdt9iaVSfPeQxT7FjCUA==
X-Received: by 2002:a05:600c:310b:b0:3cf:33c4:bc7 with SMTP id g11-20020a05600c310b00b003cf33c40bc7mr2820707wmo.25.1666796214237;
        Wed, 26 Oct 2022 07:56:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/9] Makefile: correct DC_SHA1 documentation
Date:   Wed, 26 Oct 2022 16:56:41 +0200
Message-Id: <patch-v4-3.9-b0bd35987c0-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The claim that DC_SHA1 takes priority over other *_SHA1 knobs was true
when it was added in [1], But that hasn't been the case since it was
made the fallback default in [2].

We should be making it not only the default, but something that takes
priority over other *_SHA1 knobs, but that's outside the scope of this
change. For now let's correct the documentation to match reality.

Let's also remove the "unconditionally enable" wording, per the above
the enabling of "DC_SHA1" is conditional on these other flags.

1. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
2. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 744bd4344f4..a2762e583a1 100644
--- a/Makefile
+++ b/Makefile
@@ -155,9 +155,8 @@ include shared.mak
 # Define BLK_SHA1 environment variable to make use of the bundled
 # optimized C SHA1 routine.
 #
-# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
+# Define DC_SHA1 to enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
-# Takes priority over other *_SHA1 knobs.
 #
 # Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
 # git with the external SHA1 collision-detect library.
-- 
2.38.0.1251.g3eefdfb5e7a

