Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BEC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 14:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiAZOhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiAZOhH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 09:37:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A13C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:37:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v13so26123618wrv.10
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6CaKCJtiLqmaXZoIrLFnbj/y4PK5HW64yMxzAj2oFc=;
        b=bpQ54Wjveolb8utXbeIctF3d1mKXsWojLSbFxz2Z3vASj9hwtmlvaKje0uw9m17PTJ
         DSUY6MikdzZshCCYeVsB8KTvTvWLPGR2lmTV8RZHwv16m+DjgKRuja2FSghFt0CKjeX5
         RaoMHwPxZgujQ/cNLpEP7JwJOnd+rIcC7xBznHFC0LGpalVEwU3m3S89C+6XeMBV6Lv8
         jxff+N/mvxrsvLb0ughQ4L5fdLw6vPGVxU18Gffr42viLzpsYFzOmKthsCWg4A4BhLiD
         G4usfdEPdZ19eygmYUWcNkJtUnEJJh7BSpwDQx/zM/nMB+DXKBq4AOs6aHbK8fpKpwkZ
         fa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6CaKCJtiLqmaXZoIrLFnbj/y4PK5HW64yMxzAj2oFc=;
        b=LmqiUrD2yixRFUkPA9Kquc4Xs/A6o80kJWtOQwSSHRvuU0sHXLaOR9wp3yNNwCnI/3
         wfaQ4KSmI38J3J9D/LYDqzadWE9wQEPb2n1qUzXf6hWq7Xk/RjtnGjPYZ0zBXPWykzdf
         /tm7CNdLo4dmzErxVkKoLZPjm6fFtSHssFZUNxXYpxH7/dX9EsrLcREHt5lLeiJ3/THy
         6VjeH9pIuvRr4PUhYgXrjcp3IiB3aojBj4t1QwMI1z/2MCLBAeL5ALI6vzmV+RRez2bO
         iifiOmeipEXhs20TSYPp/K0CgCkft8CX22SR2qi1kIHx0hlsYko4GNw3ZnU2cuzU0Hdp
         i9cQ==
X-Gm-Message-State: AOAM532g990SOTmb8zxk1Q4NOmGsQhP3KFc11XW7HeDBlzJYNBBVT7Yf
        qohFlq0iJhmsLnWEVkTCR9DC/ZcqBAilPw==
X-Google-Smtp-Source: ABdhPJxKbQjOihqGqgntnZvFiLAfrjBlvigpcw6K1Wkgqc7upEpOg9jnIn6vIOE5sHB+8mARXxNeYw==
X-Received: by 2002:a05:6000:38a:: with SMTP id u10mr22243346wrf.0.1643207824688;
        Wed, 26 Jan 2022 06:37:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x4sm21015294wrp.13.2022.01.26.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:37:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/2] refs: remove the last use of "errno" from the public API
Date:   Wed, 26 Jan 2022 15:36:59 +0100
Message-Id: <cover-v4-0.2-00000000000-20220126T143427Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.g96f29f9df61
In-Reply-To: <xmqqo84gu4sb.fsf@gitster.g>
References: <xmqqo84gu4sb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12 2022, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> This is a follow-up to the recently landed ab/refs-errno-cleanup
>> topic, I missed a spot and left some meaningless use of "errno" in the
>> refs (file) backend.
>
> Is it a fix "oops the ones we merged to 'master' were buggy and
> needs these on top to be correct"?
>
> If it is merely a follow-up "I am doing more of the same thing as we
> aimed to do in that topic", I'd rather leave it to the next cycle.

As discussed before the last release you merged 1/3 of v3 of this down
as 31e39123695 (Merge branch 'ab/refs-errno-cleanup', 2022-01-14).

Now that we're post-release here's the remaining 2 patches, which as
the range-diff shows have no changes since v3, except an updated
commit message for 2/2 mentioning that previously merged 31e39123695.

This has no conflicts currently with "seen", but with the ongoing
reftable integration that probably won't be true for long, so I think
it would be good to queue this up sooner than later. I'm hoping that
between myself & Han-Wen's main push that we can get "real" reftable
integration started during this cycle.

Ævar Arnfjörð Bjarmason (2):
  sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
  refs API: remove "failure_errno" from refs_resolve_ref_unsafe()

 refs.c                    | 51 +++++++++++++--------------------------
 refs.h                    |  7 +-----
 refs/files-backend.c      | 31 +++++++-----------------
 remote.c                  |  3 +--
 sequencer.c               | 10 +++-----
 t/helper/test-ref-store.c |  3 +--
 worktree.c                | 11 +++------
 7 files changed, 35 insertions(+), 81 deletions(-)

Range-diff against v3:
1:  a45268ac24b < -:  ----------- refs API: use "failure_errno", not "errno"
2:  8d8691a5e93 = 1:  7f31277fd57 sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
3:  8f937d8f64a ! 2:  5e6f63afb40 refs API: remove "failure_errno" from refs_resolve_ref_unsafe()
    @@ Commit message
         boilerplate "ignore_errno", since they only cared about whether the
         return value was NULL or not, i.e. if the ref could be resolved.
     
    -    There was one caller left in sequencer.c that used the
    +    There was one small issue with that series fixed with a follow-up in
    +    31e39123695 (Merge branch 'ab/refs-errno-cleanup', 2022-01-14) a small
    +    bug in that series was fixed.
    +
    +    After those two there was one caller left in sequencer.c that used the
         "failure_errno', but as of the preceding commit it uses a boilerplate
         "ignore_errno" instead.
     
    +    This leaves the public refs API without any use of "failure_errno" at
    +    all. We could still do with a bit of cleanup and generalization
    +    between refs.c and refs/files-backend.c before the "reftable"
    +    integration lands, but that's all internal to the reference code
    +    itself.
    +
         So let's remove this output parameter. Not only isn't it used now, but
         it's unlikely that we'll want it again in the future. We'd like to
         slowly move the refs API to a more file-backend independent way of
-- 
2.35.0.890.g96f29f9df61

