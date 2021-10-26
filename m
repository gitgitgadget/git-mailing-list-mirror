Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F56C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B526560187
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhJZK3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhJZK3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 06:29:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D1C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 03:26:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y78so8312538wmc.0
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9PGlrG9XPeHlBLiES0SJIWjEbxDtYwhA2ifXp/lLxis=;
        b=R5BXuDJqxkcK7Cl9TLA88FQU7CvDM8+1hXH/c121SHdG9dk9Aru72CnWnA6YHlsiAM
         EetuIf1G5obI6d1c0ZVR5Xg6HbadZ0LyXWtTiERn7YwAI3CrzNTxVmSgtYygIompOKMy
         CeZoCk29kuMxvKRjOGZGjT7i92VxDtvZhov8auGvlFWNhz1OT9IHN21VRGw4x3XRFEgy
         CJuVWeNxC2wSBWk8rSIEpJXuu/YykRmHenrUKEelynH6+OPokJb/lKGR8g3Vv3cVza7O
         LbGfLnyJIx16d+ZtRfaogebV5JQiUxbcbql65yYi4W4Z9/vjN+MSZF4ufUQcvWVc8UNf
         beSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9PGlrG9XPeHlBLiES0SJIWjEbxDtYwhA2ifXp/lLxis=;
        b=A14YXEScbHypJi3pJdVuLh1c7H5Gd9QhKGy/hMJeAzfYIzOPDMkY0w/63S5i1tTbrd
         oicNUBTg448j+KbkbZ1cN+vanBAkqkfpozyBMoUmsWdAOXI6oj0wmTOMVf7IQaFEoD4i
         c0MsVYnMvIXQMRBK4+upPFZqV3tXwRrmE3CwG23G6Q1HCg0aepUOZGIWkvtqRZcCU2Hf
         MMJ8VcCAjQ5Sd8OHvCXvnkOCdZ7/FrhZXxTU34zSAES6j033vfOS2Lx8eIfzYhuAKbHN
         2AcjmpIxAWBSGvWjvF0kohbMdOotreNUbzrVLD7Wewiqcy2OHhx3qVyUN5NVFpUV5zhD
         YvAg==
X-Gm-Message-State: AOAM530Mrce0IlqQ+XohjE13FdGrDN8Ej8uvV6vTBQiE86mOdHeBjwe/
        8sBL4DRsPDv02Tz5p58dEBJ7rEQqVwczXQ==
X-Google-Smtp-Source: ABdhPJwF0QexOgofOBfeh2TLiY3BXAJcge3FQK6vJ+E8kbFvEhPIgNHHP7apLAKIPhQitqtKXVLCoA==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr21250372wmh.66.1635244012468;
        Tue, 26 Oct 2021 03:26:52 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p7sm18512376wrm.61.2021.10.26.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 03:26:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfJfP-001l0q-Cj;
        Tue, 26 Oct 2021 12:26:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
Date:   Tue, 26 Oct 2021 12:12:12 +0200
References: <211025.86lf2hgsmj.gmgdl@evledraar.gmail.com>
 <20211025185356.1232635-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211025185356.1232635-1-jonathantanmy@google.com>
Message-ID: <211026.86bl3c13pw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Jonathan Tan wrote:

>> I had some concerns about the specifics of the implementation/what
>> seemed to be tailoring it a bit too closely to one use-case[1][2], not
>> inherently with the idea (although I think e.g. for brian that more
>> closely reflects his thoughts).
>> 
>> Anyway, just saying that aside from this RFC I don't think we were at
>> the point of really fleshing out what this would look like, and there
>> being some hard "no", so I think that idea could still be pursued.
>
> Which idea specifically do you think could still be pursued?

I meant the whole in-repo .gitconfig. I.e. to the extent that you're
submitting this as an alternative to that because of the negative
feedback on that RFC.

>> On this proposal: this also applies globally to all history, but I don't
>> have the same concern with that as the 1=1 mapping of remote-suggested
>> hooks, our path includes work that way, after all.
>> 
>> I think it would be nice if you could think about if/how this and the
>> "onbranch" include would work together though to serve the general case
>> better.
>> 
>> Also if you have a repo with N remotes each where "origin" tracks URLs
>> at git.example.com, and you add a "dev" tracking dev.example.com, will
>> the config apply if you're say on a branch tracking the "live" server,
>> if you've said "include this for repos matching dev.example.com?
>
> Right now, the feature is only dependent on remote URLs configured
> through remote.?.url. It wouldn't work with "onbranch" because there's
> no way to combine conditions (and I have no plans to do that). I think
> that if you have something that you want depending on which branch
> you're on, you can just use the existing "onbranch" feature.

