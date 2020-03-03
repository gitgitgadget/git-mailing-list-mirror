Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BAC3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BED620857
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9LJiCcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgCCRI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:27 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53824 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgCCRI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:27 -0500
Received: by mail-wm1-f45.google.com with SMTP id g134so2792035wme.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BADsMnhBpMKXOeHKmVs5ns9ktlhqiF5d36YcYu5/KEU=;
        b=S9LJiCcrAAxmxk3AA393/4AUt6MTQRHf+DLOKI4nsspCAxeb7uElDYYAjXoPBX1ZS4
         /0aj5KBndHLjcREfpYl9SW9JeN8Kk7HH8GxkyjI85IXSJmYxkgBsjOKlY/8cW/5PS+y+
         gfPHhg8F2lNfRfcO44xI0X0yf6BPHmgiM9BYbkhGzO2+Oqvq4r+P2mb4wxpcdD5V+ETX
         YZXo7qL4yuRUIDCJeqnnLTQch+5CLAN4l13NHWrOPTgeohohdGvjmXG3D435pEuEnvf5
         8MMl5C+s0p9EfGqg0xfRmSeHzRLkTiyDW/FkPDwxD0N83ihFdovAVxZ9eA1nsOswQqY2
         Y6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BADsMnhBpMKXOeHKmVs5ns9ktlhqiF5d36YcYu5/KEU=;
        b=p0/+VT5dUQ1nBjhaUTtXQ54b2C+O/H92n8Eo5r8PSdl7aAVtF8xsKK9xzx1TK9eMQM
         zUZI4VvACLhrZpxCiVzna0hHCB2K+F2zq31gzQn1EpkXPdVekuDG0UWosATCh574Ut0x
         RriElAfOn3via2a+pFcrBTveeAZ94+j2PiCR4sBW5gIl5B4jQhn1bH/aXgHdVbdZRcJB
         b/OZy4nTIKAIT/9lwyvlhtaXDh45+EUbBDE53mwivGNzLtFWQ81CW1C80kyz8/72rR5K
         9eoHpBZfPccFpQQI/wkqofmfwQyv3lc2N0l7um3J7uIFV8AdxLolxBzef83VSvSQladJ
         WVbQ==
X-Gm-Message-State: ANhLgQ0xS/SAvyTe9JszMAryLhLj3j+xioyfAEmZEeQN/qtXF/nDT2HR
        C0y6BdDHbNOkiwjU2rWFEABuurYC8xI=
X-Google-Smtp-Source: ADFU+vsFn0iQcUW5GZ2V+IPRWqFUh1o2LaNNimA0VyD8Kshd/yAPvrRE2NgDOimKeCvFNmsikcUDlw==
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr5490243wmm.180.1583255303673;
        Tue, 03 Mar 2020 09:08:23 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 16sm4746576wmi.0.2020.03.03.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:08:22 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 0/5] doc: --recurse-submodules
Date:   Tue,  3 Mar 2020 18:07:35 +0100
Message-Id: <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Incorporated the comments of Philippe Blain.

Other changes since v1:
- Patch 4: also updated a little the man page of git fetch and git pull.
- Added a new patch to refer to 'active' submodules.

Damien Robert (5):
  doc: list all commands affected by submodule.recurse
  doc: document --recurse-submodules for reset and restore
  doc: explain how to deactivate recurse.submodule completely
  doc: be more precise on (fetch|push).recurseSubmodules
  doc: --recurse-submodules only apply to active submodules

 Documentation/config/fetch.txt     |  6 ++++--
 Documentation/config/push.txt      |  3 +++
 Documentation/config/submodule.txt | 12 ++++++++++--
 Documentation/fetch-options.txt    |  9 +++++----
 Documentation/git-checkout.txt     |  2 +-
 Documentation/git-grep.txt         |  2 +-
 Documentation/git-pull.txt         |  5 ++---
 Documentation/git-read-tree.txt    |  2 +-
 Documentation/git-reset.txt        |  6 ++++++
 Documentation/git-restore.txt      | 10 ++++++++++
 Documentation/git-switch.txt       |  2 +-
 Documentation/gitsubmodules.txt    |  3 ++-
 12 files changed, 46 insertions(+), 16 deletions(-)

-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

