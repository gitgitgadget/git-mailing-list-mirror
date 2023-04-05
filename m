Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D1FC77B6C
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjDEVPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjDEVPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:15:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098E49CA
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:15:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id iw3so35626043plb.6
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680729334;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMiniGJKYDR4lICw16lxdGhJM/NxtzFecUZyXYQvuXU=;
        b=mIHDCEZi8dkPXH6jDEDiWIZiNj/6fcmuvE6Bze3m8jPfJ1T3C0FdeOrv/yqUQmZ5vf
         ajaKQ0qyKRL+FD3tx9ykO6DyhTceWhTWT0k6zrXu0EDdVo/G/xcKm8x+nn9AxsNqaO5Y
         PL1vAI75cc+FFpsBp0cMmG2FtcIgFOmdUyO70QttWkZqB3o1u1sEdVwMNf2eeX5LQCI5
         lHEbzLiWGQvpQwH7LDUF8dTvmMRee8kGW8WUEE8HsuXqCt0jD9+6kSO6q5UqCapSiDW0
         acunR6TtihQ7n1ZAgfOzHCHhySka5NN+y1VCFRHiVHpZ8ESAu2n4YRCr6p1p16h+IOc8
         1qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680729334;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMiniGJKYDR4lICw16lxdGhJM/NxtzFecUZyXYQvuXU=;
        b=00KaTgZa93uFUre4yZ0qdusJwXIk2kaGvVv9wSFTjMCmK7RfO8pT0dDQBimT/VV53q
         N9Y504DvQYi+cQ6z847cIDWsIxsBmM3gfOOX5UqMg/C3r7k7gji9qL11VCoGHcJo8Hv+
         3LCv+Mw1wlHKFm0c5k0dLf2sZ9+ub4yxSYCr05n0PEhNysGk8zR845idjlQXbq1byZUm
         dJJdUlBChW9d+5ae8ABCFW/8pX4Vn4zfCDDcwrOCw0Pr7tdFbvb+vJWNYdxDYmsDI4v/
         NCXl2o8YTab95FNDpFLQgSyRzyil++MqprOVyQuaNamAhLicjd64spvQlLqJFt8E1m/J
         PtvA==
X-Gm-Message-State: AAQBX9d4aIDfYnJQsFXKQmamV5RXlRH0hGUr0Oi6Afv+f2WWsxZAu1Dh
        ZF+SSE5Es7PwfxyuRM/NxU0=
X-Google-Smtp-Source: AKy350Y0ivmgiUNiRKrFVAqY5Y+GKg4WPMuZrve54/rv+5HBvgyHmwUIf5WMwM+7jGEZMWUkJy1elw==
X-Received: by 2002:a05:6a20:671b:b0:d4:a361:fd3 with SMTP id q27-20020a056a20671b00b000d4a3610fd3mr485562pzh.58.1680729334151;
        Wed, 05 Apr 2023 14:15:34 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a62e514000000b005da23d8cbffsm11067349pff.158.2023.04.05.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:15:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
        <xmqqa5zmukp5.fsf@gitster.g>
Date:   Wed, 05 Apr 2023 14:15:33 -0700
In-Reply-To: <xmqqa5zmukp5.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        05 Apr 2023 13:40:22 -0700")
Message-ID: <xmqq355euj2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I guess we only need to touch "git clone" then.  Without being
> asked, it advertsizes object-format=sha256 already, and when the
> maestro repository is prepared without --object-format=sha256,
> upload-pack advertises object-format=sha1 instead.  So it probably
> is just the matter of capturing it and using it to populate the
> extensions.objectformat with an appropriate value.

It turns out that there was a readily mimickable example in 3d8314f8
(clone: propagate empty remote HEAD even with other branches,
2022-07-07).  The commit lifted code out of a block, in which we
know we are copying from a non-empty repository, to execute also
when talking with an empty repository.  The recording of the
hash-algorithm in the extensions section is done in the same way, so
we can do the same "fix".

----- >8 -----
Subject: [PATCH] clone: propagate object-format when cloning from void

A user could prepare an empty repository and set it to use SHA256 as
the object format.  The new repository created by "git clone" from
such a repository however would not record that it is expecting
objects in the same SHA256 format.  This works as expected if the
source repository is not empty.

Just like we started copying the name of the primary branch from the
remote repository even if it is unborn in 3d8314f8 (clone: propagate
empty remote HEAD even with other branches, 2022-07-07), lift the
code that records the object format out of the block executed only
when cloning from an instantiated repository, so that it works also
when cloning from an empty repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c        | 11 ++++++-----
 t/t5702-protocol-v2.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git c/builtin/clone.c w/builtin/clone.c
index 462c286274..8f16d18a43 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -910,6 +910,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 	int filter_submodules = 0;
+	int hash_algo;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1298,15 +1299,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (mapped_refs) {
-		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
-
 		/*
 		 * Now that we know what algorithm the remote side is using,
 		 * let's set ours to the same thing.
 		 */
-		initialize_repository_version(hash_algo, 1);
-		repo_set_hash_algo(the_repository, hash_algo);
+	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
+	initialize_repository_version(hash_algo, 1);
+	repo_set_hash_algo(the_repository, hash_algo);
+
+	if (mapped_refs) {
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
diff --git c/t/t5702-protocol-v2.sh w/t/t5702-protocol-v2.sh
index 71aabe30b7..6af5c2062f 100755
--- c/t/t5702-protocol-v2.sh
+++ w/t/t5702-protocol-v2.sh
@@ -269,6 +269,17 @@ test_expect_success 'clone propagates unborn HEAD from non-empty repo' '
 	grep "warning: remote HEAD refers to nonexistent ref" stderr
 '
 
+test_expect_success 'clone propagates object-format from empty repo' '
+	test_when_finished "rm -fr src256 dst256" &&
+
+	echo sha256 >expect &&
+	git init --object-format=sha256 src256 &&
+	git clone src256 dst256 &&
+	git -C dst256 rev-parse --show-object-format >actual &&
+
+	test_cmp expect actual
+'
+
 test_expect_success 'bare clone propagates unborn HEAD from non-empty repo' '
 	test_when_finished "rm -rf file_unborn_parent file_unborn_child.git" &&
 
