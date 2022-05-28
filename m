Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C204C433F5
	for <git@archiver.kernel.org>; Sat, 28 May 2022 00:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355214AbiE1ANJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 20:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiE1ANI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 20:13:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFC119046
        for <git@vger.kernel.org>; Fri, 27 May 2022 17:13:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s10-20020a170902a50a00b00162359521c9so3587829plq.23
        for <git@vger.kernel.org>; Fri, 27 May 2022 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MJge4p5QQJELT+lPU7j1/hPxL5V3en2iIsdxZElEdes=;
        b=qP+e9p9ElcrPw6YlCOa8cGHRWxmzXsWxzpnIXg8P5Xzv+df2rdo5E6EKLvG6clGkv0
         C8X5l1D8arEB6QS1at9vU9ZPaR2B1wIHuian/jWdYfMjiQzfMM1MMGPPoI0M6nPzUTFh
         YwXE26MMrHsXyxQKt4hyRUB22ZT3glhBLMgw+zhSkwySXtBhaEDJY6PlY0hl26W9sizV
         EDXxacp+Yooew0rMOxJS3NE1XFSrGKE6Ta8/yHQzuR3K7W+UsvBUm5KXdZhurhhPbBiE
         LM/uAjwWfkmbdXrBvktewJ8l7f9c2NOR30fP4Ilu6l5tHWb73RDZLtVS8f7B29fc0Y1I
         IcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MJge4p5QQJELT+lPU7j1/hPxL5V3en2iIsdxZElEdes=;
        b=2XljjxaBQvx9EpFprI0fUi92zbr4AZXxbBHhLFIwc+wgpizhkfU8lhZ7t67y9leX9E
         9KGCTUL/EHNwElEnZ+iFYJn/pMUsf2Yr8g1QNDVueUDFzgKtm319gzuL/VqGMp3tij5q
         CjCw6nrybiveygvSvrndNZGbC3Q4/Lx3NPoq1Csg8Pq+e7852in7CmN+UUHSPnLZqX0O
         cC4JySHAyO9x4fPanmFZBH2A6/Lh4FqtbI4zWO8ouSyvOj/0ThrNAvTQVdQD3U5/35qC
         f4KMscaSO102VY+n2/3xCh6Y5fYPS6qUGHjHkWQmwMeQKaFKDoe6GHAsu0nAI/qrLMpf
         FlCA==
X-Gm-Message-State: AOAM532r7FDwzNfeeEJ4JhV3OefCanvESl9VJO5hs6ZYEETwNfaE1h73
        fevyvWNXT4O2Wq7jAiM39Ftrv5TxjBWbUw==
X-Google-Smtp-Source: ABdhPJx5jVc3B7X0lfV74dIbAReXume0dJj6IKs1Udh4P6wDGZUM0EQP0pg2YYmE9rmbrEziVMkjTzw1fpgpmQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1306:b0:512:ca3d:392f with SMTP
 id j6-20020a056a00130600b00512ca3d392fmr46342904pfu.79.1653696787178; Fri, 27
 May 2022 17:13:07 -0700 (PDT)
Date:   Fri, 27 May 2022 17:13:05 -0700
In-Reply-To: <YoXqmrOTxD5MiDU1@coredump.intra.peff.net>
Message-Id: <kl6lfskums4u.fsf@chooglen-macbookpro.roam.corp.google.com>
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
might be a non-subsection config that starts with "branch.", e.g.
branch.autoSetupRebase. Something like..

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

