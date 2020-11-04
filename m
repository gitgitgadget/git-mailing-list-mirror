Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A03C388F2
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 03:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E484422403
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 03:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdhbrGU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgKDDL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 22:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbgKDDLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 22:11:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C040C061A4D
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 19:11:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o18so20971610edq.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 19:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kXLXnbZBuebT7uuTVB/BfEXNSyTC5JdH2qmfumFU5ug=;
        b=jdhbrGU/EkDSP19qfyBmRv3BWRLfrBkSCsr77HnHDTiWoFcv6Ka80/Wia3Z+FxiX+H
         3FF/CHFIFVNpt/QLFuQo620kWpbCwzlFuw+WrEKce2zfZUHNxbDYqnEJO6CGxhSLWni5
         mocMJKqCdLEaigGb+lAvJfUbIhnSTl2tc3rwo6PVV7HuiPQ6fA9/wf54zFEiA/ew6sRL
         Ih0tGPnbwsvrNs/uvHLmOs+1kVdLSqK4egZLdtB9TAe7+uRccwHQF6vnyqEVQUf5MHGC
         HkRP4z1/ozXwZ9p6zHLjzpkL7yX1UJZzsz4/SD74IhGp4VpqtYiw44ZWGzf3B1yULdPi
         pKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kXLXnbZBuebT7uuTVB/BfEXNSyTC5JdH2qmfumFU5ug=;
        b=HLtBJUVUvTDxSgz0viETNBRfpmL3JLU9/6bDJgcY9i2sbnyRGkjVA29jpLNrR+jd7J
         Ha3ifhI7Le+OOuxaSgwGhOgmBFIEf9dtyCbnSqpK7TTD0XgbUB5cNgqE15aV2Kfe2nW/
         u2928oLVJ/6mj+JaKxSUDc3uNCL4MbradtYHfwndkUtRl0SfyrZ3GHR83eobDgkPvcIJ
         mybGZ8aTBFnXjsY+F2F+Yb5mgZtaMFM9pmAHT+XaKPH10bFYJW89lQlViBPMzb6+j8mG
         bMnw9488AqyAvPsxwgx1DiijyfaatVKpdqfat+hCIJI564CzoMoiRALgtqq2Sv/saPoN
         /ghQ==
X-Gm-Message-State: AOAM530A/gW4g0Ii7s3+aBig6klGGX55/iO9HINZ2ms9tOblMN3DQFFl
        jMPufSxTGFR3p51+/B3eVwo5VlwR5qKQ8xE+cJsmKqO5cuOE2ERW
X-Google-Smtp-Source: ABdhPJyyCYLjVh3YJU6jJMQsdxs364zzwz9Q8RwPk7AMPbTTW/MUFeC5CnoPs+xo3nmYzyRVbYszDjJpRHFHQQ8qFpA=
X-Received: by 2002:aa7:cc14:: with SMTP id q20mr18661225edt.242.1604459514019;
 Tue, 03 Nov 2020 19:11:54 -0800 (PST)
MIME-Version: 1.0
From:   ryenus <ryenus@gmail.com>
Date:   Wed, 4 Nov 2020 11:11:42 +0800
Message-ID: <CAKkAvaxrG0aYw-wo_WW7zSkX=mjU8ABgXGbbPCFOhMBa4WTJ+Q@mail.gmail.com>
Subject: support comma-separated fetch specs list?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's nice to have negative ref spec support with 2.29 release, so now
we can have

```
[remote "origin"]
  fetch = +refs/heads/*:refs/remotes/origin/*
  fetch = ^refs/heads/gh-pages
```

What about having all the fetch specs put together in one comma-separated list?
Like this:

```
[remote "origin"]
  fetch = +refs/heads/*:refs/remotes/origin/*,^refs/heads/gh-pages
```

Thanks
