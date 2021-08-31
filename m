Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82040C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636AB60241
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhHaOAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhHaN7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:59:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42689C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:58:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2656166wml.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1J/s980WiuWmbzxvuBMY5WVtuf53daAZ9BvDG3KxsxM=;
        b=mmQmSxC4f0QG8Aeq+9FqYUSkqHlqR2HALIX2UAbEs6L6/4msFCgPes8F1VKzF9DtW6
         KqGLnJ+l+aa2ffc2RBKonkQDk+h8R8Vt8n1syhapH7YRKfFKgpfK+zLCQPp7U4P3xb2D
         TluiJaljBVa+IKmTXKA1UNhVLi2gL8l/fKfqIzVfT6XsUwJYA64rmHEZCVCPhM/RzyQO
         kVFJibWvwcRxxnVlOM304viUV1ct/OuQSE2tU4CaFvDGeIG2rajbb6HWUjwf8JofPvrB
         3m/8ON9NfECXviWWJV4GA6M6PHzXtycr7/8098P/5GAoF7yzsBcEek5b1th8U8v4cItz
         D6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1J/s980WiuWmbzxvuBMY5WVtuf53daAZ9BvDG3KxsxM=;
        b=J2kLTQ/DOkC/bbaYpwtg4C24VYRkjgLqeQpzsj3KpzrNoB1i5x5+APVA3C/EJzol/V
         QkgWEo1ZRdPsua07PLgElwcjU9fhDvd/EMt3wUl2Zs1RORR97XTH0AFHz8AJq0XgwtTM
         h9l9VVpUbclM14eqYT+98FHXsirvw1ol3fmlS43fYFl2YFQQwr1hP5nVBn9lKAOwiNX4
         tYvgnH17ei+L0i7eVOHtjbN2zFlTQAf9EAQt/oIJuhdXTTWA5cA0mr+J02k7Sj+j2Yif
         JLOQkdc45RM6tKUJg7ZAMgcMR/B+fNsbnPOE7VUwcoWSmht+0SD7BIBC4Na5r0caeoJe
         qAfg==
X-Gm-Message-State: AOAM5317m5AWmJIYe7c5ROdtZbCZk5CuM7Yyvae7wPRSoeNSrtiplZmV
        YwhGTV0Z2Ts0I0mupKj40f6gMESwds34+Q==
X-Google-Smtp-Source: ABdhPJz/h3cUvTIM+ZyLqEUx946kD3EAXygAQ0R+plU4+5Qos3kXn7xK6cM39oyr2QR43pYEG5OoDA==
X-Received: by 2002:a05:600c:3543:: with SMTP id i3mr4572411wmq.2.1630418300461;
        Tue, 31 Aug 2021 06:58:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f20sm2500153wml.38.2021.08.31.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:58:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        =?UTF-8?q?Jan=20Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4] pull, fetch: fix segfault in --set-upstream option
Date:   Tue, 31 Aug 2021 15:58:17 +0200
Message-Id: <patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
References: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in the --set-upstream option added in
24bc1a12926 (pull, fetch: add --set-upstream option, 2019-08-19) added
in v2.24.0.

The code added there did not do the same checking we do for "git
branch" itself since 8efb8899cfe (branch: segfault fixes and
validation, 2013-02-23), which in turn fixed the same sort of segfault
I'm fixing now in "git branch --set-upstream-to", see
6183d826ba6 (branch: introduce --set-upstream-to, 2012-08-20).

The warning message I'm adding here is an amalgamation of the error
added for "git branch" in 8efb8899cfe, and the error output
install_branch_config() itself emits, i.e. it trims "refs/heads/" from
the name and says "branch X on remote", not "branch refs/heads/X on
remote".

I think it would make more sense to simply die() here, but in the
other checks for --set-upstream added in 24bc1a12926 we issue a
warning() instead. Let's do the same here for consistency for now.

There was an earlier submitted alternate way of fixing this in [1],
due to that patch breaking threading with the original report at [2] I
didn't notice it before authoring this version. I think the more
detailed warning message here is better, and we should also have tests
for this behavior.

The --no-rebase option to "git pull" is needed as of the recently
merged 7d0daf3f12f (Merge branch 'en/pull-conflicting-options',
2021-08-30).

