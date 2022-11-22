Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943DC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 06:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKVGBL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Nov 2022 01:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVGBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 01:01:09 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C129B
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 22:01:07 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id p21so12648374plr.7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 22:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hew8/Vz/MxcZH6f3X+K90CmdRnMI6oyp8kADw9q9u18=;
        b=j/4dbgNknCIbPk1VEEeGKHSrl0jvvJjRKPbMeeQ0omc9NAtEAGrxg8dIQDeZe1bLOM
         Xdj0WfafiN8TbLLn+zgeLrElRz0PTIdsqe/Qmtmf2YzobtwJdTw4KgePPIM6pReaUxJP
         HgUWfyFtuj2r0F5n6rhkoM3ZRJkFGg7BchBF87u7mVNYLQxzI0PzY7RB2NxVuPkHdwYV
         dGH/ynCuZFdsuEyZYSPbH5nIJmm2v/SPJwddU9L9e4ut5fnrm2PaByLms9Z0bWRKr5g0
         oKl0gpzYLXSpHtGkbxq/hHdjdCdPqnHzW+5lQQXm/wYQr/hpxuq1BHUxLR+MOICnE89G
         Xi6A==
X-Gm-Message-State: ANoB5pni8uc3WaC7S6XpYzmu8pbYmhd+9YC45R9pkC6k6wzcJQyVV4uW
        YDksH/8ayP52PNu2rEFUwzCzz1uMR3ZKJu5eYjU=
X-Google-Smtp-Source: AA0mqf7Bq4mtml87Obuaf9QuOtmFsH2g59oYXxPd+4RnpSOAAUocn5asVYZ81pxMWw6iHYzoPRd8TLXZNcW1eNfu+94=
X-Received: by 2002:a17:902:ef94:b0:186:aad0:6b32 with SMTP id
 iz20-20020a170902ef9400b00186aad06b32mr15556827plb.77.1669096866508; Mon, 21
 Nov 2022 22:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev>
 <221115.86iljfkjjo.gmgdl@evledraar.gmail.com> <20221119014436.737kqsmcezkck3do@phi>
In-Reply-To: <20221119014436.737kqsmcezkck3do@phi>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 01:00:54 -0500
Message-ID: <CAPig+cSU-Fh3BnBMhomFr2ZEQZ3Cw=toVZETVY4k42-jqiHY=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 8:44 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> On 22/11/15 10:08PM, Ævar Arnfjörð Bjarmason wrote:
> > > +   test_must_fail git worktree add --orphan existingbranch orphandir2 &&
> > > +   test ! -d orphandir2
> >
> > I'm not sure about "worktree" behavior, but maybe this "test ! -d" wants
> > to be a "test_path_is_missing"?
> >
> > In general we try to test what a thing is, not what it isn't, in this
> > case don't we fail to create the dir entirely? So "not exists" would
> > cover it?
>
> Ah yes that would be preferable. I've updated it for v4.
>
> This shows up in the file in a few other places in this file as well
> (from before this patch). Should I make the changes there as well and put
> those changes into an additional patch in this patchset?

With my reviewer's hat on, my goal is to help the series land in
Junio's tree, which means I'd like to see fewer changes with each
iteration. Adding a new patch which is only tangentially related to
what the series wants to achieve isn't a priority, and could end up
delaying acceptance of the series if problems in the new patch end up
requiring additional rerolls.

So, yes, you could do that cleanup as a preparatory patch in the
series if you want to tackle it. It would be an appropriate cleanup
since you're working on code nearby. Or it could be done as a follow
up to this series. Given how small the cleanup patch would likely be,
it may not make a difference one way or the other, especially if the
commit message explains the change well (for instance, by paraphrasing
what Ævar said about "testing what a thing is, not what it isn't").
