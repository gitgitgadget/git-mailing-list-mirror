Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53497C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 05:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F736522F
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 05:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCIFnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 00:43:13 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:58454 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhCIFmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 00:42:43 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lJV8h-000xRj-BE; Mon, 08 Mar 2021 22:42:39 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1lJV8f-0002Pw-MU; Mon, 08 Mar 2021 22:42:39 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 842C750107E;
        Mon,  8 Mar 2021 22:42:37 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GvR6ZvrMNip0; Mon,  8 Mar 2021 22:42:37 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id F2808500656;
        Mon,  8 Mar 2021 22:42:36 -0700 (MST)
Date:   Mon, 8 Mar 2021 22:42:35 -0700
From:   Seth House <seth@eseth.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Message-ID: <YEcKy83ZmvGTAfxq@ellen.lan>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
 <YEbdj27CmjNKSWf4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEbdj27CmjNKSWf4@google.com>
X-XM-SPF: eid=1lJV8f-0002Pw-MU;;;mid=<YEcKy83ZmvGTAfxq@ellen.lan>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:29:35PM -0800, Jonathan Nieder wrote:
> A typical mergetool uses four panes, showing the content of the file
> being resolved from MERGE_BASE ('BASE'), HEAD ('LOCAL'), MERGE_HEAD
> ('REMOTE'), and the working copy.  This allows understanding the
> conflicts in context: by seeing the entire content of the file from
> MERGE_HEAD, say, we can see the full intent of the code we are pulling
> in and understand what they were trying to do that conflicted with our
> own changes.

Well said. Agreed on all counts.

The very early days of these patch sets touched on this exact discussion
point. (I'd link to it but that early discussion was a tad...unfocused.)
I make semi-frequent reference of those versions of the conflicted file
in the way you describe and have disabled hideResolved for a merge tool
I maintain for that reason.

>     No adverse effects were noted in a small survey of popular mergetools[1]
>     so this behavior defaults to `true`. However it can be globally disabled
>     by setting `mergetool.hideResolved` to `false`.
> 
> In practice, however, this has proved confusing for users.  No
> indication is shown in the UI that the base, local, and remote
> versions shown have been modified by additional resolution.

Compelling point. This flag drastically changes what LOCAL and REMOTE
represent with little to no explanation.

There are three options to achieve the same end-goal of hideResolved
that I've thought of:

1.  Individual merge tools should do this work, not Git.

    A merge tool already has all the information needed to hide
    already-resolved conflicts since that is what MERGED represents.
    Conflict markers *are* a two-way diff and a merge tool should
    display them as such, rather than display the textual markers
    verbatim.

    In many ways this is the ideal approach -- all merge tools could be
    doing this with existing Git right now but none have seemingly
    thought of doing so yet.

2.  Git could pass six versions of the conflicted file to a merge tool,
    rather than the current four.

    Merge tools could accept LOCAL, REMOTE, BASE, MERGED (as most
    currently do), and also LCONFL and RCONFL files. The latter two
    being copies of MERGED but "pre split" by Git into the left
    conflicts and the right conflicts.

    This would spare the merge tool the work of splitting MERGED. It may
    encourage them to continue displaying LOCAL and REMOTE as useful
    context but also make it easy to diff LCONFL with RCONFL and use
    that diff to actually resolve the conflict. It could also make
    things worse, as many tools simply diff _every_ file Git gives them
    regardless if that makes sense or not (>_<).

3.  Git could overwrite LOCAL and REMOTE to display only unresolved
    conflicts.

    (The current hideResolved addition.) This has the pragmatic benefit
    of requiring the least amount of change for all merge tools, but to
    your point above, *destroys* valuable data -- the additional context
    to help understand where the conflicts came from -- and that data
    can't be viewd without running additional Git commands to fetch it.

Defaulting hideResolved to off is a fine change IMO. We don't have a way
to communicate to the end-user that LOCAL and REMOTE represent something
markedly different than what they have traditionally represented, so
having this be an opt-in will force the user to read the docs and
understand the ramifications.

I really appreciate your thoughts that accompanied this patch. Sorry for
the long response but your email made me want to ask the question:

Does the need to default hideResolved to off mean that it is the wrong
approach?

Thinking through an end-user's workflow: would a user want to configure
two copies of the same merge tool -- one with hideResolved and one
without? An easy conflict could benefit from the former but if it's
a tricky conflict the user would have to exit the tool and reopen the
same tool without the flag. That sounds like an annoying workflow, and
although the user would now have that extra, valuable context it would
also put them squarely back into the current state of viewing
already-resolved conflicts.

I know the Option 3, hideResolved, is merged and has that momentum and
this patch looks good to me -- but perhaps Option 2 is more "correct",
or Option 1, or yet another option I haven't thought of. Thoughts?

