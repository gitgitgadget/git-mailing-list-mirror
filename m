Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FBC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CBB2082E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AE9dwyz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgDVSCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgDVSCt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 14:02:49 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A493C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:02:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j16so2390885pgg.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cyu4oXczFtLk0jRIG5wlcipsd1HEKKoY0hc7y2e5zRk=;
        b=AE9dwyz0SfnLUrEJuPFGA7mN6Wa9f8SAU83LhhW6swI8r314VY1Z8fQCoTwhqjhrM4
         mBDOBGb5jMjvd3QAqkDCCJc+P5h/+eFTgncsBm9k7Evupl520Xh1NXum1UlN1WfuqDqL
         CpI+tO1cz2OshhAWJVNE7p97LJa7KRV8NCKSDToi9R8aCXLKz9gsBjAssJ57RFpskgw3
         uuy19MJz6oQgWnKnnkrO+MeMK2BRnGPKwMkU+LZVdYn1j1dGcLGuH/MlHBhHtl+UJuCC
         +XNg/XL/q3iTeF1Mz8ZminDFsxClGlHiRAw0+UrKM79IZzhHgXBpT2Rajvnjc9HsIXPb
         a4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cyu4oXczFtLk0jRIG5wlcipsd1HEKKoY0hc7y2e5zRk=;
        b=mRcvJAYhXiZ3dRqWtYqaUglh5V4khXqEEYDL4IDTMvMoJ4UNGCXRwx0cQ1tSLlYTAI
         VxVKfLI/elBAhhIkqyp+ikcK8WBleu1xZWsM6jHIqQW0U1wsLhT/0n46IWVcHX8isrVC
         szP0LJiPNaDQH6OUjOZDXSZDsC4NLwqP9ERGoYzm2uJRge8W1i5o0esdTjJ1pAQWHUP9
         vSDs3mbrytkBYQ94N+ZzpDRejHxIaleCjrDhtbU9T/KHd7MtyR+E5A674NM/AQm0FSnu
         bKzBocL2ls5FSN46M3YX1t0/PmuNVI7n8bHowP9j6zqI6iz/YADPbBe755+g0MtmGWMg
         eC6Q==
X-Gm-Message-State: AGi0PubPg1z7IX4P796Y93K7ZXtjSeKPTN3T+RJH2fIZAp+UqSwB7Ncs
        hpBQf1+wZA//Cx4D7Kn69BwL1anYrAy8VpouyFXi
X-Google-Smtp-Source: APiQypJDeT/8Zdvnh6e0SI6MtNf3/WDQRQktdBlqynYUf9hJS8S9nbvJelXafXdJ/TfkyOJ4sAt/TSdLkikcZYhbtmRM
X-Received: by 2002:a17:90a:1946:: with SMTP id 6mr11910787pjh.42.1587578568707;
 Wed, 22 Apr 2020 11:02:48 -0700 (PDT)
Date:   Wed, 22 Apr 2020 11:02:45 -0700
In-Reply-To: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
Message-Id: <20200422180245.196132-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, newren@gmail.com, jrnieder@gmail.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Address this by introducing 'reset_repository_shallow()', and calling
> it whenever the shallow files is updated. This happens in two cases:
> 
>   * during 'update_shallow', when either the repository is
>     un-shallowing, or after commit_lock_file, when the contents of
>     .git/shallow is changing, and
> 
>   * in 'prune_shallow', when the repository can go from shallow to
>     un-shallow when the shallow file is updated, forcing
>     'is_repository_shallow' to re-evaluate whether the repository is
>     still shallow after fetching in the above scenario.

From a cursory reading of the code, it seems that this happens in
fetch-pack and receive-pack. Looking at those files, I found some more
occasions when this happens. I have outlined them in the patch after the
scissors (I hope I used the scissors correctly).

