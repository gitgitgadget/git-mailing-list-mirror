Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7BDC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B30360462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhHaT0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:26:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52860 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhHaT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:26:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D26A31408DB;
        Tue, 31 Aug 2021 15:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mTxOlwUCeHjoge1Xfg/I/WFdaSeXXeaGAIre97
        x7EVA=; b=jdcDFEZ8Nqer9ZoEptd34GWB2jwePo8KkmguVMx4lMax7TZp7yNTj+
        mxVW7MI0W7HnvVrwYA5C1N8Al91NsfhN6pTqH5JgDT+QDpcBrV9/bPxdsKnAVxwu
        QAMOnYieiB7PaOKuStj0jdUJdZgkdvCQc3XJEzUnf6NeNTQ7067FQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4A7C1408DA;
        Tue, 31 Aug 2021 15:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47A4A1408D7;
        Tue, 31 Aug 2021 15:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Thorp <andrew.thorp.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: `git commit` adding unstaged chunks of files to commits on
 2.33.0
References: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
        <xmqq4kb5v6p1.fsf@gitster.g>
        <CAHBARKfLC0ie4p=xWk+xDbEH72fSF6qeWCf=9oOTH6M9V1Qh=A@mail.gmail.com>
        <CAHBARKcKL8h-zHcyCHRAMCj8=-PghopTPkH9o-_8UYRJYNZFmQ@mail.gmail.com>
Date:   Tue, 31 Aug 2021 12:25:51 -0700
In-Reply-To: <CAHBARKcKL8h-zHcyCHRAMCj8=-PghopTPkH9o-_8UYRJYNZFmQ@mail.gmail.com>
        (Andrew Thorp's message of "Tue, 31 Aug 2021 14:01:57 -0400")
Message-ID: <xmqqczptto00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41DB7FFC-0A91-11EC-B91C-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Thorp <andrew.thorp.dev@gmail.com> writes:

>> git commit" without pathspec would have made a partial commit that
> records only the changes that were added with "git add -p" to the
> index, though.
>
> Yeah, that was the expected behavior, but not what I experienced.

Sorry but it does not reproduce for me.

Here is my "reproduction recipe", designed to be followable by
anybody who has a copy of git and this piece of e-mail without
referencing anything else.

$ edit Makefile ; git diff Makefile
diff --git i/Makefile w/Makefile
index 9573190f1d..6bf8f3147b 100644
--- i/Makefile
+++ w/Makefile
@@ -1,4 +1,4 @@
-# The default target of this Makefile is...
+# The default target of this Makefile is.....
 all::
 
 # Define V=1 to have a more verbose compile.
@@ -30,7 +30,7 @@ all::
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
 # commands such as log and grep offer runtime options to use
 # Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
+# POSIX regular expressions...
 #
 # Only libpcre version 2 is supported. USE_LIBPCRE2 is a synonym for
 # USE_LIBPCRE, support for the old USE_LIBPCRE1 has been removed.

... You can see that we have two changes to a single file now ...

$ printf "y\nn\n" | git add -p >/dev/null
$ git status -uno
On branch test
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   Makefile

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   Makefile

Untracked files not listed (use -u option to show untracked files)

... And tell "add -p" to add the first but not the second hunk.

$ git commit -m test

... And commit.

$ git status -uno
On branch test
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   Makefile

no changes added to commit (use "git add" and/or "git commit -a")

... Then the working tree file stays dirty because the second hunk
was not added.

$ git diff
diff --git i/Makefile w/Makefile
index fe6d649c27..6bf8f3147b 100644
--- i/Makefile
+++ w/Makefile
@@ -30,7 +30,7 @@ all::
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
 # commands such as log and grep offer runtime options to use
 # Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
+# POSIX regular expressions...
 #
 # Only libpcre version 2 is supported. USE_LIBPCRE2 is a synonym for
 # USE_LIBPCRE, support for the old USE_LIBPCRE1 has been removed.

... just as we can see here.  Of course, the first hunk is in the
commit, as can be seen ehre

$ git diff HEAD^ HEAD
diff --git a/Makefile b/Makefile
index 9573190f1d..fe6d649c27 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-# The default target of this Makefile is...
+# The default target of this Makefile is.....
 all::
 
 # Define V=1 to have a more verbose compile.
