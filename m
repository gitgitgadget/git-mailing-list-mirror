Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA6EC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E9922273
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 20:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbhADUsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 15:48:39 -0500
Received: from ciao.gmane.io ([116.202.254.214]:46766 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbhADUsj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 15:48:39 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kwWli-0000R6-85
        for git@vger.kernel.org; Mon, 04 Jan 2021 21:47:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [BUG] Destructive access to an "objects/info/alternates" repository
Date:   Mon, 04 Jan 2021 15:47:53 -0500
Message-ID: <jwvlfd81le8.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
        <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
        <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20201229154403.xutnk2aoawdrjfwx@chatter.i7.local>
        <jwv1rf26k9n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20210104135410.myjaygaulqnxcnsc@chatter.i7.local>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:p6iKIC1gkjtw6iQn5dBpI2Ada0Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev [2021-01-04 08:54:10] wrote:
> I would guess that this is happening in builtin/gc.c#686 [1], where it calls
> clean_pack_garbage(). Running "git count-objects -v" shows:
>
> $ git count-objects -v
> warning: no corresponding .pack:
> /tmp/test/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx
> warning: no corresponding .pack:
> /tmp/test/nongnu/.git/objects/pack/pack-5fe14feff49ccdee5469af9dc94f6784e8464a6b.idx
> count: 0
> size: 0
> in-pack: 0
> packs: 0
> size-pack: 0
> prune-packable: 0
> garbage: 2
> size-garbage: 6573
> alternate: /tmp/test/nongnu/.git/objects

Ah, that'd make sense, yes.

> I agree with Stefan that this is undesired behaviour, even when it only
> happens when attempting to clean up garbage -- git-gc (and git-count-objects)
> should distinguish between garbage in the parent repository and its own
> repository and not attempt any modification of the parent repository during
> gc or any other operation.

Great, so IIUC:
- this is a harmless warning
- it's considered as a bug
- so my use case should work fine in practice and is not considered as
  "too weird to be supported"
Thank you,


        Stefan

