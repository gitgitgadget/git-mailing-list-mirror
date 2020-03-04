Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1BFC3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5AC2146E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="pF5Hn/yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCDLsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:48:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45748 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgCDLsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:48:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so906100pls.12
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmfJ30fLh0asbMxYSTs09SsUwjpHmjZj2bV6Ge1vOhM=;
        b=pF5Hn/yTk7C406flC3XVrO29QlcXiMMxNmeTvxLoO8nP7wwKzqvt99xyVNZC2CH0JD
         D0acmOetd+VxQtWlsdV7PlwVizM1t8roCMArs+H5H+vFi18gdWWfRNPTLbLzHwAaXxlt
         Lixpq26ekX/PF5FTVl7GV+ntC4/PRJjV4i/M23a5c0dm8K6ZACTpuSBzcilFY6kc2Lfi
         H/oF1Wdu7GjCriDwB8VjCZK+2ndTC8ioIJJEtw0Y2zdoluOwecVl0eCIfG9foMoU57xT
         9ePRLTQmx1Fc2Wh9CBSVMYhKZkPq3Xc4iMIWtM2h8cEu7akvlqF10oB0BUXOiqUERBJn
         Iqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmfJ30fLh0asbMxYSTs09SsUwjpHmjZj2bV6Ge1vOhM=;
        b=Bg8cwOCklwJCe65mRSffPn9QdvVQbZHoWkGG7hv7XMentGS9qZVqnBNE0Vi3BYN1it
         4lyY99lAd7zb/KwPOtJwfvjM2ZroqXNSYQjilhlwJ2TTBkG/CNCkLcY6lDIuHw3ZUtyq
         RBjMarWU1o/kvOYlip3zKjiAK4eQ7DnZNVW61U0RymaRGDzbfmWXOfyD0m7fw2U17a6D
         gf43Ha7Nwb9mz19uSOGRq2AgxD4L4ndiR0Uync0zEKHzG+Y1uPY9mNuyU72X+OV/t4A0
         8nMRuMNaMcOQBEkVcRMTFn6Kv4XAduiAeQBOatuA6gfL79ExOfPEa+04SmTyob/KGmYh
         Y4Vw==
X-Gm-Message-State: ANhLgQ1tQJR93cZ6hOt6JS/b4keKBYDE2cn6nA7qAXTTyQyhsAs7ED9J
        3CAHhpKhDY2I1sEELKY/2aq64xGLJqg=
X-Google-Smtp-Source: ADFU+vscT4ufuh4a5RPH2r0CzFcREP4Ob6dLgZizTxi2rrscCAzi1rNqeiSDpaK3Xq3uZkER8t78RQ==
X-Received: by 2002:a17:90b:3009:: with SMTP id hg9mr2657192pjb.181.1583322488604;
        Wed, 04 Mar 2020 03:48:08 -0800 (PST)
Received: from localhost ([203.144.74.196])
        by smtp.gmail.com with ESMTPSA id h4sm2257008pfr.107.2020.03.04.03.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:48:07 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v1 0/2] gpg-interface: prefer check_signature() for GPG verification
Date:   Wed,  4 Mar 2020 11:48:02 +0000
Message-Id: <20200304114804.19108-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127174821.5830-1-hji@dyntopia.com>
References: <20191127174821.5830-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch refactors the use of verify_signed_buffer() for GPG
verification to use check_signature() instead.

Previously, both check_signature() and verify_signed_buffer() were used
to verify signatures in various parts of Git.  However,
verify_signed_buffer() does not parse the GPG status message.  Instead,
it relies entirely on the exit code from GPG coupled with the existence
of a GOODSIG string in the output buffer.  Unfortunately, the mere
prescience of GOODSIG does not necessarily imply a valid signature, as
shown by Michał Górny [1].

verify_signed_buffer() should be reserved for internal use by
check_signature() since check_signature() parses and verifies the status
message.  This is accomplished in this patch.

Changes since v0:
* Added regression tests for log-tree and fmt-merge-msg.
* Fixed a bug in log-tree.c that caused "No signature" to be shown
  erroneously.
* Fixed a similar bug in fmt-merge-msg.c.
* Always invoke signature_check_clear() after check_signature().  The
  check function may touch the signature_check structure on failure.

[1] https://dev.gentoo.org/~mgorny/articles/attack-on-git-signature-verification.html

Hans Jerry Illikainen (2):
  t: increase test coverage of signature verification output
  gpg-interface: prefer check_signature() for GPG verification

 builtin/fmt-merge-msg.c  |  11 ++--
 gpg-interface.c          |  97 +++++++++++++++++------------------
 gpg-interface.h          |   9 ----
 log-tree.c               |  34 ++++++-------
 t/t4202-log.sh           | 106 +++++++++++++++++++++++++++++++++++++++
 t/t6200-fmt-merge-msg.sh |  23 +++++++++
 6 files changed, 202 insertions(+), 78 deletions(-)

-- 
2.25.1.709.g558d21736a

