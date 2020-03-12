Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CDC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C04206F2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="cwAigg3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhaRqZTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgCLEO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:14:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47625 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgCLEO3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:14:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 95494220CA
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:14:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=9J64zS+E3V4LMpdEWB+FInlstW72Xe+IKOfY1zL9tyI=; b=cwAigg3Px10B
        9MpktYAHH+rW4BtA4XVipYDj14yOPB0isuzp5jQh+2dafsyH/7PSqK2tXMWhMkln
        mGhFEYyxsMpnsbaudkpHPLCZymJvkVpc0AuvdMIgg2CUX3ZJW1iTgLfWfYy+YZ0W
        I99/vozcdxLonXXgF/RFHKD8xf1jIeE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=9J64zS+E3V4LMpdEWB+FInlstW72Xe+IKOfY1zL9t
        yI=; b=ZhaRqZTZ4q0Mppze+S9c85VJJGzU/BjViuhea6MHbej3Y+qth4FbrnXjh
        DInpeoYfn8vnxpf+kKdM3kLL7urap7EOAX+dizesB3GYNScoMdPT3ZC/KhgFwzJg
        8jNu6bjvxi9fu8QsVZGdRYRM/xU5z+7pkx6Y87LjiNc08vIzjCDwEVhRH4YwhQqC
        cWOQZ+T1RxZsx01WyZNxc41EktgYAtOa3D2vUfk+ujkRpzQZUt0XUXkX4u7mrOz8
        Iiz6WtMy7ybSLhCjjOlhHFsknGfI6fMROoh3jJF7wJXU2UBEv7tCGNf7Bfv5yuwu
        vv2B7FYpVNsGGIK0EwpXmL63bHdOQ==
X-ME-Sender: <xms:JLdpXpbA4qQYJvAzApuUZ0u-WYq9lyC3ZsfPO2IQoWk9VJDYfObKwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:JLdpXlrN2Zq_YttFf1yR8-vdupOfh854UPYrLcY7sskU5F9v4hvgLw>
    <xmx:JLdpXtrqxtCtNwXK8ZZBUXqzA1p4cjOqOnit-agOitfa7n7Ejf-OQg>
    <xmx:JLdpXv3Q8lx6LyR50Nl4wuBr0FV0Aq8TXJoUdlqjaF20bccFXbGfBA>
    <xmx:JLdpXvpV5ZWKZLhgKdh7jS8KM5F8d4pFsdFPaYuJEhPtTWTj0gz9pA>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3EA030611FB
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:14:27 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 16/17] =?utf-8?q?=E2=80=9CI?= want a
 =?utf-8?q?reviewer=E2=80=9D?=
Date:   Thu, 12 Mar 2020 15:14:25 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Jonathan N: An experience some folks have is, sending a patch and 
hearing nothing. That must mean patch is awesome. But then realize I 
need to do something to get a review. In Git, people like Peff are good 
about responding to newcomers. As an author it can be hard to excite 
people enough to review your patch. Relatedly, you might get a review, 
but it doesn’t give you the feedback you wanted. As a reviewer, you 
want to help people to grow and make progress quickly, but it might not 
be easy to identify patches where this will be possible.

2. Emily: A few months ago we started doing code review book club. Git 
devel IRC, and mailing list, could we be more public about these? I 
queue my patch to list of things that have been idle and needs a review, 
then a bot pops something off the list to increase attention for people 
to review?

3. Jonathan Tan: during book club we discuss and review together. 
Everyone can benefit from review experience and expertise. Emily is 
hoping for similar knowledge transfer in the IRC channel.

4. Brian: general case that patches don’t get lost. There is the git 
context script, but I am now a reviewer because I have touched 
everything for SHA256. But we are losing patches and bug reports because 
things get missed. What tool would we use? How would we do it?

5. Jonathan N: patchwork exists, need to learn how to use it :)

6. Peff: this is all possible on the mailing list. I see things that 
look interesting, and have a to do folder. If someone replies, I’ll 
take it off the list. Once a week go through all the items. I like the 
book club idea, instead of it being ad hoc, or by me, a group of a few 
people review the list in the queue. You might want to use a separate 
tool, like IRC, but it would be good to have it bring it back to the 
mailing list as a summary. Public inbox could be better, but someone 
needs to write it. Maybe nerd snipe Eric?

7. Stolee: not just about doing reviews, but training reviewers.
