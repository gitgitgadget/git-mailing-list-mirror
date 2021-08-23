Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA7C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852EB6103D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhHWIX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhHWIX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 04:23:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9BFC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Y71zjWSag65OmwoHKlHdtnNfKL2qkXG25TFU4eHVkp4=;
        t=1629706994; x=1630916594; b=g1YCvbu2AtIk1T85hGTRSyk29hP+eFkeh1pq1EZcprE6rdQ
        2fplOjLf7YdfMgsj4VZT3oioW1fgUS4tYMANYuozeNGgfqrzcIzRKw+iVSeGHvHMs5GQJxofILvkQ
        qO0VtVnnWhDRoE3cT/IZnaBanvE9OXGZp3FVOIucO2feB7eDb6hOQmbyqMbfK0mlTnzNsc2FgEd5C
        Jz9DgxN3gyHvpOu8/VA1yO+DQ0dvkTAvbqEZ17kyRv3cl6cgPkp/pzNrdAnh32jOPoQhs+M5nFozJ
        72J1yjNsbqIM4HaTS5mEyK6tRCH6vkzHBAI+CWXpQV/TcAaK4e8jB1eYd1NYZOWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI5Ed-00Elb0-7A; Mon, 23 Aug 2021 10:23:11 +0200
Message-ID: <3505a827a42096938746691acf4b1a2f5bf9d04f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] multi-pack-index: allow operating without pack files
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, bup-list@googlegroups.com
Date:   Mon, 23 Aug 2021 10:23:10 +0200
In-Reply-To: <YSMenndGYr14okwv@nand.local>
References: <20210820195558.44275-1-johannes@sipsolutions.net>
         <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
         <YSMenndGYr14okwv@nand.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-08-23 at 00:05 -0400, Taylor Blau wrote:
> 
> We're going to run into problems much earlier than that, though: the
> MIDX needs to load information about objects from packs in order to
> break ties when multiple copies of the same object exist in multiple
> packs (according to that pack's mtime).

Huh, I guess I never ran into a need - we make sure in bup that each
object only exists once, that's kind of the point :)

I guess we could break ties by "lower hash of the pack" instead of
"mtime"? It doesn't really matter how they're broken, as long as it's
consistent?

Arguably, mtime is not a good measure anyway, since the same repo
elsewhere would have different mtimes.

> So I'm not sure how we would even write a MIDX without physical packs on
> disk that we can open and stat, let along how we would teach Git to
> handle a situation where packs that did exist when writing a MIDX went
> away when we tried to read from the same MIDX later on.

It handles that just fine on the read side.

johannes

