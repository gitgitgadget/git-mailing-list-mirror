Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B8E9413E
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 01:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjJGBuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGBuW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 21:50:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C93B6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 18:50:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B93A11B1C46;
        Fri,  6 Oct 2023 21:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=uJMPLOebvX8DdMxsuxu/ql5hVn23OH+YubXLUb
        mRl/c=; b=Y5FUSuQfK4qZU+6HColiE3mmNHbb1f1Z+BLcdi2CmVYRneLqPpDSdS
        8VU647RNhZS2rRNItLybSrVN9v0VDVjfmh/HDzDA8QnsMEjGm5OQJQ3KsRSVR1Dn
        Nn8NJlpd8DjrHFjhL4/N0ApngaUTgQdFmVSHTlozcQfbIrr777Q8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B09FF1B1C45;
        Fri,  6 Oct 2023 21:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1966C1B1C43;
        Fri,  6 Oct 2023 21:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <CABPp-BGxVnhnmoajWyqY_gMvQ42W5S6VX5EOXq3PW=GLVQwe0g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 6 Oct 2023 18:31:00 -0700")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        <xmqq7cnzaav0.fsf@gitster.g>
        <CABPp-BGxVnhnmoajWyqY_gMvQ42W5S6VX5EOXq3PW=GLVQwe0g@mail.gmail.com>
Date:   Fri, 06 Oct 2023 18:50:16 -0700
Message-ID: <xmqqjzrz5hgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDFAFE3E-64B3-11EE-8A22-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In my opinion, --remerge-diff does this better; wouldn't we want a
> rationale where these particular modes shine?  Is that a non-empty
> set?  (It may well be, but to me, --cc was never worse than -c while
> often being better, and likewise, --remerge-diff is never worse than
> --cc while often being better, at least on anything I had thought to
> use any of these for.  Maybe there are other usecases for -c and --cc
> I'm just not thinking of?)

Between -c and --cc, I do not think there is anything that makes us
favor -c over --cc.  While the algorithm to decide which hunks out
of -c's output to omit was being polished, comparison with -c served
a good way to give baseline, but once --cc has become solid, I do
not think I've used -c myself.

I personally find that a very trivial merge resolution is far easier
to read with --cc than --remerge-diff, the latter being way too
verbose.

Also, --cc and -c should work inside a read-only repository where
you only have read access to.  If remerge needs to write some
objects to the repository, then you'd need some hack to give a
writable object store overlay via the alternate odb mechanism, or
something, right?


$ git show --oneline --cc -U1 9fde277c338
9fde277c33 Merge branch 'cc/git-replay' into seen

diff --cc Makefile
index cf60c16deb,05a504dc28..c581c1ddba
--- a/Makefile
+++ b/Makefile
@@@ -803,4 -801,2 +803,3 @@@ TEST_BUILTINS_OBJS += test-env-helper.
  TEST_BUILTINS_OBJS += test-example-decorate.o
- TEST_BUILTINS_OBJS += test-fast-rebase.o
 +TEST_BUILTINS_OBJS += test-find-pack.o
  TEST_BUILTINS_OBJS += test-fsmonitor-client.o
diff --cc t/helper/test-tool.c
index 9010ac6de7,9ca1586de7..77b1d7c15d
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@@ -32,4 -32,2 +32,3 @@@ static struct test_cmd cmds[] = 
  	{ "example-decorate", cmd__example_decorate },
- 	{ "fast-rebase", cmd__fast_rebase },
 +	{ "find-pack", cmd__find_pack },
  	{ "fsmonitor-client", cmd__fsmonitor_client },
diff --cc t/helper/test-tool.h
index f134f96b97,a03bbfc6b2..5deeca66fe
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@@ -26,4 -26,2 +26,3 @@@ int cmd__env_helper(int argc, const cha
  int cmd__example_decorate(int argc, const char **argv);
- int cmd__fast_rebase(int argc, const char **argv);
 +int cmd__find_pack(int argc, const char **argv);
  int cmd__fsmonitor_client(int argc, const char **argv);
$ git show --oneline --remerge-diff -U1 9fde277c338
9fde277c33 Merge branch 'cc/git-replay' into seen
diff --git a/Makefile b/Makefile
remerge CONFLICT (content): Merge conflict in Makefile
index 987c8e3569..c581c1ddba 100644
--- a/Makefile
+++ b/Makefile
@@ -803,9 +803,3 @@ TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
-<<<<<<< 0fd7a144c5 (Merge branch 'js/doc-unit-tests-with-cmake' into seen)
-TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-find-pack.o
-||||||| 1fc548b2d6
-TEST_BUILTINS_OBJS += test-fast-rebase.o
-=======
->>>>>>> 0b853ad4db (replay: stop assuming replayed branches do not diverge)
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
remerge CONFLICT (content): Merge conflict in t/helper/test-tool.c
index 87a9794564..77b1d7c15d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -32,9 +32,3 @@ static struct test_cmd cmds[] = {
 	{ "example-decorate", cmd__example_decorate },
-<<<<<<< 0fd7a144c5 (Merge branch 'js/doc-unit-tests-with-cmake' into seen)
-	{ "fast-rebase", cmd__fast_rebase },
 	{ "find-pack", cmd__find_pack },
-||||||| 1fc548b2d6
-	{ "fast-rebase", cmd__fast_rebase },
-=======
->>>>>>> 0b853ad4db (replay: stop assuming replayed branches do not diverge)
 	{ "fsmonitor-client", cmd__fsmonitor_client },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
remerge CONFLICT (content): Merge conflict in t/helper/test-tool.h
index e8abf4c42f..5deeca66fe 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -26,9 +26,3 @@ int cmd__env_helper(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
-<<<<<<< 0fd7a144c5 (Merge branch 'js/doc-unit-tests-with-cmake' into seen)
-int cmd__fast_rebase(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
-||||||| 1fc548b2d6
-int cmd__fast_rebase(int argc, const char **argv);
-=======
->>>>>>> 0b853ad4db (replay: stop assuming replayed branches do not diverge)
 int cmd__fsmonitor_client(int argc, const char **argv);

