Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D46C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05BA20776
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aECTk/vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDVXNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVXNY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 19:13:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6DC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so923791pjz.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kbHxYZBHBDGs/GVLGHndYXXfUCCdeMaqQOFXbB9YDhY=;
        b=aECTk/vMb781kYBprPRDUWlX3gQn5w3i0YywecZhA5YQmdN6qQi4nKdXIw3VHVfN6Q
         vGfh49qqEXgwLUqvX9fIhYFzbBmRqFL9BuGYJxoepfUvMoMs8MucPTAUZl2VdvLMpoMy
         iQB0CAj/pQkWKYFflYCxtLI6hl633eJwvXdQxinTfUWau8nARQuSxwMNF5EHYfos+cs/
         ID4uYvMrj1DCdZFZuCxniLs9dgUXhE/O53Awmpn3McIUKILkpju4N3geXUNo84OAamd/
         b3SZnNrGscbkcCWIhRwA8L41vsFVRQKnP//ysg80QenYpOxTGFw6TIdi3xVaxiNhPug4
         ToGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kbHxYZBHBDGs/GVLGHndYXXfUCCdeMaqQOFXbB9YDhY=;
        b=hOEIUKnvKKPTGvvHT9l7CEweXTHZVxtObF/P04/X9DorSugu5Wd3XAbfQR30HBgEug
         F6+bUV9Z+j8LJW3byCRPV7w9PIigRzocCAcHnwiIMPqEU7VSMUyyVfHCh241I5ZOiQAD
         hS8IQXECbaf7VHTxMNIwWb/8fqrf+9lPUYEzeN5+UAlCLEJ+GHMSl2Kv3Rfq9hVjwJPB
         qh5tbiJ77MWRbR7kYwMcpz9EQCY+/5+x/g7ebd5GPy7HLfpxB+P3Ms3GbrVpkiz02Qvh
         90MO5HFQN1Bwlnn0EXS/e83HyhMg+Gjfqh11bsm4Q7vbDeBBvKib9Zfl+vki4hT0rpSv
         Bnpg==
X-Gm-Message-State: AGi0PuZmA3bBBZrKVlD5CIHtQKMMLDGuEp0UaBsq7eF3Hq90RBGDZeIb
        OANlKcqbL/1iT7D805/h320dXE2rT3T+mw==
X-Google-Smtp-Source: APiQypIhemUfWJ5EEVzrI9F3kg3lMM+VYPuKAhs2rIjOCNEFKTiz8I8/yNv0RjSrAcFxmQV1PV7acw==
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr1094775pli.122.1587597201934;
        Wed, 22 Apr 2020 16:13:21 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l30sm308182pgu.29.2020.04.22.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:13:21 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:13:19 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 0/4] pack-bitmap: use bitmaps for traversals with
 '--filter=tree:0'
Message-ID: <cover.1587597151.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This series contains a handful of patches to make object traversals with
'--filter=tree:0' be bitmaps-compatible. They have been kicking around
in GitHub's fork for some time, and we use them on every
'--filter=tree:0' fetch.

This is a prerequisite for a future series which will introduce
configuration in upload-pack to indicate which filter choices are and
aren't supported [1]. Since sending [1], GitHub's fork has grown support
for

  [uploadpack 'filter.tree']
    maxDepth = <n>

...and so I figure that we could get this smaller series out for
discussion before introducing that option, which doesn't make sense
without having some faster variant of the 'tree' filter for certain
values of 'n'.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1584477196.git.me@ttaylorr.com/

Jeff King (2):
  list-objects-filter: treat NULL filter_options as "disabled"
  pack-bitmap: pass object filter to fill-in traversal

Taylor Blau (2):
  pack-bitmap.c: make object filtering functions generic
  pack-bitmap.c: support 'tree:0' filtering

 list-objects-filter.c              |  3 ++
 pack-bitmap.c                      | 72 +++++++++++++++++++++++-------
 t/perf/p5310-pack-bitmaps.sh       | 10 +++++
 t/t6113-rev-list-bitmap-filters.sh | 21 +++++++++
 4 files changed, 90 insertions(+), 16 deletions(-)

--
2.26.2.112.g65467a058e
