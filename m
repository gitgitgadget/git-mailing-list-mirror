Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8FC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 04:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22304206E2
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 04:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cIxM4Yly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgFOEpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 00:45:39 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:47881 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgFOEpj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 00:45:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 9F3A1489;
        Mon, 15 Jun 2020 00:45:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Jun 2020 00:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OK7opA
        VWUZZ2MLaC/jJ5wAPqqP949ehZlhgonaO7rQ0=; b=cIxM4YlyIHKEdaQO/+pfRP
        G9jjYv9zDyGkFPu8hS3H+l7zgRrlmYaROeDhsqw82oguhWdYSXKGv/Oc+jUxkK0h
        RBAx6V18+nFDrn1xZEBfb8RkxWgmtpQi9d2ZLdFrM8SWtShRiI6HPQk8r6mBy26d
        EcAmfs8HOfiHYyZRHmO8NufoMBThZ0bM6UQPevzUdrsuG2eUf5YHfFGtmMO0ZW4C
        1QOYqrrDjdGM9uSOC5JzwcqtMsJ382NEpf+TbUqFDICA+rpa7Lo+LYRi0cNQea7W
        RCGhQ2OFr5uYVC9aM71UwPyJDF1Zt/8nfCEGf7FvMKhRbiiha3kuHnq5Jp7xDBlQ
        ==
X-ME-Sender: <xms:8PzmXvcsU-MriDoMI0YKyjZEyyuqQ_fRok-h_BH-YRV-zCyvJ8yBtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeijedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepfdflrdcu
    rfgruhhlucftvggvugdfuceophhrvggvugesshhighhkihhllhdrtghomheqnecuggftrf
    grthhtvghrnhepjefgvdffueeghfelvdelgeduieetvdefgeeuheefueegffejuefgkedu
    teehvddvnecuffhomhgrihhnpehmrghrtgdrihhnfhhopdhjphgruhhlrhgvvggurdgtoh
    hmnecukfhppeeiledrudekuddrfeegrddvfeegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhrvggvugesshhighhkihhllhdrtghomh
X-ME-Proxy: <xmx:8PzmXlMrenIEBphvhy7XaDUE5QQf1lOLXzkilDlC6F3vDT45f5IeAw>
    <xmx:8PzmXohc1WIZp9jOuvlh3vPwsgpzPcIm4RmYuKYfVzU8-QXW49zZUA>
    <xmx:8PzmXg8CPki-SrndOIb8gJ2v82nHRUS2qcsRZtbkOKyv4J89Br-qxA>
    <xmx:8fzmXsnVv_-n5ccXGPBOLJ0WkD_SoEkm6Qkr_r0qAZefab41TbCQI6SJ8Y0>
Received: from sigkill.com (c-69-181-34-234.hsd1.ca.comcast.net [69.181.34.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id E41973280063;
        Mon, 15 Jun 2020 00:45:34 -0400 (EDT)
Date:   Sun, 14 Jun 2020 21:45:33 -0700
From:   "J. Paul Reed" <preed@sigkill.com>
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Don Goodman-Wilson <don@goodman-wilson.com>,
        =?iso-8859-1?Q?S=E9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, philipoakley@iee.email,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        newren@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200615044533.GA24311@sigkill.com>
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
 <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
 <CAH5451n7e39ZCM4iJ4Ry=g7QkVYwFL-a=9CTVOifp+rcvb5i_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5451n7e39ZCM4iJ4Ry=g7QkVYwFL-a=9CTVOifp+rcvb5i_g@mail.gmail.com>
User-Agent: Mutt/1.13.5 (2020-03-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Heya Andrew... turns out I read this list too, so... thanks for referencin'
all my work!

Some thoughts inline:

On 15 Jun 2020 at 13:52:50, Andrew Ardill arranged the bits on my disk to say:

[SNIP]

> Even if git borrowed 'master' from BitKeeper AND BitKeeper used it in
> a "Master and Slave" fashion, that doesn't mean that the person
> introducing it to git was using it in a "Master and Slave" fashion,

https://marc.info/?l=git&m=111968031816936&w=2

https://marc.info/?l=git&m=111634468526506&w=2

Oops.

> It's just as likely that the 'master' usage was common in the industry

Do you have any specific references to, specifically, common usage in the
industry, at that time?

> My conclusion?
> 
> Of all the usages of master in BitKeeper, the overwhelming majority of
> them are of the "Master Copy" variant, consistent with how I and many
> other people I have seen comment understand gits usage of the term
> master.

See above.

> To reiterate my point at the top - I believe this information is
> irrelevant when deciding what git should do now, and my preference
> would be to have no default at all.

Cool. Sounds like we mostly agree...

-p
-- 
J. Paul Reed
https://jpaulreed.com
PGP: 0xDF8708F8

