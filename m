Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301D6C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1B322522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZb+HlaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAXDfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:06 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47712 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:06 -0500
Received: by mail-pf1-f201.google.com with SMTP id e62so513396pfh.14
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=HruV0RIEYH5FGbz6RizCWd0xiTXJD7QMaW86Yrw9xbg=;
        b=LZb+HlaYncwGzVo7O3qEgvJQHi2wWcWFCFVcYDON1BG4zu6Ut0ruLwYfu99KCrIwHE
         au/GmWS3OPWHEVAPij7M2kEHf6hLrbA1WDIpCCbUszAhMk8MK8y7v5E6Y/07ByclHyni
         DY8OQgic+olfEG/eLot5PKlF4y4GQkkmZ46XL2ekHMMyzgg0xjnswxZFDoamHZATjXI9
         Vxn51VCFiIOJGjJHPOpPDSzLXqYDoAy1qqtpnsZ1onlNrujUIORYkYgkZi1Xgm13fkOO
         39iCytp6x++gZd4t51TVhoUtDZuF/cOlB+BIu8pa2Qx5dKkc+wDasLVXnXla2kBn9rj/
         wL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=HruV0RIEYH5FGbz6RizCWd0xiTXJD7QMaW86Yrw9xbg=;
        b=bU6CY7+RvRUcJ+kRE9y7YoxS6YuczCvA/iBqVPAJ2jZd8gd3D0egmCbB/S/2wnJ2hG
         a6BSW8pE6WKd4JVCqSoKaTYDaOWO858uQUZPUxFlIBENyVXFdwobxs6muKGrsdzz97Nw
         WULsC9KDXKVcMuolIk6gfoTe6KoKsQdv1CeOPSV8dlpuzRRyMG7tXs3HIYGtaawUvIbi
         Wp+WiS2nDcK/5vux70apnT5dVXg6kMSb9edjfFlDPqbEl5iJItbck2dgxYxIcq6nCMaw
         NIYH9Xm0RAIW1jwPI2aqszIeRUnVvFOlPjFNr1njrtg24xKBDSliP295kd76EZ+e8MOn
         mv0w==
X-Gm-Message-State: APjAAAWB3n7rl9ehqySNEQ65bLmzy//vOPHz9Jf5VVYpF8M93JsSRoii
        QrP97EWrQlBcpbFeTlMWcbAi4QRSEWwf6V5XDtROwYLAtpeXx347pPrxEfSRDqw7MJ6IX6JZmYV
        mKA40zmPxzhzk39VW5jT6tn+GALVMdGkMM28mftCfWJeoGJvqIZdfPv9Li9dpZwSCIhoTbf9jyg
        ==
X-Google-Smtp-Source: APXvYqzy6wLjoFQ66xFGkiZGhNgjc9/D1AQ7GP3Eiyo9rWsLu4rCZW0+zdCdJigxK0lnqMyPlPqOQ5cD2oNf8z/KMQc=
X-Received: by 2002:a63:31d1:: with SMTP id x200mr1613764pgx.405.1579836905446;
 Thu, 23 Jan 2020 19:35:05 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:21 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 00/15] add git-bugreport tool
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

This topic branch depends on the patch mailed in
lore.kernel.org/git/20191211233820.185153-1-emilyshaffer@google.com in order to
display scopes for configs gathered during "bugreport: add config values from
safelist".

I'll summarize v4-v5. Since v4 has languished for some time, I don't
think an interdiff is too helpful, so I won't include one. Bonus, the
code is much simplified from some suggestions from Junio on how to
inspect objects, so I hope it's easy to review anyways.

Throughout, did some style changes away from C++ bad habits. Otherwise,
as listed:

Emily Shaffer (15):
  bugreport: add tool to generate debugging info
    (no change)
  help: move list_config_help to builtin/help
    Changed to agree with f3719846134

  bugreport: gather git version and build info
    Style only

  help: add shell-path to --build-options
    (no change)

  bugreport: add uname info
    Removed nodename for privacy reasons

  bugreport: add compiler info
    Moved glibc tattling into compat/.

    I appreciate a close look at this one - I think I understood the
    right way to go about a compat/ util but it's the first one I've
    done.

  bugreport: add curl version
    Moved curl tattling from git-http-fetch into git-remote-curl

  bugreport: include user interactive shell
    Stop depending on a compiler quirk to save us from segfault

  bugreport: generate config safelist based on docs
    Changed to agree with f3719846134
    Cleaned up script a little

  bugreport: add config values from safelist
    Made git-bugreport dependent on generated safelist header

  bugreport: collect list of populated hooks
    No change.
    Per https://lore.kernel.org/git/20191216235131.GL135450@google.com,
    should we even keep this patch?

  bugreport: count loose objects
    Use helpers from object-store.h instead of manually walking the
    filesystem.

  bugreport: add packed object summary
    Use helpers from object-store.h instead of manually walking the
    filesystem.

  bugreport: list contents of $OBJDIR/info
    (no change)

  bugreport: summarize contents of alternates file
    Rephrase commit message to explain why I can't use the helpers in
    object-store.h.


Thanks.
 - Emily


 .gitignore                              |   3 +
 Documentation/asciidoc.conf             |   8 +
 Documentation/asciidoctor-extensions.rb |   7 +
 Documentation/config/sendemail.txt      |  68 ++--
 Documentation/git-bugreport.txt         |  43 +++
 Makefile                                |  25 +-
 bugreport.c                             | 427 ++++++++++++++++++++++++
 builtin/help.c                          |  86 +++++
 compat/compiler.h                       |  24 ++
 generate-bugreport-config-safelist.sh   |  22 ++
 generate-cmdlist.sh                     |  19 --
 generate-configlist.sh                  |  24 ++
 help.c                                  | 133 ++------
 help.h                                  |   2 +-
 remote-curl.c                           |   8 +
 t/t0091-bugreport.sh                    |  41 +++
 16 files changed, 780 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-bugreport-config-safelist.sh
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.25.0.341.g760bfbb309-goog

