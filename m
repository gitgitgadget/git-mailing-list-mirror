Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D854C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B180650BF
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbhCDBx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhCDBxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:53:50 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C408C061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 17:53:10 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m4so16951869pfd.20
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MzzpwsSGUNkvu0MBb5lA6wEh8GDn/kEHA2jAcYWl/Zg=;
        b=XX4Ej0oueFEsx5CcwS4yH0og5tFYDWMWwxf7o9TDGiqV9Mwke9SyLSab/JCYaW9O7y
         P4SSlMh0SWuFscCGY5kE88BE5iaDFzwTrD7s4tBj+kEMPortQuvIV4icFvyNNvf3bTvT
         KBsg3xVdm9OMd2kag+7tGB7bnY+/+smOfOjLr3pOkwiPxruA8FJ0nVvqnXex0Ko3h+HE
         7CStsROOpPb4ipb0ZFOZNg7SwnFQzwXp9zMW1aOvXVVCXf9zKzX41Q5KU2pzIJ2flCpc
         aYl1gzx8DlO2x+8H/5lXrqpwvXPu+Z7A1qVZfhHpoDi8+brAc5zDC3eeigvhPtlx6svN
         McJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MzzpwsSGUNkvu0MBb5lA6wEh8GDn/kEHA2jAcYWl/Zg=;
        b=uYwcz21VtHDWT4pHHtgDgX0wNR8HLuqqM+DYdviJS2CIPgP1qgvjz0QvDoSRnxlR7x
         Ihsh5RcgqylP4gc/1REcc68U6IUINBDlR3WGS4LT3BwrvTB7XLjtEbBWcrP5lIaWiNxw
         if9ySImxvHRd59NUJZVwn3ULIXL2kVGaR786JJnCNBXt6wTR+WgWsnUeIucnJxJA8vuL
         8nhhHyb+vYAo9bo/Va/g2LdiIcqgr9AXrxM5vckSd0D0zowP6IPu0xytJ1gbzj9Sebz6
         a/H8ZheFlU99ucqkAdf/uXyrHtBoCTAW5WtguTcxLv65d9AjXNbFnZ987FxPCXMvrYmR
         sEwg==
X-Gm-Message-State: AOAM532dsamKalmOTAM1+YJyS+E40MQ9vz0e+tpdsdNge1vfMRiq4dk4
        4mZ7J3DvUrpNCZFg82aZumXUbj/dR2HwsbDIhR02
X-Google-Smtp-Source: ABdhPJxFVrjL3NCSNd0iaPXQyf7a7ORwC5ueaJvMbgGlJf5+Rc9XA75T0QQ2TjP7wmOUdDFl0/k7KTDsNj/V0nO7Befk
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1b46:: with SMTP id
 nv6mr1980923pjb.45.1614822789885; Wed, 03 Mar 2021 17:53:09 -0800 (PST)
Date:   Wed,  3 Mar 2021 17:53:04 -0800
In-Reply-To: <xmqqy2f3hjqf.fsf@gitster.c.googlers.com>
Message-Id: <20210304015305.1800570-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2f3hjqf.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v4] builtin/clone.c: add --reject-shallow option
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, stolee@gmail.com, johannes.schindelin@gmx.de,
        lilinchao@oschina.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > This is true with protocol v0, but protocol v2 bundles all shallow
> > information (whether coming from the fact that the remote is shallow or
> > the fact that the fetcher specified --depth etc.) and sends them
> > together with the packfile.
> 
> By the above do you mean what happens in FETCH_GET_PACK arm where
> receive_shallow_info() is called when "shallow-info" header is seen,
> before the code continues to process wanted-refs, packfile-uris and
> then finally the packfile?

Yes.

> I do not think it makes much sense to ask any option to make us
> shallow (like --depth=<n>) while --reject-shallow is in use (after
> all, if the other side is deep enough to make us <n> commits deep,
> there is no reason to reject the other side as the source), so your
> "whether coming from the fact ..." part, while is a valid
> observation, can be ignored in practice (meaning: it is OK to make
> "--reject-shallow" be in effect only when we are trying to make a
> full clone, and reject combinations of it with --depth=<n> and such
> at the command parsing time).
> 
> > It may be possible to stop packfile download (saving bandwidth on
> > the client side, at least) once such information is returned,
> > though.
> 
> Just like "upload-pack" does not get upset by a client that comes
> only for the initial refs advertisement and disconnects without
> asking for any "want" (aka "ls-remote"), the server side should be
> prepared to see if the other side cuts off after seeing the
> "shallow-info" section header or after seeing the the whole
> "shallow-info" section, so we should be able to leave early without
> having to download the bulk data.  If the "upload-pack" spends
> unnecessary cycles when it happens, then we need to fix that.  Even
> if the "fetch" client does not willingly disconnect in the middle,
> the network disconnect may happen at any point in the exchange, and
> we'd need to be prepared for it.
> 
> Do we need to read and parse the "shallow-info" section, or would
> the mere presense of the section mean the other side knows this side
> needs to futz with the .git/shallow information (either because we
> asked to be made shallow with --depth and the like, or because we
> tried to clone from them and they are shallow)?

Reading the documentation, the mere presence should be enough. Yes, I
think upload-pack will spend unnecessary cycles if the channel is
terminated halfway (and I don't know if we can prevent spending these
cycles, since I/O can be buffered). I think it should be possible for
the client to cut off when it sees shallow-info (besides the possible
wastage of cycles and I/O on the server's end).

Having said that, I think this different from the ls-remote case. There,
the server is awaiting another request from the user before sending more
information, but here, the server intends to send everything at once.
