Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D6C7619A
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 20:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjC3Uq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC3Uqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 16:46:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595AA12D
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 13:46:53 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id kw3-20020a170902f90300b001a274ccf620so3138840plb.8
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680209212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJIDpeF6MwFUe1ZwjWwh7/jM/ZY9JRBDLfQNbaWNRHE=;
        b=kYSP7hdER/5ZHl0iLBI9HT+v0ZQaZiLI5i7x6S5FCCQfuQl2fpGbl4fDbeWOvLxoKb
         PTPhvcgA56RfIqCC1iYocrQIpGlG5LXqk63WASxHO83mhIBdHKG+lAWRW44hU+CrYPD2
         pQB4KLtT/LUiFbppjBwqpNk215rWYeMAJ8EdnERVYO+EcfMu9YoNcwwYNWAtz28c610Y
         0O+n3UeE6EirZ2BnukRQXgjWZSqhFosGd6iCLt9ygqqflR9tlVymix7G4CwEKnOtrYlq
         fMRwGUwGFLB+uCCbALVnjuUQUuAZdc7e4KYIJfKfZxazdAEMDQdzK1loIbnTjOyCqTs2
         0ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJIDpeF6MwFUe1ZwjWwh7/jM/ZY9JRBDLfQNbaWNRHE=;
        b=uCQLkzUd83xOhXHIW7N8i8mhirhvMFuA6luKSBzTTfvz26HAWj76ibOAeNZwCclnhb
         w5luSnPocjbp81HEEpcz5mU4hv34OlJJb8/hmgjKr4IbI0l6M8fLfbDgO5s4W63yW0kz
         r+nHU1A8LYQiLoKob3+6firQ1svx9TVygbh+r9xr35BVKWxgjyPYUW/yVN6XRjWz3T++
         uA5s/n+qDp52etR4DQb7T6COshdjNJrUX8v2aW/fSJ3lwLbST41WETwJmI0/zvLGP5GF
         lJwVZkP2YkHqy3cJ5bhIMv2x7iB/de3qYQBHNJtNEJF0trig7G5snMk4AMYr8s4eiEQ1
         tvIQ==
X-Gm-Message-State: AAQBX9e3hkdSdZdFWDdWKlI1Uv+OBYypmjoX5hGXhBxGOcogiG8MBZWM
        TbJorUUaiojpOBTrSBVtnhdrNn+bDYOhgQ==
X-Google-Smtp-Source: AKy350bIv2bruKmiaJlHPSw7rUlxxrVTjxK+c56puD7m8ii7kPU+fJB6ItDz/Qvv50jBgyWOfpuGDsA9MM+LaQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:13a9:b0:625:cf6d:b26b with SMTP
 id t41-20020a056a0013a900b00625cf6db26bmr4035353pfg.1.1680209212642; Thu, 30
 Mar 2023 13:46:52 -0700 (PDT)
Date:   Thu, 30 Mar 2023 13:46:42 -0700
In-Reply-To: <20230324170800.331022-1-jacob.e.keller@intel.com>
Mime-Version: 1.0
References: <20230324170800.331022-1-jacob.e.keller@intel.com>
Message-ID: <kl6l4jq2c6h9.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3] blame: allow --contents to work with non-HEAD commit
From:   Glen Choo <chooglen@google.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob! Great to see you at Review Club :)

If you'd like, yo ucan review the notes here:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit

but as always, all important discussion happens on the ML.

