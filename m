Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608ECC11D05
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34163208C4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldOAdjv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBTOPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:15:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32841 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTOPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:15:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so4870237wrt.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YfXzIg0+we8LgF75TdO0ZhbpE4kK6RNtPgmS7qmZHE=;
        b=ldOAdjv2kxf9uooPw0K/E+aR9GPI8Ki4u48psM3X80ZRt1n+nnZBSAh69rnseJuyJl
         tBo+TgGz9JD3UnzO0U53uoY7/nPRubG2ZPHNxyOsDphkEg/gQoBIv5DgUnMreb5E1AYv
         719Sqgo7dSD0kdCxL1/UwdrdiN/FTDX8jc+AVsaH8275HJGd5JsVPkk5ptttShFxJzBZ
         wyKDkPLbH/lNvpPEOBMbb2X+3H5vf3UL5n2cUVeWJpS8IPsUhf51qkIVPvl3gP6iBwGe
         8HpBB65r2AEPyKDBO9s43VH9kgSWO0h1+Z1stmAAgJT2cg4kxP4mby9pt+KSc1MA9x0o
         oALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8YfXzIg0+we8LgF75TdO0ZhbpE4kK6RNtPgmS7qmZHE=;
        b=C0tIK63MkWDhILHz0apnTM3Cfg3UNM5gNKQaY/3YuFCkzaw0E+qvx4lzFBqLrOWvbu
         pqxAgsvNU5eD4ovRMuScV7ifojJ/wNWht8VRHPoyIyOh/LyCzph0DUv+TRE/g8hGTC6S
         N6b9ZW4Crt3tNtCsBE7PnCWHREHrFLTHVxMGtF9SwGyr3D9jWl/VR4tikEJ2VQ7G5Vb8
         4A8VoPFmwh51uTro0c8gqE6Mg59kfjMF4fsAu9juPq/iXKNmYR/WYY3Q2utIl3T1IXdo
         GSBbHRyCqCvzv0BFfeVMqdi367wcUmgsATD3mT5LMIg6viCrEW+2XNyEIWZEL7Hn8j+j
         TiCg==
X-Gm-Message-State: APjAAAUPwpTSubuKlsc0XeJ/trZ0x1QSlF6JG19QrJ4A1voOpJoQRSDn
        65Rp8sYeDaSpAx49vDego1Bb3lR1
X-Google-Smtp-Source: APXvYqzYt8Zj/cbF+Q6WmyvARzqdtLZv3Tqa6UapnKynkdzxVIXW4t+gUbdjySyBYLNE9uzdJ+wH6g==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr41117236wru.181.1582208121358;
        Thu, 20 Feb 2020 06:15:21 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id v15sm4933614wrf.7.2020.02.20.06.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:15:20 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH v2 0/5] am: provide a replacement for "cat .git/rebase-apply/patch"
Date:   Thu, 20 Feb 2020 15:15:14 +0100
Message-Id: <20200220141519.28315-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

When "git am --show-current-patch" was added in commit 984913a210 ("am:
add --show-current-patch", 2018-02-12), "git am" started recommending it
as a replacement for .git/rebase-merge/patch.  Unfortunately the suggestion
is misguided; for example, the output "git am --show-current-patch" cannot
be passed to "git apply" if it is encoded as quoted-printable or base64.

This series adds a new mode to "git am --show-current-patch" in order to
straighten the suggestion.  "--show-current-patch" grows an optional
argument, where the default behavior can now also be obtained with
"--show-current-patch=raw" and ".git/rebase-apply/patch" can be retrieved
with "--show-current-patch=diff".

This requires a little surgery in patches 1 and 2 in order to convert
--show-current-patch from OPTION_CMDMODE to OPTION_CALLBACK.  After this,
the last two patches implement the new syntax and feature.

Thanks,

Paolo

v1->v2: - split testcases to a separate patch [Junio]
	- improve commit messages [Junio]
	- fix spacing in designated initializer [Junio]
	- use test_i18ngrep [Eric]
	- replace abort with BUG [Eric]
	- replace "diff|raw" with "(diff|raw)" in docs and help [Eric]
	- improve docs wording [Eric]

Paolo Bonzini (5):
  parse-options: add testcases for OPT_CMDMODE()
  parse-options: convert "command mode" to a flag
  am: convert "resume" variable to a struct
  am: support --show-current-patch=raw as a synonym
    for--show-current-patch
  am: support --show-current-patch=diff to retrieve
    .git/rebase-apply/patch

 Documentation/git-am.txt               | 10 +--
 builtin/am.c                           | 96 ++++++++++++++++++++------
 contrib/completion/git-completion.bash |  5 ++
 parse-options.c                        | 20 +++---
 parse-options.h                        |  8 +--
 t/helper/test-parse-options.c          |  2 +
 t/t0040-parse-options.sh               | 18 +++++
 t/t4150-am.sh                          | 20 ++++++
 8 files changed, 140 insertions(+), 39 deletions(-)

-- 
2.21.1

