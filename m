Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042DC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8B20707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 16:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUblWEH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgA3QKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:10:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36238 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3QKc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 11:10:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id g15so3655987otp.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjrAQHx9nPodNLTaOSUFzvR8vgSBvnA69pKfWK9f/EE=;
        b=CUblWEH/K/gU8UF46OrBxpXK/OFZxq5MbvRKhw2TZfq/GH1Dh4crbGkpbqa4IV/Ifq
         nEwMxdYjTsJIGEc6H6qkK130AzMA/3dTwNkFgsPmqRk/P/4BzmuSVXSltjnbEeIbLZB4
         hIhiL4gkB3kyLVdmK7rBDjyFKB+NQnkSdtXulrdmDMfPX6M/RzVPAV39rSG9Ot+87lhr
         vuVfQ7CwvhRAXEeIPFBNyw0pWyFDGSAZieer/Dsuua+/vEXInE+ZMArIdkhc09C9lFNj
         JXz1JuzJ3EzYzCgH6nywp3ESkXhP8GBortQoCumFOxxjGHVP5E2+5dPQTOpHqeICUAUV
         H5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjrAQHx9nPodNLTaOSUFzvR8vgSBvnA69pKfWK9f/EE=;
        b=gmpFVZOGRvg44wVYSXWpkOCa8V6iAKMUYfTKD9lqiWcx71TdGH7ijnpC9u+LJpX1ej
         41wz305pWcYrRTMsM559CCtuD7Kt1Ia+67xQHHCUVIBt3mLUX82pJtcf61Q2tw1feAyf
         c3z4bIwdJQ4nqTkh0mZfKTwpZGhtsjd9XSgSslKRivLFpBm4c/ai1e6qwq1AiSPhDftq
         x3n43c/XTr5DiGsBLepXMpv/RT8+ljm468KfhCBEpT3YhoO0fmEEpHAdyPyQ9vD8UWwx
         V+wnGspoZH9s4QA39m3pbUbfbP6O+Umh18C+zr5B96EfOByfsnHEOBKxA+xnDFhl6wHK
         VD+Q==
X-Gm-Message-State: APjAAAX5a3TP6W2J0PC5aNz9cCuu5k5f7VmKUFO09oDQj7PKMUwVihJ4
        +pP0vmO+eDnlIB16/k+QVgY=
X-Google-Smtp-Source: APXvYqwfAi7hK2mjMcHHb6VcjuGj5p6P3ferjlE72ym26/xwA1idspYIHZDuxYPIWqJOCe2ExKU+Yg==
X-Received: by 2002:a05:6830:110a:: with SMTP id w10mr4189311otq.300.1580400631000;
        Thu, 30 Jan 2020 08:10:31 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u26sm1792613oic.2.2020.01.30.08.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:10:30 -0800 (PST)
Subject: Re: [PATCH 4/6] dir: move setting of nested_repo next to its actual
 usage
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <3b2ec5eaf65c9fe44c4337a4cc2fc3dae6203d54.1580335424.git.gitgitgadget@gmail.com>
 <8d9a6047-26be-ff78-cf1a-9f2b35f927e0@gmail.com>
 <CABPp-BFbXJRW38CeGy78b22MfZ8cNizexCM-+n-ODqy+fOo2uw@mail.gmail.com>
 <1bc41d94-5d4d-4157-fc00-08b97fb20738@gmail.com>
Message-ID: <d67eb395-3b6d-9558-0288-cd3878290c9e@gmail.com>
Date:   Thu, 30 Jan 2020 11:10:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <1bc41d94-5d4d-4157-fc00-08b97fb20738@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 11:00 AM, Derrick Stolee wrote:
>  
> Let me send a v2 of this patch now that you've pointed out my error. It
> is worth making this method clearer before you expand substantially on
> this final case.

Here we are:

-->8--

From 3fb4fdda25affe9fe6b3e91050e8ad105bcb6fe0 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Thu, 30 Jan 2020 15:28:39 +0000
Subject: [PATCH v2] dir: refactor treat_directory to clarify control flow

The logic in treat_directory() is handled by a multi-case
switch statement, but this switch is very asymmetrical, as
the first two cases are simple but the third is more
complicated than the rest of the method. In fact, the third
case includes a "break" statement that leads to the block
of code outside the switch statement. That is the only way
to reach that block, as the switch handles all possible
values from directory_exists_in_index();

Extract the switch statement into a series of "if" statements.
This simplifies the trivial cases, while clarifying how to
reach the "show_other_directories" case. This is particularly
important as the "show_other_directories" case will expand
in a later change.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/dir.c b/dir.c
index b460211e61..0989558ae6 100644
--- a/dir.c
+++ b/dir.c
@@ -1660,29 +1660,26 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const struct pathspec *pathspec)
 {
 	int nested_repo = 0;
-
 	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(istate, dirname, len-1)) {
-	case index_directory:
-		return path_recurse;
+	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
 
-	case index_gitdir:
+	if (status == index_directory)
+		return path_recurse;
+	if (status == index_gitdir)
 		return path_none;
 
-	case index_nonexistent:
-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-		    !(dir->flags & DIR_NO_GITLINKS)) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, dirname);
-			nested_repo = is_nonbare_repository_dir(&sb);
-			strbuf_release(&sb);
-		}
-		if (nested_repo)
-			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
-				(exclude ? path_excluded : path_untracked));
+	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+		!(dir->flags & DIR_NO_GITLINKS)) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, dirname);
+		nested_repo = is_nonbare_repository_dir(&sb);
+		strbuf_release(&sb);
+	}
+	if (nested_repo)
+		return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
+			(exclude ? path_excluded : path_untracked));
 
-		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
-			break;
+	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
 		if (exclude &&
 			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
 			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
-- 
2.25.0.vfs.1.1