I see that this patch is already queued for 'master' (which is fine),
though I think it might even better with another patch on top.

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The --contents option can be used with git blame to blame the file as if
> it had the contents from the specified file. This is akin to copying the
> contents into the working tree and then running git blame. This option
> has been supported since 1cfe77333f27 ("git-blame: no rev means start
> from the working tree file.")
>
> The --contents option always blames the file as if it was based on the
> current HEAD commit. If you try to pass a revision while using
> --contents, you get the following error:
>
>   fatal: cannot use --contents with final commit object name
>
> This is because the blame process generates a fake working tree commit
> which always uses the HEAD object as its sole parent.
>
> Enhance fake_working_tree_commit to take the object ID to use for the
> parent instead of always using the HEAD object. Then, always generate a
> fake commit when we have contents provided, even if we have a final
> object. Remove the check to disallow --contents and a final revision.

I thought that the commit message was very clear and provided enough
context even for reviewers who weren't familiar with "git blame
--contents". Thanks!

I'll reorder the patch hunks to make discussion easier:

> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index f1b9a6ce4dae..b35be20cf327 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -98,6 +108,10 @@ test_expect_success 'blame 2 authors' '
>  	check_count A 2 B 2
>  '
>  
> +test_expect_success 'blame with --contents and revision' '
> +	check_count -h testTag --contents=file A 2 "Not Committed Yet" 2
> +'
> +

As the test notes, the author of the changes is "Not Committed Yet"...

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 9a663535f443..95599bd6e5f4 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -64,11 +64,11 @@ include::line-range-format.txt[]
>  	manual page.
>  
>  --contents <file>::
> -	When <rev> is not specified, the command annotates the
> -	changes starting backwards from the working tree copy.
> -	This flag makes the command pretend as if the working
> -	tree copy has the contents of the named file (specify
> -	`-` to make the command read from the standard input).
> +	Pretend the file being annotated has a commit with the
> +	contents from the named file and a parent of <rev>,
> +	defaulting to HEAD when no <rev> is specified. You may
> +	specify '-' to make the command read from the standard
> +	input for the file contents.

which I found quite difficult to reconcile with the description here,
in particular:

  Pretend the file being annotated has a commit...

We could try to make the two more coherent by rewording the docs, maybe:

  Pretend that the working copy has the contents of the named file. If
  <rev> is also given, also pretend that HEAD is at <rev>.

But (as Junio suggested in Review Club), maybe it would be better to
just change "Not Committed Yet" to something more accurate, like
"External file (--contents)", and then we can drop the language around
"pretend".

It would be pretty simple, too. Here's a rough patch (that I don't mind
you sending as your own):

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 95599bd6e5..4a861ff31c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -64,11 +64,10 @@ include::line-range-format.txt[]
 	manual page.
 
 --contents <file>::
-	Pretend the file being annotated has a commit with the
-	contents from the named file and a parent of <rev>,
-	defaulting to HEAD when no <rev> is specified. You may
-	specify '-' to make the command read from the standard
-	input for the file contents.
+	Annotate using the contents from the named file instead of the
+	working tree copy, starting with <rev> if it is specified, and
+	HEAD otherwise. You may specify '-' to make the command read
+	from the standard input for the file contents.
 
 --date <format>::
 	Specifies the format used to output dates. If --date is not
diff --git a/blame.c b/blame.c
index 2d02cf0636..129dae7641 100644
--- a/blame.c
+++ b/blame.c
@@ -204,8 +204,12 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 	origin = make_origin(commit, path);
 
-	ident = fmt_ident("Not Committed Yet", "not.committed.yet",
-			WANT_BLANK_IDENT, NULL, 0);
+	if (contents_from)
+		ident = fmt_ident("External file (--contents)", "external.file",
+				WANT_BLANK_IDENT, NULL, 0);
+	else
+		ident = fmt_ident("Not Committed Yet", "not.committed.yet",
+				WANT_BLANK_IDENT, NULL, 0);
 	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
 	for (parent = commit->parents; parent; parent = parent->next)
 		strbuf_addf(&msg, "parent %s\n",
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index b35be20cf3..2ef70235b1 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -72,6 +72,13 @@ test_expect_success 'blame 1 author' '
 	check_count A 2
 '
 
+test_expect_success 'blame working copy' '
+	test_when_finished "git restore file" &&
+	echo "1A quick brown fox jumps over the" >file &&
+	echo "another lazy dog" >>file &&
+	check_count A 1 "Not Committed Yet" 1
+'
+
 test_expect_success 'blame with --contents' '
 	check_count --contents=file A 2
 '
@@ -79,7 +86,7 @@ test_expect_success 'blame with --contents' '
 test_expect_success 'blame with --contents changed' '
 	echo "1A quick brown fox jumps over the" >contents &&
 	echo "another lazy dog" >>contents &&
-	check_count --contents=contents A 1 "Not Committed Yet" 1
+	check_count --contents=contents A 1 "External file (--contents)" 1
 '
 
 test_expect_success 'blame in a bare repo without starting commit' '
@@ -109,7 +116,7 @@ test_expect_success 'blame 2 authors' '
 '
 
 test_expect_success 'blame with --contents and revision' '
-	check_count -h testTag --contents=file A 2 "Not Committed Yet" 2
+	check_count -h testTag --contents=file A 2 "External file (--contents)" 2
 '
 
 test_expect_success 'setup B1 lines (branch1)' '

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

The patch doesn't do anything special, except that we'd need to make
sure to test that the working copy is annotated correctly (we didn't
have tests for this before??).

The doc and the fake commit author could use some tweaking, but IMO the
end result is a lot easier to explain to end users, even in the case
where "--contents" is given without <rev>.

The _one_ reason not to merge this is that this changes the annotated
author with "--contents", which could cause trouble for end users who
are parsing the output and expecting literal "Not Committed Yet". Given
our history with Hyrum's law, surely _someone_ is doing this in the
non-"--contents" case, but I suspect that "--contents" is uncommon
enough that we could take the chance.
