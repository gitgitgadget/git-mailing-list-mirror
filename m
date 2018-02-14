Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005F41F404
	for <e@80x24.org>; Wed, 14 Feb 2018 05:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbeBNFHC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 00:07:02 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:38861 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeBNFHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 00:07:01 -0500
Received: by mail-it0-f48.google.com with SMTP id k6so13570296ita.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 21:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mmBryuVYhcRV5rfBAbqqxS320biU0wc+xP3pdYzrdKk=;
        b=bK9z1dq6Kb5hHQ8CrR3IgpqaW9QCrDFC9EvaEmEiHH+VijkV5tDgyoL5TEy38ClJjK
         hp/zxkLE01Zb/LAa7MTCgVxsQnZ3rc8JH08jw004zJymCLGkF1cdwO3t7smzvFFIwiHp
         SvfiIN7SoETW+iWU5W64XHgH/qFdJKSlWQSciTt1KG1clIrMkF9DiRk47HdHKVNcS4xC
         OATua4C/09QLmm5pVFm5/INhovAU5lRwIuNxVx+UqNX3grujDu/knNDlb70k9qbbPBRZ
         FMQtsYZRpbjjkZ75BJdaV9f8PbrBoxuGCES5kWCCZWknTuHAPQmhfecWx+yyI7Xhitvn
         u6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mmBryuVYhcRV5rfBAbqqxS320biU0wc+xP3pdYzrdKk=;
        b=aeUKgUC88AO9nMAgX5aHDnf3sPWv18Geu5IDZZuvzmlKNLaccMrFyA8MRPSjzOH+36
         Y+ixON2EVpf+7LUFU6KtoiHf+4AfCd1J/20p2ypGgJtI+mBrnhCewjyX1Yh2mS1PAwH4
         fcs6/PUuH/ax+cdC58yxvUZQ4A+l83rqO4XZYJHRFpFujqjkr3YjXB+KM90FG/MV1SV+
         n3PuSt60RE26XQrSqdN+C4UWdThSee9nRRoaxf4320JOgfSjr9Oj04RvIZZlOxQduvIl
         pm3Mcwr9N/5OM50HjrRHBMaEFlbxQaoQZlXu03ZFd0JrfOypAXV5mI4IuBOstyHAFCbH
         WN4A==
X-Gm-Message-State: APf1xPCC9pvdtxV5WmhC+p1cK75yN9QlVD6DAH90o4CQCrHQuCASeisT
        +ZRd3N5E9ybazWEPo9+8VgcGwLT7BgpG4Q2ETDcI6HPJ
X-Google-Smtp-Source: AH8x224DcUnnrI4kMHvwUkaDhHAUP3PTqrpvFBwcd71NyFlMzHNV1Y7T4Yc//YPsSniUims2L6PorHdxnDsBYyZmjF4=
X-Received: by 10.36.86.134 with SMTP id o128mr4301494itb.56.1518584820801;
 Tue, 13 Feb 2018 21:07:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.197.136 with HTTP; Tue, 13 Feb 2018 21:06:40 -0800 (PST)
From:   Ciro Santilli <ciro.santilli@gmail.com>
Date:   Wed, 14 Feb 2018 05:06:40 +0000
Message-ID: <CAFXrp_cP-WaXO27VV1OcVakfmDX0b6M62Qz1j4XRCbtQJzFfnw@mail.gmail.com>
Subject: Can we make git clone --recurse-submodules --shallow-submodules work
 for commits that are not on tags or branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a git repo with large submodules, notably the Linux kernel, and
shallow clone saves a lot of time.

However, QEMU is also a submodule, which I don't control, and QEMU has
submodules which don't point to commits that are not on any tag or
branch, so:

 git clone --recurse-submodules --shallow-submodules git://git.qemu.org/qemu.git

currently fails with:

error: Server does not allow request for unadvertised object
22ead3e0bfdb87516656453336160e0a37b066bf
Fetched in submodule path 'capstone', but it did not contain
22ead3e0bfdb87516656453336160e0a37b066bf. Direct fetching of that
commit failed.

on git 2.16.1.

Furthermore, I reproduce this locally with direct filesystem clones:
https://github.com/cirosantilli/test-git-web-interface/blob/15335d3002a3e64fc5756b69fb832a733aa63fb9/shallow-submodule.sh#L158
and on GitHub, so I'm guessing it is not just the settings for a
specific server?

Would it be possible to make that work, or are there fundamental
reasons why it is not possible?

Here is my use case repo, at the point of the ugly workaround I'm
having to do: https://github.com/cirosantilli/linux-kernel-module-cheat/blob/a14c95346cfd9d2e7b2e475b0981aa71d819c20b/configure#L23

Some more context:
https://stackoverflow.com/questions/2144406/git-shallow-submodules/47374702#47374702

This would make some embedded people happy.
