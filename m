Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC22EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 05:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHKFTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 01:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjHKFTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 01:19:36 -0400
Received: from mail-lj1-x262.google.com (mail-lj1-x262.google.com [IPv6:2a00:1450:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF02D48
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 22:19:35 -0700 (PDT)
Received: by mail-lj1-x262.google.com with SMTP id 38308e7fff4ca-2b9a828c920so24523701fa.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 22:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691731173; x=1692335973;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEThzklYYRv3YTrBphax+a3ISW2JZqbqPINroxrQSj4=;
        b=MuzERmUYMeoC4Duea5I1SLioa82X0RA7wBU5kAdIhSpkoJ/qiNoDN8Wbnz0JDBpOVa
         HBaXimCS8WYl2VxMruwCHKfi66ceFk+Mn/UfIcpcKnoyXeRLwAbteiW+lRCXym4gYzl3
         lfxUv/OFQ/CNRNfnCpFrXSrEWohkXkkH6uvVAnqK43NB+lonpZQMet/Xv/b/0si05DkJ
         Z5dswAZpUOGqkrb6k0xbTVzySM9Mg7R2YIlUtj3Zen0HdVyFLK9GXRlN/TfXJUIA8olW
         TFbZXmMYz67b/p4ubT9wSwVv1Q1zXJAMo8aiC3RiMlKUxJrUY5KWkpdvu1P98Nn2jRbj
         PvMg==
X-Gm-Message-State: AOJu0YywIRX5EtU1bqf/2aFbvA11eN2gO0qLHgAymmbrSVQp8NdlbwV2
        beTgyhmghJ0megtCDjZcoQX4rPjU4C1Deeg8wOJDUiV2Jhe0ySkNxRENITU2xOpFjkI5tpFrrJL
        l0oD90E127eFZYVUHEB8HBhHzYpsHos8oX0zCdUj0VfaG1P2IZiou9lQnhhtOECeiP3Fm59NEKJ
        Ap70HKh6Fmc50LhZHVgoVzSPCUyduN
X-Google-Smtp-Source: AGHT+IE38FxDuS6RwfQ2D8DXPff4VuG72GoKwuy4jS6x1ZMUW6OWALCEE4UldWd9Wi1ofZ+BXbmYCf6kg/LF
X-Received: by 2002:a2e:87d2:0:b0:2b9:48f1:b195 with SMTP id v18-20020a2e87d2000000b002b948f1b195mr722828ljj.44.1691731173273;
        Thu, 10 Aug 2023 22:19:33 -0700 (PDT)
Received: from 26f120e6-outbound-1.mta.getcheckrecipient.com (ec2-108-129-6-148.eu-west-1.compute.amazonaws.com. [108.129.6.148])
        by smtp-relay.gmail.com with ESMTPS id o8-20020a2e90c8000000b002ba16f6ec16sm222123ljg.41.2023.08.10.22.19.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:19:33 -0700 (PDT)
X-Relaying-Domain: klarna.com
Received: ("Tessian outbound 38628e78e225:v175"); Fri, 11 Aug 2023 05:19:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9d57d2d01960d2ea
X-CR-MTA-TID: 26f120e6
Received: from c0f479b919c0.1
        by 26f120e6-outbound-1.mta.getcheckrecipient.com id 423B99BC-A306-4EEE-ADB2-AA208EAB5F64.1;
        Fri, 11 Aug 2023 05:19:25 +0000
Received: from mail-ed1-f71.google.com
    by 26f120e6-outbound-1.mta.getcheckrecipient.com with ESMTPS id c0f479b919c0.1
    (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256);
    Fri, 11 Aug 2023 05:19:25 +0000
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-523204878d9so1071544a12.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 22:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klarna.com; s=google; t=1691731165; x=1692335965;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEThzklYYRv3YTrBphax+a3ISW2JZqbqPINroxrQSj4=;
        b=V9NNnJg/YzQZVBMjNkG2jRSYSGZ27rV1b06V2lSqySW6F8Ah6Jd8VBr0M9E4kJ4KqT
         8wCoDgT/bn9Y5tF45BD0OV+hnmqZvsqLrAalfAQXrey4zwJM2vsJ+8321jsLwmxyYs85
         1SpLtLTFrp1oOUi2PfV/BiexKTS145jLOtR5QzOvY5zrejQQbT2GWTMXYdDUTlN6bCkX
         DNvpdbAtvp/PQgIPg6vAU9rM+gfmQGEZjUFNdDlBPOxCu7z6OqTaTDccCkLBT/0omhnt
         ZexgyVRG2XKOl+HSWw9CinVTSsRdPOcXme8ih47nD67Uxbd080HJvtKa7W8shJOApntA
         5O9g==
X-Received: by 2002:a05:6402:20c:b0:522:2111:1063 with SMTP id t12-20020a056402020c00b0052221111063mr787514edv.18.1691731164869;
        Thu, 10 Aug 2023 22:19:24 -0700 (PDT)
X-Received: by 2002:a05:6402:20c:b0:522:2111:1063 with SMTP id
 t12-20020a056402020c00b0052221111063mr787506edv.18.1691731164458; Thu, 10 Aug
 2023 22:19:24 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastian Silbermann <sebastian.silbermann@klarna.com>
Date:   Fri, 11 Aug 2023 07:19:13 +0200
Message-ID: <CAE_ah1-D4jAu6Ak71pAVDWo97H9hEOqMZznreOoV5B-NCuSSEg@mail.gmail.com>
Subject: git ls-files --others not leveraging core.untrackedCache
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CheckRecipientRouted: TRUE
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

`git ls-files '*.gitattributes'   --exclude-standard --others`

Calling `git ls-files` including untracked files is slow in
repositories with large untracked folders despite
`core.untrackedCache` being enabled.

What did you expect to happen? (Expected behavior)

Just like a repeated `git status` with `core.untrackedCache true`
takes no longer than .3s, a `git ls-files` should also leverage the
same cache.

What happened instead? (Actual behavior)

Calling `git ls-files` including untracked files is slow in
repositories with large untracked folders despite
`core.untrackedCache` being enabled.

What's different between what you expected and what actually happened?

4s for the above-mentioned `git ls-files ...` instead of .3s

Anything else you want to add:

No

Noticed during investigation of https://github.com/git-lfs/git-lfs/issues/5453

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.1 (Apple Git-137.1)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Thu Jun  8 22:22:20
PDT 2023; root:xnu-8796.121.3~7/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
commit-msg
post-checkout
post-commit
post-merge
pre-commit
pre-push
prepare-commit-msg


-- 

Sebastian Silbermann
