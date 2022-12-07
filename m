Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C107CC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLGBKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGBKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:10:39 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D9101
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:10:38 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id b11so16136182pjp.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM3Z71yWMK9BRWUFh5ns98h/bNTaztd7trbDLoRk5R8=;
        b=k9lrhKHtQB6VF15lTquwssf6cJai7V0rK6hMTKVZVpLRMY16JCT0sKL+IroMuKBSAk
         JijFpaktgN3ZgXt2FevUUUiPxATIz08aJaY+din/9Hs95uQ6rcNruMrp+6PVRcYh9moD
         hlhtLK6oIs0MkFtCA5/KEP2KHdoAc+wLDpLv41csyRMCkDDE09Q3D+rgSSRmLUIuiAk9
         KF82/PvhQyppn5BIe6BNLolfs1I7Gkrnd9n98n/BEaykTsVdf+X3EYhoLMlmErNyKnN/
         sh3g1Ss27XIDBqFMQYQ5QFhbfpRB/Uio5j10B4oqkp5UxbMTm0xdkEJrCAajl8u+hV2U
         aHfw==
X-Gm-Message-State: ANoB5plmWgFTodgVANNPIl3VhPrEoqIM2HG/fzo4/hVl3dh2sjE+HghI
        7Dh2A85bTbimNFLxcwVmy0U0lF32sDfAnCLXBZU=
X-Google-Smtp-Source: AA0mqf58lQK5erV14/C6YXXj/yiP9S1BHk/WQ8ha/4vck95Str4WB8gnDm7NCh9gAOrCl6TMXBDfOYz3U35gw/3FMH0=
X-Received: by 2002:a17:90a:bd96:b0:219:3553:4ff5 with SMTP id
 z22-20020a17090abd9600b0021935534ff5mr47000852pjr.22.1670375438006; Tue, 06
 Dec 2022 17:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g>
In-Reply-To: <xmqqedtc842m.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Dec 2022 20:10:26 -0500
Message-ID: <CAPig+cT_xz3m-3kkL_Scf0opNXkikU94kSF46VO8KHkNMWbGzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2022 at 7:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> > Add a new flag `--revision`/`-r` which will allow it work with
> > revisions. This command will now, instead of checking the files/index,
> > try and receive the blob for the given attribute file against the
> > provided revision. The flag overrides checking against the index and
> > filesystem and also works with bare repositories.
>
> As "check-attr" was not invented as a user-facing subcommand but was
> a hack for debugging, I would have minded this change, but these
> days people seem to treat it as if it is just one of the proper
> plumbing commands, the new command line convention bothers me a
> bit.  No other command uses --<anything> to signal that what comes
> after it is a rev.
>
> But I do not think of a better alternative without making the
> command line ambiguous, so I'll stop at raising a concern, so that
> others who may be better at UI can come up with one.

A few minor comments...

We don't usually squat on short options, such as `-r`, right from the
start but only add the short alias once shown that there is demand.

Option `-r` has strong association with "recursive" elsewhere, so I'd
worry about giving it such a completely different meaning here.

Rather than calling the option `--revision`, perhaps pattern it after
git-restore's `--source` option which allows specifying a particular
commit, tree, tag, etc.?
