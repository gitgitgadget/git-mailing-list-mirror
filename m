Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62700C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5D920789
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjaWq4Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFMUDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 16:03:10 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C3C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 13:03:10 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b5so11885029iln.5
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w+ucvuv55H5pya5vuj6sem/iRFWoF20KytJt80pZ/xo=;
        b=MjaWq4Wtre+KoB0q7OoPEEi1tpdnRwXZwDIj1nJ+UpHAcY/uaf0+uoCX9/dZyP9Xhh
         onvp8SH354Jm3yNIIKsMNfpMzFWj9ny/e95L6LezSbhy624qWwU8ehYBJlrlCkoWAuow
         d2dV1gYVLh3prjFQgkPE6XZneVGzbpd84yVRT4Zk9+BnvJukHva1W/uiyC6dHy8wLa2l
         X8BRPpV1A9pCF7sHlp01HveD7/OO3QUKG7I9tCpPR9Iev04cZTT3pb75ZoCi4P8QKiC5
         ruxYCr/sTa5jBvpJiyFSQ75hh5U/5ynLdw0nLeZ00Z4a2526YfaDfoCUhFTj15Sa/a85
         H8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w+ucvuv55H5pya5vuj6sem/iRFWoF20KytJt80pZ/xo=;
        b=kGRXZUUpHlj2DpHyBOr2ek7hDZmvmFAoPYXoW2ho2hVotlmG5kWf27fwOcU9wBo4Tk
         +71wTbiBoFF053DSAcQHm596v4a4Mh+cKUbBvYBuJPSprYm6omS+Y8GIu6YERfVKIgX3
         fN92aGh+OxmikYwqFWuOVQvatA+0DQiPLITNJ7wUZ0pv703zIseTxmpfukmLPE+oZlVm
         2QBAjZIJqFNOHQiWgs8vxrmjpRtVJ9c11gAspcnKrD3yCJ/2sx6ro+7gcz9KUkfWxXXi
         NSCw+3bnegn2ToaAzN+rU2K6T2BrJ1qt2AIWhtCpRd6FqaZuVGH6LkvzN9tGhvPuHTTU
         qkZQ==
X-Gm-Message-State: AOAM532aswk1l+bClYb/HzE0qWvgJhdM31b2mJkq8nAd+YntaLv1QfDc
        YRup54Yr1P24f3rsnPOP+OXM0G4BSGWkqbvxR1RgAxVCyz8=
X-Google-Smtp-Source: ABdhPJxBI2vUPQKYsATznyPTliCIAW7nSrRw779qiO9XjtBoTH2uQO+2RTi1581SLFYW4poPOI3FXrHpiWBDx6/wl+k=
X-Received: by 2002:a05:6e02:ec3:: with SMTP id i3mr18947429ilk.211.1592078584941;
 Sat, 13 Jun 2020 13:03:04 -0700 (PDT)
MIME-Version: 1.0
From:   Trivikram Kamat <trivikram.kamat@gmail.com>
Date:   Sat, 13 Jun 2020 13:02:53 -0700
Message-ID: <CAP3FiOUrx07agv+27buatCzWPLdxNBh4wLiWLs8XrpWU-V3=Ww@mail.gmail.com>
Subject: About renaming git default branch name from "master" to "main" or equivalent
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

This was suggested in Node.js core in [nodejs/node/#33864][1]

Background: Many software developers [on Twitter][2] are planning to
rename their default branch from "master" to "main" or equivalent. The
primary reason being master-slave being an oppressive metaphor.

Is the git community considering renaming the default branch from
"master" to "main" or equivalent in git?

[1]: https://github.com/nodejs/node/issues/33864#issuecomment-643667917
[2]: https://twitter.com/search?q=master%20branch&src=typed_query

-- 
Regards,
Trivikram Kamat