Maybe instead of enumerating the cases (of which there are quite a few),
say that we do this when we unlink the shallow file, we modify or create
the shallow file, or when we change the value of alternate_shallow_file.

> @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
>  	} else {
>  		unlink(git_path_shallow(the_repository));
>  		rollback_lock_file(&shallow_lock);
> +		reset_repository_shallow(the_repository);
>  	}
>  	strbuf_release(&sb);
>  }

The "if" part (not quoted here) commits the shallow lock file, and thus
possibly modifies (or creates) the shallow file, so I think we need to
put reset_repository_shallow() outside the whole "if" block. I have done
that in the patch after the scissors.

> +test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
> +	(
> +	cd shallow &&
> +	git checkout master &&
> +	commit 8 &&
> +	git tag -m foo heavy-tag-for-graph HEAD^ &&
> +	git tag light-tag-for-graph HEAD^:tracked
> +	) &&
> +	(
> +	cd notshallow &&
> +	test_config fetch.writeCommitGraph true &&

When I patched onto master, this line causes the test to fail with a
warning that test_when_finished doesn't work in a subshell. I've
replaced it with a regular "git config" and it works.

Here is the patch containing what I tried. I think that most of the new
reset_repository_shallow() invocations don't change any functionality
(we don't usually read shallow files so many times in a process), so
they can't be tested, but I think that it's better to include them for
completeness, and to close the open question mentioned in bd0b42aed3
("fetch-pack: do not take shallow lock unnecessarily", 2019-01-10)
(about the full solution involving clearing shallow information whenever
we commit the shallow lock - we find here that the full solution
involves this and also clearing shallow information in other cases too).

-- 8< --
From 46a69a133db2e8e948d2bf296294656c9902e5ae Mon Sep 17 00:00:00 2001
From: Jonathan Tan <jonathantanmy@google.com>
Date: Wed, 22 Apr 2020 10:53:30 -0700
Subject: [PATCH] fixup

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/receive-pack.c   | 1 +
 fetch-pack.c             | 2 ++
 shallow.c                | 2 +-
 t/t5537-fetch-shallow.sh | 2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..d61cbf60e2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -878,6 +878,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	}
 
 	commit_lock_file(&shallow_lock);
+	reset_repository_shallow(the_repository);
 
 	/*
 	 * Make sure setup_alternate_shallow() for the next ref does
diff --git a/fetch-pack.c b/fetch-pack.c
index 684868bc17..9a1cec470c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1657,6 +1657,7 @@ static void update_shallow(struct fetch_pack_args *args,
 						&alternate_shallow_file,
 						&extra);
 			commit_lock_file(&shallow_lock);
+			reset_repository_shallow(the_repository);
 			alternate_shallow_file = NULL;
 		}
 		oid_array_clear(&extra);
@@ -1695,6 +1696,7 @@ static void update_shallow(struct fetch_pack_args *args,
 					&alternate_shallow_file,
 					&extra);
 		commit_lock_file(&shallow_lock);
+		reset_repository_shallow(the_repository);
 		oid_array_clear(&extra);
 		oid_array_clear(&ref);
 		alternate_shallow_file = NULL;
diff --git a/shallow.c b/shallow.c
index 9d1304e786..1a1ca71ffe 100644
--- a/shallow.c
+++ b/shallow.c
@@ -414,8 +414,8 @@ void prune_shallow(unsigned options)
 	} else {
 		unlink(git_path_shallow(the_repository));
 		rollback_lock_file(&shallow_lock);
-		reset_repository_shallow(the_repository);
 	}
+	reset_repository_shallow(the_repository);
 	strbuf_release(&sb);
 }
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index c9c731c7a9..c5c40fb8e7 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -187,7 +187,7 @@ test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	) &&
 	(
 	cd notshallow &&
-	test_config fetch.writeCommitGraph true &&
+	git config fetch.writeCommitGraph true &&
 	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
-- 
2.26.1.301.g55bc3eb7cb9-goog

