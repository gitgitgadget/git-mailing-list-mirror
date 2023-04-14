Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE6C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNRrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNRrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:47:52 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED3D86A6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:47:51 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-183f4efa98aso28935963fac.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681494470; x=1684086470;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lB9SVDpQyvSc2aWUKuGgej7Q+bdDU9jswtfY3NI0+k=;
        b=MMuShOYc19l0GOzGh8zpnf+3akyUAg4pi5W/OxRaF+f5VIMsb3XezwFK242w/pRX5k
         gx8avbqYclrzRvXJ7DAmVQip93LeifzzeXitRFj8J+WxEJ/VCiRtp4JsUBMwXvpd0T0C
         ra2B49BLH82De313nVYzY84kiQTtsRfTXn+lk1Jl/OdO3oJcAcEZzqraeLZuZBSWT61o
         udGezjM3YBCP+5pwCuA2XimZiDDRQhI15+KzYqNQrCmNe4Op8f7+bT5GrXcfSZlIMg67
         vBMM/Nig1P1m1gX/zyQ3DWXMOdd3/+fm5ZCU1fwL9Mni2gra+6QDVvZ/jm0SMd/jqSeX
         EXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681494470; x=1684086470;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7lB9SVDpQyvSc2aWUKuGgej7Q+bdDU9jswtfY3NI0+k=;
        b=AyFRMPl06owhFnSLbuEqKG20V/KzOG9X+QJdvBHf7mM8ywqdsTNn4R/JA2yqDaGVS3
         XzIaoA2/kuTj4OfpEQbd/B1X6pj8N8gJvPINmp+3tMorn557sbHkoMnwURKXgPUoS/OR
         glttH4CmZbkKtYx6Dgm1kFMZ67WlolqaSyIXiXCXyuq5p0POIkPzl+q8FaOsf5oZ9wQV
         8q8ZsBce003WkH43jhzmVG5cIBok86V0mX8QOaO5GS5w5Ap900lP77A2SqIEAYHur21m
         q8YUsF8Lq/iGAt7C1mXpU9zpUUv8XDpTUBCq0+9PaS1HGGLy8ul6qbiNWcmPAaQ2EJ3x
         Dypw==
X-Gm-Message-State: AAQBX9crnZqdeESnuTNUTBs+mtCSJFl3TUsc4ITHWl28W9BRtsG4pXmA
        7N3Uns78876QiqQ/NtSI4/c=
X-Google-Smtp-Source: AKy350aRNPZFBvD6ry+isT84jPBkcWl6thkNF3bARn3xofwdoaRjVhp0qXvvAG0nA7dvuIVuoYXyWA==
X-Received: by 2002:a05:6871:592:b0:177:c62f:b059 with SMTP id u18-20020a056871059200b00177c62fb059mr4585074oan.49.1681494470512;
        Fri, 14 Apr 2023 10:47:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870944600b0017fea9c156esm2011306oal.18.2023.04.14.10.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:47:49 -0700 (PDT)
Date:   Fri, 14 Apr 2023 11:47:49 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <643991c58aef_5ecfe29433@chronos.notmuch>
In-Reply-To: <ZDltLSTxBCWRoMjK@pobox.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
 <20230414121841.373980-7-felipe.contreras@gmail.com>
 <ZDltLSTxBCWRoMjK@pobox.com>
Subject: Re: [PATCH 06/18] version-gen: remove redundant check
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:
> Felipe Contreras wrote:
> > If we are not in a git repository `git describe` will fail anyway.
> 
> The parent directory may be a git repository though.  The
> current code ensures that we're running `git describe` in
> the proper repository.

How exactly does it do that?

The current code expects the cwd to be the git repo, run it in any other
directory and it will generate GIT-VERSION-FILE in that directory, which is
clearly not intended.

> If we drop this, aren't we breaking things for someone
> building a git tarball which is in a subdirectory of a git
> repository?

How exactly would this hypothetical person build such a tarball?

  git init /tmp/foo
  mkdir -p /tmp/foo/bar
  cd /tmp/foo/bar
  make -C ~/dev/git dist

Works fine.

-- 
Felipe Contreras
