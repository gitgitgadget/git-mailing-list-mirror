Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07CC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 03:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB73C64F04
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 03:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhCSDZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 23:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCSDYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 23:24:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E8C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 20:24:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id u190so1572466qkd.6
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DHyU0Uq+/yHV8qGXXwunQy1aE44SNdjYvmeHC4x2/k=;
        b=gah1y53no5pGtvSVYUsg3guBYwKkuFECgqaZ1hnlvZGvlQiI3gDQ2YjZUAG1f6DRqB
         B6mI+Shjs90SUrmEKxQQ6d9H/dF9U+Eqmcv+5KljVnMHcjKLAhTZH7yji819n8QaruUU
         bYAlfRaewv/8iP58Trf142qo9O5KsRa/VLmXB+rjnbn/g99i6PWXkeuPCfp6usk0m4B7
         fug0d+nfXJtBsqGLhOUmgmVOQbZEvqHAbzBPLA1stVaFqux0dycC8hRiIW3BzfwzdJna
         L80QbMBs4jE+gcXrJZ1nqjs2uh6iS9JGTyTO2GdlhP8RRKkw1M4vbQ2fUrFmW1Jt09yr
         MLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DHyU0Uq+/yHV8qGXXwunQy1aE44SNdjYvmeHC4x2/k=;
        b=A8OrQibBzcHaXUVbm6DFYP7QpL+2uxXB4TA2SAdfGlqfQapxur76EYbnYg5hvtXFD1
         s4zTGG5VBECJZ9O+oDpRbEjesm4q0opyLx/zu9SMwHnOvVmfR1kbb12ZxFGd2IrFb2Xd
         b1GeePUk2Wofk2JHtXfdhGbBiZoAZPJ86XHx5mWofDFXRUCB08hsAn8QcgPxiSFzmle5
         RC1BwbyltAm3SnjskI/QRvIUBYzTvRUvOhy250gUFzaFIBag/sE7W+JyiY3V0fREqGsp
         wbeA6AXUoxaD7cgVDTj4Vxcyjdxq+QZxs8+sif5HxZ3sAz24f12x0RHXhHsm2/tMNjni
         Ls+w==
X-Gm-Message-State: AOAM532YF2fVfTegkmwJGg7Yj3P5W8pXrN57fkpzBsu6zBFk2al9EE/3
        lsKBOsRoS9cPYfYkcJcxmBv8Wg==
X-Google-Smtp-Source: ABdhPJyl+Y4k4wDRpdxFX5HK/5PPw8eM0r14OvetLzBey9fyR6Ey7x+rjXDNvWrumufeEfOvlEV3HQ==
X-Received: by 2002:a05:620a:1669:: with SMTP id d9mr7476753qko.3.1616124285254;
        Thu, 18 Mar 2021 20:24:45 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id e2sm2927715qto.50.2021.03.18.20.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:24:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/5] Parallel Checkout (part 2)
Date:   Fri, 19 Mar 2021 00:24:38 -0300
Message-Id: <19fee535ee0ec5211f22b2b69a4a9804816c2322.1616122653.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <xmqqft0srxjc.fsf@gitster.g>
References: <xmqqft0srxjc.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 5:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > This is the next step in the parallel checkout implementation. An
> > overview of the complete series can be seen at [1].
> >
> > The last patch in this series adds a design doc, so it may help to
> > review it first. Also, there is no need to have any familiarity with
> > part-1, as this part doesn't have any semantic dependency with that.
> >
> > This series is based on the merge of 'mt/parallel-checkout-part-1' and
> > 'master', so that it can use the "brew cast" fix and the latest security
> > fix (both from master), to run the tests. (The merge is textually
> > clean, but it needs a small semantic fix: the '#include "entry.h"'
> > addition in builtin/stash.c).
>
> Let's redo part-1 on top of 'master' first without such a merge; it
> has been out of 'next' so we can do so easily without wanting for
> the tip of 'next' to get rewound.

Thanks!

I saw you've added the "entry.h" inclusion that was missing at
builtin/stash when merging this branch on 'seen'. However, now that
part-1 is based on 'master', the branch is no longer buildable without
this fix. So could we perhaps squash this change directly into the
relevant commit in this series? (I'm asking this mainly to allow me to
later base part-3 directly on part-2; without having to base it on a
merge again.)

If you agree, here is a fixup! to be squashed into part-1, for
convenience:

-- >8 --
Subject: [PATCH] fixup! entry: extract a header file for entry.c functions

---
 builtin/stash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index ba774cce67..11f3ae3039 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "diffcore.h"
 #include "exec-cmd.h"
+#include "entry.h"
 
 #define INCLUDE_ALL_FILES 2
 
-- 
2.30.1

