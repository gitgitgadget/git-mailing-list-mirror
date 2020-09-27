Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D112C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 16:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F01820663
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IuhyKUO+";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="RSOkRkt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgI0Qdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 12:33:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61083 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0Qdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 12:33:51 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 12:33:49 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7261FE4AAC;
        Sun, 27 Sep 2020 12:25:32 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=x3EG4EtLxHhX5W8ZP2AEfeNYZ4E=; b=IuhyKU
        O+A+XGSVdH8CAhAYxqVsA0rVVex28r/tNCuoj7L4PtrjtefWCkhATf0kbEwwFqxT
        wOCEMAMdfWoQvkcGrMCb3fWUhR+NlMWirnA0jqXvTIFFtW8hYgaoC8apJzNlWf3Q
        u3TtG70eMO6IpDknjgO/M7WxmJ5QVhYhWFplk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AF92E4AAB;
        Sun, 27 Sep 2020 12:25:32 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=E/p4jqams8YgsjhGPDyV+9wWsC6Ze2rm3r3Erzk7uG4=; b=RSOkRkt2kjQ/HBSxgs9hMaVEF9wQIQGCj7e+LUkDI0wVNYAa6OJ/SWcJd19mR05GO3+x2M9eZYsGRyyC1fKdtGweJrwUs6QuHEU9kspEAsaheSLKhMnuqGMLCl1dNQVWKU4gH9cKIeUxNSlxLciB6tI+bNbIy8hOFKXQkRseEcU=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D77E7E4AAA;
        Sun, 27 Sep 2020 12:25:29 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Matthew Timothy Kennerly <mtkennerly@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Differences in compound tag sorting between 2.27.0 and 2.21.0
In-Reply-To: <CAKqNo6RJqp94uLMf8Biuo=ZvMZB9Mq6RRMrUgsLW4u1ks+mnOA@mail.gmail.com>
References: <CAKqNo6RJqp94uLMf8Biuo=ZvMZB9Mq6RRMrUgsLW4u1ks+mnOA@mail.gmail.com>
Date:   Sun, 27 Sep 2020 12:25:27 -0400
Message-ID: <877dsffaq0.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EFA5D46-00DE-11EB-BB37-F0EA2EB3C613-24757444!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Timothy Kennerly writes:

> Hello,
>
> I've run into a difference in the results for a compound tag sort
> between 2.21.0 and 2.27.0 (I believe also applies to 2.28.0), and I'm
> not sure if it's an intentional difference or if there's still some
> way to achieve the old behavior with newer Git versions. For
> reference, I'm using Windows.

This sounds like it's probably related to the fix in 7c5045fc18
(ref-filter: apply fallback refname sort only after all user sorts,
2020-05-03).  That was part of the 2.27.0 release.  Let's see if that
explains what you're seeing.

> I need to sort tags first by the date of the pointed commit, then by
> the date of the tag creation when available (I understand that
> lightweight tags don't store their creation date, so multiple
> lightweight tags on a single commit may not sort consistently). Let me
> give a concrete example.
>
> Given a repository with this setup, using annotated tags:
>
> git init
> echo hi > foo.txt
> git add .
> git commit -m "first"
> git tag v0.1.0 -m "A"
> echo bye > foo.txt
> git add .
> git commit -m "second"
> git tag v0.2.0 -m "B"
> git tag v0.1.1 HEAD~1 -m "C"
>
> I get the desired sort results in 2.21.0:
>
> $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
> v0.2.0
> v0.1.1
> v0.1.0

As far as I understand, committerdate should have no effect on annotated
tags (i.e. it's always a tie).  So I'd guess that you're just happening
to see the sorting you expect due the inappropriate refname fallback
described in 7c5045fc18:

  This worked correctly for a single "--sort" option, but not for multiple
  ones. We'd break any ties in the first key with the refname and never
  evaluate the second key at all.

> However, in 2.27.0, the first listed tag is the tag that was most
> recently created, rather than the one pointing to the newest commit:
>
>
> $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
> v0.1.1
> v0.2.0
> v0.1.0

Based on the description above, I think the second key (-taggerdate) is
now coming into play.

> If this is intentional, how can I achieve the desired sort order in
> newer versions of Git?

Try using * to refer to the commit that the tag points to:

    $ git tag --sort -taggerdate --sort '-*committerdate'
