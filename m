Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D8C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE30610FA
	for <git@archiver.kernel.org>; Tue,  4 May 2021 14:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEDOH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhEDOH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 10:07:56 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60AC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 07:07:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l19so3952593qvu.8
        for <git@vger.kernel.org>; Tue, 04 May 2021 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmrlbVTNntZMWQw5tVwYlfV1WdS9jdHPaGcc7hfMBxc=;
        b=oZkFLR9i7Q5I147DfAOt8oqqIH9RXR/7UbKVJAML6LDiAbxKu6h4PosgjwEWPEVEGy
         Dwb1MHxKRtyGfrT2vvtnJy+KvV4WxzeadyNHw3ecGFPlDz9xxWPDzPPcBG1OO0iDFE8W
         xd9ghFhr/ruoSDbNZ+QqLN/ieZxGq9dxi5UePHAQPSUcEiKHsX9KZRA55yDgd2g5tbPG
         2l7hFhaJ6IZymOgbbjSjQ1koWz59zGA1W06ACPBf9I0NEEL8FZwJnCr0zZugsciEeHSU
         ita1Mta6oE7JUvM3WbMTfRlCIADZ3foYsPyYonuc03wRTq5fsq8t7oaUuSB6UQ5zJH66
         QZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmrlbVTNntZMWQw5tVwYlfV1WdS9jdHPaGcc7hfMBxc=;
        b=iMHlORMfpuEqHEsWsoDs6Rj56PPrweyJg6fmEItvXRWDQqF/aKGM3AcCLRvisdIiZl
         YL1G+bYNDyKnj0l0xtY/d4Oep73RkNSgtChmYTk6tAi0k3HM4jOt/qIJJmniNqNKsIkF
         tB+BuvFp0IpXBa3Ph5pt+3snwQjIsbYju6jt0xKsiaKA4wbOwwE6olcDQ5F/uIEHJWn7
         Gcg9jC/z08wSWmcnkCldovCxuM4nRASZ/1wBXfxxirsDyMBnCpr7zDAUDb5z3gA9KRSd
         rwQjxWV4G14aG1ozcGIywaq5W0LQI4EVThwDTJE95QQBeH/mA/pAIW/8LTzNTIxINYaD
         L2ag==
X-Gm-Message-State: AOAM532VXnWYavgeehP2RDW2va4fBFX9eWGLYwB0iAyVrZMuIkGpcA88
        c8iNgCEEnQCI5pdjGHzWHw6/cGZd1OEbzg==
X-Google-Smtp-Source: ABdhPJxtrMU9icd2WtlvRLd8D8Sq1Lx+jfYKVLpxG4+Cknb1JeqOJHNYRKDLL0PBGnGd0JVuI5Byew==
X-Received: by 2002:a0c:ca8c:: with SMTP id a12mr25308163qvk.14.1620137220220;
        Tue, 04 May 2021 07:07:00 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm2428556qth.57.2021.05.04.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:06:59 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     philipoakley@iee.email
Cc:     git@vger.kernel.org, mailnew4ster@gmail.com
Subject: Re: gitignore + commit with excludes = bug
Date:   Tue,  4 May 2021 11:06:53 -0300
Message-Id: <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Paul and Philip

On Tue, May 4, 2021 at 9:55 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> Hi Paul,
>
> On 01/05/2021 19:37, Paul Jackson wrote:
> > Hello,
> >
> > I stumbled upon what I believe is a bug in git.
> > See the following reproduction steps:
> >
> > mkdir test
> > cd test
> > git init
> > echo 1 > ignored
> > echo 1 > not-ignored
> > echo ignored > .gitignore
> > git add -A -- ':!ignored' || echo 'ERROR!!!'
> >
> > In these steps, I ignore the "ignored" file twice - first time in
> > .gitignore, and second time in the "git add" command. I didn't expect
> > this to be a problem, but I'm getting the following error message:
> >
> > The following paths are ignored by one of your .gitignore files:
> > ignored
> >
> > It looks as if git thinks I wanted to include, not exclude "ignored"
> > in "git add".
> I was intrigued by this. The man pages can be hard to decipher, and it
> may be an 'as designed' feature, but still not intuitive
>
> It took a while to find the relevant parts of the man pages.
>
> The `-A` option of `add` is under
> https://git-scm.com/docs/git-add#Documentation/git-add.txt---no-ignore-removal
> which has caveats for whether a pathspec is given.
>
> The `exclude` magic pathspec is under
> https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-exclude
> and again has caveats and a double negative regarding whether the
> `exclude` pathspec counts as a path spec.
>
> I _think_ that it is saying that the `exclude` pathspec is ignored for
> the purpose of the `-A` (all) condition for git add.

Hmm, I think the issue is not really related to `-A`. In fact, if we
reproduce Paul's original example without `-A`, we still get the
warning.

The problem seems to be at `dir.c:exclude_matches_pathspec()`, which
creates the list of ignored files that is later used by `git add` to
presented the "The following paths are ignored..." warning.

This function ignores the `exclude` magic, so a path 'x' incorrectly
matches both ':x' and ':!x'. And thus, we end up warning the user about
'x' being ignored even when the user had ran `git add ':!x'`.

I think something like this, might solve the problem:

diff --git a/dir.c b/dir.c
index 3474e67e8f..165ca6a543 100644
--- a/dir.c
+++ b/dir.c
@@ -2042,6 +2042,25 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
 
+		if (!(item->magic & PATHSPEC_EXCLUDE))
+			continue;
+
+		if (len == pathlen &&
+		    !ps_strncmp(item, item->match, path, pathlen))
+			return 0;
+		if (len > pathlen &&
+		    item->match[pathlen] == '/' &&
+		    !ps_strncmp(item, item->match, path, pathlen))
+			return 0;
+	}
+
+	for (i = 0; i < pathspec->nr; i++) {
+		const struct pathspec_item *item = &pathspec->items[i];
+		int len = item->nowildcard_len;
+
+		if (item->magic & PATHSPEC_EXCLUDE)
+			continue;
+
 		if (len == pathlen &&
 		    !ps_strncmp(item, item->match, path, pathlen))
 			return 1;
---

I had to split the original loop into two and handle the `exclude`
pathspecs first because we cannot let the original loop return early
when one of the `non-exclude` pathspecs matches the path. Otherwise, we
would still incorrectly warn the user on executions like
`git add ignored ':!ignored'`.

(We might also want to extract the matching part to its own function to
avoid repeating this code on the two loops.)
