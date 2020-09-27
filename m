Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF1EC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F49622207
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LbVYd+5n";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="INN4NTZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgI0UEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 16:04:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgI0UEO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 16:04:14 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 16:04:12 EDT
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 626FB83CA1;
        Sun, 27 Sep 2020 15:56:00 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BQxA+UYtCYp2VBY5yce8cavTxoY=; b=LbVYd+
        5nIZqKNv616XaXIxFQ15JIJJzFs5ozmFjc9HkCYt54HldmMBaGIxVEjQJophd7+S
        mShmhrvkDRznQAyIMUO4ElxUStCrPm1RXe5XoJmulSAPv6ExqDneRfETqsGSzQKj
        /zJJJD+Cb93B7lD/RwOHTwZXPYjYUVH0Eb8eA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56B4383CA0;
        Sun, 27 Sep 2020 15:56:00 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=XU31LI31YPI0iqXxRsmeLd/MlLP5Pl5ICmJlSNfDGTc=; b=INN4NTZ26CY7Cp/jlFo0eRA06zBATbG8z60WuxsZlp3rMHkURmOSAqbolgxvXiRxJkd0X/EwU3HNAPqin8F63H1PyYyH5PDZ62t0zQy1ntPlMXrMLjEsozDvDuAoTNKPyR1x2bbxdMwOjgdHBvdIQcyEdRtLCy3MyoDXqmHKtuw=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C140383C9F;
        Sun, 27 Sep 2020 15:55:59 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Matthew Timothy Kennerly <mtkennerly@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Differences in compound tag sorting between 2.27.0 and 2.21.0
In-Reply-To: <CAKqNo6QCa2bGF3Uj-0ewh-_O+_qTOeOFYOM2k_daXw-vGg+xVg@mail.gmail.com>
References: <CAKqNo6RJqp94uLMf8Biuo=ZvMZB9Mq6RRMrUgsLW4u1ks+mnOA@mail.gmail.com>
 <877dsffaq0.fsf@kyleam.com>
 <CAKqNo6QCa2bGF3Uj-0ewh-_O+_qTOeOFYOM2k_daXw-vGg+xVg@mail.gmail.com>
Date:   Sun, 27 Sep 2020 15:55:58 -0400
Message-ID: <871rinf0z5.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76FDE9D6-00FB-11EB-BE88-2F5D23BA3BAF-24757444!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Timothy Kennerly writes:

>> $ git tag --sort -taggerdate --sort '-*committerdate'
>
> That gives me the desired result with the annotated tag example I
> gave, but if I do the same repository setup steps with lightweight
> tags, then it inverts the order:
>
>     # Lightweight tag repo
>     $ git tag --merged HEAD --sort -taggerdate --sort '-*committerdate'
>     v0.1.0
>     v0.1.1
>     v0.2.0

Yes, that depends on annotated tags.  For lightweight tags, there's no
tag object to dereference to a commit.

> It looks like I can support both setups at once by using
> -committerdate plus -*committerdate, though:
>
>     # Annotated tag repo
>     $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
> --sort '-*committerdate'
>     v0.2.0
>     v0.1.1
>     v0.1.0
>
>     # Lightweight tag repo
>     $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
> --sort '-*committerdate'
>     v0.2.0
>     v0.1.0
>     v0.1.1
>
> It's fine for me that the order isn't exactly the same, as long as
> v0.2.0 is listed first.

For the lightweight case, v0.1.1 and v0.1.0 point to the same commit and
taggerdate has no effect because there are no tag objects, so it falls
back to sorting v0.1.0 and v0.1.1 by refname.

Given your stated goal of "[sorting] tags first by the date of the
pointed commit, then by the date of the tag creation when available", I
don't see a better solution than what you landed on.  creatordate is
nice for handling a mix of annotated and lightweight tags, but it
doesn't help in your case because you want to give precedence to the
committerdate of the commit that a tags points to.  (Also, I'm not sure
what the wider context for this sorting is, but perhaps just
--sort=-version:refname would do what you want?)

