Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE5C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755FA64F9B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhCDPYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhCDPYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 10:24:05 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFDDC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 07:23:25 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d20so27124589qkc.2
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qu6Zu/Y1SJ2un6Tz/PhujrvbeqCeUaEUgpmmYUAxHm4=;
        b=RfgrNxCM+Vbwfc9OD9VMY3/7VtyGaAt34nq0U0Te1HjlAIftPxahegRzix4PzMSEwU
         WdGHpfWSqM+t0FOgwPiKACYimmcWaK2ye2YBBg7a9JScZosG2Z/04ttKE/lFEVDyrNkt
         wm7OM3dx5PwZxnlzKqbfE9DDjFGdggQNjfAjI+VUoO/nyPZ1jooeM4gC4MAjU6rez48X
         voZFFSeASJU6EMLpRJ7rMzZxOJIZVkNwwETIKvD5v8b2hGHlAGe+RwqSmPLOwymXE1DK
         20dWKzQp/tzfJacGBgsYcQhmFywQrNlQQP1IL94CWgjkykxprV2zRxw7dk58HEThYmLw
         jICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qu6Zu/Y1SJ2un6Tz/PhujrvbeqCeUaEUgpmmYUAxHm4=;
        b=noe7iHvukzbQIrMZ4bJWNsT0MN9x3e7PfSwVlJLx19M46IF1e4gWtGx3EQyadQBizZ
         FAlZqnp2GEtEJCokBDwfMvYhRjDtEYtsep0FXXJdJg1Gg8gaS4zsnsSXDTwfm9s/xvgM
         hQuOhN5qMDQP1vTBReEFyRcQxlGgJWSgly5161RrYtfMczcgpeub50nThuUa3YNhp6mU
         eiUHmWXsFpyO9VxdqMfFErXrfCv0f5acdrC4GLgwC6GqrjHLhONNpths7JGqQvHONuYj
         JaXIxIJpKFBh1D2MzCH9M6Oye/5JZAixmDLqcn0yfQDX1XUSOXY/yLC1EAZjzlm/7l1z
         qXkQ==
X-Gm-Message-State: AOAM530zRCGv3BCxUx/qh5i1Q+aI14RVCSQCk1vLO9Feu9brUScEMbHA
        bl1RGyUQYt2hBFYLmqn+dyoKtA==
X-Google-Smtp-Source: ABdhPJxfupgOIxQJ9S9XHUlats9XszZORfDvrWVThcV5RGLJsguqcYbmF8C1ULx/fFvfhp2pIk+SfQ==
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr4399582qkl.377.1614871403659;
        Thu, 04 Mar 2021 07:23:23 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm15972117qkg.6.2021.03.04.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:23:22 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
Date:   Thu,  4 Mar 2021 12:23:15 -0300
Message-Id: <20210304152315.18498-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
References: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Elijah

I was going to send v3 a couple days ago, but there is still one issue
that I'm having a bit of trouble with:

On Wed, Feb 24, 2021 at 3:50 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hmm...here's an interesting command sequence:
>
> git init lame
> cd lame
> mkdir baz
> touch baz/tracked
> git add baz/tracked
> git update-index --skip-worktree baz/tracked
> rm baz/tracked.  # But leave the empty directory!
> echo baz >.gitignore
> git add --ignore-missing --dry-run baz
>
>
> Reports the following:
> """
> The following pathspecs only matched index entries outside the current
> sparse checkout:
> baz
> hint: Disable or modify the sparsity rules if you intend to update such entries.
> hint: Disable this message with "git config advice.updateSparsePath false"
> The following paths are ignored by one of your .gitignore files:
> baz
> hint: Use -f if you really want to add them.
> hint: Turn this message off by running
> hint: "git config advice.addIgnoredFile false"
> """
>
> That's probably okay because it does match both, but the "only
> matched" in the first message followed by saying it matched something
> else seems a little surprising at first.

After giving this a little more thought, I got to this idea [1]. With
this patch, git-add doesn't warn about sparse paths that are inside
ignored dirs (it only warns about the ignored dirs themselves). If
--force is used, then git-add recurses into the ignored directories, and
warns about any sparse path inside them. I think this is more consistent
with the way in which ignored dirs (and their contents) are handled with
and without --force. And we avoid the double warning.

But there is a performance penalty. The relevant code is:

@@ -2029,19 +2033,23 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 		       PATHSPEC_ICASE |
 		       PATHSPEC_EXCLUDE);
 
+	assert(matched_ignored);
+
 	for (i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
 
-		if (len == pathlen &&
-		    !ps_strncmp(item, item->match, path, pathlen))
-			return 1;
-		if (len > pathlen &&
-		    item->match[pathlen] == '/' &&
-		    !ps_strncmp(item, item->match, path, pathlen))
-			return 1;
+		if (matched && matched_ignored[i])
+			continue;
+
+		if ((len == pathlen ||
+		    (len > pathlen && item->match[pathlen] == '/')) &&
+		    !ps_strncmp(item, item->match, path, pathlen)) {
+			matched = 1;
+			matched_ignored[i] = 1;
+		}
 	}
-	return 0;
+	return matched;
 }

This function is called for each ignored path (not recursing into
completely ignored dirs, though). Before the patch, the internal loop
stops at the first pathspec match. But with the patch, the loop must
continue as we need to know about all pathspecs that had matches with
the ignored paths...

And there is also one odd case:
$ mkdir d
$ touch d/s d/i
$ git add d/s
$ git update-index --skip-worktree d/s
$ echo d/i >.gitinore
$ git add 'd/[is]'

This outputs:
The following pathspecs only matched index entries outside the current
sparse checkout:
d/[is]
(and no warning on ignored paths).

I don't think the warning here is 100% correct, as 'd/[is]' *does* match
other files, only they are ignored. And git-add only warns about an
ignored path when the pathspec is an exact match with it (no glob
patterns) or inside it. 

So, I don't know... Perhaps should we just rephrase the sparse warning
to remove the "only" part (and don't try to avoid the double warnings)?
I'm open to any suggestions on alternative wordings or ideas :)

[1]: https://github.com/matheustavares/git/commit/5d4be321e1f69cb08b0666ffd3f8fa658e9f6953
