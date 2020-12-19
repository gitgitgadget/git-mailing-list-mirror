Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8CBC3526C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327CD2389F
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 20:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgLSUTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 15:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgLSUTd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 15:19:33 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D29EC0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 12:18:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id j12so5340318ota.7
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zOWXEHSKVpuA9oFsrQs02gFMkE9l7drnJ5Ft9TKV8pc=;
        b=PtF7ziYroOoqqxfL66GD1ifGv1xcem7/9ofg08MCjLXbEvvwSu62IlGeSLo819hpJI
         O3Q9JTbABgrGi4ofBZpxFG4U0EiLY9garZ8kmR1XmAIx8OE1avFMwf4YAMz8JhFONtJj
         sK6vls9Px/6Y3wm4zyF/7yrpnBwifUSyw6C8hOygBcJnGUNqXlFGM+QBkqHY/Wt40dQW
         7rYmGkttkvmJumPo9/vw4uKg0n44xD1YjjGPaRPm/IX9wIdbjqWiaqE2PRAcbY0hD9ur
         hWvW40kX9sgZzA8kb9Hmt0RkWEyyxNBLrvR4KDfw5+HwoJD+wLhRfqp7t1KXYmMt7fsG
         v/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zOWXEHSKVpuA9oFsrQs02gFMkE9l7drnJ5Ft9TKV8pc=;
        b=sY+KfoqBc6AESOtE+aYmy3Q3Tu4OPUuEBPHQzh1hLh64g1/M1lCdER/K8o7kUnRJKz
         5XxlsCqB8u6ELHMsM5+2zv7AA15mXeVOhrc0ex9KN3t4e/QsyvnityuZkobEJbnx0P68
         t+ydAuGR4dBDQoKRCV/W9iV95vkqkNH1PWxDjMElzOFyzNPlXVgpVOoJ+xgm17jxkjZj
         9xp0xcYM9OTULsuTUK6aBm2LQ1jjnk8R5FY8F/s7/3OsA7J6vz89SUsX6uK8sc6fJCGJ
         wXvhmPMexBsDcJTvw7z5GV6veXJhoD+OAPdlv7CmE34thvEcJoaKUatCwBwtcQvu6Llu
         7Rng==
X-Gm-Message-State: AOAM532FmvgTBqt+2woPUctFprKD83aPclT3Uw+K+mhpX2BH2zaJVBdJ
        cVsxBgj6Wf1WNJAlyysFHr6FcjnZVlkQ4Q==
X-Google-Smtp-Source: ABdhPJw99fyS2XOUusIoyPXCcjjDqSwii+RrflE8mH79dJcD3tbh2j94HauRUmTMbGJOCw7wweYlSg==
X-Received: by 2002:a05:6830:2402:: with SMTP id j2mr7175688ots.319.1608409121386;
        Sat, 19 Dec 2020 12:18:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r8sm318720oth.20.2020.12.19.12.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 12:18:40 -0800 (PST)
Date:   Sat, 19 Dec 2020 14:18:38 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fde601ee30f5_1e50c72081c@natae.notmuch>
In-Reply-To: <xmqqpn35odnm.fsf@gitster.c.googlers.com>
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <5fdded2523e7e_1de0de208e1@natae.notmuch>
 <xmqqpn35odnm.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Seth House <seth@eseth.com> writes:
> >> 
> >> > I think where we're not seeing eye-to-eye is that you're focusing on
> >> > potential "negative" consequences whereas I'm talking about having more
> >> > information about the merge rather than less.
> >> >
> >> > There is very likely no negative consequences for most, if not all,
> >> > mergetools. I wrote the initial version of diffconflicts ten years ago
> >> > and I've been using it nearly every day since. I'm fairly confident in
> >> > the end result. What is a fact is there is undisputedly less information
> >> > about the merge if we overwrite LOCAL and REMOTE; as I've written,
> >> > I think the tradeoff is worthwhile for most tools but a per-tool
> >> > configuration will allow people that feel differently to choose
> >> > differently.
> >> 
> >> Thanks for stressing this point.
> >> 
> >> When a user or developer asks for a reasonable feature (e.g.
> >> configurability to suit personal taste), especially when there is no
> >> obvious downside for adding it, the burden of proof is on the party
> >> who refuses to add it
> >
> > Sorry, but no.
> >
> > You may be the final word in the git project, but the burden of proof is
> > an essential part of logic, not project-dependent, and that's just not
> > the case.
> >
> > *Anyone* that makes any claim has the burden of proof.
> 
> Yes, and in this case, Seth already said he prefers to be able to
> see the original, and not necessarily all the users of his mergetool
> backend prefer the same thing.  That is enough "proof" to me that
> the need exists.

That's not proof. That's one person stating his opinion.

He did not present evidence of *why* one of his users would prefer to
turn this flag off in his tool, but not others.

Here, allow me to show what diffconflicts does:

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index abc8ce4ec4..a8fd8e4a84 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -29,6 +29,10 @@ merge_cmd () {
 				"$LOCAL" "$REMOTE" "$MERGED"
 		fi
 		;;
+	*vimdiff4)
+		cp "$LOCAL" "$MERGED"
+		"$merge_tool_path" -f -d "$MERGED" "$REMOTE"
+		;;
 	esac
 }
 

"mergetool.automerge=true" plus the code above replicates the main
functionality of the diffconflicts plugin.

Why would anyone want to turn off automerge for vimdiff4, but not for
vimdiff2?

Nobody has explained that.

> It is your turn to prove your (implicit) claim that it does more harm
> than it helps to allow such a preference expressed by end users.

No. The burden of proof is still on the side that claims such preference
is desirable.

"I think X" is not evidence of X.

> > Is there a conflict in this example?
> >
> >   echo Hello > BASE
> >   echo Hello > LOCAL
> >   echo Hello. > REMOTE
> >   git merge-file -p LOCAL BASE REMOTE
> 
> Sorry, but I do not see why that example matters.

But I do. That's why I asked the question.

> Would such a case even come into the picture to be resolved by "git
> mergetool" in the first place?

That is precisely the point.

It is not a conflict because that line only has changes in REMOTE, but
not in LOCAL. Correct?

git doesn't bother the user because there's no merge conflict.

But if there is an *actual conflict* some lines below, why should git,
or git-mergetool, or the mergetool now bother the user presenting it the
diff of the "Hello." line?

Why does that line that according to you "wouldn't not even come into
the picture" becomes suddenly relevant when there's an actual conflict
below?

Either the "Hello." change is relevant or it isn't.

But more importantly; its relevance doesn't depend on the mergetool.

Choosing vimdiff4 doesn't magically make it a conflict.

Cheer.

-- 
Felipe Contreras
