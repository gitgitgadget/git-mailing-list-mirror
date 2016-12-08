Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42FC420259
	for <e@80x24.org>; Thu,  8 Dec 2016 11:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbcLHLqc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 06:46:32 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35111 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbcLHLqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 06:46:30 -0500
Received: by mail-wm0-f46.google.com with SMTP id a197so212962649wmd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bossastudios-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=fNUCdNuq+9cHW9Yj7acf4J+ynuzYL+gN66F6XATTz2g=;
        b=NUDfKFGT24sTf43yoaRmvebVEidM77Ek2qg66m2TuRwIQwCpxw9QZrDTi2FBYMn/mB
         TAPGHHaox9kHhjPC/EXbfsMf3wCj8XsJal0UDEdBbMm3PqJ//IHOMOHBGwdTpFkQmge5
         cU7pI5kgZDO6UA5XvyHSUeVyDcQgeu/GxDcoC71zT+h1BdxZkiR32ActKsTCD4e+cVvN
         jR3afAsNAFYmo+rTLUk06Ezg7QnUC2ii5+XjjvdxGUX7cAWeFM897K/uMO9ZrOs6ZD6f
         ggMCiluQ3SfvOFi3D7tBYnsMf6KQCh2bINOz5xfjk8w0Y5pegf1f3y1jZTfxF5ZAd1oX
         MygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fNUCdNuq+9cHW9Yj7acf4J+ynuzYL+gN66F6XATTz2g=;
        b=mOw7xDSiasQE9Erp2A1YuMPL02Q5PPyYuCDV3ySXxHnmO8vGryzOZyxYoq5RTo5Hq8
         L01V+KYCr9Uu3cQJslr8nBE8czJz6gCQDgEaPBHkunmy7oHSbEkgrlrFXxRSYoSmrxR+
         ShBhP5M3Y+Nmrcl8p815lBxGsXB4b1LiuNd5r6S1rpSLKJm5q3cLXQ+P7TyLslNx+6Qv
         9Q/fpnoKIaMyAwSc25jSlNqQAhbLia5/UYnhkY5oUrvbUOE82p5SH0M9k7grsMmKQTrf
         9uCUS+seE6ypM363jlXLT0kwZixdCUU32BznBrnfkquhMU5d/pVlNHgLK0NEUXGRuhJ/
         B6UQ==
X-Gm-Message-State: AKaTC01rQ3TD+J+02XpkHjVMwIskQ/qQA9TR9n8tv/Idvbmrj6ReCa3knzMfvEvxCgBlzWd2vXoJzUjykDJFNm6W
X-Received: by 10.28.170.134 with SMTP id t128mr1719758wme.29.1481197589061;
 Thu, 08 Dec 2016 03:46:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.14.9 with HTTP; Thu, 8 Dec 2016 03:46:28 -0800 (PST)
From:   Nick Warr <nick.warr@bossastudios.com>
Date:   Thu, 8 Dec 2016 11:46:28 +0000
Message-ID: <CABW+60x0PSw7uNQZg4SeN7EAbNpraR_HWvnVFz1-fVLYX=B8RQ@mail.gmail.com>
Subject: Serious bug with Git-2.11.0-64-bit and Git-LFS
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using Git-2.11.0 with the latest git-lfs 1.5.2 (also tested with
1.5.3) cloning from our locally hosted gitlab CE server via HTTPS.

 When cloning a repo (large, 3.3 gig in git, 10.3 in LFS)  for the
first time the clone will finish the checkout of the git part, then
when it starts downloading the LFS parts it will reliably finish with
a smudge filter error.

 This leaves the repo in an unstable condition, you can then fetch the
lfs part without issue, but checking out the lfs files or trying a git
reset --hard will continue to spit out the same error. As you can see,
the actual error is not particularly useful.

fatal: workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi
Effects/Effects/Debris/Meshes/debris_junk.FBX: smudge filter lfs
failed
Unknown command ""

Possibly it's due to the file extension being all capital letters, we
did manage to change the error by recommitting the file with a
lowercase extension, but it failed on the next file (which also had a
capital letter extension).

 This has happened on multiple fresh windows 10 64 bit installs,
different machines and target directories (to hopefully remove the
possibility of file permissions) where cloning is taking place.

The solution is to back level to Git 2.10.2 and the error disappears.

More than willing to provide any further information,

Nick Warr
