Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF3DC433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A01D2077D
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WL++b37K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgGUXmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbgGUXmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:42:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C2C0619DB
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 16:37:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p8so226903pgj.14
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qkHssKzdwwolrduJEAZ5F3Vxxi9m5z1HmgUZwGTEV/0=;
        b=WL++b37KesuM7LLX48p9/nFECmP68s7zfHo3dpSqExsRCmtLMzL/7NS7C2lT41xK9O
         nA1aB6CLKNKuHawBeWHaGj5TEeu6Z9mA/tvJn0XilRozNKVPo5zpzbI6coZSu+mlpVHd
         GrpRuE8yO9fv6Wrg41Lu8E/sURADzycHtRhe2E6hUxPFwUcDW6PyjaUdLkekYeY8iFSn
         anjWUBqLn1J0VuAlMB/Ocr3JTYsd/4gSPYQgT2Ogacle0Fo1FDKcTNc/Fts8IYNFVDAi
         RIIlf6HhLt0OXS0JuZJIIKt+yDTNBsa7PJ+peXrD7OglO/T21d+oq6nqaGZiQ1/MuVQs
         /1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qkHssKzdwwolrduJEAZ5F3Vxxi9m5z1HmgUZwGTEV/0=;
        b=UbjUfW4vj8mm0ynVJBv2gQVQ7cGOFpICtMPHYw7Yi8qKaZRJir0y4uOH9s+T/HfLjm
         S4NC4MrjOL2SPAHGkgghkehsfuJqlXOTEDYXDzzoe5S5NRiS0cpAqYEPAKO+qxACezHo
         vLXs8QUoYgFDEtrYPSDThnHz3pYIuzkniH3xDn2CC9BVWm5/YKtT8dDIt8Hbv8d2M5ZM
         ZXdFuullTj016emzD/F430W737HM0T46S0ffeLnNB/BpJx1HUquQGdqrEnbJBup7TWBl
         HnPkuIH3GHaSW3IWj4KB17OeyehdVrGrHWG3wnhIePrMHrJhHZG5Hi8+nWoiQFCDG8sR
         tSwQ==
X-Gm-Message-State: AOAM531F/LVirEma5aKo/X/vCg0oPGCwalHKFklbAIiiQaBikFZiNbrU
        fM67p4FuHPJ9CM1CbXruKZ2Ni1l0GMPqMYiG7W90
X-Google-Smtp-Source: ABdhPJzxFabYW3tO9bzSQlTbLb/yDi35odU61yuKtc3PcR7zEu8sRXMLgx7D9DmzVAAP2ly10llUNWlkbcmaLuaWkHF2
X-Received: by 2002:a05:6a00:78a:: with SMTP id g10mr26813431pfu.0.1595374629839;
 Tue, 21 Jul 2020 16:37:09 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:37:07 -0700
In-Reply-To: <xmqqh7u07e41.fsf@gitster.c.googlers.com>
Message-Id: <20200721233707.1363438-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh7u07e41.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, sluongng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>> The optimization makes sense to me if certain
> >>> conditions are met, like...
> >>> 
> >>>  - Most of the time there is no missing object due to promisor, even
> >>>    if has_promissor_to_remote() is true;
> >>
> >> I think that optimizing for this condition makes sense - most pushes (I
> >> would think) are pushes of objects we create locally, and thus no
> >> objects are missing.
> 
> Another simple thing I missed.  Why do we specifically refer to
> "push" here?  Is this codepath in pack-objects not used or less
> often used by upload-pack (which is what serves "fetch")?  
> 
> I just wanted to make sure that we are not optimizing for "push",
> trading efficiency for "fetch" off.

Ah...that's true. For "fetch" I think it's less important because the
multiple roundtrips of the pack negotiation means that the packfiles are
usually more specific, but this optimization will help "fetch" too. I
don't think we're optimizing at the expense of "fetch" - any
improvements should benefit both similarly.
