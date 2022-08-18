Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F7C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 14:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiHROmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343495AbiHROm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 10:42:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC28BB68D
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:42:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so1966689wrp.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=3GETJov08DET2EMWYdGroEyGanmI/kQtIJzaCTJby5A=;
        b=b01N3YDBRE0zB//dP9/7m31qlnVyOuNFHBSbwe5d0cwHRSb8e2W//zWf4rE914U14E
         nedqBjxl+8bjLM3bL4ZCuERorDINoIM3Lx0fkFlW5H59E0Sj/Wi5b/SpL1XckMboKbXL
         7jOYxkN7/Kppx7nysCjlUksty6HcTr36M+xCHHQyHqL9w5UGL+CmkW489kI12a1308Mh
         YO/EM3uSOsRYUmgv5DnwhUHt21gmsPkOFqaaA7b6PLd2vTjLKpEex4vNqYlOXTH0eItr
         4SJqNuU3P1AtaVCtoaFQ7xAHenZoBU6jAsKoosCmrDRscsQ410ckMUaqjSPU4MKUvPZj
         7ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3GETJov08DET2EMWYdGroEyGanmI/kQtIJzaCTJby5A=;
        b=ZAPxUeJOWmd3ki7cliBE+zjk4PmOjr2Axs14KHzc7ym2hpijlS4k7pI+UtAoMf+4U5
         lH7OKWc1h/CqtU3kchhWGoLAm0hba/BawN4q22zdx+yhMWM9UAAK8rMiDsy9l5X/MWuB
         1KbI2O/1KSXj1NVLznO5pdohyU6w1iYZCv4TQRcXukMrUGCn7C5ShJk+Ik6MqVpkVl2V
         ETuvU4hpVzo3Rr3fcss9NSHUg4zvKYZqDiPfpGnc3l6B3YI4WuXE7Im7cJcSoywG8cuZ
         p9p9nC0XjQ9/eYMGQ5/k6vTsCl+qKXdO6yzzXS/QWL1ujjQT0teCNkuEGnKklPYBTZzO
         dWWA==
X-Gm-Message-State: ACgBeo3e3Ht9EMCxEKpZGDADO++LE1ddTpqYw+nXhmHOn0EtHR+jVSrl
        VFttBoT4Fgl/NamjYLiksZXmcR1/1C185A==
X-Google-Smtp-Source: AA6agR7kTTZFO0btGjwHu9vR9lbNzr+GvbVWI1TmZYx3elHQEMa/ogF+3QEeOksKCRo9nffoFlHSWQ==
X-Received: by 2002:a05:6000:1d82:b0:220:5f9b:9a77 with SMTP id bk2-20020a0560001d8200b002205f9b9a77mr1799378wrb.622.1660833744633;
        Thu, 18 Aug 2022 07:42:24 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b003a35516ccc3sm3177772wmq.26.2022.08.18.07.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:42:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOgj0-000Gdc-2E;
        Thu, 18 Aug 2022 16:42:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
Date:   Thu, 18 Aug 2022 16:24:38 +0200
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com>
 <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
 <xmqqilmzkd7p.fsf@gitster.g> <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
 <xmqqedxgt1zx.fsf@gitster.g> <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
 <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
 <xmqq7d36vfur.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d36vfur.fsf@gitster.g>
Message-ID: <220818.868rnlaa0h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 17 2022, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
>> There's also another concern you tried to address in your other email;
>> let me quote from that email here:
>>
>>> If you want to have an easy example of a custom merge strategy, then let's
>>> have that easy example. `git-merge-resolve.sh` ain't that example.
>>>
>>> It would be a different matter if you had commented about
>>> `git-merge-ours.sh`:
>>> https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge-ours.sh
>>> That _was_ a simple and easy example.
>>
>> ...and it was _utterly useless_ as an example.  It only checked that
>> the user hadn't modified the index since HEAD.  It doesn't demonstrate
>> anything about how to merge differing entries, since that merge
>> strategy specifically ignores changes made on the other side.  Since
>> merging differing entries is the whole point of writing a strategy, I
>> see no educational value in that particular script.
>>
>> `git-merge-resolve.sh` may be an imperfect example, but it's certainly
>> far superior to that.
>> ...
>> If someone makes a better example (which I agree could be done,
>> especially if it added lots of comments about what was required and
>> why), and ensures we keep useful test coverage (maybe using Junio's
>> c-resolve suggestion in another email), then my concerns about
>> reimplementing git-merge-resolve.sh in C go away.
>>
>> If that happens, then I still think it's a useless exercise to do the
>> reimplementation -- unless someone can provide evidence of `-s
>> resolve` being in use -- but it's not a harmful exercise and wouldn't
>> concern me.
>>
>> If the better example and mechanism to retain good test coverage
>> aren't provided, then I worry that reimplementing is a bunch of work
>> for an at best theoretical benefit, coupled with a double whammy
>> practical regression.
>
> Ah, you said many things I wanted to say already.  Thanks.

I may have missed something in this thread, but wouldn't an acceptable
way to please everyone here be to:

 1. Have git's behavior be that of the end of this series...
 2. Add a GIT_TEST_* mode where we'll optionally invoke these "built-in"
    merge strategies as commands, i.e. have them fall back to
    "try_merge_command()".

So something like this on top of this series (assume my SOB etc. if this
is acceptable). I only tested this locally, but it seems to do the right
thing for me:

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8ebff425967..9d0f68b8147 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -30,6 +30,7 @@ linux-TEST-vars)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_MERGE_COMMANDS=true
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
diff --git a/sequencer.c b/sequencer.c
index 00a36205848..91d651f9b12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2309,6 +2309,7 @@ static int do_pick_commit(struct repository *r,
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
+		const int test_commands = git_env_bool("GIT_TEST_MERGE_COMMANDS", 0);
 
 		res = write_message(msgbuf.buf, msgbuf.len,
 				    git_path_merge_msg(r), 0);
@@ -2316,10 +2317,10 @@ static int do_pick_commit(struct repository *r,
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
 
-		if (!strcmp(opts->strategy, "resolve")) {
+		if (!test_commands && !strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
-		} else if (!strcmp(opts->strategy, "octopus")) {
+		} else if (!test_commands && !strcmp(opts->strategy, "octopus")) {
 			repo_read_index(r);
 			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else {
