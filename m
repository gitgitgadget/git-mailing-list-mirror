Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D55F1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438486AbfJQXE6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:04:58 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44748 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389846AbfJQXE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:04:58 -0400
Received: by mail-pg1-f177.google.com with SMTP id e10so2197051pgd.11
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=runtime-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7klBL7j0vLhDJbtjx22QGYbfrw5UHsfppY8scNp5Lmc=;
        b=Wauc2DXoYskJL7p4cNjtj9l5rpJU862UG63wyeRSHejs+kgZFU3O5UQT6a3S+Be/1F
         3n5a3/HPOKDOumeDfsAfs0aWnzL2PTFQUm2BWl/09pnZ12DxOdSsDVdVeQIMSO6BSOz2
         GCY/txupa2eG0K3bAQoqcsFau7L8dBbjVcys3ve4a9xP5hffZ6NC/mG3a01aXlhN4LIl
         hvrHrCt5EWOuXChli/o3PkhSuOaAKfaiSffPNUafyfHANDuIocyM2o7X2Z72B+MQrjhR
         yTlrVoPb/SY+ZzaRb3x0KZI0ZXgp83tFeBKsmUn+/Kte1adwg35/qm1kTg9VwHYx4aK0
         cm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7klBL7j0vLhDJbtjx22QGYbfrw5UHsfppY8scNp5Lmc=;
        b=o2dVNLDdttH4mv3GTJBzlBxn0igHuJJTDVX2uIf/xhBRsjbs+LgqIqW2SnTEIZtVAJ
         pkDaDCF2vn5UfMKuYyAhh433/x1Ljx4FOA1RfyVBvf9aGKTrBwB/m8iE0Fkz8BRiEnLn
         0sQmRXuDCcI9Yhzx24LFP4YmUcPX+YQbYDL+/ftkADFPiNQsC/7ZS2G99So2FGNdkfZy
         ytGTQu0BQoIG/Wnf754xQVkdTEVtivECg8CW2hOHMFWgUFd06sUWVm6Lwd1OgI3EQrij
         yUgn3VkuQPuiako6b5/O3yz9XU1qf0ImKyT4jDqm8KQmEFOMwuelMFXTdCSJSRdzs1Mq
         1Upg==
X-Gm-Message-State: APjAAAU9R5HA8PkmFFcKOf92YYtSvwgScSF3L3TuxCFEssY+m2g3BlTd
        nqYUP5X09raDT1WKb1+lSAOir/ighrQ=
X-Google-Smtp-Source: APXvYqyfY1gsGEQEd4IhewGqZsFTbvboy79cZR4BeCV762Q1f3FMla/0Dpyj+/x8M3WX11UJK+4hWg==
X-Received: by 2002:a63:1609:: with SMTP id w9mr6910364pgl.184.1571353495185;
        Thu, 17 Oct 2019 16:04:55 -0700 (PDT)
Received: from localhost ([209.160.126.106])
        by smtp.gmail.com with ESMTPSA id u3sm3546442pfn.134.2019.10.17.16.04.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:04:54 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:07:51 -0700
From:   Christopher Collins <chris@runtime.io>
To:     git@vger.kernel.org
Subject: bug: Directory replaced by submodule -> checkout fails
Message-ID: <20191017230751.GC4049@pseudoephedrine.nightmare-heaven.no-ip.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

### Environment:

$ git --version
git version 2.21.0

### Reproduce:

git clone git@github.com:JuulLabs-OSS/mcuboot.git
cd mcuboot
git submodule init
git submodule update
git checkout ae01f153b11637feaedbc9d9042172fba2e080c0

### Discussion:

In the above sequence, the last step (checkout) fails with this error:

    error: The following untracked working tree files would be overwritten by checkout:
            ext/mbedtls/include/mbedtls/asn1.h
            ext/mbedtls/include/mbedtls/bignum.h
            ext/mbedtls/include/mbedtls/check_config.h
            ext/mbedtls/include/mbedtls/config.h
            ext/mbedtls/include/mbedtls/ecdsa.h
            ext/mbedtls/include/mbedtls/ecp.h
            ext/mbedtls/include/mbedtls/md.h
            ext/mbedtls/include/mbedtls/oid.h
            ext/mbedtls/include/mbedtls/pk.h
            ext/mbedtls/include/mbedtls/platform.h
            ext/mbedtls/include/mbedtls/platform_util.h
            ext/mbedtls/include/mbedtls/threading.h
    Please move or remove them before you switch branches.
    Aborting

In the mcuboot repo, a regular directory was recently replaced with a
submodule.  This was done with two separate commits:

1. (b748f6) Rename `ext/mbedtls` --> `ext/mbedtls-asn1`
2. (f984b9) Add submodule `ext/mbedtls`

Git reports an error when you use `git checkout` to "jump over" these
two commits.  The sequence above shows what happens when you go from
post-replace to pre-replace (master to ae01f1).

When you do the reverse (pre-replace to post-replace), the checkout
operation succeeds, but git emits the following warning:

    warning: unable to rmdir 'sim/mcuboot-sys/mbedtls': Directory not empty

This leaves the repo in a dirty state.

The problem is easy to work around by hand:

    rm -rf ext/mbedtls sim/mcuboot-sys/mbedtls
    git checkout ae01f153b11637feaedbc9d9042172fba2e080c0

Unfortunately it is not easy for automated tools to work around the
issue.

Thanks,
Chris
