Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8569DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601E660EBB
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhJLVGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhJLVGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:06:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEBC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 14:04:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x4so369379pln.5
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LzBMWvWnz9pu3j21ON/2pPQglYfn9EcYkB9psxxocAw=;
        b=aa1RR1ZffdTq7Y7xPUB8URM6M6yGcKg/zhCmM5crWx+XB2CZvUr3iLMdRwa3iSHs9q
         ovnqstB/QQH8+BPaR2WtszU4xfLDZiahsxnTeWnt5kgnvgWiTvJ0udDLfLVhbgrDuBrS
         hwlZSJzkxyOXqXI1h/rGcLzeZ9BX0YZXpu7jL6vZH2S2mRkC7N3zJ+VaaSWGUZ4t3140
         TxHqdKzQOe0l1bPxcaYZ7Lfp2VJE62T238+wytjFSFLQks7ka4dYEArC9E8HtcAsr+ph
         06QUiNovwJt5Kbp8Je0hh/xHVyUeE1OyaSK54Opp9JgM3GdS6BfApU855ns6/APOgFCu
         2vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LzBMWvWnz9pu3j21ON/2pPQglYfn9EcYkB9psxxocAw=;
        b=DkVvnV2xLznzIIquFBiCwrJUJe8hfS82cKdkwjCi6ig+sBMHysEWbYn6dGx3bZo/N6
         phyWtXMh3kvKWVUU2LY0/yDbMIxHPqm0ZhKpbC1or6aKIyAFBvkZbAzYTeWiFBR5hY/F
         A+En0kXLknYGk46sQ0X1TSFwGrbkFgGVEyAAgW2ROaVr7ARJoHOnAqaCVqn1hhZBuA3h
         2PipB/IpQtPwWhw0wa5IutTX4lkPGpZ0FTPeoKv+Xlq7lO8L8YP5iBQ4/wlQUrffYMzK
         upAOoxYzeAoAEodRV2lhTaUAI5c/+8Lt2b/scEtXQoftMtD+n2YGdAlxgdniVrvCMmkh
         A1Jw==
X-Gm-Message-State: AOAM531ykm9+mNc0mmy5zgHfwbIB1xw631uFN+2OXZO6ul7Nw/psa5Xf
        PeROIYf3003or55mqmmCANysf53JkPQO6n0rpKeZv5UlA+0=
X-Google-Smtp-Source: ABdhPJz5J61gg44NaGr2jBVbLinka5ZrVFO0ydtsh0+nep04pQrZtikNZcOTtoGvCB6O4w1alfr36biBEhkZ9taLoZU=
X-Received: by 2002:a17:90a:c70d:: with SMTP id o13mr8739486pjt.143.1634072654924;
 Tue, 12 Oct 2021 14:04:14 -0700 (PDT)
MIME-Version: 1.0
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 12 Oct 2021 14:03:39 -0700
Message-ID: <CAMe9rOrononRUYK0HmW_tknApUV+ZJeDBwOYMa1Ax-VHXZmoJQ@mail.gmail.com>
Subject: Commit ae1a7eefff may have broken git behind a firewall
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://github.com/git/git/commit/ae1a7eefff

may have broken git behind a firewall:

https://bugzilla.redhat.com/show_bug.cgi?id=2013288

I am behind a firewall and using gitproxy:

exec socat - socks4:proxy-server-name:$1:$2

I got

$ git clone git://gcc.gnu.org/git/gcc.git
Cloning into 'gcc'...
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
$

Both

$ git clone --depth 1 git://gcc.gnu.org/git/gcc.git

and

$ git clone https://gcc.gnu.org/git/gcc.git

work.

$ git -c protocol.version=1 clone git://gcc.gnu.org/git/gcc.git

also works.

-- 
H.J.
