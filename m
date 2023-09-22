Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA33CD4847
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjIVRMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVRMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:12:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF08D197
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:12:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E5A665C01A8;
        Fri, 22 Sep 2023 13:12:07 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 13:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695402727; x=1695489127; bh=er
        kZoEaEEHq5sWHORPNfHfLVsKelGalg9Dcvos/ztfU=; b=KCcucbFtV2RHG8xKee
        L7HmWus0C1n5Aryn3M4BHaBaqXVSIkBjLrU5wKmQo3OXD67aBkICnyNNfjReFvXT
        /l4iG6ykBDfQLHeSrqG8GOdIV94tuQm+vQHegMYJSfkdiIlYPKfXiAw2GUlF2Jlx
        +KHF6zplGNuj4WS/JeQd0QQq/wq6WaTE2HNcIg8ygzLbhZNnifbyjx9IND/z6PMN
        7jIZvWz0e6/Q8TDd0JJlXFl/pALTcbTasplZF0wo+3LurimiBunxH0JzUE6QF4yU
        LFIpdvjryiu7a80wplanGwhgzyt+m73+z66DHPBUC7XZImUhc4EpCJgEawn4pQ3+
        DYSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695402727; x=1695489127; bh=erkZoEaEEHq5s
        WHORPNfHfLVsKelGalg9Dcvos/ztfU=; b=Jk5q6xS0J3n4LYTwIJV5cn7gDGXlb
        NYD8XeAm7U0M0lCu22GAAWKwBc3Wn0nGP6L0di18zL2kfMFUDAfwPMoUuYUJG4SH
        nc4mldz/xW0KOH1bnnULZD9TmlTw0MslHSFV7O1tHgy9Trdz3OkCSVxledr/ea5b
        9enhV33W/USqln9bsma/Jmg+JDZ2pk8MgY8Ltz611IoLsK1KnEu2TFLZ/HDAfvY7
        XaoIgNgesxvcDJpNpIjP7E5e3THryLSOb9A6lD6BkhSrcmwjezxsfJQT/w9kCe3A
        K62zg/OcopHbquo+Fg5h27B+E3H11D9bHTzzAz0HYB18P3kutciLYCjFg==
X-ME-Sender: <xms:58oNZYup3CylgS-bcdIRzsn5xFH_e__boidIvTy23CqN-fhi5loh7_s>
    <xme:58oNZVcuYXgDey-K21ZKQRSZbXrcgn2Qi8ZQYDqynlIdx2W8yO3xFnKM6eaOsPuwP
    LiqYmrpqc1ZN-XFZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefhuedtgfeluefgleejfeduueegteehleel
    geekhfefffetgeekgfevieeutdehffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:58oNZTw9l7J-uxGa2oqUb3N86WkP6sOano1L_bwZlGbAJaEzjKu-RA>
    <xmx:58oNZbNmnKvi2fi-DJ7p0Aj7ZD43wzN9Frw88sTj1wYGM2p_gv4fDA>
    <xmx:58oNZY9QJLmVwcj-YMzEWTLu_zaEXHvvi5V4b7P7xXLLOiDrrkhkQg>
    <xmx:58oNZdFFgDrFFnwzAygiOxTGw-gJYhgI_ARiqLbYzRD6E4WJzp15Fg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9964015A0091; Fri, 22 Sep 2023 13:12:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <44a4e1e3-86d3-448a-ba6a-e78c63a6f85b@app.fastmail.com>
In-Reply-To: <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
References: <ZNffWAgldUZdpQcr@farprobe> <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
Date:   Fri, 22 Sep 2023 19:11:47 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     rsbecker@nexbridge.com, "'Ben Boeckel'" <ben.boeckel@kitware.com>,
        git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological order
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023, at 18:13, rsbecker@nexbridge.com wrote:
> On Friday, September 22, 2023 11:40 AM, Ben Boeckel wrote:
>>On Sat, Aug 12, 2023 at 15:36:56 -0400, Ben Boeckel wrote:
>>> I found an issue where `git describe` doesn't find a "closer" tag than
>>> another tag as the correct one to base the description off of. I have
>>> a reproducer, but I'll first give details of the real world issue.
>>
>>Bump. Can anyone provide guidance as to what the best solution to this might be?
>
> Can you provide details? `git describe` is sensitive to --first-parent
> and whether the tag has annotations.
> --Randall

Both of the tags (`v9.3.0.rc0` and `v9.3.0.rc1`) are annotated ones.

-- 
Kristoffer Haugsbakk