1. https://lore.kernel.org/git/20210706162238.575988-1-clemens@endorphin.org/
2. https://lore.kernel.org/git/CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com/

Reported-by: Clemens Fruhwirth <clemens@endorphin.org>
Reported-by: Jan Pokorný <poki@fnusa.cz>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A re-submission for a semantic conflict with the now-merged
7d0daf3f12f on master.

On Mon, Aug 30 2021, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> There was an earlier submitted alternate way of fixing this in [1],
>> due to that patch breaking threading with the original report at [2] I
>> didn't notice it before authoring this version. I think the more
>> detailed warning message here is better, and we should also have tests
>> for this behavior.
>
> I do not think it is necessarily an improvement to give more info,
> if it is irrelevant to explain what the error is.  And the point of
> the error message here is that we cannot set the upstream of
> detached HEAD, no matter what the value of old source ref or new
> source ref are.
>
> The original from Clemens gives a warning message that omits the
> piece of information that does not contribute to the error.

I see your point, but looking at it again I decided to keep it as-is
in this re-roll. As noted in the commit message this is for
consistency with the output we emit when running a commind like "git
branch --set-upstream-to <upstream> <branchname>", which as you'll see
if you "git checkout HEAD^0" we'll quote the wanted upstream back at
you.

So yeah, arguably we should just punt on that whole thing and tell the
user "you're on a detached HEAD, this will never work" or something
like that, but let's consider that UI change separately, and then do
it for all of "branch", "fetch" and "pull", rather than leave the
latter two inconsistent with "branch" with this fix.

> Testing the new behaviour is a good idea.  I also agree with you
> that die() would be more appropriate and does not risk regression,
> if the original behaviour was to segfault.

Indeed. I changed it due to your upthread
<xmqqsg0anxix.fsf@gitster.g>.

I think doing s/warning/die/ here makes sense, but similarly to the
above comment: Let's punt on that and do it separately from this
narrow segfault fix. If and when we change that we should change
various other "warning()" around this codepath to "die()" as well.

Range-diff against v3:
1:  68899471206 ! 1:  0caa9a89a86 pull, fetch: fix segfault in --set-upstream option
    @@ Commit message
         detailed warning message here is better, and we should also have tests
         for this behavior.
     
    +    The --no-rebase option to "git pull" is needed as of the recently
    +    merged 7d0daf3f12f (Merge branch 'en/pull-conflicting-options',
    +    2021-08-30).
    +
         1. https://lore.kernel.org/git/20210706162238.575988-1-clemens@endorphin.org/
         2. https://lore.kernel.org/git/CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com/
     
    @@ t/t5553-set-upstream.sh: test_expect_success 'pull --set-upstream with valid URL
     +	cat >expect <<-\EOF &&
     +	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
     +	EOF
    -+	git pull --set-upstream upstream main 2>actual.raw &&
    ++	git pull --no-rebase --set-upstream upstream main 2>actual.raw &&
     +	grep ^warning: actual.raw >actual &&
     +	test_cmp expect actual
     +'

 builtin/fetch.c         | 10 ++++++++++
 t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e064687dbdc..28fa168133a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1625,6 +1625,16 @@ static int do_fetch(struct transport *transport,
 			}
 		}
 		if (source_ref) {
+			if (!branch) {
+				const char *shortname = source_ref->name;
+				skip_prefix(shortname, "refs/heads/", &shortname);
+
+				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
+					  "it does not point to any branch."),
+					shortname, transport->remote->name);
+				goto skip;
+			}
+
 			if (!strcmp(source_ref->name, "HEAD") ||
 			    starts_with(source_ref->name, "refs/heads/"))
 				install_branch_config(0,
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 9c12c0f8c32..48050162c27 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -91,6 +91,17 @@ test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	check_config_missing other2
 '
 
+test_expect_success 'fetch --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	git fetch --set-upstream upstream main 2>actual.raw &&
+	grep ^warning: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 # tests for pull --set-upstream
 
 test_expect_success 'setup bare parent pull' '
@@ -178,4 +189,15 @@ test_expect_success 'pull --set-upstream with valid URL and branch sets branch'
 	check_config_missing other2
 '
 
+test_expect_success 'pull --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	git pull --no-rebase --set-upstream upstream main 2>actual.raw &&
+	grep ^warning: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.0.805.g739b16c2189

