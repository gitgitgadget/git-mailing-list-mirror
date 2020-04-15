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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE267C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C189A20774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRxdpfdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636965AbgDOUcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636966AbgDOUca (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 16:32:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200FC061A0F
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:32:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w145so3753503lff.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HAVCGXUqPoGX2aopqlVni+HQ6wc4coXlvLANwf2hDR4=;
        b=NRxdpfdwzCZafIwg+5LvUjPVmDdf2SQOJ4ifv2/E+E92SCNCX5UtxCr9WravhZmIp9
         6tFKmmwj7T5h20xueEOUnCiYKo3qv+9w5oqCzb/Ejj4wlbXQ003oPxwbIR7DZEOff1e3
         h9BzRwX8gHHQarKASSJTvqLbPK9EivRzeCBEBPtwtho8sLx+lBY6F9jPYoB6RYxmQJTz
         2TLHXBhbJ4A6nv9CDOHdBcyA+lFwgQU/sybQ6SREEr2E3FFk+2OxPI2VeemmQPeMvx65
         QJC8UvDhl7/TzimZIz4R7HNIGnFYUEsNH5q5Eagca9U9e0fV5ZDQkcCa3A6t52uoV0Rk
         1e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HAVCGXUqPoGX2aopqlVni+HQ6wc4coXlvLANwf2hDR4=;
        b=DY2oVzk3uhiYhpsfskx6UjyUn8guefwLiBR3tXzXtlwpZsMOyjpo1nD3r9+EUGzQYO
         bpqzxN3kSLnElyG2eABPoEBoonZzLBqQDvleqI/sTOQmIecAIMTGA/ZrUMUNasACwAfd
         z1PU4X4b64GzjNxlW5+R36sUXTSP0eVwREhMr0NDY1YeAZSLRe+mChnYZr5aWU0dtxj4
         Bv3Oy4dWiX4TOfM8ELr7kymaAPOaXcs9E5yKWzXgR+cKPVLX98nc6hIzO+n7WuVIrpCG
         OoIA1YTrTcCiRvrxzMxVvm5fBE+i4zJ/EpfMcRrZCBAWq5t+iztb/UAr36GyyaCsh7O3
         SobQ==
X-Gm-Message-State: AGi0Pubo2sM0IvQbmjNLHS/Inv2ncK4FTfztNtvB1dbknOWk0Exdn2hw
        jOcxhggkdGw1yvHHHj+827lbbSGr
X-Google-Smtp-Source: APiQypIBXx3sTgBBs/xIusAMAB95wXfGbg50jahwghm0kASx5S/YmAcLSX37lqBbYne2b8fGtZtRwQ==
X-Received: by 2002:a17:906:b2c2:: with SMTP id cf2mr6507562ejb.262.1586982746742;
        Wed, 15 Apr 2020 13:32:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20sm459889edr.54.2020.04.15.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:32:26 -0700 (PDT)
Message-Id: <pull.760.v2.git.git.1586982745.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
From:   "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 20:32:23 +0000
Subject: [PATCH v2 0/2] range-diff: fix a crash in parsing git-log output
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
   
   

Changes since v1:

 * Fixed a typo in the commit message (found by Taylor Blau)

Vasil Dimov (2):
  range-diff: fix a crash in parsing git-log output
  range-diff: avoid negative string precision

 range-diff.c          | 18 +++++++++++++++++-
 t/t3206-range-diff.sh | 10 ++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)


base-commit: de49261b050d9cd8ec73842356077bc5b606640f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-760%2Fvasild%2Frange-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-760/vasild/range-diff-v2
Pull-Request: https://github.com/git/git/pull/760

Range-diff vs v1:

 1:  2375e34100e = 1:  2375e34100e range-diff: fix a crash in parsing git-log output
 2:  b3384880c72 ! 2:  72fddcff554 range-diff: avoid negative string precision
     @@ Metadata
       ## Commit message ##
          range-diff: avoid negative string precision
      
     -    If the supplied integer for "precisoin" is negative in
     +    If the supplied integer for "precision" is negative in
          `"%.*s", len, line` then it is ignored. So the current code is
          equivalent to just `"%s", line` because it is executed only if
          `len` is negative.

-- 
gitgitgadget
