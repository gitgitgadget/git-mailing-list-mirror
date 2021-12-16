Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F7C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhLPNpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbhLPNpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A599C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso5280106wme.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIVrkkVBWtL++Gt0FLRBKA5dBHcsakoZH8uXOqaS7q4=;
        b=baVldx0apIIfNZlArVPUjfS2+w7Us4CgAWf/fYYvjh19Kmx5kt8NPgfacpJ4S7rldn
         pbLgPg/P1aiKWqJv6MQmBHMjJHpHoalBdQ8qiuG+eLQ0KgEQ42k85AZe0Eb/OqPc61jZ
         VcRgfB+iAlsbK1uFVsmYFBWzjuGzT/+bszRF1QheFbwgIQTbFHebGVyw99YRQUkPJByi
         xXO4cqjBEVszK5x6+BB3ntqop1KQAsWwhYx7m3v1SVjlEcdPQ146nkn7d+aLUdqqSsm9
         7QU3mGLYgbeRK73WqFL6gkbMVRkAS8Y0p0xF5mxPx2D264yLZPRPP6DRXRV7fCIKEq0U
         yGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIVrkkVBWtL++Gt0FLRBKA5dBHcsakoZH8uXOqaS7q4=;
        b=DA+HWpmxgkCLjWT/5XikBcnomgHbDlVVXsIWjfi91iEVD92w5cRqKa7QjL41Fk4wTX
         AjB3T0paAeqehKxeWJ59IQdoJ1OTKmuMFQvptdD5eiW18udGM2Smd0rKcMcIkWxeWv8v
         fg87VicdPa0qJvL8oYue8UL1aou3aqE1krQshdNPO14oueygLyE9cpT1PFned/Zr9EKx
         WK1A5vkB5UY40+rPIv94X1MeeLf0++lCZmwkKiAKmBC+yU+k8OXaPWcLiUPNPMalDk+T
         InHENrxtEIQ+mNQ8CI+roJXBmOLGjhRSUYUdcohHgUq6z8TsPDg0JBiIlXoyM8ouT0pb
         5zFA==
X-Gm-Message-State: AOAM530+G6jRoz7ZuTZteyX8XO0saGFVcQW6jYlqtQKHAQ4Ja3BmHIPE
        TA5FBKt24gMge/mlyv8Zsd+vj9XB21Ur4w==
X-Google-Smtp-Source: ABdhPJyK2hNPuFd/oo3e2h62GZ2PtzFu1HiLDDy2a0CVBQn6/BTtz1RpX2QbkajyB6sUpUPmerfC/w==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr4945620wmk.7.1639662320581;
        Thu, 16 Dec 2021 05:45:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] reftable prep: have builtin/reflog.c handle "--verbose"
Date:   Thu, 16 Dec 2021 14:45:09 +0100
Message-Id: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series refactors various small bits of builtin/reflog.c
(e.g. using a "struct string_list" now), and finally makes it handle
the "--verbose" output, instead of telling the files backend to emit
that same verbose output.

This means that when we start to integrate "reftable" the new backend
won't need to implement verbose reflog output, it will just work.

This is a sort-of v2[1]. I ejected the changes at the end to add
better --progress output to "git reflog". Those fixes are worthwhile,
but hopefully this smaller & easier to review series can be queued up
first, we can do those UX improvements later.

1. https://lore.kernel.org/git/cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
  reflog expire: narrow scope of "cb" in cmd_reflog_expire()
  reflog: change one->many worktree->refnames to use a string_list
  reflog expire: don't do negative comparison on enum values
  reflog expire: refactor & use "tip_commit" only for UE_NORMAL
  reflog expire: don't use lookup_commit_reference_gently()
  reflog: reduce scope of "struct rev_info"
  refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
  reflog + refs-backend: move "verbose" out of the backend

 builtin/reflog.c     | 208 +++++++++++++++++++++++--------------------
 refs.h               |   3 +-
 refs/files-backend.c |  44 +++++----
 3 files changed, 134 insertions(+), 121 deletions(-)

Range-diff against v1:
 1:  99e8a639163 =  1:  22c8119640c reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
 2:  c424b26b4fe =  2:  b8e84538427 reflog expire: narrow scope of "cb" in cmd_reflog_expire()
 3:  5a54b04a13e =  3:  c0e190e46cf reflog: change one->many worktree->refnames to use a string_list
 4:  a7a2dfd1406 =  4:  e42fac1b518 reflog expire: don't do negative comparison on enum values
 5:  de162a476c1 =  5:  39263cd00ae reflog expire: refactor & use "tip_commit" only for UE_NORMAL
 6:  eb3dd3fa8b9 =  6:  c71aab5845e reflog expire: don't use lookup_commit_reference_gently()
 7:  3aab4a4a436 =  7:  2fb33ef2546 reflog: reduce scope of "struct rev_info"
 8:  adbec242a7a =  8:  f9fe6a2cfb0 refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
 9:  6a8f3915898 =  9:  28aa0aa6e30 reflog + refs-backend: move "verbose" out of the backend
10:  f54dee1f1cc <  -:  ----------- reflog expire: add progress output on --stale-fix
11:  794e6e677a8 <  -:  ----------- gc + reflog: emit progress output from "reflog expire --all"
12:  fc2b15d0abe <  -:  ----------- gc + reflog: don't stall before initial "git gc" progress output
-- 
2.34.1.1020.gc80c40b6642

