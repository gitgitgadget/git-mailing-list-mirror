Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD27C7619A
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 09:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDBJRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDBJRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 05:17:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759AC171
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 02:17:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so106217519edo.2
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680427062;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kiDpNY3vQdLmQA4/7ycAzjUCFzXd5ywrJC+7JcDVkrU=;
        b=lL9Q0Ecapp9Rc2ubjhJKWPDdMXX5pJ3pz+dvb/zbTcxppmpCMANvQ8qKy/RAeYgofd
         bEicg0MptqQX1fr331pnS4fVgpz/YY/H4hSndWFxRw68czQvEFFPZQvYbuajYhFAg1US
         4aUL5DixhXAH7qXJifjiiMisf2QBIT259NwDVif6Cp6vPkLDmdbxX8fI8HCnlJApnpjE
         drD7KtbnIiOfSS0u2nNeaVOGHPBO2VDEFD7b1On+9FjsfF4pYTTX8XbvUORHUJIekTLX
         Bce6XblkSUEAuCXCynoH3hPQ6GjoJGo/FrE2GvvCRImZ5Fyc6K9Fiijt7Dr+zlJK9OHH
         /21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680427062;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiDpNY3vQdLmQA4/7ycAzjUCFzXd5ywrJC+7JcDVkrU=;
        b=5PoEVtUDOkIUsGmCsMb22OL75oPzagjYbaV0IHpmVJr302yINxata1By43ZXNx1l77
         c82AiODvrUMZh9zsrd77ONBI4cORW/8UD04Vf12lfPeYYfnOmKLAG0vfnpKKPUmLZYJV
         VFku+GZvUY6BFZMevJ1LZHRfjxALGfHixpff/N7t5010DDyVrm1WHxHgBsQhozdeiPbc
         xHWDaryxo/1yIZ5SmV+lKY8FJPeDlEm5of7MzhZNkoy6Cc+4ibDEiJQmpHwNx2k63thW
         bODxCvQ1rPubieJ6oknrsDlCXNECAT8bKJnJYFX/tCsJWsp7XPO4DXSZpisnGBXVYitx
         1i1A==
X-Gm-Message-State: AAQBX9fmCwLHJWRYTVWb2Vkg9rTkgbWz7+f8mB5lOMoRO/mc5jrUjgpB
        rddFZaxEx+JBuJdU15dNZe2iSV+wGW7VcS3gHpEJamm7bRW0vAxS
X-Google-Smtp-Source: AKy350YovS/3W3IqtqqWvR6R05u1i65jhI/Bye/qz8MFOmcktnJAovrjQfiO5GHRGKZduxnFEbAVkuosf2k12SCzZ74=
X-Received: by 2002:a17:906:4ac5:b0:92f:cbfe:1635 with SMTP id
 u5-20020a1709064ac500b0092fcbfe1635mr17066717ejt.6.1680427061720; Sun, 02 Apr
 2023 02:17:41 -0700 (PDT)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sun, 2 Apr 2023 17:17:30 +0800
Message-ID: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
Subject: git revert with partial commit.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi here,

I want to revert a previous commit partially, as follows:

werner@X10DAi:~$ git log |grep -A3 -B5 -m1 texstudio
commit f18fbd1e16a1ca4215621768d17858c036086608
Author: Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sun Aug 1 20:01:02 2021 +0800

    deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
    deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
    modified:   Public/repo/github.com/Dushistov/sdcv.git.sh
    deleted:    Public/repo/github.com/goldendict/stardict-relative/bigdict

More specifically, I just want to revert the following ones:

    deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
    deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh

Is this possible?

Regards,
Zhao
-- 
Assoc. Prof. Hongsheng Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
No. 473, Quannan West Street, Xindu District, Xingtai, Hebei province
