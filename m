Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1394DC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhLIFGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIFGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:06:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E3C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:02:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c4so7617325wrd.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBlRUBEwY7EPZYYQwrVDLe9K/gMkT2cADlGEz7cGHWs=;
        b=Cor8lEYzAMAeFx5u8NKyInQpgj7WGNutGFVig7mpMormD0FDc+xaTsWpXjE9XQMrfX
         nmPa29ntVa3mS3a3Qmwx2PEx3k+db9E2tURph956umxsi6u1Bps+xaDggjrfcb3QGj1H
         7KmqJ5LO0fIrnoXwoDhDpUq+BM0VqbDj92f/HpsPhWwD2MLNgg7iw09R6lQ8FGFQWkPY
         Q2lkpHI9EO0F/DwceazJP+0JvXdAdCKJi9A0G94OvxeK957aAlv5lovFB7PkyFHsF4IT
         TuUMU5OVO+GH1p/c025/mAKDQU6cA+BBL/ci1fAb66MRAv5CO0JG0ilYZT0DNnziWKDm
         izHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBlRUBEwY7EPZYYQwrVDLe9K/gMkT2cADlGEz7cGHWs=;
        b=ZXaa05rRii6OPka4Btz7/fPQgXbypdI275cTEbWn+zgwRwIouF2ae0Y0XRUgGqiSe1
         0G+tp/M4gZVGRC3FPcW7abMpCZwWV+Gacn97/AMr5J/cT7ANpjz4ZwSTtdc7uIDWkKIr
         WKauvfAsk0vJGNYQ6fm/GkHL2g6LM4hQls8S25PLtDQWYuioboxCwr8NcQiyJjlpqnQ2
         aJapDVs8/KLC1zCpytgukkOWXZlXEzgdk+Re44LbOO9yWqBAdgXyGtACi6dnE9pzT4HP
         akZvtAr8VO4Lc6tmcHbcIiDddR5almzB8l6jteYw7TSEwMloyXtswbYRiXMydCM4DpX5
         VBJQ==
X-Gm-Message-State: AOAM532fFGrrj9C2mmKbMJbR7mjq0LcC26J7FxS7cS0UkHRthAmRzh++
        ENTfj4Oa8bacSPtwWqJXzR2MVL1lnQ/eEw==
X-Google-Smtp-Source: ABdhPJwaVVtGzn10b2BJkMmhshxo1BM2WkNABOhPzmyQekjTOY/FS7jk+WTT/lE1o1w5owFAEkYNYA==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr3701905wrr.389.1639026151089;
        Wed, 08 Dec 2021 21:02:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w22sm4270394wmi.27.2021.12.08.21.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:02:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] refs: ab/refs-errno-cleanup fixup + remove "failure_errno"
Date:   Thu,  9 Dec 2021 06:02:25 +0100
Message-Id: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g218b4aae189
In-Reply-To: <xmqqo85q2a42.fsf@gitster.g>
References: <xmqqo85q2a42.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 1/3 here fixes the bug Han-Wen pointed out in[1]. As discussed
there it's obviously bad in the pre-image, but some oddities in
refs_resolve_ref_unsafe() interacts with code it calls ended mostly
plastering over the differences by accident, so it wasn't caught by
testing.

Then 2/3 makes the one external user of that "failure_errno" stop
using it, and 3/3 removes it entirely from the API interface.

1. https://lore.kernel.org/git/CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com/

Ævar Arnfjörð Bjarmason (3):
  refs API: use "failure_errno", not "errno"
  sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
  refs API: remove "failure_errno" from refs_resolve_ref_unsafe()

 refs.c                    | 53 +++++++++++++--------------------------
 refs.h                    |  7 +-----
 refs/files-backend.c      | 34 ++++++++-----------------
 sequencer.c               | 10 +++-----
 t/helper/test-ref-store.c |  3 +--
 worktree.c                | 11 +++-----
 6 files changed, 35 insertions(+), 83 deletions(-)

-- 
2.34.1.930.g218b4aae189

