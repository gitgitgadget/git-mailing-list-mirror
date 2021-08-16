Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCEC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100D660F35
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhHPXHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 19:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhHPXHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 19:07:00 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E806C06129D
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:06:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m4-20020a170902db04b029012d5b1d78d5so11664205plx.15
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hB8Bha1PZM8xOwTJIZ7RCODtbHr5POuJYe+THbm+qno=;
        b=nvLy6weYJGAU7yb/TvwBn978N53VF1tr07Oji9NlvuoEKYHDd65DZQy5eO4DZjAG/B
         CDUJbtkjylIYy/LjaANJdkdl7PjEQWPDsHOF8qzCuiab6CMcROOYJVtPfPV0DLILPYYw
         oBYC3CszAV14OyWDmPqLiNkmo2h3MbEmv42UqC/Wi31XrLQRKoQzhu7G42USUxdlCDv4
         EvMl06KQn5iDfe71ILyPw2mRu/HwCbS8IpCdM2aGK1wMk6hw5Ubxh7nD1JaHWWQ1bhvj
         kjck8IsI47LWT1Vuq+rhJG9nzvHmvekB7c/37YZFbkDKIC6kDHoMJivUvV9nKBmRhIBP
         ej0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hB8Bha1PZM8xOwTJIZ7RCODtbHr5POuJYe+THbm+qno=;
        b=cVMI/80NnxYQASncvE1LsWUfS6uK/HUVBxQy4uZODvRkavv9VS6F/FDSsazxck4EcS
         puPrf/lLxu2s1yls307stq54IK4D0xw965cZvSCfFqX1/zu/c9C8zVzzNbD58Gg6DjcR
         x88usOeI6117djiKQFHyWPx2gCijwhoy3o/5S3RzZ0yqdiaPHtzGLUNEevcUyWeEZfCv
         P2i5lA2eQrJzok+wBfaBUP/rdO47IG2DNh0ti1+JiivB2G73CrjEi/STXIWcOEHWKAWD
         Xq+ZGZ3EtmgOWRO9fCSJjph5+565+LMmxUspYYv+adYX4YVddFvbvlY0PCOytrwP7AvL
         ETCQ==
X-Gm-Message-State: AOAM530d7J09fUHHLL8dIaqj6+TMbrEyLlo54PB2oy8vVhZqxnUhdZ35
        qYiV8K3Ev+OVDs43XftvdU4JzOkl8Bgn1gkGxPss
X-Google-Smtp-Source: ABdhPJyA3esrXlfrM9CO4SFs4KfpXFPHG7HaNshkA0WTqnYdMWmYV6hkQgULLpL/LSrrKmWovrUJPBLLQpm2F+rIZK/n
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:6946:b029:12d:55f4:c9bf with
 SMTP id k6-20020a1709026946b029012d55f4c9bfmr487036plt.22.1629155183609; Mon,
 16 Aug 2021 16:06:23 -0700 (PDT)
Date:   Mon, 16 Aug 2021 16:06:20 -0700
In-Reply-To: <xmqq4kbyfkq4.fsf@gitster.g>
Message-Id: <20210816230620.3507080-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq4kbyfkq4.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH] transport: no warning if no server wait-for-done
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >>> -	if (finish_command(&child)) {
> >>> -		/*
> >>> -		 * The information that push negotiation provides is useful but
> >>> -		 * not mandatory.
> >>> -		 */
> >>> -		warning(_("push negotiation failed; proceeding anyway with push"));
> >>> -	}
> >>
> >> Perhaps like "optional ancestry negotiation failed---pushing
> >> normally" or some phrasing that assures the users that pushing
> >> without negotiation is perfectly normal?
> >
> > The question is what the user will do with this information.
> >
> > Will they contact the service provider to ask them to turn on push
> > negotiation?
> >
> > Will they turn off push negotiation because they don't want to waste a
> > round trip?
> >
> > Does what they will do depend on _why_ push negotiation failed?  If it
> > failed because the server didn't declare the capability and the user
> > has set push.negotate to true to represent "I want to live in the
> > future by using push negotiation wherever it's available", then the
> > message is noise.  If it failed due to a bug, then the message is more
> > relevant to the user --- e.g., should we use a different exit status
> > to distinguish between these two cases?
> 
> I was hoping that the "child" command being run there gives enough
> clue before the warning message so that the user would already know
> (that is where my "assures the users" primarily comes from---even we
> cannot hide that the negotiation poll has failed, the users would be
> helped by being told that it is OK).
> 
> If "child" does not give enough clue to this codepath (via the exit
> code) or to the end user (via error messages), we probably would
> want to fix that for that approach to work.

The idea of this patch is to treat it like a user wanting to use
protocol v2 - if the remote doesn't support it, then the user is
perfectly fine falling back, and any extra message would be noise
because the user wouldn't take action on it anyway.

If we think that the user needs to know when push negotiation fails (for
example, if we think "the user enabled it so the user expects it to
happen"), then I agree that we should leave the warning messages in and
also print a message saying that push is still happening anyway (which
was the approach in the original patch set), and maybe update the
message to something like Junio suggested [1] to clarify what's going
on. But I would think that the user doesn't care - for example, I could
imagine someone globally enabling it and having pushes become
automatically faster as more and more remotes support it.

[1] https://lore.kernel.org/git/xmqqh7fyfrtl.fsf@gitster.g/
