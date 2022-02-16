Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB74C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiBPKP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:15:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiBPKPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:15:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD72FFE3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so2608704wrb.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gUeNrre0sxkva+iWqqKIxadUF66gXACgWN2tmBoWztM=;
        b=GMTVMeCz99bU+HN5F8m/vCTive8x3CXmQWob9GOVD3Su7d/hSN45wB0Ny/nnMw8uJZ
         qKTT7zp3k78yoMbzrLh8tvcOi67IGe2gknBI+46jY/hbupNT/G/fU7eMP1Xa5pCi8tmB
         YiTxasGBwZGZnrG3v/rQqJWw3Q04LcraqYnQFYJSaWkeCwW8A3HKK3UR4Hd+zAXmn8TI
         ks3KDxLyXqXM6hqxxj/H696T3b5nCnWE0DU+HHCVbPv42BKcWR+FLrzAQIqM0kZvx/Gg
         /IJ4WWN8vo/IIuq55czPs+HYmYdaeqg3YT2CqFn79Lj03Qdk4UWlyLgVujf3RmaWKRnE
         8hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gUeNrre0sxkva+iWqqKIxadUF66gXACgWN2tmBoWztM=;
        b=iu3WedftPJt283rb14miZej2DrEO7sB7MPT12VLH8aUSO/OMGkT/I+UYhX6QIawdxq
         NLhhcphaMswgxfZuaDu+Bd3k7cMeoD7UrFSCWveXLHToB0g3uFYU8M0/CZOZ5793NpIb
         UgM9DqqDyjH5l+oz0YVYlG9TbyJB2dS+DZXnsGViOYWtAsG5mkiaCoZchciyaZPujlK6
         +JkZXzQ9tsVkha1tLORQfFUXxRlv5ABORzHlwNjAj+FLtpMSD/f9Fi8y7y0HJrCcSoVx
         Rxzz8Wi1FNfzmoR/LKIoQmH8K6siGXzXlBvOdIQuL0A7LcplyZx1pouPBjNkpkFNdXEV
         1YSw==
X-Gm-Message-State: AOAM531Z1FQU40vdpKlR12B6eCowyx/nE1QAh3GB7ahifKpJr44OzVIH
        eEw20uXlvB/GPrPHGg2tA3JquhoWfDQ=
X-Google-Smtp-Source: ABdhPJzhGvmuiAHOlbgxa7rNBNo8OL3jybHDa0iw5KTnWnQ/td9mW1VghtwOkMoSbWnYayzSEsElBg==
X-Received: by 2002:a5d:45c4:0:b0:1e4:a672:586b with SMTP id b4-20020a5d45c4000000b001e4a672586bmr1651566wrs.388.1645006511227;
        Wed, 16 Feb 2022 02:15:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q23sm16074648wmj.44.2022.02.16.02.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:15:10 -0800 (PST)
Message-Id: <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:15:05 +0000
Subject: [PATCH v2 0/4] xdiff: handle allocation failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Junio for his comments on V1.

Changes since V1:

 * Patch 1 is new and addresses a memory leak noticed by Junio
 * Patch 2 is unchanged
 * Patch 3 now avoids a double free of xe1 on error
 * Patch 4 reworked handling of the return value

V1 Cover Letter: Other users of xdiff such as libgit2 need to be able to
handle allocation failures. This series fixes the few cases where we are not
doing this already.

Edward's patch[1] reminded me that I had these waiting to be submitted.

[1] https://lore.kernel.org/git/20220209013354.GB7@abe733c6e288/

Phillip Wood (4):
  xdiff: fix a memory leak
  xdiff: handle allocation failure in patience diff
  xdiff: refactor a function
  xdiff: handle allocation failure when merging

 xdiff/xdiffi.c     | 33 +++++++++++++++++----------------
 xdiff/xhistogram.c |  3 ---
 xdiff/xmerge.c     | 42 ++++++++++++++++++++++--------------------
 xdiff/xpatience.c  | 21 ++++++++++++---------
 4 files changed, 51 insertions(+), 48 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1140%2Fphillipwood%2Fwip%2Fxdiff-handle-allocation-failures-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1140/phillipwood/wip/xdiff-handle-allocation-failures-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1140

Range-diff vs v1:

 -:  ----------- > 1:  3fcb6c80367 xdiff: fix a memory leak
 1:  b8f88f1b9f8 = 2:  fec1f4a4152 xdiff: handle allocation failure in patience diff
 2:  8655bb0348d ! 3:  073a45e9e85 xdiff: refactor a function
     @@ Metadata
       ## Commit message ##
          xdiff: refactor a function
      
     -    Rather than having to remember exactly what to free after an
     -    allocation failure use the standard "goto out" pattern. This will
     -    simplify the next commit that starts handling currently unhandled
     -    failures.
     +    Use the standard "goto out" pattern rather than repeating very similar
     +    code after checking for each error. This will simplify the next commit
     +    that starts handling allocation failures that are currently ignored.
     +    On error xdl_do_diff() frees the environment so we need to take care
     +    to avoid a double free in that case. xdl_build_script() does not
     +    assign a result unless it is successful so there is no possibility of
     +    a double free if it fails.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
       		xmparam_t const *xmp, mmbuffer_t *result)
       {
      -	xdchange_t *xscr1, *xscr2;
     --	xdfenv_t xe1, xe2;
     --	int status;
      +	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
     -+	xdfenv_t xe1 = { 0 }, xe2 = { 0 };
     + 	xdfenv_t xe1, xe2;
     +-	int status;
      +	int status = -1;
       	xpparam_t const *xpp = &xmp->xpp;
       
     @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
       	result->size = 0;
       
      -	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
     --		return -1;
     ++	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0)
     + 		return -1;
      -	}
      -	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
      -		xdl_free_env(&xe1);
      -		return -1;
      -	}
     -+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0)
     -+		goto out;
      +
      +	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0)
     -+		goto out;
     ++		goto free_xe1; /* avoid double free of xe2 */
      +
       	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
       	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
     @@ xdiff/xmerge.c: int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
       	xdl_free_script(xscr1);
       	xdl_free_script(xscr2);
       
     +-	xdl_free_env(&xe1);
     + 	xdl_free_env(&xe2);
     ++ free_xe1:
     ++	xdl_free_env(&xe1);
     + 
     + 	return status;
     + }
 3:  3e935abba1d ! 4:  7e705d771b0 xdiff: handle allocation failure when merging
     @@ Commit message
      
       ## xdiff/xmerge.c ##
      @@ xdiff/xmerge.c: int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
     - 	status = 0;
     + 	    xdl_build_script(&xe2, &xscr2) < 0)
     + 		goto out;
     + 
     +-	status = 0;
       	if (!xscr1) {
       		result->ptr = xdl_malloc(mf2->size);
     -+		if (!result->ptr) {
     -+			status = -1;
     ++		if (!result->ptr)
      +			goto out;
     -+		}
     ++		status = 0;
       		memcpy(result->ptr, mf2->ptr, mf2->size);
       		result->size = mf2->size;
       	} else if (!xscr2) {
       		result->ptr = xdl_malloc(mf1->size);
     -+		if (!result->ptr) {
     -+			status = -1;
     ++		if (!result->ptr)
      +			goto out;
     -+		}
     ++		status = 0;
       		memcpy(result->ptr, mf1->ptr, mf1->size);
       		result->size = mf1->size;
       	} else {

-- 
gitgitgadget
