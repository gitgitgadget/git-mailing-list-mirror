Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E7C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiATRtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiATRtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 12:49:49 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75858C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:49:49 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z20-20020a63d014000000b0034270332922so4089338pgf.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5UWRecftrcgNPO6VdVS9v8rkIO/6WAvtexuJ+pkU+Zc=;
        b=mSpXqN461dDwayubaNX2jbX8umK6RljtrXeGKGlhaKcaH1jjtHPzqgJzpnFmEnkPuX
         DlZnVzt9Iz0JwoBP2237V3S/JNjcfpgwSBEtg2cQ6NGCeLKXq5+7uEBQBznoj6YrOeZB
         G7q8bBbw+myh9o/bTsKAfilPL6uK77eqXSWel0fuOguDEcpB+2LVX2Xa+08a9YgD4qMr
         RR+Ve1FDttLnvQjcw0vyhMu9hKDdfi8FPJXJBEeH6Rq/uqtDljCuDIQ5FyHvh5D+cF/N
         FoUwH+T50PclnaiEzLe5aeRDzjXF2Kg4WqW5Oe7mJOu1kYQzCwd3pIOWqAx42R4UaEiU
         AYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5UWRecftrcgNPO6VdVS9v8rkIO/6WAvtexuJ+pkU+Zc=;
        b=K5+VHQqwlXGsLzqsQJoLY8i4nmhHSfM0Ik8Llh2J7ugkUKDbopJqMknodojvQRmnGc
         rkQpO3+3GE50DsSKzPGDz+CmvpUs28A6gPs9LaGVfidzzEVEqEF94YjI26WUAF4BbWSa
         9ge+ITKFl2VDEMBIraECvjNpdmzkeALWP6V4ofZdu88ZIpEWoRGENhvh1/M3E+U3jtpa
         verPl1yAqheOLYRjXAvefDdJTly9og4GLyuHYV78LV6agZRst0jx3qd9FLPjHGXrUsbh
         Ig/JZnkXtbhvdBdtCnzIGLJlqFjOpFEZoyPzSwTLRVSrqIJjn9j4bt/ke/53YPn7TucF
         Q03w==
X-Gm-Message-State: AOAM530sP6GvF4E+1MiAxADan4HUb4rba2GdHHXfJ0Po02w8SZdp9ssq
        r8srrpzFHfcjjBEOO+kIB8+IUPKM4fgMEuV3Vbtyfdk1Tzb3kuQXrglQVY1sdgPJv9lKXP6+I6v
        Z/2Mjs5f4LpO9HCZ4cFbRO/Yg8iDIzbrRblNSb5JlAj9IaEr8rkCMdnZbJDBKF+4=
X-Google-Smtp-Source: ABdhPJxMFFCbUMogV9V6ZlmKIHt0cXMCLtM5bvE2VtTGfePVzrkLggj55oA6aHS67N5kgyL491CHNXvDI0WKUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e541:b0:14a:5a5c:10d9 with SMTP
 id n1-20020a170902e54100b0014a5a5c10d9mr95917plf.56.1642700988885; Thu, 20
 Jan 2022 09:49:48 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:49:39 -0800
In-Reply-To: <20220119000056.58503-1-chooglen@google.com>
Message-Id: <20220120174942.94231-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220119000056.58503-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v7 0/3] fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v6:
* use standard message format introduced in 246cac8505 (i18n: turn even
  more messages into "cannot be used together" ones, 2022-01-05) (thanks
  Jiang Xin!)

Changes since v5:
* revert v4
* drop the unnecessary block that Junio actually meant

Changes since v4:
* drop an unnecessary block (thanks Junio!)

Changes since v3:
* change commit message subject: builtin/fetch -> fetch --negotiate-only
* move the 'goto cleanup' to _after_ the submodule updating task because
  we may want to update submodules even if objects were not fetched (as
  pointed out by Junio, thanks!)
* disable submodule recursion in the patch that checks for
  --negotiate-only + --recurse-submodules, so we never silently ignore
  --recurse-submodules.
* incorporate some of Jonathan's suggestions (thanks!)

Changes since v2:
* added a prepatory patch that introduces a "goto cleanup"
* drop an unnecessary line move (as suggested by Junio)
* check for user-given --recurse-submodules and die() (as suggested by
  Jonathan and Junio)
* update --negotiate-only's documentation

Changes since v1:
* added more context to commit message
* added a NEEDSWORK comment

Glen Choo (3):
  fetch: use goto cleanup in cmd_fetch()
  fetch: skip tasks related to fetching objects
  fetch --negotiate-only: do not update submodules

 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 41 ++++++++++++++++++++++++++++++---
 t/t5516-fetch-push.sh           | 12 ++++++++++
 t/t5702-protocol-v2.sh          | 12 ++++++++++
 4 files changed, 63 insertions(+), 3 deletions(-)

Range-diff against v6:
1:  ffa1a24109 = 1:  ffa1a24109 fetch: use goto cleanup in cmd_fetch()
2:  b0c73e8135 = 2:  b0c73e8135 fetch: skip tasks related to fetching objects
3:  239101e752 ! 3:  7e0de7232b fetch --negotiate-only: do not update submodules
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +			break;
     +
     +		default:
    -+			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
    ++			die(_("options '%s' and '%s' cannot be used together"),
    ++			    "--negotiate-only", "--recurse-submodules");
     +		}
     +	}
     +

base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
-- 
2.33.GIT

