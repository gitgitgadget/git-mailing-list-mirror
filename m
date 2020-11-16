Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAEBC63798
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0B20855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Z7M/9tZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgKPSlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbgKPSlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 13:41:12 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E39C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 10:41:11 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 3so13668039qtx.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iQMgRDuN2t5c7LWHOnIK0SbF6ALH20ct0tWAJhL4a3s=;
        b=Z7M/9tZVbFprOh6oihuEx9n8/voWvgB3YaVIVNhLsHhjAIvmKrUSENXUu0tdSgaj7r
         +Xc2l9KDB2DMdqCNqyGXCMlZgblhfImHSIYKjbOJwSEll43Z3hkhHbSAtwMcE6K8JUWM
         vc07cIvXCwbaKD9JNoR+oD2H4sWFnJC0dK17+RxSHiAGmZ/zA+YmNoiMpYHJ4/4afa3r
         +KAHEOEVnuIDeyw/kISGJ0q+FO0Ovb8soCkzHqeoBz+EQlY/NFcz8TELvv1qUZsQQ48l
         vHdxVBew+JKZj97uxXJoKKGfto3sCXl6p/+c7VB/hxmFxKyLUvgSfFXt61XpNPS1NmXQ
         p6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iQMgRDuN2t5c7LWHOnIK0SbF6ALH20ct0tWAJhL4a3s=;
        b=mEync+aPrUk0VJwgy9DCb+QuPvNI2H7QyY1auDsasWeBi0MmGp62ljlB6beDUCxi5q
         2ubYPT7PkzpHmvgsmw8u6zR4igXFv5F4CPJIyPyHnJs7pxkCqa/NJVbqvYHeLZaymxAE
         RIKqyT6gzIAZSm5gAOoJr5bRJE52eVrI+rPPUXHqTmAWs9UqqrDgRvvO8S1HVytdaqal
         oYVkXLXgNEBIaHVK+/ynsbLjHx4E2hsrUpvworSSjfXI2onijhlPEPTieVRkEXVBZ7BR
         dg/mcbMsp8Dux+C8zp0OCfZvbxor2qxogr5g8/fQ9yxSknUZGukjoHmCu3b8kT6cQl+b
         so2w==
X-Gm-Message-State: AOAM530bjMg4Laq2fqel6FqCYFe7Ah48yLjSNYjO0291REjMh5CzZGkc
        aOTfd7cPqqHhCfOgQzNjwFkHmpQF625lfO6D
X-Google-Smtp-Source: ABdhPJyGaC6stjOj/I45JrYLEcGKdN1bR4Mixbge8GWLDnDiym7nmBPVOAo+RXlmGgrEyNum3fxZEg==
X-Received: by 2002:ac8:24c2:: with SMTP id t2mr16001737qtt.295.1605552070078;
        Mon, 16 Nov 2020 10:41:10 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:990b:ddbb:a86d:1de2])
        by smtp.gmail.com with ESMTPSA id w15sm1581483qkf.52.2020.11.16.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 10:41:09 -0800 (PST)
Date:   Mon, 16 Nov 2020 13:41:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 0/3] repack: don't move existing packs out of the way
Message-ID: <cover.1605552016.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here are a few patches that GitHub has been running to get rid of the
rename-to-old behavior that 'git repack' has when its invocation of
'pack-objects' produced a pack that already exists.

This was developed in the context of a circular dependency involving
writing a multi-pack index during 'git repack' (we have some patches
that do so by adding a '--write-midx' in the repack builtin), but it
should be generally useful.

The idea (which is explained in detail in the final patch) is that prior
to 1190a1acf8 (pack-objects: name pack files after trailer hash,
2013-12-05), 'git repack' had to move existing packs out of the way for
safety, but after 1190a1acf8 no longer needs to do so.

This makes 'git repack' a little simpler since it no longer has to deal
with any failures encountered during this rename-to-old behavior. It
also paves the way for sending the MIDX-during-repack patches.

Thanks,
Taylor

Jeff King (1):
  repack: make "exts" array available outside cmd_repack()

Taylor Blau (2):
  builtin/repack.c: keep track of what pack-objects wrote
  builtin/repack.c: don't move existing packs out of the way

 builtin/repack.c | 153 +++++++++++++++++------------------------------
 1 file changed, 54 insertions(+), 99 deletions(-)

--
2.29.2.312.gabc4d358d8
