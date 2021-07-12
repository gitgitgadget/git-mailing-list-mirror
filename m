Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC3C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB10611F1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhGLStF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhGLStB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:49:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB8C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:46:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so19852858otq.11
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dilQo0DL92/KL4Wbbo3XHjkVHsBsAsleQpKO9TdkyD4=;
        b=Mfed6F8317imF+CrPNrXu877y1st66SjaQtZIA6SitP9DWzKD1OddYOvSFTDfXqZc3
         Bj43XxTR1C1HaE8K0ZEx6Q8J+eSeKxPOfpEiYMVTYEjU3MOk4J27YW/e32anq3Tid+m+
         XumqjDrnZ3gLsTwk2H04bxVRjWkV4ZxnoAKwyG/5RK/F5709sRRQLrqIciTPbY5l4dEx
         4IfTM3il/c4BefBTYRBk7arriLhkJEsyAuuNWH1p6gLqtj0lFJOlFosG5fX0qAlYSNPo
         h5u11670UcPR6yexwIsAJuO4gHqxU0Zzf3cNfijfd/210EsAhBYq2bqWRi8RANwejjQ/
         hM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dilQo0DL92/KL4Wbbo3XHjkVHsBsAsleQpKO9TdkyD4=;
        b=DGYAThvQPz/yjfIytwiLZ+6zF7iGwG1G5MVhqAZel7cZHdSEXJJWIdjZmUEFa7zqnR
         tB8TPwK0OiF41UMSyTjAPFsgLZI0xzh0mW7KI1D1yJj/6YIqL/4ju5UYaEZAdeN9/jz0
         QAWeTnp76qZrx479/6mhG7+eN+IGkEYJSCIQcOXQxsoO/BKWVkaxXq8CMDEZaB5ai0Vb
         xjgzOH7BhtXiUpHf3iTw58Nc/bvdjIgXWEqlNsAD9g+xJFB3g7wZJM6nvqlvmLOujwMj
         Ey3f0wq3Q3j6aMzvh4HhDHFKiOLogG3twrisSsvMFpw7VKnvg9TcgPyCRqdzrbV/Lqym
         UtmQ==
X-Gm-Message-State: AOAM5307yc7/FOERwhZ9yimDZqisTBe4EtroaQXK7nWYBS8KrL2j1NG5
        HH6dQBtbFOKcUAxFtCB1YKY=
X-Google-Smtp-Source: ABdhPJz0w0sj9mGXiAifyLTPZgo6rC/f51vHSbnkuQQYvXGQI2w2zmwybq+GQv2UEdvTsy6IOUhTOA==
X-Received: by 2002:a05:6830:2097:: with SMTP id y23mr326188otq.363.1626115571995;
        Mon, 12 Jul 2021 11:46:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id k14sm2675520oon.5.2021.07.12.11.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:46:11 -0700 (PDT)
Subject: Re: [PATCH 0/5] Sparse index: integrate with commit and checkout
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
 <CABPp-BF_i1QRCXaeKzqoc6Q2=3un-wku7aKUEdBbXfeVfTG8xg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b362c428-eec9-39e3-55a0-0738431e1d98@gmail.com>
Date:   Mon, 12 Jul 2021 14:46:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF_i1QRCXaeKzqoc6Q2=3un-wku7aKUEdBbXfeVfTG8xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2021 5:26 PM, Elijah Newren wrote:
> On Mon, Jun 28, 2021 at 7:13 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
...
> I've read over these patches and didn't find any problems in them in
> my reading; however, since it builds upon ds/status-with-sparse-index
> (v7)...
> 
> I decided to retry some of my ideas and testing on Patch 10/16 of v7,
> over at https://lore.kernel.org/git/CABPp-BHwTAKwFiWQ0-2P=_g+7HLK5FfOAz-uujRjLou1fXT3zw@mail.gmail.com/
> 
> It turns out that the block you added there is now triggered by t1092
> after this series, and the testcase won't pass without that block.  It
> might be clearer to move that code fragment, or perhaps the whole
> patch, into this series...though the code fragment as is has
> introduced a bug.  If you take t1092 test 12 ("diff with
> directory/file conflicts") and modify it so that before the
> 
>     git checkout df-conflict
> 
> invocation from sparse-index, you first run:
> 
>     $ git sparse-checkout disable
>     $ echo more stuff >>folder1/edited-content
>     $ git add -u
>     $ git diff HEAD   # note the changes
>     $ git sparse-checkout init --cone --sparse-index
>     $ git diff HEAD   # note the changes are still there
>     $ git checkout df-conflict  # no error??  What about the
> conflicting changes?
>     $ git diff HEAD
> 
> then the last command will show that the staged changes from before
> the commit have simply been discarded.  In short, this makes the
> series behave like --force was passed with sparse directory entries,
> when --force wasn't passed.
> 
> So we've still got some directory/file conflict issues.

You are absolutely right that this seems strange. In fact, there
is a behavior change during 'git checkout' for sparse-checkouts
in general, but also my sparse-index change creates an additional
change in this case.

Here is a test that demonstrates the issue:

test_expect_success 'staged directory/file conflict' '
	init_repos &&

	test_sparse_match git sparse-checkout disable &&
	write_script edit-contents <<-\EOF &&
	echo text >>folder1/edited-content
	EOF
	run_on_all ../edit-contents &&

	test_all_match git add folder1/edited-content &&
	test_all_match git diff HEAD &&
	git -C sparse-checkout sparse-checkout init --cone --no-sparse-index &&
	git -C sparse-index sparse-checkout init --cone --sparse-index &&
	test_all_match git diff HEAD &&

	# Sparse-checkouts handle this conflict differently than
	# full checkouts, as they consider the file "folder1" to
	# be deleted in favor of the staged file
	# "folder1/edited-content".
	test_sparse_match git checkout df-conflict &&
	test_sparse_match git diff HEAD
'

The sparse-index case drops all staged changes during the
'git checkout df-conflict' command, so the test fails on
that line.

That final diff looks like this in the sparse-checkout
repo (no sparse index):

diff --git a/folder1 b/folder1
deleted file mode 100644
index d95f3ad..0000000
--- a/folder1
+++ /dev/null
@@ -1 +0,0 @@
-content
diff --git a/folder1/edited-content b/folder1/edited-content
new file mode 100644
index 0000000..8e27be7
--- /dev/null
+++ b/folder1/edited-content
@@ -0,0 +1 @@
+text

This is a strange case in that we have a staged tree that is
outside of the sparse-checkout cone. When running the 'git
checkout df-conflict' command, the twoway_merge() method
receives the following values:

 current: "folder1/" (tree OID)
 oldtree: "" (NULL OID)
 newtree: "folder1" (blob OID)

Is this value for 'oldtree' correct? It seems strange to me,
so I'll look further into it.

Clearly, the resolution that was presented in the previous
patch was incorrect so I will try to understand this
situation better.

Further, I expect it to be simpler to modify the behavior
here to match the full checkout case than to make the
sparse-index case match the normal sparse-checkout case.
The "natural" thing would be to keep the staged "folder1/"
directory, but that would present as adding all contained
content, not just the single staged entry.

Thanks,
-Stolee
