Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B1CD484C
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 18:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjIVSmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjIVSl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 14:41:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9234180
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:41:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-774105e8c37so125142685a.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695408087; x=1696012887; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnB70STvs1KfR8kdcEd86egCAJ1NGDfQgWA6WwyMWzM=;
        b=uHoUGF823e20EKFfZRgtcuMDCbX+4h9DqXGh4ZzzZHPUyqeIcVI3t6C20lIueAjiu/
         D+MCNJ9dLHeFPV/pSpfaF6Xu+wsQaL9Bw3Wmj0+v8dhdN47vXvhilHM6sWLUsDx81FP+
         02GCm42KdppHwHANevqI/rrSvB0rXBqtButEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408087; x=1696012887;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnB70STvs1KfR8kdcEd86egCAJ1NGDfQgWA6WwyMWzM=;
        b=krA1LJSXJZoCXlySKQ+5sKFA//fuKYUOkq3GlFYoLJgfbHKDsAtEJXzEvFKTEhamiP
         s4uNXrFhlwcTpHx9wH+GuWlvnh0OQw5t0I72oBm6uyAVuS2L+WfX8aI8owD26seRYl48
         g9wve14OtL9ysE91NgM7pKiM50pu1EkVO8yPR2kVf5DpDykC8Z0Ox14On9Y0JdlxMEet
         mjNHyNFmUnCPkAZ56xkbcpkE6GnfMY8grPpzf0OFjEiQvSyYSqwCE8Tcs9kP4FrwDvsN
         ZTT7iGmzshOeJOCm7fG6Iz2vdyeJ8aIlF8QQqk1VdZ+on0n+oMgQTK3IchmWdg65UGm4
         hTRg==
X-Gm-Message-State: AOJu0YwGDPxCaoBw9P/ZvgqSZg2nRyEYTheR8Gb5RlYOyuOzAu/2rE1o
        6ztEqmy7M7189ITa7O7BC72emGvPjQS7dhS5Tb/zKA==
X-Google-Smtp-Source: AGHT+IHrIiDmTr/e3vVbjTTJLPytdGqxQ0x84pxuwUqCXPcMu76SPJoSs44Y5O/S2UXQoNz1+nV1nw==
X-Received: by 2002:a05:620a:2454:b0:772:45f0:501e with SMTP id h20-20020a05620a245400b0077245f0501emr339255qkn.25.1695408087025;
        Fri, 22 Sep 2023 11:41:27 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id 27-20020a05620a079b00b00767b24f68edsm1622524qka.62.2023.09.22.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:41:26 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:41:24 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ3f1OZBGbOegVva@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
 <xmqqediq2j0g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqediq2j0g.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:51:59 -0700, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > There appears to be a merge at 446120fd88 which brings v9.3.0.rc0 closer to HEAD than v9.3.0.rc1.
> 
> I didn't look at the actual graph but let me say I trust you ;-)
> 
> I wonder if there should be an obvious "explain why you gave this
> name" mode added to the command, though.  The command should be able
> to say "The closest path from HEAD to any tag is via this, that, and
> that commit, which is N hops to tag T0", and from there, the user
> should be able to say "Oh, I thought T1 was closer, let me try again
> to describe HEAD, limiting the candidate only to T1" and run the
> command in that mode, which should be able to say "The closest path
> from HEAD to any tag that is allowed as a candidate is via these
> commits, which is M hops to tag T1".  And if M is smaller than N,
> then that may deserve to trigger a bug report (but as you said,
> there are rules like preferring annotated over unannotated tags
> involved, so it may not as straight-forward as comparing the two
> integer hop counts).

The thing is that the count is what is wrong here, so the determination
of what is "closer" is wrong. Any explanation would say things like
"commit X~10 is not part of X".

--Ben
