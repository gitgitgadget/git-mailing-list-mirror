Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1AC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972F8206F2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="Ht4YRMlX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miu0sJlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgCLD5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:57:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59115 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387453AbgCLD5e (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 23:57:34 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CE3F4215B2
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:57:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 11 Mar 2020 23:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=VmNntVW9MJ4acIi3Z32vz2KUCcHZsISpETajifW9BwA=; b=Ht4YRMlXPEAk
        jA0iCFkv1MXCzm3vkhYHSCoVLm/FE+i4ibfi2HQFodcYdJ7ddU5qxycoGpg/dZMn
        SmYb1sfW3PtUOSsymq8tpmKHBdAE6q1071tdwN/ZNS1bOesKVa3pPWVJiJeA4gfY
        zawnQMphhZumOZyOzslOpWig8NDa0/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=VmNntVW9MJ4acIi3Z32vz2KUCcHZsISpETajifW9B
        wA=; b=miu0sJlTWmAgVf6XM1SMC61jMg+H0YMZEUEwiYmmULF55q/Omz0UGvuvl
        9HaMGi8UAR1pUYaF3rIJaZ9Hyt4fwZbzFDfpg57zmSOCa3VdLKa5p0mOd6cvAgjK
        PsLnpbfnkiur5fRZ7zo33fPxKyO6eBxlGADoduLPbYX5kcOpRLpCg2eJN4yR7LMK
        ahOP94TPNTCVOjE2OU2PfXkPnkNvForlZTxtDXQNbu4Ilh/XJBdvu6NEs8S/O7sa
        AltnvmDlZ0coNRpa6Q3WY7fh0sUp+NxZhd957XZDUte1q9egrczEzDsabnvuPF7g
        MWlzeQz8yK25If/UTpVrKJ+pDsMdA==
X-ME-Sender: <xms:LbNpXtIxhOSRVxoh7QcdNW__YnNSEWJ6-yngOoktUytB59KUFz5JQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:LbNpXmu-5wVt4SoLjqdV9fEIyVrDzVQRYPmuX92_3rnYHd-CTUEqyA>
    <xmx:LbNpXsKjE5yqKV0CpJbfgeeASE4hOhIHyM_hHCM3Jehp30aTOFipEA>
    <xmx:LbNpXv_ZCZTdGmL1GXyCWsW_C4fDo9K00xp50FHhjldxVuhIZrR2nw>
    <xmx:LbNpXhq_DRAW0wRgiKnnhJ55LRB0r-1FOBQjHwjXr-4bDUXGB3RQPQ>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 123AF3280060
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:57:32 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 3/17] Obliterate
Date:   Thu, 12 Mar 2020 14:57:24 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Jonathan N: sometimes people accidentally add a big file they don’t 
need. Have to use BFG and it’s a pain. Next time, maybe you just deal 
with it and ignore. This happened to Chrome. Some huge blob that was in 
the repo, should no longer be in the repo, but don’t want to rewrite 
the history. Other use cases are confidential information, like 
password, credit card number etc. Initial reactions: it’s already out 
there, rotate. Second reaction: if it’s a toxic blob it needs to be 
removed everywhere! What if someone taught kernel repo to

2. James: I’ve been in a lot of meetings with customers where they 
mentioned it’s not possible to rotate the information that was leaked 
into the repo

3. Demetr: How far back do we allow to go to obliterate?

4. Jonathan N: there are indeed horrible real-world examples where 
things to be obliterated are from a long time ago.

5. James: real cost to changing object ids: Git and tools interacting 
with it really assume that history is immutable.

6. Elijah: replace refs helps, but not supported by hosts like GitHub 
etc

     a. Stolee: breaks commit graph because of generation numbers.
     b. Replace refs for blobs, then special packfile, there were edge 
cases.

7. Demetr: Backward compatibility, wouldn’t custom handling be 
problematic for old clients.

8. Jeff H: can we introduce a new type of object -- a "revoked blob" if 
you will that burns the original one but also holds the original SHA in 
the ODB ??

9. Peff: what would this mean for signatures? New opportunity to forge 
signatures.

10. Jonathan N: if a new entity, this means you’ve changed the content 
which we want to avoid. Maybe a list of revoked blobs. If fsck notices 
missing, it should be happy. Protocol support, if someone tries to 
include a patch with it, just ignore it. Not great. Improvement would be 
to send a list of things I deliberately didn’t send. Could also 
communicate blobs to be deleted, but ignore that for v1. Learn from 
Mercurial who have a very complicated signed revocation mechanism.

11. Brian: the remote can’t be trusted, ala leftpad maintainer could 
do something malicious causing repo to become invalid.

12. Jonathan N: main scenario I’m considering is trusted company 
remote.

13. Terry: partial clone and solve large files. Maybe the server could 
handle it by converting normal clone into partial, and then handle the 
error if someone asks for that blob.

14. Jakub: one idea would simply be to treat this as a missing blob in a 
partial clone

15. Michael Haggerty: does this only apply to blobs? (Peff: no, commit 
messages can contain sensitive information; Johannes: trees contain file 
names which also can contain sensitive information)

16. Jonathan N: partial clone is not a solution for the desire to get 
rid of the blob on the server side.
