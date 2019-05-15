Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FCD1F461
	for <e@80x24.org>; Wed, 15 May 2019 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfEOOC3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 10:02:29 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:42043 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfEOOC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 10:02:29 -0400
Received: by mail-qk1-f179.google.com with SMTP id d4so4819qkc.9
        for <git@vger.kernel.org>; Wed, 15 May 2019 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=33FGNoLvmUBRS4tqKUQV3+P3tXGMQiDwitVPNEV2qqo=;
        b=O4rptvPqqTlFkTVhZzbc6LYvWToZ2DFpEJcl3//dPVF5GPOM6T4660bbNojohURF7y
         O+YQuTMLHQVSCZvWbwYcgkRx1pyryFsUVPzVRqyTbY74cMtc6Mnblpw+/7giXXT0/1zi
         CXyAhFpHW+ntLmpeyXBhFKuP20H1bzWDgV8HJFRM2pSkuvM9t2cWXFEqVKADZaRCvnoW
         eL7kt5387ZqSSKa/PfJ1Tw2NFKUaYXPENs5oTTLooMnpH8Un3V9oJ658SF2+mAlJfJi+
         OYHi1COxBNI30Ct+050vQOXrYwJCxG/sAgmEKwksTZsiRqMSQ/jU81LbCWWo4kcnWeXV
         haTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=33FGNoLvmUBRS4tqKUQV3+P3tXGMQiDwitVPNEV2qqo=;
        b=cIPnOZy/hfrZjhaLIYSuWOU9Y+vBT39Vrw4eke4eqWYVc3unSAoar6mGhH2IkmW0Tt
         SHx3lncdn7/9ARZp3momZOcfpwuIina5C2xmO+G0fsU6mUkWtm7aPtnl/AnaK4S3ohew
         //SefQQ6xjDX2ynHVO+zx2DOfQ1kbk+q9zVOSzf/p/b15ARkKd+ppf42dim3ggKdI7nv
         IQnyTC+OpBvMI7eHCry4qv6Sghj+SM47vzDHG5wjs8UgDPOplxV2sImXrl+O669sWkDE
         TmBQszv/F5/efaDsMaPCzONmmAB44WYWOvjIaEAKbJM597dvREIMKq3cJj4jtYgjz4/s
         ySTQ==
X-Gm-Message-State: APjAAAWratEXPAsO76WFn+Ys4tuhycdlx7dzzMxoufVb2MoEV1WLbNIw
        +ay+9UgMTeSD1VfmRBtFpEZbT7TETAufKJSmBykk+w==
X-Google-Smtp-Source: APXvYqxUWz/bpwQW5xSKDhSfs7sjYF48nymr7201vUJeOuXDWb7v7ty/nLHOSt2ilSW0uiUHmfYAGxY5WQQvvQTfWdA=
X-Received: by 2002:a37:7d82:: with SMTP id y124mr34195243qkc.167.1557928947954;
 Wed, 15 May 2019 07:02:27 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Sonski <s.sonski@gmail.com>
Date:   Wed, 15 May 2019 16:02:17 +0200
Message-ID: <CAGR_whtu75fcWGz-EALyXLTWkPCu-rHK8r0M7Lr2t71RKT-kww@mail.gmail.com>
Subject: Setting submodule.recurse true can lead to loose of changes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I discovered a potential bug regarding submodules and the use of
rebase and stash.

When setting the configuration submodule.recurse true, doing changes
in the super project and also given submodule, these changes are lost,
when doing a rebase or stash. The stash even shows these changes with
stash show -p, but trying to apply them, leads also to a lost of these
changes.

Removing submodule.recurse and setting fetch.recurseSubmodules and
push.recurseSubmodules fixes this problem, because the submodule is
not touched.

Stefan
