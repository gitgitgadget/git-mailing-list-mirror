Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA9C433FE
	for <git@archiver.kernel.org>; Fri,  6 May 2022 08:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389969AbiEFITH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390008AbiEFISw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 04:18:52 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB868988
        for <git@vger.kernel.org>; Fri,  6 May 2022 01:15:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r27so7321930iot.1
        for <git@vger.kernel.org>; Fri, 06 May 2022 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8OYmImC+A9CDuv6S+M5gWnH58qa1cO118SWr1fNX8GI=;
        b=fUUOmuadxhNi6j2pHYOQvKk1bkGz5ZtAYuVpIk7jC8pHwHA9yJvHfb4l8D75m6GS2L
         OlVEnBjfMcI4MktxHDsNQDg4MOUuSDCTKZxoWJ9faWHCMhgqxq8BHa/squd7alYKWu4x
         EI2QFN/L5ktt1cmCpi5M0urJDn4+Q83m1WvgUtsvFsex9KGL/TF4Od/y8pDiJMu4w3PD
         XCLTOEiRg/i1N0Td4DiNkrlbCQwTTu2ydwQMbdVrRGIigsQYqs6Dot3r9T6LStU2qxdb
         zRMjm9VHrPsKtoPj2bHjKsKEdiiWv/qCrOGNf3icWtVDUGEL2ydvLTRygURdsP3hw6bm
         8WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8OYmImC+A9CDuv6S+M5gWnH58qa1cO118SWr1fNX8GI=;
        b=jaYlPNmJ49emj75JIVpBIH3i6ddRyNae0fJhrMmGT5wGgiJAJcZBhw7ylV07T5r+DV
         ZgxEZTS8c5yoanUeIAEUSuvYdw6M3N41xmMdxmDOBKOXRT8lHaveQi+wAuLgxFO2whLy
         UjH6GWXda//pxTNYP2pZh+B4uW8OwtQ9OB2kwZzErQrxGj+yrQ73t2Qkb9S/U+hEOTWP
         jn6Q7id4kNHmCddkukIi4bm7Wg3mgBIbhjhPGeXQAOo+E+Aj/6Vzg9h+yjwPYPTwpaBr
         jdLNF9nx86mG9e0jA7tVmC9Qk2l6AaaOlzRcg0nrB1NVc+w3dTRWDwLKh1Kb6LkuryJG
         Prww==
X-Gm-Message-State: AOAM5311Id6/sib64FCX/iq/F9ALcCFIaaIXPHDdTeisMB+ZwrJ2u6Ut
        aOG/j/GwS6Exs+87Umthh/HIwV/uCGPASy7QvdVoXeQKMZHLeWCsO57bkA==
X-Google-Smtp-Source: ABdhPJxyEiP6rTPOC1aRB4meu8AUDpuAknRGjYMrihBaLwTQy+YpKPYmBGnycOB5bhV1ZgD+S+nQQO40/m0dN42SQiY=
X-Received: by 2002:a05:6602:58e:b0:65a:6b91:5251 with SMTP id
 v14-20020a056602058e00b0065a6b915251mr934550iox.206.1651824909050; Fri, 06
 May 2022 01:15:09 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 6 May 2022 16:14:56 +0800
Message-ID: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
Subject: Question about pre-merge and git merge octopus strategy
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am thinking about if git can "pre-merge" multiple branches, which
can check if merge
will have conflict, but not to merge them actually, like a option `--intend`.

I find "git merge-tree" can output merge result in stdout, which meets
my needs, but it can only
support two branches' merge.

So I find git merge with more than two branches can use octopus strategy.
What about git merge --no-commit? Which will not commit automatically,
so we can check if they have
confilct, and abort merge.

I think it's not useful for git merge-octopus, because if we meet a
merge conflict, we can't find
MERGE_HEAD at all! How can we abort this conflict merge?

--
ZheNing Hu
