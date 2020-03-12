Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA9C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4E206F2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="IHTv+E5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V10p3cZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbgCLD46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:56:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34295 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387453AbgCLD46 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 23:56:58 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5136C22182
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:56:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 11 Mar 2020 23:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=v4lmjN0k9U6dx0RJDI4SnzdhYq0ALbyi6tIOu98mZ4g=; b=IHTv+E5Gy/5y
        UrnxKJf+OuY+6Wk6sLRc8u2Hsjzk71+swiMVEZs1Y2Qk7egoMM2XBvfR9QBRFr34
        g64zo2jE0/rREqsAxgmoZiX972esZy0AnWsJLNDQ7Rpbz7iq+FFqqqgqVBMdyGJv
        qSlq9LTsxMs8qMkHzLXB7vzU1bzZq+Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=v4lmjN0k9U6dx0RJDI4SnzdhYq0ALbyi6tIOu98mZ
        4g=; b=V10p3cZAXk3A8ODpw4JTlRwSoQXZpqqt2UGMnPhhyRpJ8aSvXR9hP4Ilg
        jCgWslVWK+NZCORXe8bWQ85TtKUFBPwbOnVKMV6a3MLIHXp6440EW5eONmSDw7fQ
        2ldA497Q9IfH9qG8utZXU8O+uYr6glwbz6WU2kCwJR3EZnvryjjeUf7zdrGz+9ow
        33kXQ5YqLMhAiGVJkOR3fBFLxLpNFFwH868peYFVJeJs0TTOceak/ufwRnA8Tnf1
        SKMHJDy5JuXp+MpEBymBP/Uj9cD4+jp6PzF6zSRQ83cOTFgZ5bqo5VpERv4y3mSC
        s8h/2U0rge9U9GOb4n+vvUG8dUUrw==
X-ME-Sender: <xms:CbNpXqLojllwFBR6IXzVgsx88ZdpEiPvCzl0vh-mtPpwl33Aug_f7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:CbNpXi5oqN7pLUo1WsX2R6wDp41w0OB_hZS54gb9TVk5rlVLtj2_Og>
    <xmx:CbNpXm3O5ZgOdARvlry81WaSGd24bMLs09IEO25TMh_L75UpRmLCig>
    <xmx:CbNpXgdJ03GVtiN_mVuMMkXvcEyPn1K-sv1wTfl2CQYi8JAPaGXjAg>
    <xmx:CbNpXriEer8O8WlqoyhwBd_Wx77zo6PGH2-CsexEcjCnH5LvYI4yJA>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9126B3280059
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:56:56 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 2/17] Hooks in the future
Date:   Thu, 12 Mar 2020 14:56:53 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Emily: hooks in the config file. Sent a read only patch, but didn’t 
get much traction. Add a new header in the config file, then have prefix 
number so that security scan could be configured at system level that 
would run last, and then hook could also be configured at the project 
level.

2. Peff: Having hooks in the config would be nice. But don’t do it at 
`hooks.prereceive`, but use a subconfig like `hooks.prereceive.command` 
so it’s possible to add options later on.

3. Brian: sometimes the need to overridden, ordering works for me. For 
Git LFS it would be helpful to have a pre-push hook for LFS, and a 
different one for something else. Want flexibility about finding and 
discovering hooks.

4. Emily: if you want to specify a hook that is in the work tree, then 
it has to be configured after cloning.

5. Jonathan: It’s better to start with something low complexity as 
long as it can be extended/changed later. If there's room to tweak it 
over time then I'm not too worried about the initial version being 
perfect — we can make mistakes and learn from them. A challenge will 
be how hooks interact. Analogy to the challenges of stacked union 
filesystems and security modules in Linux. Analogy to sequence number 
allocation for unit scripts

6. CB: Declare dependencies instead of a sequence number? In theory 
independent hooks can also run in parallel.

7. Peff: Maybe that’s something to not worry about from the start. 
Like, how many hooks do you expect to run anyway.

8. Christian: At booking.com they use a lot of hooks, and they also sent 
patches to the mailing list to improve that.

9. Emily: In-tree hooks?

10. Brian: You can do `git cat-file <ref> | sh` to run a hook.

11. Brandon: Is it possible to globally to disable all hooks locally? It 
might be a security concern. Or is it something we might want to add?

12. Peff: No it’s not.
