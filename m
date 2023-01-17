Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FCC00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjAQXBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjAQW7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:59:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4C47EC7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:40:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x7so18420165qtv.13
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c+BudafJ+1JLrWDqGs7isNTnY6+XeB5uxvJX6ocKcoo=;
        b=ck5Nn65GzQRPT8bUlTxDOPvWVs6M5dmh3pnamKAMMgPW77HH0iHBw3nV6wbKeNP+Dx
         7CiS14LCsD3o0u1vmlVZ39lLso26gGJqmLzh/PMkXG2uyFDhxBmuFcj5f3gMO2I6cTnT
         f1FRMrlZvyX55EataqJz5iZK9aF4iuBKodyTJCRYyux+0uxrAhRpsCwpXeVR5F1CdgyS
         /nLEXTizCH+bOZTbMoJZpEP/9+W7DOKez52DPf0MynqlSLLNeJAgZE42y0s+sX9kTmUe
         xXZhZchN+3BdriLGw2JlnQTOABFghqMhvtFLJCK64GErrwNoHdxRBqGEesQiPbfB35fX
         Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+BudafJ+1JLrWDqGs7isNTnY6+XeB5uxvJX6ocKcoo=;
        b=d9jRwaNYmJ3G5xEUmhwCVcpbBCAXPYnlSVwrJ6j4egRdXhyTCb/tDZUtQEkrQ/aqwI
         7b47YNCQfxF1X6I17RT8XR/GeicITiKBtDvrK0Sspj2aP4W/iriyEgtrTny6Itt1DcUV
         ZH0OUP1DipNb0IJoAu2C/XXPLcNlR3r329/uxZlbta8h0POZfdvtsF27UUECAfEcPBUq
         5Mzc6T0DKeMpTJwsJZnBy55mZcxp7uV+PyS/7n6Zt5WrmqwfciNwgVbDX2IM3w/SnNQ4
         35ZQuHf5o52mcwVfi84Ar8rCHJ0sbe/nEoTvAqxNhYtgIQ+oTFDONSLCvmFedMagudjD
         +IDw==
X-Gm-Message-State: AFqh2kqYUkpo+kuplPbxrog/9tUtGJiuXea4SDad8NMwf4DUGlcSfrui
        X2hGftgB7OrzH+Y3TDjdsiZDNHk/+JM5ZQ==
X-Google-Smtp-Source: AMrXdXt9Hq7sLTeNHlv5Tnd8j+WmZ1+HX+qCnwhCqp+lGqg9CyobB645R+iLu8DgRJSBeslAL3ak2Q==
X-Received: by 2002:a05:622a:1e1b:b0:3b6:317f:2d5a with SMTP id br27-20020a05622a1e1b00b003b6317f2d5amr6062550qtb.29.1673995208689;
        Tue, 17 Jan 2023 14:40:08 -0800 (PST)
Received: from localhost.my.domain ([2601:6c1:c281:3430:223:24ff:fe37:484e])
        by smtp.gmail.com with ESMTPSA id az16-20020a05620a171000b00706aeebe71csm807688qkb.108.2023.01.17.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:40:08 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:40:06 -0500
From:   Crls <kaploceh@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
Subject: Re: ctrl-z ignored by git; creates blobs from non-existent repos
Message-ID: <Y8cjxv0CkJPTN+NA@localhost.my.domain>
References: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
 <Y8Qfj32h89hq5UD6@mit.edu>
 <Y8SCZvMu7DZZH1Pl@localhost.my.domain>
 <Y8SNNeQ3fQdrf5Fi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8SNNeQ3fQdrf5Fi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 06:33:09PM -0500, Jeff King wrote:
