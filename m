Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48263C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 01:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CB364D99
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 01:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhA1BSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhA1BQO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 20:16:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE97C061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 17:15:28 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id hg20so2317145pjb.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 17:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TAzyUSaAcBcN2Vh9gelTanxS4kNp7k8svXvfg95CO4k=;
        b=gMqL11t4ztmGE9OPXgMDDz3/vyN1OHx0A62HmTtSnkZmsP2qfuuR3LL5xNKvAUHqyS
         GFXPv0O77e3c4Ar54HrGyGIsdGBoXW2SFsPyNfGUrRqiZLIbd0kacCQv3s/dqoehp8Gn
         13/ERlpTL+ffnA5WwuOaRmyHPuVX0NOy/SAwxW9YBicB8NkwQEvN2U1fe4o8s6TtMfyq
         Su7ev8ogulWfDcsN/gjTqiFndB7QDutTSRQmB3xgeK3IhNJL9kRwdoK0C2qJqqGSGy4d
         A9H3LLZ2D0ZSY7OUbKEuxjHAZWe18AQCjlUsxHfYMoI8GvWtOLAOh9bm/LiZRdufK+py
         KWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TAzyUSaAcBcN2Vh9gelTanxS4kNp7k8svXvfg95CO4k=;
        b=fzX9WC2DS//qJzoU+mmfbvKmYXsAHj9fFduq/WTgzisaPbYhFQjbTP1DBtT5h0hvGK
         /lLrKt9gfkr6pRUoR59vaMcbHNLLh6c2WNCtTsX4v/iD/o0lmCA4mheB8aSliNR1/UbE
         pIR6y/SLc2KONtD9wjq2a/1WiP4sqrB3r2ooUx3vJh91iJquxbybtJltMQF2JW5G8oNy
         uqG3+azK1l1VeMtbmOIPncEs+x0r9zhtpXOKXI61e7S3IIb2bsNv2G3G1ZDdMQwgMsJl
         HQ6WuU95NJYux6pBPiix7Tzfdj+S5Cl/EygYjBL1KeePqRFAZrlNle3IJaHVb4cPm9Mk
         BHcA==
X-Gm-Message-State: AOAM530gnfKXoVeUa9OnmFyuB9h8T1g3up0MScV+NKRavCJSLbL74EH3
        MmMDhPjI8bCVEulvP1H2oQn5m6PVt60SGv8NbOSB
X-Google-Smtp-Source: ABdhPJxwDXfiKyw9voYJBp419X6061WKoeHmrA7yLMSovk1lMIEm8/9gHqiZoxVJ3bRGHgu/dfaJMccLTLyW12XQsHSX
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr1223229pjo.0.1611796527161; Wed, 27 Jan 2021 17:15:27 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:15:25 -0800
In-Reply-To: <87czxu7c15.fsf@evledraar.gmail.com>
Message-Id: <20210128011525.3886106-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87czxu7c15.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sun, Jan 24 2021, Jonathan Tan wrote:
> >  --fsck-objects::
> > -	Die if the pack contains broken objects. For internal use only.
> > +	For internal use only.
> > ++
> > +Die if the pack contains broken objects. If the pack contains a tree
> > +pointing to a .gitmodules blob that does not exist, prints the hash of
> > +that blob (for the caller to check) after the hash that goes into the
> > +name of the pack/idx file (see "Notes").
> 
> [I should have waited a bit and sent one E-Mail]
> 
> Is this really generally usable as an IPC mechanism, what if we need
> another set of OIDs we care about? Shouldn't it at least be hidden
> behind some option so you don't get a deluge of output from index-pack
> if you're not in this packfile-uri mode?

--fsck-objects is only for internal use, and it's only used by
fetch-pack.c. So its only consumer does want the output.

Junio also mentioned the possibility of another set of OIDs, and I
replied [1].

[1] https://lore.kernel.org/git/20210128003536.3874866-1-jonathantanmy@google.com/

> But, along with my other E-Mail...
> 
> > [...]
> > +static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
> > +{
> > +	int len = the_hash_algo->hexsz + 1; /* hash + NL */
> > +
> > +	do {
> > +		char hex_hash[GIT_MAX_HEXSZ + 1];
> > +		int read_len = read_in_full(fd, hex_hash, len);
> > +		struct object_id oid;
> > +		const char *end;
> > +
> > +		if (!read_len)
> > +			return;
> > +		if (read_len != len)
> > +			die("invalid length read %d", read_len);
> > +		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
> > +			die("invalid hash");
> > +		oidset_insert(gitmodules_oids, &oid);
> > +	} while (1);
> > +}
> > +
> 
> Doesn't this IPC mechanism already exist in the form of fsck.skipList?
> See my 1f3299fda9 (fsck: make fsck_config() re-usable, 2021-01-05) on
> "next". I.e. as noted in my just-sent-E-Mail you could probably just
> re-use skiplist as-is.

I'm not sure how fsck.skipList could be used here. Before running
fsck_finish() for the first time, we don't know which .gitmodules are
missing and which are not. And when running fsck_finish() for the second
time, we definitely do not want to skip any blobs.

> Or if not it seems to me that this whole IPC mechanism would be better
> done with a tempfile and passing it along like we already pass the
> fsck.skipList between these processes.
> 
> I doubt it's going to be large enough to matter, we could just put it in
> .git/ somewhere, like we put gc.log etc (but created with a mktemp()
> name...).
> 
> Or if we want to keep the "print <list> | process" model we can refactor
> the existing fsck IPC noted in 1f3299fda9 a bit, so e.g. you pass some
> version of "lines prefixed with "fsck-skiplist: " go into list xyz via a
> command-line option. And then existing option(s) and your potential new
> list (which as noted, I think is probably redundant to the skiplist) can
> use it.

I think using stdout is superior to using a tempfile - we don't have to
worry about interrupted invocations, for example.

What do you mean by "the existing fsck IPC noted in 1f3299fda9"? If you
mean the ability to pass a list of OIDs, for example using "-c
fsck.skipList=filename.txt", I'm not sure that it solves anything.
Firstly, I don't think that the skipList is useful here (as I said
earlier). And secondly, I don't think that OID input is the issue -
right now, the design is a process (index-pack, calling fsck_finish())
writing to its output which is then picked up by the calling process
(fetch-pack). We are not sending the dangling .gitmodules through stdin
anywhere.
