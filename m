Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E1C76196
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 03:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCZDJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZDJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 23:09:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409549EEF
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 20:09:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kq3so5460635plb.13
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 20:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679800184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oayQy3r2WlceDAk+h+VTqHuWCCfEBjeitaO7oQRg/mY=;
        b=N5ezz0iUPVvDrjYHCk6kxLOLiikLwbCdUJzNA78XHGbmk+L8dOSbGG8wGsT5vdvtkP
         +lVzF0ivVB23evsJnhQYpEIHM+zcvoS0hUBRtV/WtI4INT8Dfsq7MdIgUKHYxL3s3hwP
         4reay7BkDhj4JeNuk3JftX1/dPNrjpXz+QBMSwnbu3zwZBDyTFp7DSbC1A2NWrtngiC9
         DMTNMDPmzStfpAAjEoitBAnYM4B/ADwWliOEYsNQXixJUQIiLq/a4dBbY21Vc3rUID14
         uZEqdOPyYRH7vw0L548bLbD+OlGd85oQ2DIUeKhIFQLtRWKudcBrHhxEwvOoITlQWScq
         1KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679800184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oayQy3r2WlceDAk+h+VTqHuWCCfEBjeitaO7oQRg/mY=;
        b=eAro7wgq2Dd8PJzxpgnSFZKe5Yp4yTzdjSs/BUradU/2r5HKgG30QR9Qarka8faNkL
         jq2pOUmR7njkfjck1u107sOwVRQsb+2FHq8t36v/4IAItB74NfdBQD3FZkIFbdnI8NB3
         gE5MZoeC8xdSm5Pn0DpK3vf0E52Luk2IgBh2MhvNwPPsTa1GhUEWPjZzDltoYtNf2VO/
         sKGTclxDfAr2b5a8lSD3zfBm2i6aEdRNZR7nFK8cZdIRKH4Av+UfBCUovMsZew2M2JKh
         vpnjy4rVL4cXpXx3GSaCmbmIH+1UwH2gbpDFAFy6QEvJEXvyOH6wRfjrjsHFlv2w8yhd
         pHqw==
X-Gm-Message-State: AAQBX9fQwLxk7A+7qt8wUsD/gY1f5fOXU8AzsZh7hKGB9NhdjgLcLjrF
        4rlNRjyt62s3aoh54xTtsGS9bi2nttH6pQ==
X-Google-Smtp-Source: AKy350ZJdkGIKrFgSnBaEnY992WEIv6vHUM70QLVEdmTpDb0XdjW07iewnPJRdTdlu2t/fMpVMOGkg==
X-Received: by 2002:a17:903:32d2:b0:19e:68b1:65b9 with SMTP id i18-20020a17090332d200b0019e68b165b9mr9777252plr.12.1679800184423;
        Sat, 25 Mar 2023 20:09:44 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:897e:74d0::de86])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b001a1c00317b0sm13587929plb.273.2023.03.25.20.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:09:43 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v9 0/3] rebase: document, clean up, and introduce a config option for --rebase-merges
Date:   Sat, 25 Mar 2023 21:06:33 -0600
Message-Id: <20230326030636.2635642-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320055955.461138-1-alexhenrie24@gmail.com>
References: <20230320055955.461138-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces a rebase.rebaseMerges config option to
accommodate users who would like --rebase-merges to be on by default and
to facilitate turning on --rebase-merges by default without
configuration in a future version of Git. It also cleans up and
documents the behavior of the --rebase-merges command line option to
avoid confusion about how the config option and the command line option
interact.

Changes from v8:
- Add braces around one-line else clause
- Remove unnecessary change to error message priority

Thanks to Phillip, Junio, Johannes and Sergey for your feedback on v8.

Alex Henrie (3):
  rebase: add documentation and test for --no-rebase-merges
  rebase: deprecate --rebase-merges=""
  rebase: add a config option for --rebase-merges

 Documentation/config/rebase.txt        | 10 ++++
 Documentation/git-rebase.txt           | 19 ++++---
 builtin/rebase.c                       | 70 ++++++++++++++++++++------
 t/t3422-rebase-incompatible-options.sh | 17 +++++++
 t/t3430-rebase-merges.sh               | 44 ++++++++++++++++
 5 files changed, 138 insertions(+), 22 deletions(-)

Range-diff against v8:
1:  09fb7c1b74 = 1:  a22b9d0da2 rebase: add documentation and test for --no-rebase-merges
2:  a846716a4a = 2:  112fee4833 rebase: deprecate --rebase-merges=""
3:  b12a3610ba ! 3:  868899cd6d rebase: add a config option for --rebase-merges
    @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
     +		if (opts->config_rebase_merges < 0) {
     +			opts->config_rebase_merges = 1;
     +			parse_rebase_merges_value(opts, value);
    -+		} else
    ++		} else {
     +			opts->rebase_cousins = 0;
    ++		}
     +		return 0;
     +	}
     +
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		if (ignore_whitespace)
      			strvec_push(&options.git_am_opts,
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 				break;
    - 
    - 		if (i >= 0 || options.type == REBASE_APPLY) {
    --			if (is_merge(&options))
    --				die(_("apply options and merge options "
    --					  "cannot be used together"));
    --			else if (options.autosquash == -1 && options.config_autosquash == 1)
    -+			if (options.autosquash == -1 && options.config_autosquash == 1)
    + 					  "cannot be used together"));
    + 			else if (options.autosquash == -1 && options.config_autosquash == 1)
      				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
     +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
     +				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
      			else if (options.update_refs == -1 && options.config_update_refs == 1)
      				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
    -+			else if (is_merge(&options))
    -+				die(_("apply options and merge options "
    -+					  "cannot be used together"));
      			else
    - 				options.type = REBASE_APPLY;
    - 		}
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
      	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
      			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
-- 
2.40.0

