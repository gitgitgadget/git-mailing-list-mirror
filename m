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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBAC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8C720A8B
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce+myJa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHCTKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTKS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:10:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8EC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 12:10:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so626305wma.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i4e1Ul2B+x7vfqiP0g2ZMLEV3XGUGdCp8CM6LMuyQjs=;
        b=Ce+myJa2gWEx9q9a2E6E26JaFjwi+azm/rjVAFxuLiE9vVIAHPxcUYERpswsgDe/CJ
         +/pYKuBjVhlmdBv3N0QPEIlK+6gpywqOGOY6Gin6Jk5QHvPG3rx9Uh0wFvvgvfAlV1vM
         mHD7u39wpemnnTMBu+N/63zTAxujylVd6z+14Eb3VjYBx1aZt4ldnbAf1O1BXEy0FUxK
         1EWXlLnHDV0fvnm76yQBjcr7K8MXHaixGu4DKyBgU4C4lndMSWCS5exMBa0IplMisEhq
         SyxYQB4+1dP/EAeruZp6G7heq8DdKo3z96dPFm260/crG3RTjHGmu0yzP6toMN1UYFep
         ezZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i4e1Ul2B+x7vfqiP0g2ZMLEV3XGUGdCp8CM6LMuyQjs=;
        b=C3el9FXGTG4e87UkI/SeGxd643It744SzqXYa/TK5BpiyNmkap/zE1T3h7R2UeRLWs
         RfUZUGoMdSep4RUYVhM+3mzKAJD1I+1ohshHHioBhyecsGJ0cPjiWSGr5zXlT0E9Yzp6
         VyyiEyF9HLUFRw7enbRCgawt40oiuPnCAweNoiHx5uZduS3DXOvFLmb12TJpat5RoJIt
         nC2gLlyl3V81IQHlQ6YotycPElR20OS17shYc5hDXNKFpoWb/1HeZqp7VU24M0eVoCrq
         v2hIpluYxfqSvPm9WyNsoUCpglfti7X4F/PPXA3DyUv/gyi7tU1p4Vug3FK5mEbv/zJN
         08xQ==
X-Gm-Message-State: AOAM533si2Rlf9ZK0U308t7ZfTQ/XgBenaCOUYKe8M9+ijWsrqyrD9Ad
        bbT6PwkzqUep+gtl15o+52+3NXMC
X-Google-Smtp-Source: ABdhPJyND0jGr64sqN3SKjpDWPUFFsmhF5H38GdKs/q7gcw/HH+OuowXLShPYyjpLbTbAlCgq93XUA==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr623617wmd.72.1596481817139;
        Mon, 03 Aug 2020 12:10:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z207sm984628wmc.2.2020.08.03.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:10:16 -0700 (PDT)
Message-Id: <pull.692.v3.git.1596481815803.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
References: <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
From:   "Noam Yorav-Raphael via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 19:10:15 +0000
Subject: [PATCH v3] docs: improve the example that illustrates git-notes path
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
    
    Changes since v1:
    
     * Improved the commit message, according to comments by Taylor Blau.
     * Changed the parts to random hex, so the '...' won't be confusing,
       according to suggestion by Junio C Hamano.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/692

Range-diff vs v2:

 1:  8b3defb657 ! 1:  e973e321d8 docs: improve the example that illustrates git-notes path names
     @@ Documentation/git-notes.txt: are taken from notes refs.  A notes ref is usually
       they describe, with some directory separators included for performance
       reasons footnote:[Permitted pathnames have the form
      -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
     -+'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory
     ++'bf'`/`'fe'`/`'30'`/`'...'`/`'680d5a...': a sequence of directory
       names of two hexadecimal digits each followed by a filename with the
       rest of the object ID.].
       


 Documentation/git-notes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index ced2e8280e..0a4200674c 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
 contains "files" whose paths are the object names for the objects
 they describe, with some directory separators included for performance
 reasons footnote:[Permitted pathnames have the form
-'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
+'bf'`/`'fe'`/`'30'`/`'...'`/`'680d5a...': a sequence of directory
 names of two hexadecimal digits each followed by a filename with the
 rest of the object ID.].
 

base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
-- 
gitgitgadget
