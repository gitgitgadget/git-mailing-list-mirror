Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE19DC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E01E64F85
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCKUoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 15:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCKUoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 15:44:12 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3BC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 12:44:11 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:57150)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1lKSA8-0000qf-GQ; Thu, 11 Mar 2021 15:44:04 -0500
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:47459)
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <tsdh@gnu.org>)
        id 1lKSA7-0007UT-65; Thu, 11 Mar 2021 15:44:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id A7C8C27C005A;
        Thu, 11 Mar 2021 15:44:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Mar 2021 15:44:02 -0500
X-ME-Sender: <xms:EoFKYCsL28v0m81eY5f3J_UgaZ7cIl8KSkQWZ8ZwQs-b1WbZQkKhWA>
    <xme:EoFKYHd_5nVmAoTr_MKNvjqnslG9MEss8DGPIV-mfce3cNBe3C2S7oxSSyfNhcHew
    pI9WcUhcd-dMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvtddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepfefgjeeuueevvefghfduheethffhgfefveefve
    ekgffhvedtjeeghefftdeftddtnecuffhomhgrihhnpeigkhgtugdrtghomhenucfkphep
    geeirdektddrjeehrddvfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepthhhohhrnhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqkeeijeefkeejkeegqdeifeehvdelkedqthhsughhpeepghhnuhdrohhrghesfhgrsh
    htmhgrihhlrdhfmh
X-ME-Proxy: <xmx:EoFKYNyHvfRo1TbEIWU-jWeDZ8uw8kgKeE_DXf9OBMnNupd3yrXNWA>
    <xmx:EoFKYNPsdciq0fkvKJhq78Bg0lJ5hz6W02KPb2NHTlwq7BwEsue2eA>
    <xmx:EoFKYC8sw9VweJsQ1VCZ_Q3EBHcWbGa5RWHAhrnbIGvPJ2teAr0FjA>
    <xmx:EoFKYDKK2CA7Irv6gtUf4hkjfK9-9A23J_VRE6G8C3mYGLWpxfreZcysHMM>
Received: from thinkpad-t440p (p2e504be7.dip0.t-ipconnect.de [46.80.75.231])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF6101080067;
        Thu, 11 Mar 2021 15:44:01 -0500 (EST)
References: <875z1xwznd.fsf@gnu.org> <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
User-agent: mu4e 1.5.9; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] Stashing during merge loses MERGING state
Date:   Thu, 11 Mar 2021 21:31:09 +0100
In-reply-to: <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
Message-ID: <87a6r9o1yo.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

Hi Jeff,

>> What did you expect to happen? (Expected behavior)
>> 
>> I expected that stashing during a merge will keep the MERGING state.
>
> Thanks for providing a clear recipe and expectation. However, I think
> Git is working here as intended. The MERGE_HEAD file (which is how "git
> status", the prompt, etc figure out that we're in the middle of a merge)
> is cleaned up when stash runs "git reset --hard" under the hood.
>
> However, I don't think we would want to _not_ clear that file. The
> conflicted merge placed some changes into the index and working tree
> representing what happened on the branch you're merging in. Then
> making the stash (and the reset of the working tree) removes those
> changes. If we were to leave MERGE_HEAD in place and you ran "git
> commit", then it would create a merge commit that claims to have
> incorporated everything from the other branch, but has quietly dropped
> those changes as part of the merge resolution.

Yes, that makes sense.

>> Or that popping the stash again would also restore the MERGING state.
>
> This would make more sense: the stash records that part of the state,
> and then we make it available again later when the stash is applied.
> However, that feature doesn't exist yet.

Too bad.

> I can't offhand think of a reason it couldn't be implemented. It's
> possible that it would mess with somebody else's workflow (e.g., they
> think it's useful to stash some changes independent of the merging
> state, and then apply it later, perhaps while replaying the same or a
> similar merge). So it might need to be tied to a command-line option
> or similar.

Everything breakes someones workflow [1], so an option would be fine.

However, I'd suggest to protect users shooting in their foot with a
warning and confirmation query for the time being.  I consider myself a
quite experienced git user but this stash trouble today came totally
unexpected.  And I've asked on #git@irc.freenode.net and got no answer
which is totally uncommon.  So I guess that this stash during merge
thing is pretty much a gray area.

Bye,
Tassilo

[1] https://xkcd.com/1172/
