Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865FDC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617A720857
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYExG6aD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394003AbgDOO2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729551AbgDOO2o (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 10:28:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D65CC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:28:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s10so5056986edy.9
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lokLKbUc3e5uZaxy4174Xk5RgkiRFdm/WMrK2fuZtHA=;
        b=BYExG6aDiF5NuHKavvRPo1buazj1u+6S4VrMkth3oBYvsPylh0BYDn0GKMgyD4c+P4
         lcKsDG2oXw3hHEfi3aR+z4eJ9IwzZb+Tte77grST9PznbPuwizT/X1ZpOBlIKY+H4GPy
         S3htsrJUIk1O4TndqmbVoR2h/7H219l0U3nW6xiUX43tYcqntbGzcSIwJGZAmQs8REIc
         7UW3BLbshCpxQdBZfFQnI+PA3UxA03nutaON0/h4JfdfyaoN1G6W7Ym047vkZ34TurDJ
         m4Y7Wq1arCAgFma8d49cc2cmXwWrb2STGvyqsiIziTglMHo10UtVmertIAtnceOPiEq8
         3vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lokLKbUc3e5uZaxy4174Xk5RgkiRFdm/WMrK2fuZtHA=;
        b=Q+cnwLNX4IYWQwIeBdu9n2ZwCboTHkME0N+JQiasEzdwfzO6KgRASePwJlAub1Z1gm
         4IoMhcIaRXL1d4r35mPa9sKcYjANo1PEtOEYIM8w7K1sSpgzFj7BAqIbc+7kj6HA7BPg
         KzF99/NWMaxPbQZCQIYPY/NkIaWqD79uDeecbGQEMrCecI/ByEAnw9TSDLkdfjzjIRXB
         jyM2jkIcXah5uuPpDxMx0lxZWYwbdZeiB7PKgNSGVGUjKvj/6w44/1UvIX6FTorgvLE0
         Uhvz2VQh1IbItenu1owKwcdxdQZko527TNDEHznXjhftg/qRQnrcLa4QqNsOKDX8TG/f
         hdnQ==
X-Gm-Message-State: AGi0Pubw9UpzoK86cuBMsLJNLP7wJu/2cTj/aHbnY2RDrFyGm0I1l11Z
        ab8xvxLszaSM8rMRZ0hlUL8nbASk
X-Google-Smtp-Source: APiQypLPddKKjoSuJfON+yPff68O5RP+kdOZZTaQaP8+WzC+BzqAJQZVmobFNHB/nV+7VfGnHjP/6g==
X-Received: by 2002:a50:fe8f:: with SMTP id d15mr26138117edt.64.1586960922691;
        Wed, 15 Apr 2020 07:28:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm2212178edv.88.2020.04.15.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:28:42 -0700 (PDT)
Message-Id: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
From:   "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 14:28:39 +0000
Subject: [PATCH 0/2] range-diff: fix a crash in parsing git-log output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vasil Dimov <vd@freebsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 * override a possibly user-customized format.pretty that would render git
   log output unparsable by git range-diff
   
   
 * don't use negative string precision, e.g. "%.*s", -5, "foo"

Vasil Dimov (2):
  range-diff: fix a crash in parsing git-log output
  range-diff: avoid negative string precision

 range-diff.c          | 18 +++++++++++++++++-
 t/t3206-range-diff.sh | 10 ++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)


base-commit: de49261b050d9cd8ec73842356077bc5b606640f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-760%2Fvasild%2Frange-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-760/vasild/range-diff-v1
Pull-Request: https://github.com/git/git/pull/760
-- 
gitgitgadget
