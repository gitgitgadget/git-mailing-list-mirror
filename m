Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2042D1F406
	for <e@80x24.org>; Tue, 15 May 2018 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeEOUAo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:00:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38533 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeEOUAi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:00:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id n9-v6so502187pgq.5
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+wbKnKGeaQISNjdeiE+cstnfACP1HNrxK4doXBebbw=;
        b=RhStz7j/Q/g5Klizu/KdHM5y8KNNM7n/vzhQSJzhg03cJks4ndso5ouY/h4A26KoS+
         /8QL3lVNOLUGTa4F5xdvPWGNcuPmXHPFBR9X4qi/G0zOSmPPDkk7C7HvyDa+ydwITSB9
         phU6q2hupKFWTuAadkMXK/Muii0ZlGMnfnTTT+jYEu2OQdMEe/QK4WSdzUlDc0+/BZi2
         XQ8WLL5z0aUt+6hNEjha8zL5tYNS/ZIwmHu/w4lSc9k1AQF6E1CiAnDlLJaID5OsWpLq
         X6DkyfiGdtWM6+pLbt03Bv+He7VcL++VWq0NTx/mHsxaYDSjKMkHuOx6tRrfHAZFoYft
         ZqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+wbKnKGeaQISNjdeiE+cstnfACP1HNrxK4doXBebbw=;
        b=K0Lh53XM7xArfqO5y+hSvDyBuS8ee1yys4LrLWt7I04QiHcy3+AjUimiGSfjb1GTi8
         831YrM0316veL+gdhO+/hfFAvqs1kG+S+CJt7dmgtM5qIaBHjh1hWhUtB8zFl34zEksC
         NVBO2YSorpboO40kB4ge6KPCJAfA2yoY9u1uml310uvmX0xUPUGWO3tDTnO/TLEC4+RZ
         5BsRd558hU+yTYNqMjMpjSJOwp1giU31gVrwotRtm8ByIzF2YPA9xqjems6El0FGmc+3
         /RyB1vJlenekn+3LoF6kU9T/6ylFwenHjGBsB6OUsov82yY+m7kx2WfASQU2uEfdxwia
         fYPQ==
X-Gm-Message-State: ALKqPwfmvQtcQnJxsa2rDAx678ZamFtYX0Wer1+SzD5+iSdcsOpMlBXi
        EbgX4EspzSibItCRvgPRG1yRcGVH7Zw=
X-Google-Smtp-Source: AB8JxZo09+7oR9u5RQHrQYD1InVwoOJvY7zYiQAQvw/aABE99fzx5HB2np+UpTbI9sa/kDJF2MN0fQ==
X-Received: by 2002:a62:404f:: with SMTP id n76-v6mr16556538pfa.185.1526414437230;
        Tue, 15 May 2018 13:00:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b3-v6sm1090290pff.132.2018.05.15.13.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:00:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, leif.middelschulte@gmail.com
Cc:     gitster@pobox.com, newren@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] git-submodule.sh: try harder to fetch a submodule
Date:   Tue, 15 May 2018 13:00:26 -0700
Message-Id: <20180515200030.88731-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the logical continuum of fb43e31f2b4 (submodule: try harder to
fetch needed sha1 by direct fetching sha1, 2016-02-23) and fixes it as
some assumptions were not correct.

The commit states:
> If $sha1 was not part of the default fetch ... fail ourselves here
> assumes that the fetch_in_submodule only fails when the serverside does
> not support fetching by sha1.

There are other failures, why such a fetch may fail, such as
    fatal: Couldn't find remote ref HEAD
which can happen if the remote side doesn't advertise HEAD and we do not
have a local fetch refspec.

Not advertising HEAD is allowed by the protocol spec and would happen,
if HEAD points at an unborn branch for example.

Not having a local fetch refspec can happen when submodules are fetched
shallowly, as then git-clone doesn't setup a fetch refspec.

So do try even harder for a submodule by ignoring the exit code of the
first fetch and rather relying on the following is_tip_reachable to
see if we try fetching again.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963ca2..00fcd69138f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -614,7 +614,7 @@ cmd_update()
 				# is not reachable from a ref.
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" $depth ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
-- 
2.17.0.582.gccdcbd54c44.dirty

