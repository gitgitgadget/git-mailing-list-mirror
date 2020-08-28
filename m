Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756C4C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE1C2078A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="dmNDS4N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgH1VqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1VqR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:46:17 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A72C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 14:46:17 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1598651169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=pzthjGHI2FE/M6LXXrINVWK+mAzC53ja8Sp09jEt0lI=;
        b=dmNDS4N7Q+RelgzYDkcz8nGQljZ2GI2ZFuEI6D/3Zo3B23AV79NS5XND2Qwc4uB0ovqaUA
        OYwUVFjPmu/Yw/Auh2mUxbg85Vx8z+wgyiGM4EZit0ChTHJgM6P6S/nT069lZr2g9FbkSj
        8eplzxCK7HcIjNuAw8TfCBrAoeXBosE=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Drew DeVault" <sir@cmpwn.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Date:   Fri, 28 Aug 2020 16:58:36 -0400
Message-Id: <C58XJ602TKUG.33AM95HQC9OZ4@ziyou.local>
In-Reply-To: <C58UKAYKF1ZY.V5LLW3DY1KAY@homura>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Aug 28, 2020 at 2:39 PM EDT, Drew DeVault wrote:
> "You can give an empty answer if you are not responding to any message"
> could confuse users, because they might think -v2 is a "response", or
> maybe they've written the patch in response to a discussion on the
> -users mailing list, or any other number of reasons. Now they have to
> figure out how to answer this prompt, even if the mailing list they're
> sending it to isn't expecting it to be a reply. I came up with a number
> of alternative wordings but they all ultimately failed to this same
> problem.

These *are* all reasons why a patch would be sent as a reply. You can
moderate your own lists however you like, but that does not mean that
patches being replies to other mails is 1) wrong or useless, or 2) not
in wide use. I wish the user experience were a bit smoother for those of
us who aren't dedicated Emacs manglers, but things like scissors lines
help a bit.

> "Legitimate" use-cases like qemu-devel or not, this is only ever going
> to confuse new users, and I think that qemu is wrong for encouraging
> users to deal with it.

qemu-devel was given by Carlo as an example of a list which does *not*
keep discussion together in threads; the example give of a list which
*does* keep things together in threads was the Git list itself (surely
the normative list for Git, if there is such a thing). It's too useful
to hackers (and presumably maintainers), I don't think anyone is going
to stop.

Looking at this in isolation from the polemics about list practices,
it's pretty clear that the way send-email prompts for things is not
logical. Axing the In-Reply-To prompt would be one way to make it
logical, because the only other prompt is the To prompt; this is removal
of a prompt users may expect, but by being so inconsistent, the software
itself already removes the prompt when I'm expecting it!

There may be other ways to make it logical, like having the appearance
of the In-Reply-To prompt depend solely on whether a message ID was
already provided or not (but since a message ID is not mandatory, it's
weird to prompt for it and not for, say, additional CCs).

Since every mail client I've ever seen has a "reply" button, I don't
think the concept of a reply is eldritch arcana that users must be
protected from. It's annoying to have to get a Message-ID and paste it,
sure. It would be nice if a mail client could do that for me (I think
dedicated Emacs manglers are insulated from this problem for that
reason). Probably whoever prompted for it in the first place just didn't
want to flub a message by leaving it out, which wouldn't be an issue for
a client command invoked as some variation on "reply all".
