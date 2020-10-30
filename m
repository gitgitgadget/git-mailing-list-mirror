Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BAFC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45ABE221FA
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGiarWPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJ3KQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 06:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ3KQg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 06:16:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB43C0613D7
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 03:16:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 126so7153935lfi.8
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MHfaaYKbzn/KkUgLAlgTDlcxHak9p35JtF2hO0NBZ7Y=;
        b=vGiarWPTtljumVbWfNLJwJUrD84Hqt/+4UL9biBneQ/FwcNuM/V4rOwBalEzz9+pgZ
         +gsTS5QQ9Tx9OaYosQBZU5ZNASQp7iR2/ojzueIweBb7gL9xJ6wVSWPb/7m/L/+uk3xY
         hOP92/oQXF5uZi9HQV8VB/pXKnOGB1DS1gC6ao0ztWa6TYBvJwYTbkkp6GHaWRwO7L2B
         p8UvGbnfTAqgYd71WYOGUym2pjTznUUNZ8KBIgLbhk2oSqCs9WjxfTshTDOAtE3Bltai
         XLqqbTTA6cV5F304zrHxQbgrGNyP+0keOlV6lvcxrW7AaV1ysAs5iPZcVJt9ny5pUiRZ
         1UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MHfaaYKbzn/KkUgLAlgTDlcxHak9p35JtF2hO0NBZ7Y=;
        b=B/Dk1xbfKLIbDws8UClT4NFEaWNEKlrHSxvzyrKdDHQouYVYg0rrmtDD729eZviOsS
         wjcEB0frvySNynE7nYpRDcFZeNi0i1uVSDBeB18lJNkBsC85mXYpD1tVUzW2ph5T8qOt
         Q54OpOIyOZ028QfUf0y9hYjRuY4FX2PUYMDLAOTzkViPorHD5D1PfV7bbp4F7Si0cKcl
         +G/tDMVTaRJ3QeRQiJrWT4+30wXZ8PcHZLomS0BdLvZhODZ6cezPxGZlB5So1WgnUgFt
         J0HxrJXHkHPWQV7Nl3ID/dK5QCXno9opOWseFdSB+6YaC0ygml71+KU5ob3CFsMPWUqS
         J+og==
X-Gm-Message-State: AOAM533anER1LxwnCDCD4UoS2Pgr9GmzAyaBfkYTuczqOOXyB1EFKazA
        ynwMM8y21iNXTtOuRMS0lA8SqVNNhBNO8S64fbykUOnz7LAh2Q==
X-Google-Smtp-Source: ABdhPJw8ZSNYyFeQiYmOWaIXhx1XodYlH6d38OvvoxLKfPGtRQjh0EMqcc0+EUElXt28qJxhl4xBiYDRLVP2Y1lMvgY=
X-Received: by 2002:a19:4151:: with SMTP id o78mr598997lfa.408.1604052991820;
 Fri, 30 Oct 2020 03:16:31 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Fri, 30 Oct 2020 11:16:21 +0100
Message-ID: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
Subject: git-gui: How to configure for use in gigantic projects?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to use git gui for a project. The problem is that the
repository directory is really gigantic. Doing a scan (F5) takes a
couple of minutes to finish.

I would like the scan to only focus on files that are specifically
added to the index. In git I do this:

git config status.showUntrackedFiles no

git status will then only show status of files that I have
specifically added. So git status completion is instant.

But this configuration appears to have no effect on git-gui. The scan
is just as slow as before.

Anything I can do to make git-gui only scan files that are
specifically added, and not look through the whole directory?
