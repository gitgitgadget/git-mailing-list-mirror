Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7602FC55178
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064552074B
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbjibdSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKESpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKESpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 13:45:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5839C0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 10:45:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g7so1730166pfc.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=H7TPbQa+iNHz/pcAEboTsPACfKNn/cMmUnncj3iOO94=;
        b=TbjibdSg4MVbINS4G7tCBw9ofhUPzrh77zS6lQisl2/DaXOD28LguL3GmIBMSZatAL
         mHoEG38XC4LY291pANxoBILn/BQrha0ZaA10P1TdDyKUH1TLrpUKdiUenfE+ego1RtTw
         tc+huIgr/Zbb4oNNJ/IOqbQ+Jxd7foSzf4suOC6bhamNPd6hU0YZMbdDR2coH9R46QdI
         kryI37njdPRLPUlnauaqjOYcWOSZRWvprPhYjvUHvqeU3U47nxYLtwjVIIO6eVhhaaN5
         ajIpxvs0UhZfOHgt7rS4Ff0tVXIGUh8E0BqIoQUTlG9qDT8RJi88hQ6m5y5QngAmFZhC
         W0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=H7TPbQa+iNHz/pcAEboTsPACfKNn/cMmUnncj3iOO94=;
        b=YYNAYkR0f0Dj5jAbBH9+QRroTIU/Dhv4s7/L/4Os28j0OKg8qEzKO4dIB1wCkp+b8V
         0CRRZNL1H8r6a0fhwTtiypfFma+T8cx0gohL/fVj5E5UVzCbb3Vgi16n2COrFabfUD2K
         5vzoYJBIp5TeMkvpqqgtsC/PwQjHIXH+rDmeLpMb+P9LnB1Z64Uduktle/EJt1g6QYq+
         nrCUivuAWSrBVUrAVPmtfRFL22JwcoAqLeNUceU420HRqfIr5qlrsYMt1Z63aQygz3Vv
         xw/rbqjd8nBKcbDnK9LWvMTQVJqItNiDTaVliy2eGbKTewb0ACvZCOApSbBsGE0EYAd+
         SUNw==
X-Gm-Message-State: AOAM530iTzg/gPNAYMuKW3VTZhFPqVzeH6ajyhhyqVY8EQZ/8rfKxxeZ
        G0wlrcM96ZIq3xC2AaU8/4XPTRZfQvXpaQ==
X-Google-Smtp-Source: ABdhPJw3QE1V7b/gQ9/PYMnODplfR+aZ5u6BV7M+xN3nmwH67LfZBtnfX4hKVLVzdFRHpp1KMabCPA==
X-Received: by 2002:a62:ee06:0:b029:164:20d:183b with SMTP id e6-20020a62ee060000b0290164020d183bmr3867386pfi.4.1604601902141;
        Thu, 05 Nov 2020 10:45:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id u24sm3327132pfn.205.2020.11.05.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:45:00 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:44:55 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 04/11] upload-pack: advertise trace2 SID in v0
 capabilities
Message-ID: <20201105184455.GA36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <4912af5f2b949b9944b37843a9ebabdd33e66215.1604355792.git.steadmon@google.com>
 <xmqqwnz2p0wo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnz2p0wo.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.03 13:48, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > When trace2 is enabled and trace2.advertiseSID is true, advertise
> > upload-pack's trace2 session ID via the new trace2-sid capability.
> 
> I would have imagined when advertiseSID is enabled, trace2, at least
> the part that allocates and assigns the session ID, ought to be
> enabled automatically.
> 
> But the above goes in a different direction and requires both to be
> enabled.  Any compelling reason behind the choice?

My reasoning was that by advertising the capability, you are telling the
remote side "I have definitely produced a log using this session ID. If
you need it later, you can find it with this key". If we advertise a
session ID even when trace2 is not enabled, the remote side can't be as
sure that the received session ID actually points to any useful logs on
the other side.

Of course, this is a weak guarantee since a client could send whatever
it likes regardless of whether anything was logged, or one side could
delete or lose its logs before the other decides it needs to view them.

I think your idea in a different subthread about having a general
session ID not tied to trace2 is interesting, and would also be a point
in favor of changing the current behavior here, but I have some thoughts
on that point that I'll add in the other subthread.

I'm still leaning towards advertising a session ID only if we actually
produced logs locally, but I'm open to further discussion.

> Does the documentation added by this series make it clear that
> asking for advertiseSID does NOT automatically enable allocation of
> session IDs (even if it does not explain why it does not happen)?

In V3 I'll update the docs to call out whichever decision we reach on
this point.

> Thanks.
> 
> 
