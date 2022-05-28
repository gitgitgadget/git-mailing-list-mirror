Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4901FC433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 00:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355208AbiE1AMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353713AbiE1AMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 20:12:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B8126985
        for <git@vger.kernel.org>; Fri, 27 May 2022 17:12:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d12-20020a17090a628c00b001dcd2efca39so3221681pjj.2
        for <git@vger.kernel.org>; Fri, 27 May 2022 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6ldz4ken6BkEr84lqzis6HhReV7Iil/MXxrQLcCozdA=;
        b=dSFZ+BZCLbGL7ce6HqTKVGOPxRr+6vkhe2lXXmev4vuDpqoe4bwiF8byH8nDMfEOAm
         E/tXJZp0Lyh2Kk+7lAd2Y7BmiO2xMODsCb7iejUH1Duk5Wgk4q/C5LapgmPuJrZMbUHl
         1Sys4Gw+e0ppyL98R4zQEpc3rbCI6mMILXnWnL3TqY7jF1b5qIAuJ5UKBUcFiDLDNMes
         GV8cGzhm9G/cYiM+STIpT1FKFYeksGJUFzXCFNP/KLDzaViBPApCRUqtEj/Hgok+Pps+
         MqMrpzSrL8/GYMtCgO1RsGAY9dclumy809XrCxWhqY0M2hJXgPUKeQn78GeewJSypxe2
         CPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6ldz4ken6BkEr84lqzis6HhReV7Iil/MXxrQLcCozdA=;
        b=DA8RfNoAUTa2oaAAZ/tdMoK45kKAaPjjw4zbz5qTpzrcAFWiW0dtnd1t66gwC3DOwi
         SKttJmq5ETsrkrDY2tqoqLYR1nPgh4pZIKz5lour+795jfdVmy/bA5PFQvoX8oZe7615
         usC4SUJbRMDukP8YpmbuLopSJT7S2iPT3cdLKuxgzZ7wQIBugxU0ZzFaAInSBgbfAYAU
         HTTpeR8xDLJm4YrcZdc8qcbbNcwKgEu0XnC9vlXSzKvqBbOkV4roPGehpXJXFLk20lAE
         X9ZLI4q6qK0HT3gKKxCAqnQWY+ISMs4SgnBBpnaoyTO5CepIAVcMUHKtumVZWSFFwUVa
         PZxA==
X-Gm-Message-State: AOAM532JcRpK73hWhC6sA8Y4BblD045yoNYPocE+EIrN7u5oKAguxDOb
        /0qpC06UWNeIydZgjjuupqDjOLLk9vv78w==
X-Google-Smtp-Source: ABdhPJzWs29hYbR+ub1sS1bAPJSYlVUlCzMGG0kNGjBi2qCfcbT5x+Lndp39hHbKyR/BBXJseiWSCUzLlSLuAw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d5c1:b0:162:64e:8c21 with SMTP id
 g1-20020a170902d5c100b00162064e8c21mr33896398plh.34.1653696754261; Fri, 27
 May 2022 17:12:34 -0700 (PDT)
Date:   Fri, 27 May 2022 17:12:25 -0700
In-Reply-To: <YoXqmrOTxD5MiDU1@coredump.intra.peff.net>
Message-Id: <kl6lh75ams5y.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <24f547-6285e280-59-40303580@48243747> <YoXqmrOTxD5MiDU1@coredump.intra.peff.net>
Subject: Re: Bug - remote.c:236: hashmap_put overwrote entry after hashmap_get
 returned NULL
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for taking a look! (and welcome back :))

Jeff King <peff@peff.net> writes:

> On Thu, May 19, 2022 at 08:23:25AM +0200, Ing. Martin Prantl Ph.D. wrote:
>
>> file:.git/config    branch..remote=origin
>> file:.git/config    branch..merge=refs/heads/
>> [...]
>> 
>> git ls-remote
>> BUG: remote.c:236: hashmap_put overwrote entry after hashmap_get returned NULL
>
> Those branch entries with an empty subsection are the culprit. I'm not
> sure how they got there, but they should be safe to remove, which will
> make your immediate problem go away.
>
> It looks like handling of such bogus keys regressed in 4a2dcb1a08
> (remote: die if branch is not found in repository, 2021-11-17). In
> make_branch(), the call to find_branch() gets confused by the 0-length
> "len" parameter, and instead uses strlen() on the partial string
> containing the rest of the config key. So it tries to look up branch
> ".remote" for the first key, and ".merge" for the second. Since neither
> exist, in both cases it then tries to add a new entry, but this time
> correctly using the 0-length string. Which will confusingly already be
> present when handling the second key.

It wasn't obvious to me before what the regression was (since a 0-length
branch name is nonsense, right?). Turns out that we used to just ignore
the 0-length branch name, but now we BUG(), so yeah this needs fixing.

Interestingly, this 'name=".remote" and len=0 confusion' pre-dates that
commit, but it got exposed when that commit introduced the confused hash
map.

I can get the old behavior by getting rid of the strlen() fallback (I
think I will, it doesn't provide any benefit AFAICT), but...

> Either find_branch() needs to become more careful about distinguishing
> the two cases, or perhaps 0-length names should be rejected earlier (I
> don't think they could ever be useful).

I think this is even better. Warning the user about their bad config
sounds like a good thing.

We would have to be careful not to reject an empty 'name', because this
might be a non-subsection branch config, e.g. branch.autoSetupRebase.
Something like..

diff --git a/remote.c b/remote.c
index a1463aefb7..d3ae1445a4 100644
--- a/remote.c
+++ b/remote.c
@@ -351,8 +351,12 @@ static int handle_config(const char *key, const char *value, void *cb)
 	struct remote_state *remote_state = cb;
 
 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
+		/* There is no subsection. */
 		if (!name)
 			return 0;
+		/* There is a subsection, but it is empty. */
+		if (!namelen)
+			return -1;
 		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
 			return git_config_string(&branch->remote_name, key, value);

