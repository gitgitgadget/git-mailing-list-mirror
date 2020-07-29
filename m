Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F825C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345E4207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="uDrZ5uWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgG2VkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:40:18 -0400
Received: from out0.migadu.com ([94.23.1.103]:41394 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2VkS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:40:18 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596058814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=ORDpPQbCERaReisAU1WWJKa+pp7mmDhJdPlIJHMiT7g=;
        b=uDrZ5uWpgOC9H/d0yb2P/J2tuBPXagYS1RSQGnD2ZgdJI96WexCEsFg/vkqXocuuEaXN1I
        Z/qR1gUVBYSdCx8jAL7pF5zi0fXlXJSOUiLCXmci7y9k9ofKZAnz5tD5Xor/ThtBX9K1Wd
        lhTDWPKJNFSt43LxFZrJV+vod/gt0C0=
Content-Type: text/plain; charset=UTF-8
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Raymond E. Pasco" <ray@ameretat.dev>,
        "Another Email" <yetanotheroneemail@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: Issue when adding new files to staged changes using interactive
 mode
Date:   Wed, 29 Jul 2020 17:30:23 -0400
Message-Id: <C4JFF5L90V54.1FQKYQPIC3O43@ziyou.local>
In-Reply-To: <C4JC6LFSAFFS.2U4ZZ9ZMO066A@ziyou.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before I continue rooting around in the source, though, I wonder if the
real issue here isn't the fact that add -p fails to support new files
(requiring the intent-to-add workaround in the first place). I have
always thought it's a confusing user experience that git add -p on a
file that isn't yet tracked simply returns "No changes".

The underlying problem may be, and I say this without intimate knowledge
of the subsystem, that we're now trying to force add-patch.c to do
something it doesn't actually support, namely new files, whereas before
it was attempting to patch what it saw as an empty file.

This (patch-adding new files) is real in my workflow; is there any
reason why git add -p with an explicit argument shouldn't attempt to add
untracked files covered by the explicit argument? (In addition to fixing
it for intent-to-adds.)
