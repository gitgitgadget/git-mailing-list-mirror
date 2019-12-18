Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D5C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404F218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLRTQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:16:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44857 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRTQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:16:42 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so3132612iof.11
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6pyFSV6cpvjl30RQSQWwN8DeEyEiW7Dg3a0WwXBXOdg=;
        b=km5Z1Ep7WdYj7X+O55AXXEzdru2Tlk5bI2qxl5a4yDPf6pm7ea2oXRSZaS4KmYRIfE
         xjWIv1BypmmQh/0kvRv80oIZZjJd0DI+b3egh7NcmU2nGMl62JVH8OHFf7oNQrULVP1R
         vsckucSq+74yvK0znboeJyzVd7XGnq4z5KKSFRvNY1cic5IauBWzV6xFpEhGY88YkeNh
         r32Y7xJRenku8+uNNP1C3vIx9ncayqmyzRNpSZQZSBJ3N7Iv/4dOinFr1sH1rbsCk+yq
         is9Hg8HlSdxieO+hIOoEKD58sdornKv69EGYjmS1eAzEt37ZiqNqhzucTMnBDDwCBh1v
         WILg==
X-Gm-Message-State: APjAAAWir2+1SqTmgB3qeYFbnm4+N2CvNusvTR7EMRc6bJmYHed9rS4y
        ssaaji4pXVm3ot7VcPep10mkHBesHoAZvwIAmkY=
X-Google-Smtp-Source: APXvYqxzl3/l/JJ/VJkG2cS4aoSY8ri15z2Q75P3EDwuKETlmQ8YxlqFK7HdzCGklprn/MhfFd5hulmVElKrlcPa/a4=
X-Received: by 2002:a5e:aa12:: with SMTP id s18mr2769078ioe.182.1576696601699;
 Wed, 18 Dec 2019 11:16:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
In-Reply-To: <pull.488.git.1575920580.gitgitgadget@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 18 Dec 2019 06:41:00 -0500
Message-ID: <CAPyFy2AwJ6TJpNWQOSPia9=5tMd1sUJKvRmNwbqTFkYWixTHjQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] sparse-checkout: respect core.ignoreCase in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 9 Dec 2019 at 14:43, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first of several cleanups to the sparse-checkout feature that
> had a large overhaul in ds/sparse-cone.

After this landed in next t1091-sparse-checkout-builtin.sh failed in
my Cirrus-CI run on FreeBSD -
https://cirrus-ci.com/task/5085664047005696

The first failure is:

not ok 4 - git sparse-checkout init
#
# git -C repo sparse-checkout init &&
# cat >expect <<-EOF &&
# /*
# !/*/
# EOF
# test_cmp expect repo/.git/info/sparse-checkout &&
# test_cmp_config -C repo true core.sparsecheckout &&
# ls repo >dir &&
# echo a >expect &&
# test_cmp expect dir
#

I'm trying to reproduce locally and investigate.