I mean with this and the below...

>> Arguably that's what you want, but perhaps something that those more
>> used to the centralized workflows wouldn't consider as being unintuitive
>> for users who might want to add this config only for their main "origin"
>> remote. We don't really have a way of marking that special-ness though,
>> except maybe checkout.defaultRemote.
>
> What do you mean by adding a config for a specific remote?

...what happens if you add a google.com remote for a repository that
"lives" on github.com. I.e. are the semantics "match any remote", or
"match the 'primary' remote (origin?" etc.

>> I'm also still somewhat mystified at how this would better serve your
>> userbase than the path-based included, i.e. the selling point of the
>> remote-suggested configuration was that it would Just Work.
>> 
>> But for this the users would either need to setup the config themselves
>> for your remote, but that would be easier than pro-actively cloning in
>> "work" or whatever? I guess, just wondering if I'm missing something.
>> 
>> Or if it's a partly-automated system where some automation is dropping
>> in a /etc/gitconfig.d/google-remote-config-include 
>
> Yes, the config is meant to be handled e.g. through a package manager
> like apt. We don't want to prescribe directory structures like "work",
> which is why the include is conditional upon the remote URL.
>
> Even if the user pro-actively clones into "work", the user still needs
> to set up the conditional config, so I don't see how that is a net
> benefit.

Ah, that explains it. I assumed both cases would be ones where the user
would need to manually enable the 'configuration' (or cloning to a given
subdir).

>> I wonder if this
>> whole thing wouldn't be better for users with such special-needs if we
>> just supported an "early config hook".
>> 
>> i.e. similar to how we read trace2 config from /etc/gitconfig early, we
>> could start picking up a hook that just so happens to conform to the
>> config schema Emily's config-based hooks use.
>> 
>> So the /etc/gitconfig would have say:
>> 
>>     hook.ourConfigThingy.command=/usr/bin/googly-git-config
>>     hook.ourConfigThingy.event=include-config
>> 
>> That hook would just produce a config snippet to be included on STDOUT.
>> 
>> Since it's an arbitrary external command it would nicely get around any
>> chicken and egg problems in git itself, it could run "git remote -v",
>> inspect the equivalent of an "onbranch" etc. etc, then just dynamically
>> produce config-to-be-included.
>
> I see that later on, you suggest an environment variable to guard
> against recursion.
>
> One thing is that if there are multiple such hooks, each one won't be
> able to see what the other hooks have produced.

Yes, although aside from this hook that's a general caveat with the
proposed config-based hooks, I think if you need a hook that does that
(whether it's this, or pre-receive etc.) our answer is "put it in your
own wrapper".

> If the feature you described already existed in Git, I think I could use
> that, but if we're deciding between implementing the config hook you
> describe versus something with more constraints, I think the one I
> proposed is better for now. Some design points that have already been
> discussed are whether setting a config during processing of an included
> file would then invalidate the include and also the order of operations,
> both of which would be much more difficult to control with config hooks.

I suggested it because maybe it would be a lot simpler, i.e. we don't
need such a feature to be aware of remote config at all, or having to
"read forward" to find it, maybe it would be more complex. I haven't
tried to implement it.

>> Please don't take this as some objection to your current proposal, just
>> a thought on something that might entirely bypass odd edge cases and
>> arbitrary limitations associated with doing this all in the "main"
>> process on-the-fly.
>> 
>> The special-ness with that one would need to be that we'd say it
>> wouldn't have the normal "last set wins" semantics, or maybe we could do
>> that and just note that we saw it, and execute the "include" when we
>> detect the end of the full config parsing (I'm not familiar enough with
>> those bits to say where that is).
>
> The "last set" would be those set by the hooks, so yes, a user would
> need to know to make their own hook in order to override anything set by
> the hooks. The end of the full config parsing is in
> config_with_options().

On the "user would need to know" that's the same if it's config? I.e. in
either case it would be in /etc/gitconfig or whatever shipped by the
*.deb package.

Anyway, I really just meant this as a suggestion, and one that might
make things simpler. If you don't think it makes sense...
