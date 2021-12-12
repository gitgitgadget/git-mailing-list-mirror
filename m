Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B6C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhLLTyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:54:23 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:45845 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhLLTyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:54:23 -0500
Received: by mail-wm1-f42.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so10334966wme.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RneHcJKN+nrQIJdcwC/ohRWueVrRIZuGCl/Btf3G5kI=;
        b=G1Ps+/yhIiqIKisOIfZiVBJSUTKL7AhQrvQ018Sc3uwdjgbdCV+g419ow0tevRbtic
         b/ztz6YSdt9B/Kore+6H8KyKQ39mQTlCAqzC4YGZO1Vsjj+XnPfjkszWIeEg/6kWmMXa
         igf8tlUyPEreSc1z2cEIccupI0K/JXObL+YTeszVMNKQ0Xlj6vmUPBWZW7CTY59RqKWD
         AfUhr8litKaHfgcTOI144TmrG1lOVKreYOd0X433ywbcMpgFJBV2xc+bFIZOu7yjbuO9
         eLej8IwefcB7aeEiyn4aDvyLBQgmujkQb/bAkp9z3AuR4e7IrCoYH6DHjjAI/VtS95Gq
         KVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RneHcJKN+nrQIJdcwC/ohRWueVrRIZuGCl/Btf3G5kI=;
        b=M3V4WaLn5GNPcFsHIAbMoLSI8RJDJDBTsF/UZ82y+b7zBLIhQcimBXUuSQ3Aim+Odo
         57fffI6la6joj365DmTFMwAHl21AncsSnHEsu0FaCx3joFB0RLwv74xPwcH4Tz4k5v+Y
         MLieQsxpKDd+EODD8RFl03WdKL4HXC/ARmlrbaKkbgTvAQmfKr1tScuwjMEBtCwwxChg
         MeSKhx8mI1iQl07OdwV1J4m+T/RNWS8yczGrZwXttJakaSOqHaMWG4EvVFnl2WKYBsbq
         s/1sJsmCm7wFS+6fXJPLcYSSSa9qJ6NhlECWeYYgfcFq+IYE3tJ2ATEMro1mpcSy+hWW
         xJ2Q==
X-Gm-Message-State: AOAM531zx7HaMdr2U8LOkkRpa6m0krqLw9bulIMlOb2HyZyDKJmjnrMf
        mSmc80+h30cjSRDLn4/13zNrTuPytXWZ2A==
X-Google-Smtp-Source: ABdhPJzZQ5O95VJY7iBqwE5wtqKZziZz1JEwsPURK7MqpOkE0Bf2yx2OZHhYBLUHmadEww7HabMwKg==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr31891208wmr.159.1639338801806;
        Sun, 12 Dec 2021 11:53:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm5494323wme.23.2021.12.12.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:53:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] refs: ab/refs-errno-cleanup fixup + remove "failure_errno"
Date:   Sun, 12 Dec 2021 20:53:10 +0100
Message-Id: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.929.ge922d848c7a
In-Reply-To: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of a fix to my recently landed topic to remove "errno" use
from the refs API.

The only update is a rebasing on "master", this previouly semantically
conflicted with an in-flight topic that's been merged to "master".

1. https://lore.kernel.org/git/cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  refs API: use "failure_errno", not "errno"
  sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
  refs API: remove "failure_errno" from refs_resolve_ref_unsafe()

 refs.c                    | 53 +++++++++++++--------------------------
 refs.h                    |  7 +-----
 refs/files-backend.c      | 34 ++++++++-----------------
 remote.c                  |  3 +--
 sequencer.c               | 10 +++-----
 t/helper/test-ref-store.c |  3 +--
 worktree.c                | 11 +++-----
 7 files changed, 36 insertions(+), 85 deletions(-)

Range-diff against v1:
1:  b983d3b6033 = 1:  161fcad1578 refs API: use "failure_errno", not "errno"
2:  a4d1dadb9c9 = 2:  12d453d3884 sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
3:  a42539d103c ! 3:  614590b2d10 refs API: remove "failure_errno" from refs_resolve_ref_unsafe()
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      		}
      
     
    + ## remote.c ##
    +@@ remote.c: static void read_config(struct repository *repo)
    + 
    + 	repo->remote_state->current_branch = NULL;
    + 	if (startup_info->have_repository) {
    +-		int ignore_errno;
    + 		const char *head_ref = refs_resolve_ref_unsafe(
    +-			get_main_ref_store(repo), "HEAD", 0, NULL, &flag, &ignore_errno);
    ++			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
    + 		if (head_ref && (flag & REF_ISSYMREF) &&
    + 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
    + 			repo->remote_state->current_branch = make_branch(
    +
      ## sequencer.c ##
     @@ sequencer.c: void print_commit_summary(struct repository *r,
      	struct strbuf author_ident = STRBUF_INIT;
-- 
2.34.1.929.ge922d848c7a