> On Sun, Jan 15, 2023 at 05:47:02PM -0500, Crls wrote:
> 
> > > Now, when you type ^Z, the git processes are stopped --- but the
> > > objects are created already.
> > 
> > The directories exist not because ^Z is used, but because by the time
> > git-clone prompts for a username, git is already set on what to do
> > next. Correct? in other words, the process is shoved down my throat.
> > Or the user's throat in this case. Or going by another analogy, it
> > certainly sounds as if I meant: «Git, please git-clone such and such
> > repo, but let me fix just a typo on the repo name before submitting
> > it, pretty please» and then Git replies: «too late for that
> > chick-a-doodle» and there it goes. It injects blobs all over (well,
> > not all over but on the dir specified).
> 
> I don't know what you mean by "blobs" here, since we fail to download
> any Git objects at all, let alone blobs. But yes, Git creates the local
> repository, and then tries to fetch into it. So the directory is created
> before it even contacts the remote server at all, and you will see the
> same behavior whether the repository exists or not. And then if an error
> occurs, it will rolls back by deleting the newly-created repository.
> 
> It _could_ be possible to contact the server first, and only when things
> looked successful-ish, to create the local repository. But:
> 
>   1. The clone command is simply not written that way, and converting it
>      now would be tricky. The clone command's view of the world is that
>      it makes a new repository, sets up config, etc, then fetches into
>      it.
> 
>   2. It would not fix all cases anyway. At some point we have to say
>      "this looks close enough to success to create the directory", but
>      things can still go wrong after that.
> 


What I meant by blobs is in the following:

Ending up with a list of directories and subdirectories, is not unusual, is actually very common really with every git-clone while fetching a non-existent repo with a git clone operation either through github or gitlab. First it comes with two (2) git, or one git instance first, then another  and finally one (1) git-remote-helper instance.

ps -a | grep 'git' can confirm it

You'd be able to see 

19159 pts/9    00:00:00 git
19160 pts/9    00:00:00 git
19161 pts/9    00:00:00 git-remote-http <defunct>
19188 pts/9    00:00:00 git
19189 pts/9    00:00:00 git
19190 pts/9    00:00:00 git-remote-http <defunct>


Obviously, its <defunct processs > part was only made possible just right after and invoking a `kill -9 process id`

And if you wanted to find out the leftovers behind through a `du -h <reponame>` by either by git/git-remote-helper (it doesn't really matter at this point which one out of the two may have been the culprit here):

8.0K    /.git/info
4.0K    /.git/objects/info
4.0K    /.git/objects/pack
12K     /.git/objects
64K     /.git/hooks
4.0K    /.git/refs/tags
4.0K    /.git/refs/heads
12K     /.git/refs
4.0K    /.git/branches
116K    /.git
120K    /

These  are the default values. Any curl operation through git with a non-existent repo will get those values.  

Now. We can all proceed trying to sugar coat these leftovers behind an explanation of whatever git-remote-http is actually doing or for that matter, as I said before and without being redundant here, the git-clone processs itself, but it doesn't realyl matter, the end results are the same. Are there leftovers? You can bet on it. It may not happen — and borowwing someone else's phrasing, wording, — «instantaneous», for it's actually quite clever really, to the detriment of an end-user. 

I've read tibbits from gitremote-helpers(7) quote: When Git encounters a URL of the form <transport>://<address>, where <transport> is a protocol that it cannot handle natively, it automatically invokes git remote-<transport> with the full URL as thesecond argument. End quote.  But it's unsettling. The whole issue. The gitremote-helper is not helping, no pun intended. Luckily for these use cases ^C and ^\ seem to be functioning. 


> Now if you have a problem with the rollback, there might be a bug there.
> But it sounds like you are simply stopping the process and not letting
> it finish. It should roll back even if it receives a signal death, but
> ^Z is stopping the job and putting it in limbo. If it hurts, don't do it
> (or use "fg" or "bg" to let it finish).
> 
> > > So what's going on is that github.com is not returning a non-existent
> > > repo error; it's prompting for a username/password, as _if_ the
> > > repository exists.  That's presumably to prevent disclosing
> > > information as to whether or not a private repository exists or not.
> > 
> > I agree with you there. Coincidentally speaking, why does a username
> > warrants a prompt from git, is simply beyond me. I mean, that is
> > certainly the more far-fetched reasoning of implementation I've read
> > in a long long time.
> > 
> > Can you git-clone a user? What about the user's settings? What about
> > the remainder its gpg tokens and so forth? In other words, if a user's
> > repo is not found, why even prompting for a username? The latter, that
> > is, the user's repo, is redundant,  when the prompt is clearly asking
> > for a username, and not a repo.
> 
> Huh? GitHub cannot tell you whether you have access to a repository (or,
> for privacy reasons of the owner of the hypothetical repository, whether
> a repository of that name might exist) unless you authenticate. So it
> returns an HTTP 401. Your authentication in this case requires a
> username and password. Git asks for the username first, then the
> password.
> 
> Is there something else you think GitHub should be returning there? Or
> something else you think Git should do with an HTTP 401?
> 
> -Peff

-- 
Don't hit the keys so hard, it hurts.
