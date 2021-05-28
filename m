Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52804C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 07:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E117610CE
	for <git@archiver.kernel.org>; Fri, 28 May 2021 07:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhE1HCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhE1HCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 03:02:33 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54348C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 00:00:58 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so2589920otk.9
        for <git@vger.kernel.org>; Fri, 28 May 2021 00:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78VcOZ+tNlT+OQ5xUTxcwTY0pyX4HxW/EiB7UUgxvSc=;
        b=RhL9/eIr93EG6nggdGNwGY9sOW893XVB7QmXjQZ+182BMAhtgCpNugt/u+NYmzcFhj
         v+C2rM/or9vW3tEuE7FOVLqCCyNqX/Efv5fXTsBrhIU3eEjT5FxrA+4MBP5HHmoFHJGU
         P/uW01TFzYPVPscF3QAhvG+172RDhsENkAZ4tcGhn2y1S7R605NBUw0LP3MgVfMGlmVR
         tuellvz4VGq3lMX/Fo7XsuFFBZwpdPM53JtVR9w1SCzhgapYqeVslZhD8oaO2vkfUsuM
         caZgveUS43DP/+cXvUnaC45QlAdEynysZU7XIMMaLuldJpfvZh/Jrv3GRPKs4NbcGgTR
         9H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78VcOZ+tNlT+OQ5xUTxcwTY0pyX4HxW/EiB7UUgxvSc=;
        b=nZhyQuSuxmS9s/GKWy0kv8/ZJFBUgCO9/Ms3ajM41GYklfdfSbg0Z96GNtEfo2JzpZ
         P8K4O3Fx3ICaC5Nn+GG3YlWgFl/+z0OiDx3RVKIG0V91FTtHGq5aGTdm8TGaVlfJReeH
         +pqxWhbiZhjdDMfEkWbWvP6r0XVqVtQgyMkwIGC/keuZkyLbpxL8X2M4YX8phyzkDEJF
         o2+sZJeD0R79bVYCIWG5M0tIEcx29LpkxbGoqUUKsSw5qQqrknMWYSTw7Z+pPY5QzM2M
         XG4bL7WcPeq1C0iOwg88sAz5ZGyRFnbjJyxfG9EN1hygSE1k35ZmHiGEZamus2lspiEQ
         6T5g==
X-Gm-Message-State: AOAM531S2wpJhkLxF60ijxEOzGOntz1jmRsLZLJy8aqeBToWqEvi/OQY
        3sJGBew+ikZKVwEtEKTBJRH4k7jnuOS0avVHup8=
X-Google-Smtp-Source: ABdhPJwdzRo4seqyhzsq01D0VdiXs6BAakyNLZ1MleVueas5rI40BMGxPdTVY2ayN2wxpKck3QsSyJq9JYtJU527/wI=
X-Received: by 2002:a9d:1b64:: with SMTP id l91mr5767720otl.316.1622185257705;
 Fri, 28 May 2021 00:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com> <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
In-Reply-To: <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 00:00:46 -0700
Message-ID: <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
Subject: Re: git push doesn't use local branch name as default
To:     Mathias Kunter <mathiaskunter@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 11:39 PM Mathias Kunter <mathiaskunter@gmail.com> wrote:
>
> Felipe,
>
> thanks for your reply.
>
> > Sounds like you want to change the default to `push.default=current`.
>
> Yes, but shouldn't `simple` pushing also work? The documentation says
> about `push.default=simple`:
>
> > When pushing to a remote that is different from the remote you normally
> > pull from, work as `current`.

Perhaps this wording should be clarified to read

When you have a remote that you normally pull from but you are pushing
to a different remote then that one, then work as 'current'.

> If there is no upstream, then there also is no "remote I normally pull
> from", and thus, according to the doc, `simple` should actually work
> like `current` in this case. Am I wrong here?

The relevant code is

    return (fetch_remote && fetch_remote != remote);

so you only get the "current" behavior when fetch_remote is non-NULL.
