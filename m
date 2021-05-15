Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF5DC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 15:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407FD611C9
	for <git@archiver.kernel.org>; Sat, 15 May 2021 15:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhEOPaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEOPaC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 11:30:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD149C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 08:28:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 62so163982wmb.3
        for <git@vger.kernel.org>; Sat, 15 May 2021 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47SMlDx1j7ETuxG6fFAh9xl61uf2eZt8tWhrnMYWaco=;
        b=tz/NW4dP5c7z0Jt7TnSvl/wnPMusjHIMvyPWyMK4kPOjxB+4hBxwZY5dDrQFi0lgou
         2dby4WVzYYg1ee0rYbn0KlgajDkEWjHzzWa+9iP2TAjupwoRCE+3DqieE0bsgdwlUJQb
         TR1rjkqr/U90RK8vvwL0Y4c4beofb2otQ1T/BPUr5SLNR0mpWi4psDomTyPHYba07fyz
         KOJI9n5twhnoSH9PBPtPv2tW1qYxF1D7E1XjgwXsOd21G+btdiASwrGNbg6A0pLKUE1k
         Np5jk81UEkAuXdQ5pRI/0hlmbHSIuedr3FEtObwd4+bcNqW9LzzEzGWvI751pbsCcpXS
         wDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47SMlDx1j7ETuxG6fFAh9xl61uf2eZt8tWhrnMYWaco=;
        b=qeQnWRssDOQqPCIHwH75g0AZD3Z3Oatz+bVuQWmx+970XYmAJ7XHBzC66esUZuvVgD
         9EPLMeGJYF6xRcqQdxp/pEhfK3WsxIC/3OrX6nJKEUrgX+nJSkpJ2zbbXjVeQnTtFsyZ
         om0z9jYAcqtROGKE6iVICHxs8uAXHW98+zuvRekCE+DoLfkUAOr6mC7EiY55qYoGesmV
         Oe02jTd8Wn4mUT1Ur8UbzCRYrxlOR6Y3NcdJf7HsOU4ACQ1Y0T1KOL1hdcvt15gVrjE+
         MbUOJ6axr8Ro3kkzcdHfH1eWbqWswjKuLa8U3rXWAkcoNlsowonnknSVdex6rUzzZzmM
         a66Q==
X-Gm-Message-State: AOAM533x6tbsMf08oSkPSy2+iIoSm76ftB9BQhg3er9vEE/GJQ+qG2WP
        pHFJnRlG6BNtwY2toEMdD7o=
X-Google-Smtp-Source: ABdhPJw6lvUnPRP/lC2EQV0SPXv8xUFLtAsJB/ojDT9PF/SeQsPRkUMwlxoHF+YbB2ENoGXFBufYQQ==
X-Received: by 2002:a05:600c:4148:: with SMTP id h8mr5749116wmm.15.1621092526658;
        Sat, 15 May 2021 08:28:46 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001504451e90ab6b33.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1504:451e:90ab:6b33])
        by smtp.gmail.com with ESMTPSA id v18sm11617271wro.18.2021.05.15.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 08:28:46 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] document test_config & use it whenever possible
Date:   Sat, 15 May 2021 17:27:19 +0200
Message-Id: <20210515152721.885728-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
In-Reply-To: <20210514065508.247044-1-firminmartin24@gmail.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Fix wording.

---
Firmin Martin (2):
  t/README: document test_config
  t: use test_config whenever possible

 t/README                         | 15 +++++++++++++++
 t/t3200-branch.sh                |  9 +++------
 t/t3900-i18n-commit.sh           |  3 +--
 t/t4027-diff-submodule.sh        |  3 +--
 t/t4041-diff-submodule-option.sh |  3 +--
 t/t4205-log-pretty-formats.sh    |  8 +++-----
 t/t5505-remote.sh                |  3 +--
 t/t5526-fetch-submodules.sh      | 16 ++++------------
 t/t6006-rev-list-format.sh       |  5 ++---
 t/t7401-submodule-summary.sh     |  3 +--
 t/t7610-mergetool.sh             |  2 +-
 t/t7900-maintenance.sh           |  9 +++------
 12 files changed, 36 insertions(+), 43 deletions(-)

Range-diff against v1:
1:  ee35266247 ! 1:  07ca310549 t/README: document test_config
    @@ Commit message
         test_config is used over one thousand times in the test suite, yet not
         documented. Give it a place in the "Test harness library" section.
     
    +    Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
     
      ## t/README ##
    @@ t/README: library for your script to use.
     +   Set the configuration option <config-option> to <value>, and unset it at the
     +   end of the current test. For a similar purpose, test_config_global for
     +   global configuration is also available. Note, however, that test_config_*
    -+   should not be used under a subshell.
    ++   must not be used in a subshell.
     +  
     +   Example:
     +
2:  8a878755ef = 2:  279b5b3701 t: use test_config whenever possible
-- 
2.31.1.443.g67a420f573

