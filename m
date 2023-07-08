Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E344EB64D9
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjGHAbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGHAbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3E1FC7
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so2789580276.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776295; x=1691368295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wpNqXGtWosTJRHx//ty9/vbv2/HxZAXF5sfv6OZG4QM=;
        b=K88WMLb0qOsVhFUC0s3+or1El5lZrWN3LqWPnLQzfMaQKB3ARNNLgle9gxhX34Ta7G
         gy3cVU28mRsLIkqmg0MdhXLpaIeyV2KAIaJfroHUpZeGMBF33Eojq46GG3OIltA/r1G1
         cNOKOB0c7x8nJ8bFbLRw6dbLmmBYVzwOv0sRHGk7j4AjOuaDrLKcXH+8/e8IV5U8ITo6
         lESCIHUtJCgWqYX0gkG8oi4y76Jod/qOAAIKEFGmRxeCf814CWEk2lZtP0DKl5ZxZTLk
         0X2CYV4EvtNmCMnm/TgnNZfmBjL8bYOWNcswll2CtTemG7U/eKLXZwoaOHKiQ+jpvj9J
         zfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776295; x=1691368295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpNqXGtWosTJRHx//ty9/vbv2/HxZAXF5sfv6OZG4QM=;
        b=RpJdATSQU/+zOX5gqUTbK+tRFQnPdVOFNo749P6Xsee2VNSSroMBXpy3sRkMKE2tpu
         J3Dop2SEgiV0PORc+YZbWOhLCpZag5U/LxAu4YU2VlWdXNd6ScN8KB3TiGrXdG0bGlBJ
         lcnZjRw4tS2Xkwgm/kdn2OFqWlIQP0lgBHGu14JJJ7gAbAL7a3PSlcUKAntFu2YcY5i1
         LHzInQC5TxyAaZecrh0vXrHQsLH9wpz4UZ3Zu7Z5v6u4lRBse7jWX/nSVTgfoYmXf5Ce
         TJHqsbgxK+O2rpoFBqmyNSemsoceqYq+uzGAj5LjdereqNLHlaysxzUoS/7WvpDsJNT6
         8oIA==
X-Gm-Message-State: ABy/qLaeSOiA58cPci1F0dKAjlD6oeXcSMXAwQMXJqktSx9YtUPEROoD
        sIvrmDP0fn+CVBfgs5RYjKUbkHXkxUFdjFUWKaXClA==
X-Google-Smtp-Source: APBJJlG7d0UV1ci/ZOprUWU0ozoFJIFzLKXPVe4kK/fppU+GOF3ocktD12pNDSv6xifsN92S4KNZ9Q==
X-Received: by 2002:a0d:e241:0:b0:573:d710:6f88 with SMTP id l62-20020a0de241000000b00573d7106f88mr5895569ywe.36.1688776295344;
        Fri, 07 Jul 2023 17:31:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u63-20020a816042000000b0054c0f3fd3ddsm1414452ywb.30.2023.07.07.17.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:35 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/6] fsck: suppress MIDX output with `--no-progress`
Message-ID: <779466732ccf24ce982cf61a57aeb05a23cefba2.1688776280.git.me@ttaylorr.com>
References: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous commit, address a bug where `git
fsck` produces output when calling `git multi-pack-index verify` even
when invoked with `--no-progress`.

    $ git.compile fsck --connectivity-only --no-progress --no-dangling
    Verifying OID order in multi-pack-index: 100% (605677/605677), done.
    Sorting objects by packfile: 100% (605678/605678), done.
    Verifying object offsets: 100% (605678/605678), done.

The three lines produced by `git fsck` come from `git multi-pack-index
verify`, but should be squelched due to `--no-progress`.

The MIDX machinery learned to generate these progress messages as early
as 430efb8a74b (midx: add progress indicators in multi-pack-index
verify, 2019-03-21), but did not respect `--progress` or `--no-progress`
until ad60096d1c8 (midx: honor the MIDX_PROGRESS flag in
verify_midx_file, 2019-10-21).

But the `git multi-pack-index verify` step was added to fsck in
66ec0390e75 (fsck: verify multi-pack-index, 2018-09-13), pre-dating any
of the above patches.

Pass `--[no-]progress` as appropriate to ensure that we don't produce
output when told not to.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/fsck.c              |  4 ++++
 t/t5319-multi-pack-index.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index e6473ecabc7..8959b3c7b87 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1092,6 +1092,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			midx_verify.git_cmd = 1;
 			strvec_pushl(&midx_verify.args, "multi-pack-index",
 				     "verify", "--object-dir", odb->path, NULL);
+			if (show_progress)
+				strvec_push(&midx_verify.args, "--progress");
+			else
+				strvec_push(&midx_verify.args, "--no-progress");
 			if (run_command(&midx_verify))
 				errors_found |= ERROR_MULTI_PACK_INDEX;
 		}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 0883c7c6bd9..1bcc02004d7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -485,6 +485,18 @@ test_expect_success 'git-fsck incorrect offset' '
 	git -c core.multiPackIndex=false fsck
 '
 
+test_expect_success 'git fsck shows MIDX output with --progress' '
+	git fsck --progress 2>err &&
+	grep "Verifying OID order in multi-pack-index" err &&
+	grep "Verifying object offsets" err
+'
+
+test_expect_success 'git fsck suppresses MIDX output with --no-progress' '
+	git fsck --no-progress 2>err &&
+	! grep "Verifying OID order in multi-pack-index" err &&
+	! grep "Verifying object offsets" err
+'
+
 test_expect_success 'corrupt MIDX is not reused' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" &&
-- 
2.41.0.242.g6eec849fa5a

