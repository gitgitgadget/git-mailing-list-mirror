Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104D720282
	for <e@80x24.org>; Fri, 23 Jun 2017 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbdFWN4L (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 09:56:11 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34450 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdFWN4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 09:56:09 -0400
Received: by mail-lf0-f47.google.com with SMTP id l13so30964605lfl.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MbnB5aXOqUtrd0j9ITMJcYStmE3FMaKvYct+q2CrGDE=;
        b=HrqqgoEWBzRIm/5BF9+P2MBPIBvNUcoVjjRudaSHEUocwYMbgUd0vVWFt0oxUBDfCu
         YepoYMejmsXBQZqEeiO0pdDb3IWFKMIjPU+otzUKWuPi0HSVxMVqxXCK6hGBCA4vzNx+
         WPW8c221TWqiBX+NVyXiqUwPQPzZ5zV9vYcPTCg+vQmUH6T5diltbhPL2goA+NveZ8gY
         cSECNuVONpc++pdnNrdZRlEcW2EtuN9pkNzvdftTNnHvTUtz/8v8AuH8BHCP6MIiLkBw
         /Ujfd7IpAeDLswQo4aq88NFYJqc/RGK29QufXj3u9E/hoD4bFgxK17aetsDNidhDTb8w
         uuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MbnB5aXOqUtrd0j9ITMJcYStmE3FMaKvYct+q2CrGDE=;
        b=qlvWQVDA4fVkfZBD25WdToC3EhyXL6H0MRWkUI2hSNFi5n0n3gY5/0+7d7aLQY+0CB
         Yi0t/jQjwMKr6idGW5Ryw0Y7gHB9/mmLD2mwHJTk3Njgae3tP6UglM62mcgM/V+Dr6S9
         ddddful3iayiSBJK6Kxn6/Bq+4TFpRJAxVJs4sLNX/tg8TG7gidUi6u1Gp5Qk0gNruW8
         1ujScRBDId1aq3LSE9UcbrI4u7jn280+HqzlG59FvN3hUMkEeebKm5WlT2npTq0AdmRF
         hWUpFTWk3D3OHoIYHtzc3vBKNdLS8SFXtSmAgxbrwACzGuGzUAzy4K5+UKTusf8gxMV+
         KxoQ==
X-Gm-Message-State: AKS2vOzYsjmOJpNwF2cEhgXqId/PoewXAiKFd0hDTIBXR1fs4k9XCpqb
        /BpceUUkKTvvwrDJm8SM/7ATfkuiYQ==
X-Received: by 10.46.9.4 with SMTP id 4mr2643868ljj.23.1498226167368; Fri, 23
 Jun 2017 06:56:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Fri, 23 Jun 2017 06:55:46 -0700 (PDT)
In-Reply-To: <20170623135230.10534-1-jacob.e.keller@intel.com>
References: <20170623135230.10534-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Jun 2017 06:55:46 -0700
Message-ID: <CA+P7+xov17vsoVZSvSim0psX72NJ+arsc_5LPSuxpqXHEg4egg@mail.gmail.com>
Subject: Re: [RFC PATCH] proposal for refs/tracking/* hierarchy
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 6:52 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Historically, git has tracked the status of remote branches (heads) in
> refs/remotes/<name>/*. This is necessary and useful as it allows users
> to track the difference between their local work and the last known
> status of the remote work.
>
> Unfortunately this hierarchy is limited in that it only tracks branches.
> Additionally, it is not feasible to extend it directly, because the
> layout would become ambiguous. For example, if a user happened to have
> a local branch named "notes" it could be confusing if you tried to add
> "refs/remotes/origin/notes/<remote notes refs" as this would collide
> with the already existing refs/remotes/origin/notes branch that existed.
>
> Instead, lets add support for a new refs/tracking/* hierarchy which is
> laid out in such a way to avoid this inconsistency. All refs in
> "refs/tracking/<remote>/*" will include the complete ref, such that
> dropping the "tracking/<remote>" part will give the exact ref name as it
> is found in the upstream. Thus, we can track any ref here by simply
> fetching it into refs/tracking/<remote>/*.
>
> Add support to tell a new remote to start tracking remote hierarchies
> via "--follow" which will track all refs under that section, ie:
>
> git remote add --follow notes origin <url> will cause
>
> +refs/notes/*:refs/tracking/origin/notes/* to be added as a fetch
> refspec for this remote.
>
> This ensures that any future refs which want a method of sharing the
> current remote status separate from local status could use
> refs/tracking
>
> A long term goal might be to deprecate refs/remotes/ in favor of
> refs/tracking (possibly adding in magic to convert refs/remotes directly
> into refs/tracking so that old stuff still works?).
>
> Things not yet thought through:
>
> 1) maybe we should create a configurable default so that some known set
>    of default refs get pulled (ie: notes, grafts, replace, etc?)
>    Possibly with some sort of easy way to add or subtract from the list
>    in config...
>
> 2) so far, there's no work done to figure out how to remove
>    refs/tracking when a remote is dropped. I *think* we can just delete
>    all refs under refs/tracking/<name> but I'm not completely certain
>
> 3) adding magic to complete refs under tracking, such as for git-notes
>    or similar may wish to understand shorthand for referencing the
>    remote version of notes
>
> 4) adding support for clone.. (this is weird because git-clone and
>    git-remote don't both use the same flow for setup.. oops??)
>
> 5) tests, documentation etc. (This is primarily an RFC, with the goal of
>    providing a known location for remote references such as notes to
>    reside)
>
> 6) we probably want to enable notes and grafts and other similar things
>    to use the remote tracking data if its available.
>
> 7) what about tags? Currently we fetch all tags into refs/tags directly,
>    which is a bit awkward, if for example you create a local tag and
>    a remote creates a tag with the same name, you simply don't get that
>    new version. This is good, but now you have no idea how to tell if
>    your tags are out of date or not. refs/tracking can partially resolve
>    this since remote tags will always be "exactly" what the remote has.
>    Unfortunately, I don't know how we'd resolve them into local tags...
>

Oops:

8) if we decided to go with "all refs always get tracked in
refs/tracking" we probably want to either add a way to say "all refs
except refs/tracking ones" or we want a way for servers to (by
default) not advertise refs/tracking when clients fetch from them.
That's partially why I went with the easier "only some hierarchies
will get pulled by default" Otherwise, two remotes that fetch from
each other could create a never ending cycle of
refs/tracking/origin/tracking/origin/tracking/origin/ adding a new
layer every time they fetched.

Thanks,
Jake
