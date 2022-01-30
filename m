Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA072C433F5
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 20:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356018AbiA3URl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 15:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiA3URg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 15:17:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079ACC061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 12:17:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so21264180wrg.12
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 12:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=YoN2eI12XxRGvnfHRLizRZcFc6kU5ztNPLOV5qfXkr0=;
        b=G1IYODSzLmhOeBaNSdj3OSdmptU9seD0rB1ukwrSi6lobYel0MOUPVrOanKWKjw9yd
         ZHTkK3Ppw+3ssktuNr07/Hoj3nr/qL3q/GN0bqcJBeObew4y0pcQDBhpp1aTEqEXYwL9
         4TJiMEHxziSXHdZVpbNbAydpZi3PjdVjus8ksuhZJWfl05hwh+LezlEMhcHWjccp2Fi9
         QwlSx5h7SvyoTkfbzDYyMcNre3/Sl/v/brXo4ukqAm7vu/SSWWJxCVuM66TjMPXUNTD9
         2lOM9HX4i5Cps/g8tvi2/nm6l8+BPzZrRtPTiCuopfrbvVJYmaq041gLQ1zZBtQ3r9ye
         bvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=YoN2eI12XxRGvnfHRLizRZcFc6kU5ztNPLOV5qfXkr0=;
        b=lqF17//XTyR2ccxPfOxpuWiOxqmNUBiJ7WBFyXIqEGeYDFM+0uuTlHgeirUlUuu54E
         XSvT68LFRq05LTl3HGsR+MxZw57ACoRhmN20e+y8fLXIXWT6pYoUiSYZPvMo5PfkbCNo
         byhZ2uhNXjXVw7D2+mepk8HLJ/dREmhaK/3UXTHXOgeR9NItcu/fzbI4/K7x5wGTwblQ
         UttbU2fJPg9ezegxSg3VJcL1s+Yns8MAwl5pnDG1ObKYOSxpGSq2VSovShlUHbxzo1PZ
         7p1D4SfIiIjWATnQe995OpDrMvRPwH5yYQDUrQKUhPRPBW1KYRQCUScplsh4iQ8Iq2Gf
         Q4pA==
X-Gm-Message-State: AOAM5321NnXCV1oQ1Mb8X++x5wtFAh3BNwb75NWpmFqJS1nm4Ccm5fVK
        BK55uCw0UUdZLRLAt0jGelVLLnoMgo8=
X-Google-Smtp-Source: ABdhPJwTi1XUgJ6nhOMiq0aAUqO6e6r/4hJxDgNGI7TvRM+qwGLGP7zgYJ1ojqaayjx4HqG8sn24NQ==
X-Received: by 2002:adf:d1ec:: with SMTP id g12mr15569904wrd.8.1643573854494;
        Sun, 30 Jan 2022 12:17:34 -0800 (PST)
Received: from smtpclient.apple ([2a01:e34:ec41:7980:c54:d02e:bc75:bfd])
        by smtp.gmail.com with ESMTPSA id o5sm11080493wrc.23.2022.01.30.12.17.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jan 2022 12:17:34 -0800 (PST)
From:   =?utf-8?Q?G=C3=A9ry_Ogam?= <gery.ogam@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Stage, test, and commit only some changes, then repeat
Message-Id: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
Date:   Sun, 30 Jan 2022 21:17:33 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to stage, test, and commit only *some* changes of the =
working tree, and then repeat this process with the remaining changes.

My current solution (published at =
https://stackoverflow.com/a/70914962/2326961):

1. Stage some changes:
   ```
   git add -p file
   ```
2. Save away the remaining changes:
   ```
   git diff >patch
   git stash push -k
   ```
3. Test the staged changes.
4. Commit the staged changes:
   ```
   git commit
   ```
5. Restore the remaining changes:
   ```
   git apply patch
   ```
6. Go to step 1.

It is not ideal because a) it uses a patch file for saving the remaining =
changes; b) it uses the stash only for setting the working tree to the =
index state.

It would be ideal if I could save *only* the remaining changes in the =
stash instead of resorting to a patch file. How to do it?

Best,

G=C3=A9ry Ogam


[Info syst=C3=A8me]
version git ::
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Wed Nov 10 22:23:07 =
PST 2021; root:xnu-7195.141.14~1/RELEASE_X86_64 x86_64
info compilateur : clang: 13.0.0 (clang-1300.0.29.3)
info libc : aucune information de libc disponible
$SHELL (typically, interactive shell): /bin/zsh


[Crochets activ=C3=A9s]=
