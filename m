Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6241F597
	for <e@80x24.org>; Mon, 30 Jul 2018 09:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeG3LEO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 07:04:14 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52643 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeG3LEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 07:04:14 -0400
Received: by mail-it0-f66.google.com with SMTP id d9-v6so16098147itf.2
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PCju3bVaexDwAnpqHU3MRlJixBmUZbaAuc8M7FKOsJc=;
        b=T3GW7Yu8hUtvuDrFieiitLs9dM7bpp0nSr5NYPKG1l9NsWFeQToL1e6P4CZqBo8ZKX
         Xg3kVVeGm7Vz1kyiK+9rJFbHHgf+ywHO0ZsleDD2nJdi/TfyFco/YNMW7G9cxMh9cfW4
         yiBJhOAVsQV6oh4cAkIj8weUR5PUzlovGjysps+Q4X9Y1RYiG6n/hQl3GN+HdrUtBc6G
         nlYAxzS3UENrmlBjrwHjjWmCbY1KxhzRYd35+b8JEyGbEv5z+r6tTeS6TKyBvIcls40J
         x8tl82OKZTBFOSKbE/ELAiyQIwUdMyklu3zQXGDtqEkVJPOejQm9jR4aajJoYBsA5XBH
         AshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PCju3bVaexDwAnpqHU3MRlJixBmUZbaAuc8M7FKOsJc=;
        b=q2sPZ7vgQCQz/TILap0TX/by/WPdD0y3s+9BQ9Mc/Ji5d3bTndJHcg86EayHru8m2R
         U3tJ964j7nFcHvvd8erTs8XHaOCmJuT0FSo5OWxPWGvxAeb8wL+xFU4uA2CzDLM6FhIc
         6hRWqmGYt9qQzBdqw2n4a0aUNyyMdIadRJzYo8H9fnlOZw8Tcp+koXYqre8kNdhB0qic
         nEM/QHQmtsWn5dDFUlPEeCdwXdXt/LWZGu7IV5cU7iz5EGmibxvcO9a6KYeBE6kZ9tIq
         uStFekpZZwn5yMSoqacNwFbKzTmWUPPUI3xElUHzgRHSiW7jyfuTY6jtPh9CULU5uaps
         JWeA==
X-Gm-Message-State: AOUpUlFA85aJD6kzACyl3Q3ljuPGP6WEzB13pULjH5HQBaOqdJSx6Kqd
        yzbiPwAYmwipPbFa2gKWmxwIQOji
X-Google-Smtp-Source: AAOMgpf8o3OxeVIaayi/Lxq1I3nXvevOQyk8JUw4M1/mihole/KriY3wUp4mXv/gEboIydASh5SLxQ==
X-Received: by 2002:a24:cb03:: with SMTP id u3-v6mr13534185itg.15.1532943006568;
        Mon, 30 Jul 2018 02:30:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id d10-v6sm3341105iob.4.2018.07.30.02.30.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 02:30:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
Date:   Mon, 30 Jul 2018 05:29:27 -0400
Message-Id: <20180730092929.71114-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes bugs causing corruption of the root commit when
"rebase -i --root" is used to swap in a new root commit. In particular,
the "author" header has trailing garbage. Some tools handle the
corruption somewhat gracefully by showing a bogus date, but others barf
on it (gitk, for instance). git-fsck correctly identifies the
corruption. I discovered this after git-rebase corrupted one of my own
projects.

Unfortunately, these bugs (from js/sequencer-and-root-commits) made it
into the v2.18.0 release. It's worrying that a released Git can be
creating corrupt commits, but fortunately "rebase -i --root" is not
likely used often (especially on well-established projects).
Nevertheless, it may be 'maint' worthy and applies cleanly there.

It was only after I diagnosed and fixed these bugs that I thought to
check 'pu' and discovered that Akinori MUSHA already made a stab[1] at
fixing one of the three bugs which this series fixes. Akinori's fix has
the somewhat undesirable property that it adds an extra blank line to
the end of the script, as Phillip correctly pointed out in review[2].
Patch 2/2 of this series has the more "correct" fix, in addition to
fixing another bug.

Moreover, patch 2/2 of this series provides a more thorough fix overall
than Akinori, so it may make sense to replace his patch with this
series, though perhaps keep the test his patch adds to augment the
strict test of the "author" header added by this series.

[1]: https://public-inbox.org/git/86a7qwpt9g.knu@iDaemons.org/
[2]: https://public-inbox.org/git/f5b56540-d26a-044e-5f46-1d975f889d06@talktalk.net/

Eric Sunshine (2):
  sequencer: fix "rebase -i --root" corrupting author header
  sequencer: fix "rebase -i --root" corrupting author header timezone

 sequencer.c                   |  9 +++++++--
 t/t3404-rebase-interactive.sh | 10 +++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.18.0.597.ga71716f1ad

