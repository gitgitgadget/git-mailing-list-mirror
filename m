Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C22FC3815B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE750208E0
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walsh.ws header.i=@walsh.ws header.b="A81EB+nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503854AbgDNSYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503868AbgDNSX4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 14:23:56 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB431C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 11:23:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id w14so603085vsf.7
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=walsh.ws; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=5GTqpGmUGcVfl/ezp8pSRNSdktkqbVhLvP0hF1GAnYI=;
        b=A81EB+nmA6+SByehPl3pF1s6AHKvZ1QXRujp2NTB+hM+f03Kzz38DNBnIx1plJwRCJ
         GKyzjKQ6AFzXSbLPDSdK8cEmQIUhfhdwks5nv7u73fHv7EqN9iwhVIscd4QoodkQOkxQ
         UCuyG6yvTdIKEh/SJLsm0hhu4HWv/25OikG3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5GTqpGmUGcVfl/ezp8pSRNSdktkqbVhLvP0hF1GAnYI=;
        b=HdENdY83aN2JkQ9zaCU3lRE57MHagGG95FUIbxP8kMUc9dE2oRtZMYDrsGjONXyYN1
         NZ/9ybjasWEz7N6vNUQwjsRKiziZ+I1BxOdhDeY8SGNwiFWMzK6oCziaUaYfXLkVtTgR
         nbZQAabVDgHJhc/noOssT8jRXV7nS2b7UgsMJIOMsrV2bAFnvnzdJQse/RhlJogZVeLZ
         Jm6Mbt4qFyqdHjk0hpR0sn57vAhAzXEcEiDpgpH6StQVB7aKPTvpStW16ODEsBgCP7mV
         JHIWMngV1jjORplebQ6O+GSUPvanF82AyIDTIn/Y8i5Pm8ckX44rGw6/HYa4Kv8B1MQN
         pt3Q==
X-Gm-Message-State: AGi0PuZjeA6DAgBSoNqF6XWedppvPNil5Hi2s1wa/KJ4iCXEpLWGY6Xx
        oNJeC/rSBPhNnQqwex54YhoY68oJbaiRl4XIeqidA/77HUU=
X-Google-Smtp-Source: APiQypLiwn+/IqpWzDwMSdWtRpbyQZ4+GIO6Miru1TGVBfhudyM1TWQyryKGjJhyw8jUCzZ5gtK5jShWdl242K8pv3I=
X-Received: by 2002:a67:f585:: with SMTP id i5mr1325046vso.36.1586888632264;
 Tue, 14 Apr 2020 11:23:52 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Walsh <brian@walsh.ws>
Date:   Tue, 14 Apr 2020 14:23:41 -0400
Message-ID: <CAG0OLMYrQhuUXP7yrBCA5yKu3hvnrNKrjSn5nZj45gW_P0U5tg@mail.gmail.com>
Subject: submodule cloning issue
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am seeing a problem with cloning a repo with submodules while on my
company vpn. One of the submodule urls has an http redirect. It will
timeout trying to clone that redirected submodule and only that
submodule. I would say that it is solely an issue with my company vpn
however I can do a git clone of the repo that is failing and it does
properly redirect and clone. So there is a difference in how git
submodule--helper clone works vs git clone. If I drop off of the vpn
it works without any problem.

I am seeing the issue with version 2.25 and 2.26 running under ubuntu.

I have not had time to dig into it further to see what is going on.

Here is the repo that is having issues.

https://github.com/ycm-core/YouCompleteMe.git

This submodule that is buried in there is redirected to a new url. It
will hang trying to submodule clone.
https://github.com/mitsuhiko/flask-sphinx-themes.git
