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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE417C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF012076E
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWINAvlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHCOnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 10:43:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9523C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 07:43:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so14466088wme.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=fj+ibUTSZRYH4ByXQvENWT0q8QpEj4Cl6BLRvGPFdDI=;
        b=EWINAvlExUFssjoihyxSufKLBhKzjHnyZvpgYmksQLaRc1Nu96NoHvI1Wug5unTny3
         vQvt6jEjDpyMqvSuAs3EfRTYp7fAmfH42OwDjpuS26d6EX0ocPEGV8pUGMbtUa3417/0
         4f3yU+pSOlyUh7kjqqNci3jQAgqXHlZi4rCM37BLycs2k147KY5z8W0DZO24K/T1gzZ1
         HH+OQnshNP1WgmZqaP4qpwpVH1kaHPtS3oF8WPNG7CukiuYXwHJFauh8ym+PRz7dbzkv
         m73sq9r7u+AK+boyKwqbNPbmwePZX+VmDYQXqDD8PVJCgUNlgkgViA7OXVahvrYI/WS8
         NiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fj+ibUTSZRYH4ByXQvENWT0q8QpEj4Cl6BLRvGPFdDI=;
        b=PC3G/oj3RT1SB3OWI2g6tiAPhSmWerqM4hvJbNLiYnAFoRibSC/ziP7lHd2anYvpAx
         yeOSXVPuwX9QY3xUImvzmVLc5svJGhVIOHY5lh60fwML57iivDe1D9tb+9Mf51h5pwME
         dYWSTV+Sn+zgBgLyNBy97a8PBrVtvLueadWk8Yd2qrz6qP858wpuuAfSj4LQXqZY9Ibk
         r1pvT86nOmYSp9cDfRt7iczjOJF9DnFJsxap60E3p0EjA3Or4C0vdGgY76ZL/vmuFhEx
         WRoNZvmOXsg/nK+SGrv/fM5uF7McCdxwFAY8sattxX1U6oILegIDmwWGmJbSOWXA0G83
         D8bw==
X-Gm-Message-State: AOAM533eenKs0K8fKKHD4ILeWCbWFTygCi/XLBRBfNA3kxuTgM8A7Adi
        WYYssCmGq46yDf5zdmDRhDgBiSrT
X-Google-Smtp-Source: ABdhPJz94dgJqgBWclXtGM7kAID+TupGqJWGL+1IpYeF5YoAISchs4bmwS2kSFDv8HuogkrgPETGRw==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr301526wmn.123.1596465818339;
        Mon, 03 Aug 2020 07:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm24893784wrv.50.2020.08.03.07.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:43:37 -0700 (PDT)
Message-Id: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
From:   "Noam Yorav-Raphael via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 14:43:36 +0000
Subject: [PATCH] docs: improve the example that illustrates git-notes path
 names
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Noam Yorav-Raphael <noamraph@gmail.com>,
        Noam Yorav-Raphael <noamraph@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Noam Yorav-Raphael <noamraph@gmail.com>

The existing git-notes doc says:

> Permitted pathnames have the form ab/cd/ef/…​/abcdef…​: a sequence of
> directory names of two hexadecimal digits each followed by a filename
> with the rest of the object ID.

Even though the text says that the filename has the rest of the object ID,
I felt the need to check this, since the example gives the impression that
the filename is the entire object ID (a schema which is quite prevalent).

The new example makes it clear that the filename has only the rest of the
object ID, and not the entire object ID.

Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
---
    Improve the example that illustrates git-notes path names
    
    The existing git-notes doc says:
    
    > Permitted pathnames have the form ab/cd/ef/…​/abcdef…​: a sequence of
    > directory names of two hexadecimal digits each followed by a filename
    > with the rest of the object ID.
    
    Even though the text says that the filename has the rest of the object
    ID, I felt the need to check this, since the example gives the
    impression that the filename is the entire object ID (a schema which is
    quite prevalent).
    
    The new example makes it clear that the filename has only the rest of
    the object ID, and not the entire object ID.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/692

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
