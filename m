Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452FBCD4847
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjIVRf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIVRf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:35:28 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAFBB
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:35:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 857485C01CA;
        Fri, 22 Sep 2023 13:35:22 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 13:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695404122; x=1695490522; bh=gB
        +c3GmgC/tJ0rmrf3A9egnqT4T8e2P9iDzvQQyg5HM=; b=t5aUTQQRh1F1nbThyS
        fzvkJzVK5jpk5nj4oGwFChJg5nsSmxfl7tJVb1z6xi93hN6RKuNi9kjrWCkizFJA
        pFGoYgMDTJiIZI+QwwKxu/QRS5uHtTJYxJqehL3M7F7oueojqm5zekpodAzP/TN2
        H6BSGs3W4Pow9Ng1IWdfTw/j40AuNHACat4kkEocR12JtO+SxmVrcXpqeBRSsFNi
        pysVbCHuJAQf6Dt0pbKT54bgK3C3p9xx37ccfG1u5YBl3Tm92FdEP2vcVrsdqRkw
        T3o0KKCTcdGFDGUTfhm50aM6AaN1KBwcCUSN3LEbnwv6gs+gLD2vCHNo02JvuHye
        xbNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695404122; x=1695490522; bh=gB+c3GmgC/tJ0
        rmrf3A9egnqT4T8e2P9iDzvQQyg5HM=; b=Dmn3Wn3zkZbNB5uim/pwuhCgyBsDy
        fONsvk3lnE601KQpvg3psqzmf3p1ArFm31aWjGnNqAyciy640gsGp4TB/kphjnfx
        v7Z9L1UVqXmgfZ5/4JngydRx8GGTETMlrjMcTQ5iFns0PCHZuAZ+80zO8tERDyOV
        8XQKHKUtEnn0IgDQDyz4rUjDnM3wn08deAtbWmOufnyOvgEEZXzvFaGUsefKJD6r
        cDcqfbEuBLA3/XuXfXlKnjSbVuJ/xSWBI5XSvpq5nX30k/5LupfZYLi8Hgh4vq5J
        ZxHQZQOaqzyO5l7ldmiPpHfFQMJ7vzpWq7TsaQJ95k69QtNsQa5cOjLew==
X-ME-Sender: <xms:WtANZSbJSYYclhDmp4-e8Uf8U8iHxWG_QMpAGy1vCSiXTnSxIxzpS5A>
    <xme:WtANZVblICNuV81h69qeAmbeI5IuE-ZsWqVaQw0EeYaSpc-DRiEKksM803y30JPQC
    Jsaf15nJ9f1uctKWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpedvhfetveekheetgefhudefgefhueeiheeg
    leffheeujeetheefvefgffeltdegheenucffohhmrghinhepphhusghlihgtqdhinhgsoh
    igrdhorhhgpdhsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgv
X-ME-Proxy: <xmx:WtANZc9BtXnQ9ihpXJ3g9B1A5xYQ9VqG44iMFfopJ0HaIxLZ0d_8oQ>
    <xmx:WtANZUprBB3m13zHNFHsqxqgP5SW-WOFaj4TRHMalxq_u5BnwdgOWA>
    <xmx:WtANZdruwaMqjSlLSe43ytMgHkxxhPs9g5Q-f7Zis-RBOz2qgyGYtg>
    <xmx:WtANZfEs4PSrjGN1eMQHOKbvSQhmZcM_pKrRfImJufAX6q4lNKdbew>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2528215A0091; Fri, 22 Sep 2023 13:35:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <8f034aa3-67ac-456c-a754-b0a86666bcdb@app.fastmail.com>
In-Reply-To: <ZQ21NsLmp+xQU5g+@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe> <ZQ21NsLmp+xQU5g+@farprobe>
Date:   Fri, 22 Sep 2023 19:35:01 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "'Ben Boeckel'" <ben.boeckel@kitware.com>, git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological order
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks related:

Link: https://public-inbox.org/git/CABPp-BH2zuYe87xhjdp5v7M7i+EfEgLHAZgwfzJUAxGk1CFgfA@mail.gmail.com/
Message-ID: CABPp-BH2zuYe87xhjdp5v7M7i+EfEgLHAZgwfzJUAxGk1CFgfA@mail.gmail.com
Via: https://stackoverflow.com/questions/72886894/git-describe-is-not-returning-the-expected-tag

-- 
Kristoffer Haugsbakk
