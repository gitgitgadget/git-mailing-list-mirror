Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BDC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 20:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjAWUNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 15:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjAWUNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 15:13:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C452B632
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 12:13:34 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r18so9851274pgr.12
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AS2WVpfcXOSBCa8Agx1sOU/1pske4EbK3DIdQoMZRg=;
        b=FVvNjzZr8rn+fH4GH52uYM1AQA9mM3fxlNdAP3r51Ak6CZCkR62AitMQylW2UfoiTz
         jfAS5p9ODR/aYbX/gu2xiu9NTbbkmS1u8fR1XxGd8RI0zUgEey7dNRMImLozq06hRqL1
         M5jbBH2n9jx6wl8Q+kiGv0+cLNQa7+104Z7l0DyL700puk4rZU94Nel8ixqsghDOCKQJ
         HgSv6NDgR3QWTJATBbZJu5kBcNeGL2ngAtGJ4E8eZOy9YoVH1s04ilEURESZdRhL+Hp2
         Q+uC+t7Lyy3VKNRQW1LwTLtTGbFkfFJNea3IxxnGyZM52eBx1L/4sKCj6Brdu8ihXXGG
         /gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8AS2WVpfcXOSBCa8Agx1sOU/1pske4EbK3DIdQoMZRg=;
        b=O5OpfFkk6i8IxFzHU+zV8gzAGNj3QS8PI9ZGiQ4BSRkHane2HNZ7+j75SKCRtB03q4
         O+MbR1k9HPCpI9tda00vT0W/NfTp8SbXg20+oEDs+5SwDkWtMUfNGJQ3njiat1jb6PNO
         hNyotPd5Lx8cBEyAfK58yu3Avr40wOMw8BdMzThfZCtpKwz8n69XHkuMroVgPOoLNSEJ
         pSyAcE/+f1JPWO2oHknSsPukIMq8vNmMTGuCR9At4Ps5j3F2PBDoGXgBLN5Ae/fpPg8J
         XgpEpKW88RtanzeeltXGFAOe1I+Y46FHdpuPC82w6jxt4HxVyEu64YFXfIx6NwlbzF2H
         Qocw==
X-Gm-Message-State: AFqh2krcA1RhMIy1pis748p2rTs1ad6yBns96qIw7uzU1zP9LA8g7Zkf
        AlmOKsfJ2kdavHx67Wj0Zxmz6mMRZ8o=
X-Google-Smtp-Source: AMrXdXvQSg1Ch1hzvHlhQKjJ/lgMccRWhSZtLnam2SkTZVNYZFeFBz+kG/H8BKq4C8zJP9hqIhPRJg==
X-Received: by 2002:a05:6a00:1d23:b0:589:6338:9650 with SMTP id a35-20020a056a001d2300b0058963389650mr24109462pfx.5.1674504813884;
        Mon, 23 Jan 2023 12:13:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id bv15-20020a056a00414f00b0058e1b55391esm6877188pfb.178.2023.01.23.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:13:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
Date:   Mon, 23 Jan 2023 12:13:33 -0800
In-Reply-To: <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com> (Derrick
        Stolee's message of "Mon, 23 Jan 2023 13:24:26 -0500")
Message-ID: <xmqqilgxm2ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> We are specifically removing the requirement that the objects are
> reachable from refs, we still check that the objects are in the
> object store. Thus, we can only be in a bad state afterwards if
> the required objects for a bundle were in the object store,
> previously unreachable, and one of these two things happened:
>
> 1. Some objects reachable from those required commits were already
>    missing in the repository (so the repo's object store was broken
>    but only for some unreachable objects).

A repository having some unreachable objects floating in the object
store is not corrupt.  As long as all the objects reachable from refs
are connected, that is a perfectly sane state.

But allowing unbundling with the sanity check loosened WILL corrupt
it, at the moment you point some objects from the bundle with refs.

> I think we should trust the repository to not be in the first state,

So, I think this line of thought is simply mistaken.

>> I am OK as long as we check the assumption holds true at the end;
>> this looks like a good optimization.
>  
> So are you recommending that we verify all objects reachable from
> the new refs/bundles/* are present after unbundling?

Making sure that prerequisites are connected will reduce the span of
the DAG we would need to verify.  After unbundling all bundles, but
before updating the refs to point at the tips in the bundles, if we
can make sure that these prerequisite objects named in the bundles
are reachable from the tips recorded in the bundles, while stopping
the traversal at the tips of original refs (remember: we have only
updated objects in the object store, but haven't updated the refs from
the bundles), that would allow us to make sure that the updates to
refs proposed by the bundles will not corrupt the repository.

