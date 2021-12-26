Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA69C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhLZXnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 18:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhLZXnB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 18:43:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6556C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 15:43:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y22so55667126edq.2
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CGz5kAPf229fyBOwEDytZ/KKRM547A+pwGSC0wFCopc=;
        b=KJsPuM5mBt3mJ/L6PzxTCh0a203TduM8pOOMSBcIZ99X+8SFLGoQ5GbfBJbglg/Yal
         oK0GSzxJUT1vUYqR3Lqj4wqbpTpl7XvuAXRReZSahcXVhAL9BoxeqJNRHVVx5dxa/7KO
         IhvGUsfAJlzSJKTDQM+WmrcM9IpKLYzHtMghj6/eiUrUp/S8AuhyWZIyFUuMs2j41zn2
         De/C7OGOinwS01fB/pW02+ALQSwFsZpONrpW2+Hn6EkqIsrqnGeUJKTc/0CmtPR82Hmr
         y4Avy1tkFG0jzNmzNDslFMdGhkie4gGhkakAUGPtBRshKdE1t2GWShhphXiPR4cYX4Jg
         Jx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CGz5kAPf229fyBOwEDytZ/KKRM547A+pwGSC0wFCopc=;
        b=8MGr2rfPQdkbhl26WCW3UaTWq32omLTEiD4TLxW+EpdhpZ06NMlvATb3JHRNKYOrTL
         n+9oCfNjEkwM3pLtvgRFAPnDgvNBolYx+I7S/jsAbW/top/snq34G8IEps5mDUcV2luQ
         uKW3jbdOcWJ/dvmtlqK8S/16EbYtH8ZivfDXIgi4Zk6PxjotpGC6I1AUFdc1ylvGxOru
         kOYKyUJgIYEs02ji1MgTrG4SHiLyfaGoljUxUO9JgTHZqopfNl+sKk4x3OzJi68jCTPx
         htyAHWuF8j4kQWJWw4vEozyqz3TtqhAe53SXIwhkH3uLwY7w7CyZvXmUooHW1NRUm7RS
         ANcQ==
X-Gm-Message-State: AOAM532jYBHHGx8lwj3CHBDfyHiR8ZpUMpiqcIsAjCPCEM9YH2HzYkB+
        rrBynqVRmGfnf9RtN6dBiOxvK88M4c7Uczq8
X-Google-Smtp-Source: ABdhPJzLQHzUFsgf+DFOi0kqqkmbQwjpTsMecrKD/FUrSeHTiBv8MjhaHgcH+yPzuXwaJ8H8xOeSxg==
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr12011800ejc.450.1640562178185;
        Sun, 26 Dec 2021 15:42:58 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id j11sm5473672edv.0.2021.12.26.15.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 15:42:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1dAH-000IIL-1Q;
        Mon, 27 Dec 2021 00:42:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Vicarel <shundra8820@gmail.com>, git@vger.kernel.org
Subject: Re: Why does "merge --continue" expect no arguments?
Date:   Mon, 27 Dec 2021 00:31:07 +0100
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
 <xmqqlf0dq3t3.fsf@gitster.g> <211224.86mtkqgc8e.gmgdl@evledraar.gmail.com>
 <xmqqk0ft5toy.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0ft5toy.fsf@gitster.g>
Message-ID: <211227.868rw7exvi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 24 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Dec 21 2021, Junio C Hamano wrote:
>>
>>> Or we could throw in another
>>>
>>>  * document more clearly that "merge --continue" is a mere synonym
>>>    for, and hint that there is no reason to favor it over, "git
>>>    commit".
>>
>> But it's not:
>>
>>     $ git add foo
>>     $ git commit -v
>>     hint: Waiting for your editor to close the file.[...]
>>     ^C
>>     $ git merge --continue
>>     fatal: There is no merge in progress (MERGE_HEAD missing).
>>
>> FWIW I prefer and use it for that reason, i.e. it's useful for scripting
>> to use these "stateful" commands when we're in some sort of rebase/merge
>> "sequence" since it's an extra layer of sanity checking.
>
> There is no additional safety afforded by that, though.  There is no
> reason why one would even try to say "merge --continue" without
> doing any merge to begin with.
>
> The "merge --continue" not taking any pathspec is a bit of safety,
> but even there, "commit" already has its own safety to reject
> pathspec when it notices that it is concluding a conflicted "merge",
> so "merge --continue" is not necessary for additional safety there,
> either.

The reason would be that you're confused about what state you're in.

I've had that a few times, so I prefer it over "git commit", so I daresy
someone less experienced in using git could and would benefit from it as
well.

Usually because my "__git_ps1" and a subsequent "git status" shows one
state, so I'll want to continue the merge, but forgot that I did so in
another terminal tab already, and the real state of the repository might
have moved on to the index being prepared for a non-merge commit.

For "rebase --continue" we change the reflog entry from "rebase (pick)"
to "rebase (continue)". Any reason we wouldn't do the same for "merge
--continue"?:

diff --git a/builtin/merge.c b/builtin/merge.c
index 5f0476b0b76..51ef8ca36d0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1358,6 +1358,10 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
=20
+		strbuf_addstr(&buf, "merge (continue)");
+		setenv("GIT_REFLOG_ACTION", buf.buf, 0);
+		strbuf_reset(&buf);
+
 		/* Invoke 'git commit' */
 		ret =3D cmd_commit(nargc, nargv, prefix);
 		goto done;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index c773e30b3fa..7a180f571b7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -772,6 +772,8 @@ test_expect_success 'completed merge (git merge --conti=
nue) with --no-commit and
 	git stash show -p MERGE_AUTOSTASH >actual &&
 	test_cmp expect actual &&
 	git merge --continue 2>err &&
+	git reflog -1 >reflog &&
+	grep -F "merge (continue)" reflog &&
 	test_i18ngrep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5 merge-result &&
