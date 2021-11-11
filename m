Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766F8C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 05:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F292611C9
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 05:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhKKFWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 00:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKKFWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 00:22:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45EC061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 21:19:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso4824655wmh.0
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 21:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IagjBMYBwMo8NV5DAWe6XRoByN8pTF4ctMSMyVF1Fk4=;
        b=ke4zqAXS1o/16tRengXAOhk2iv5mrr7YrRdxa9hhDNPPnTw6fTjWCMCgXvr6SknK1V
         9f68G6Jiy+rZHF6HbdK3Ap+aFkGx6eKPONMjIaLWQYnTaSxLPq0/nOIOF8f1ydW+5Tnc
         G9AYM6DdnwXcGMMndH1VUCnAH6alwv3pqUJ8S8uKLtadgDZLHEPs4UeBpkfzbwe5r1Sr
         9IJdAwOXUpp4CIZCNraBGP5jLY9kVeGOfICcpLkF6eXkNY5bWhWlhy83cOSL+qHhYO1M
         D0CBzkVQGEdKTpWpI3CyVuNZ8ndUu6rMAt+VM6ECwgeTNFJqqcpynuwve8gn3IzAgz0m
         FZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IagjBMYBwMo8NV5DAWe6XRoByN8pTF4ctMSMyVF1Fk4=;
        b=7nHRjTKKzvNZBeLAhMYakPDcrPduMfwdo4zj3MAkAF86lcbLfIyKiAgqwmsZFpjohW
         4HSyFz67sjofDmavrmg/DLcLD+Ec7X12WJW4JkB6EIep8I4QrcLa/mvb8SAfIz3Y/XLf
         u1c6ohg2tXsohlY3bihzvYn6HFcR44Fc/mCkQNmqYBxwZSy5a/hB7kx69glX2i6NTUUu
         sssTDZoF1ILAmNmQ5A3omqQwJ/haKVveOe0kxoUTNRaDDQsMPUPTIaJKxpbXspcFJKsf
         X+F7o8wBSRPFwK4F/4HUMG7YIzNEwXfRwVznUixciH7sCemUp1kDvFZxz86/BrbAXdxf
         lZMg==
X-Gm-Message-State: AOAM530JNdk//nqVGhOWMQNliAP/VOfFS0F9F1xHz91UL70Pu3ZI20UO
        irQfc8qffNPiifeJhdyixb4+8Gw45Y47+A==
X-Google-Smtp-Source: ABdhPJyss/Res0BOe0HLd/hxeK+k/4IpROlL3aFcEu/8BwQCh4P6C7gJDK+ObmebA45V1zTDIaDu+g==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr5266641wme.158.1636607972438;
        Wed, 10 Nov 2021 21:19:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1845391wrg.1.2021.11.10.21.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 21:19:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] v2.34.0-rc2 regression: free() of uninitialized in ab/fsck-unexpected-type
Date:   Thu, 11 Nov 2021 06:18:54 +0100
Message-Id: <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11 2021, Han Xin wrote:
> [...]
> Deleting "*contents = NULL;" here will cause a memory free error.
> When reading a large loose blob ( large than big_file_threshold), it will enter the following block and *content will not be set:
>
>       if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
>               if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
>                       goto out;
>       } else {
>               ...
>       }
>
>
> This test case can illustrate this problem:
>
> test_expect_success 'fsck large loose blob' '
>       blob=$(echo large | git hash-object -w --stdin) &&
>       git -c core.bigfilethreshold=4 fsck
> '
>
> git(73697,0x1198f1e00) malloc: *** error for object 0x36: pointer being freed was not allocated
> git(73697,0x1198f1e00) malloc: *** set a breakpoint in malloc_error_break to debug
> ./test-lib.sh: line 947: 73697 Abort trap: 6           git -c core.bigfilethreshold=4 fsck

Thanks a lot for the detailed report and test case. It looks like I've
got the dubious honor of most scary caught-by-rc bug so far.

This series:

Ævar Arnfjörð Bjarmason (2):
  object-file: fix SEGV on free() regression in v2.34.0-rc2

This is the most minimal fix for this issue. So Junio, if you'd like
to just pick this up for v2.34.0 you can peel just 1/2 off...

  object-file: free(*contents) only in read_loose_object() caller

... a fix for a related issue. In ab/fsck-unexpected-type we stopped
die()-ing in the object-name.c, so per SANITIZE=leak's accounting we
introduced a memory leak with the same variable we dealt with in 1/2.

But IMO more importantly by changing this code so that only one
function owns the free()-ing it's much easier to reason about this
code.

 builtin/fsck.c   | 3 ++-
 object-file.c    | 5 ++---
 t/t1050-large.sh | 8 ++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.34.0.rc2.795.g926201d1cc8

