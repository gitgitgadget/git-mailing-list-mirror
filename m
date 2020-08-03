Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390DFC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1294E2070A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxAynLjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHCQVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:21:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC89C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 09:21:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so140171wmi.5
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OJl2IbLbooJ9cxNAvMKUa8/Vi4ur2csBSGLG/LMgUUE=;
        b=fxAynLjdhhPdm72EgFiLBbK3V3QqxEMBKoq1oHjO12ptatddoR/nY0VB6r/QCl5Fnx
         oMIfGAUqjed+fo8PKn2OfP2en1e/2oak3U4xb8hQXahK1R9yfuODU6GLYnd6DLQ+PDKS
         O7pMyg2gEElLCEOBu8BGhjuKJ5ePynSRS48uKiOhTYnDaGp4wMAjcsOsDqQKsmH15dRh
         3/GlQ0aRZ/dnzFkMjEGXJbG1qrwOz4VHpDZJ7pWS1p/+anK6+H4xbpXaph4pg1IaHOAl
         URI3sr2BHtnvRCMTPPFPBsSas+oP7J3lIZTbzSu05rrXEScE7vUQ8MXx0um9hNbx2YeC
         foMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OJl2IbLbooJ9cxNAvMKUa8/Vi4ur2csBSGLG/LMgUUE=;
        b=DxL2XHpWyThvYlgIyTydlXujcev6ApE6yeEUY0sg9iFJS648qvKt+fKCyIB0ZhJgX4
         1NDNccVY3pbGJJJgmzZo+8/hG9j+PRN2HKYNi40fMyGPCye9BQTmxjopUlVHMh8J7vv1
         Kf7bJEnOtl85lDquQ2CpaYaANoZUZZ3UBICxb6oT6dco5OKRwy8HZb324gQfVxk+dTll
         mawTZBzdrPIRI/YIdTEAEFogJ9IBNVQKkMNJaPHNsctjahpkZgLZ1c6x5UKh/Lbh76Ju
         KWkHYyNC7cB3PEyW+361cZg/qg7Iyl02t9494aT04CY1KHuvmyn9ECVxFLfA7NFmJe1O
         mhvg==
X-Gm-Message-State: AOAM532+3ouEo7lFfFtQ9Lqwutgc0iyYo53Ii8yleqAwXS1cjSF5QwXT
        ExKhgoyM+x+otic34y6BryZrOdKs
X-Google-Smtp-Source: ABdhPJyimMIhHeSK3qrl2dWNjcj4iB6MVBuplAa8ThtZtbKuXGBVk3orC7p4GtXxQyRGpGeAj98J9g==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr42379wme.119.1596471678069;
        Mon, 03 Aug 2020 09:21:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm26358046wrq.58.2020.08.03.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:21:17 -0700 (PDT)
Message-Id: <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
References: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
From:   "Noam Yorav-Raphael via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 16:21:16 +0000
Subject: [PATCH v2] docs: improve the example that illustrates git-notes path
 names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Noam Yorav-Raphael <noamraph@gmail.com>,
        Noam Yorav-Raphael <noamraph@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Noam Yorav-Raphael <noamraph@gmail.com>

Make it clear that the filename has only the rest of the object ID,
not the entirety of it.

Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
---
    Improve the example that illustrates git-notes path names
    
    docs: improve the example that illustrates git-notes path names
    
    Make it clear that the filename has only the rest of the object ID, not
    the entirety of it.
    
    Changed: improved the commit message, according to comments by Taylor
    Blau.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/692

Range-diff vs v1:

 1:  76a674871a ! 1:  8b3defb657 docs: improve the example that illustrates git-notes path names
     @@ Metadata
       ## Commit message ##
          docs: improve the example that illustrates git-notes path names
      
     -    The existing git-notes doc says:
     -
     -    > Permitted pathnames have the form ab/cd/ef/…​/abcdef…​: a sequence of
     -    > directory names of two hexadecimal digits each followed by a filename
     -    > with the rest of the object ID.
     -
     -    Even though the text says that the filename has the rest of the object ID,
     -    I felt the need to check this, since the example gives the impression that
     -    the filename is the entire object ID (a schema which is quite prevalent).
     -
     -    The new example makes it clear that the filename has only the rest of the
     -    object ID, and not the entire object ID.
     +    Make it clear that the filename has only the rest of the object ID,
     +    not the entirety of it.
      
          Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
      


 Documentation/git-notes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index ced2e8280e..9fc1979531 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
 contains "files" whose paths are the object names for the objects
 they describe, with some directory separators included for performance
 reasons footnote:[Permitted pathnames have the form
-'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
+'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory
 names of two hexadecimal digits each followed by a filename with the
 rest of the object ID.].
 

base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
-- 
gitgitgadget
