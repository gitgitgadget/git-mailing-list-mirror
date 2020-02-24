Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF171C35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925122082E
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWE1VxrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBXJNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:04 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40742 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgBXJJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:56 -0500
Received: by mail-yw1-f65.google.com with SMTP id i126so4889794ywe.7
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frOCZO6BkU7Kav5TlROV6nOW5fL22SKyjNnuHyHvXNE=;
        b=uWE1VxrIv4CjifBDP3clXxZjTL1Mo31kq5B81qs5wOoF9oQgk3khj0qusWekq/dhYf
         DmvwyrM0SHwgUOQckwekymCkgvPQZ0qMY+MqNG7vsWLAynHqEjjUpkY8QwOEVLuGzVAD
         MdrHTM4DPJapbiTL2hdRx7sGaSd/qJ4hMxs/l3/5YTA+JT3HtL7bON5V4HhE579bEK/g
         qn4eeNMGTcLd8PP7PDcktjC/Q0u+fx/NaPT7Uvrcb1NLvWM10xJWn4bWf87pBjiudH5L
         ZRdSqY45a7OmI1IEfAA6vZqw8ycX/RBlB+x0XM9fL/LX5mQgkD8SHcBzYCtfCoHm97dR
         YBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=frOCZO6BkU7Kav5TlROV6nOW5fL22SKyjNnuHyHvXNE=;
        b=NAniJnAl03tLB2b6HxwgOfdFCbBdOjfPVfSZCrHUW/AMDq2Tx6FRbyCz+6dtvQ2m34
         Wx4/QN+SxceT6+3ZgNIykUSwy7oF60IVQqvbkmjwLBZ2PkIC5PdQ64Zqvj4zMi1M8Gjp
         CUVUi/jM7LgKo02Z2JwoQuXQWDhIHRs04XyC9OUcg0OUKdh8dprZU1p3qU5QaQPTzCJG
         Bg1bFPJBslgA2qDQYTX4AlZIamFlAJSvymXoQtpL+pg+GNtHTjZiX8COJIrJ8V9PNXpj
         Y06kS2pU6i80cyvyFB4Ssk4i8EXR+so4VnewLnfzph8QAvQRMF+G65cdxZ+AIfwez2hl
         4WaQ==
X-Gm-Message-State: APjAAAUEqqSVwjgi8SH8oYegSyc2wkVeC9+pivKuIsoDTrx6rNyPZsQD
        zXzLc+8VBkWZXuSzHbS/k/e+PcYN
X-Google-Smtp-Source: APXvYqy4eF9AMfVYIbLLGgCQzmLLp2jApLuq0HxQVnQ16DVxBz/ZOWeqXrkeqGTUBlZ321XR6D3N/w==
X-Received: by 2002:a81:8d01:: with SMTP id d1mr39514227ywg.409.1582535394837;
        Mon, 24 Feb 2020 01:09:54 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g29sm5045988ywk.31.2020.02.24.01.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 01:09:54 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cameron Gunnin <cameron.gunnin@synopsys.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] git-worktree: fix "add" being fooled by suffix matching
Date:   Mon, 24 Feb 2020 04:08:45 -0500
Message-Id: <20200224090848.54321-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
References: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree add <path>" performs various checks before approving
<path> as a valid location for the new worktree. One such check is
asking whether <path> is already a registered worktree. Unfortunately,
this check can be fooled by the magic suffix matching performed by
find_worktree() as a convenience to minimize typing when identifying
worktrees on the command-line.

That the check could be fooled was a known issue, and a special-case
work-around for accidental matching against the main worktree was
already in place even when the validation check was first
implemented[1]. Since that time, an additional case of accidental suffix
matching has been reported[2], which was not covered by the existing
special case.

Rather than adding more band-aids to the validation to work around magic
matching performed by find_worktree(), this patch series fixes the
problem once and for all by locating a worktree deterministically based
only on pathname.

[1]: https://lore.kernel.org/git/CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com/
[2]: https://lore.kernel.org/git/0308570E-AAA3-43B8-A592-F4DA9760DBED@synopsys.com/

Eric Sunshine (3):
  worktree: improve find_worktree() documentation
  worktree: add utility to find worktree by pathname
  worktree: don't allow "add" validation to be fooled by suffix matching

 builtin/worktree.c      |  9 +--------
 t/t2400-worktree-add.sh |  9 +++++++++
 worktree.c              | 16 ++++++++++------
 worktree.h              | 20 ++++++++++++++++++--
 4 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.25.1.526.gf05a752211

