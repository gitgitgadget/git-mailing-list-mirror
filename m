Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F8C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68742206D5
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIGKiO7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411738AbgDOTHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416871AbgDOSwe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 14:52:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E3C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 11:52:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b8so408674pfp.8
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yduVtC6rkfGsDCqg3mngKke7E7ll4iipnW5Wzg0EEgU=;
        b=CIGKiO7I2R5qbXREIWo1l7KtpaesrLl6fKh2qflVlv0ZP3o1e7haC4WOIFlUbrxzda
         l4TY5TMtCwO3fNL9VlkAi+1aeBYlUd/6gGzx5qfU1i9Orq6nSFySjtgtXDfHQCikKcts
         dNUjCy7zYOOKM+qyhLciK9xmTSEkc4sYemax5AE4MYSNIMfKZnSC+ipJ/hPKrd386+zS
         8G00oAod4JJncAhuNOVZ+7dqEiBnLSZmlhXXKI/5FxZXkJht4MSfOn8JaNGn7CbJGIUo
         NIvYHYqOz6zn41vtYYznntLadVRb0Jc6IjNIbggtsznQI655l3Wxh8mxFI6dSrlrhm/k
         7TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yduVtC6rkfGsDCqg3mngKke7E7ll4iipnW5Wzg0EEgU=;
        b=jMI11qhgMzQj1Yi+5jGOSLnm1wxqjMFTg6sGLJXXzf/5FrkZGyN1q5SwYyuQgqCWZx
         4QPL2IFxkvVnBRW9MHUO79xQh6q3uoeR4xtwzCJpLObV0fgY6qkSd1/USnQwq2rGxSbJ
         QBX+EmAXT6OPoOLSRsY96Yni9sIqKTlRS6eHmSU7Y3ZJaDdtrp1SFwuM162k6kg63qit
         DOHfu4J8iauzpzT9h3pAtfYO4EA3dWjYROYJVeFCKO+y62GbG3Z7lUsyOMclbmbYYsps
         CQKE4CQJtipUjnMH6iGKDUYZcCqmVI34gltPaoHzVbJBBBsUoH4s3RTdDAeH15GYeo0/
         6eNw==
X-Gm-Message-State: AGi0PuZq8bF+UxsOmjjIZmTA5+/10Gk+f3BpxLEDiul7f8fWx91b5i4u
        6Q0svfdn4zx2xplzV/ur9Gc=
X-Google-Smtp-Source: APiQypInHMHMDzISd9Jsl5dXCmaCIdkEWRgP1q1JG3uGoS2QZgSu6uXNWwhR+4jL3vMlsiWZs995ew==
X-Received: by 2002:a63:d46:: with SMTP id 6mr3167359pgn.434.1586976753328;
        Wed, 15 Apr 2020 11:52:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id d8sm9109287pfd.159.2020.04.15.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:52:32 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:52:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
Message-ID: <20200415185230.GA216285@google.com>
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
 <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
 <xmqq1roo947y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1roo947y.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>> On Wed, Apr 15, 2020 at 10:01:46AM +0200, Jiri Slaby wrote:

>>> I was at 8f3d9f354286 of:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>> I did git remote update today and it fetched:
>>> Receiving objects: 100% (7330823/7330823), 1.20 GiB
>>> It updated master: 8f3d9f354286..8632e9b5645b, that is 24 small commits.

I suspect this is due to negotiation differing in protocol v2: in
protocols that do not maintain server side state, we have to record
previously matched "have"s at each round and the number of additional
"have"s sent on top leads the server to have insufficient information
about what the client has.  In other words, I suspect that with
https:// in protocol v0 you would experience the same thing.

Does

	git config --global fetch.negotiationStrategy skipping

help?

Thanks,
Jonathan
