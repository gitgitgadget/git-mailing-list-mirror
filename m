Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92068C4321E
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhKYMbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 07:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbhKYM36 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 07:29:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F0C061758
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 04:26:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so24991125edc.6
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:user-agent:message-id
         :mime-version;
        bh=4wc1oxL08z1HF6rTSeomWnS2uB6vxd/KHeR4FSaBY+0=;
        b=lv9+bC508BXH0kG3grYN6nDZMDdZk5PnL9fLRbTzxTpgBoVQS7yICWZoIIsUuGMnMO
         BOKDQ4mHA5wpkelX/i5CtqzqVvFjpw/miUC7Qd/LdKrrqix9iArBZGkNEojZMyE0ACK2
         l8q8M4bp11Iv+DG5gwe7+kkWiOxuzJmIyRygK5ZKjT8BnpAjpooZP1nUGdcnNdmzgSnu
         Ajwb0ICWLa8RQHrq6j77fbI3K1LPEbY7U1QSU81Usf3yxE+ymRd6dUZo8KYUQt7IKUiE
         2w4ZDNnh3u9KWdlgvV4IBGzdv4fRHafVVAPUPCkaqnPVoLqVTX8nwcdpERvIJ60wp2Na
         cdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:user-agent
         :message-id:mime-version;
        bh=4wc1oxL08z1HF6rTSeomWnS2uB6vxd/KHeR4FSaBY+0=;
        b=Oe1YzhzrmQuv+SOH1ReRMwD0XYd/zpOoTa/83iYx5ADY4b87/ifbzJF+Jys5TD4hwi
         9pa7wIyW1EKReRN2H8B006XfNdSFWP6WSWi5SDaP7v3il/Xq5XmFkgAsQBvEujtGVWLp
         JYpwoBr6DCjl9zeo/JooG8LJtekvTVnJq+sREXjzbeuGqV5uh2U6yJ9zLd+4878KwXtB
         M0Ulb/GI1Mx/Q8F7cm09gKQpijDSyKaDiD+n31PIF5hq6cZnr7MHLDoQVpGGVSX/oFwy
         AphtWg7EKoq36eHAo9AOvge26KVTVbu18IrwCPU9er7KT1Wqp7vqnIqoJ1R9qFFp92Te
         p3BA==
X-Gm-Message-State: AOAM531zqpTImPuejLmPCbkimz0ZTJLCFBop5ROmKOL1u9/PyqLOFGY7
        Jxd+QElEtBMFjsMkbGbFJ/LTYyOamz0=
X-Google-Smtp-Source: ABdhPJylTrV28TQVy/Yad9J+n7sqVFs6JBDGfnd0joEADguTb2jAhsErDhClD5yauuduJ8qzZ5a49A==
X-Received: by 2002:a17:906:3489:: with SMTP id g9mr30132359ejb.17.1637843204812;
        Thu, 25 Nov 2021 04:26:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t3sm1751919edr.63.2021.11.25.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:26:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqDpr-0006nV-Dz;
        Thu, 25 Nov 2021 13:26:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Git ML" <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: t4216-log-bloom.sh fails with -v (but not --verbose-log)
In-Reply-To: <64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 13:14:45 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211125.86pmqoifp8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't looked much into $subject, but there's an interesting
regression in 2ca245f8be5 (csum-file.h: increase hashfile buffer size,
2021-05-18) where it fails with -v, but not --verbose-log. Discovered
while running it manually.

This is a regression in v2.33.0 (not v2.34.0!), so nothing urgent, and
this is pretty obscure anyway.

For the original change see:
https://lore.kernel.org/git/64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com/

To reproduce it:

    make test T=t4216-log-bloom.sh GIT_TEST_OPTS=-v DEFAULT_TEST_TARGET=test

Removing the -v, or making it --verbose-log will make it succeed. It
fails on:
    
    + GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 GIT_TRACE2_EVENT=/home/avar/g/git/t/trash directory.t4216-log-bloom/limits/trace git commit-graph write --reachable --changed-paths
    + test_max_changed_paths 10 trace
    + grep "max_changed_paths":10 trace
    error: last command exited with $?=1
    not ok 135 - correctly report changes over limit

If it's run with/without a debugging shimmy to save away the "trace" we
can see that it doesn't include the max_changed_paths trace2 payload
with -v. I.e. for some reason we either don't run
trace2_bloom_filter_settings(), or don't log that data in the same way.

It's probably easy to figure out for someone familiar with this code,
but I couldn't see it from some quick skimming. Hence this
E-Mail.

FYI This is our only failure when running the whole test suite with -j1
-x (I didn't test a full run with just -v, takes a while, I was using
-j1 to get sensible output at the end without needing to scroll up).
