Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9C81F731
	for <e@80x24.org>; Thu,  8 Aug 2019 22:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404681AbfHHWeF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 18:34:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56881 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404581AbfHHWeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 18:34:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61FA483C96;
        Thu,  8 Aug 2019 18:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sCwkmJ8LTos0IxEsk4BXY5Gt6A8=; b=XNJO0i
        6FrGL1jdC/9kDaWK/A8iN9aXU0xmFe+Qvp0hOEmh4GEBwtm83H0bJUGT1o7+B5bF
        TeV/X/emaRTwdVXTpf8xZaOg/LjbpOl+iYdk3uABiRbOvRoxH2ekTJaQhFWJORaa
        V2fdnMBqAfqI3ogdioV69K9P5RwXbCOu5fNgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oWOW9PWAw+IZLXZI8X4WbHHhfS24L5eK
        v4LN1pvk4TPmS1vq3PI/vtM+n/LxtWi+f2S/WGY2j/Hs4seS7dI+kbKmCbdeOS33
        lhmYMc4ryqf5/Nn4p5/3DcXK3JFYProRZSi3rzxbYMaxQWFMTcca38Ur6Crf7pBH
        emuRQq91sFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B6AA83C95;
        Thu,  8 Aug 2019 18:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81A5783C92;
        Thu,  8 Aug 2019 18:34:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Rushakoff <mark@influxdata.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible to unshallow or deepen based on local objects?
References: <CALxJwdP70PpcJKFC3FRm5t58yjxz438WwYisuFwQsJ2oaXV_9A@mail.gmail.com>
        <CALxJwdM0ifKoQDMXJuuWyeXdR9-oxVpOyODBO0TXcz=d+0vq2Q@mail.gmail.com>
Date:   Thu, 08 Aug 2019 15:33:58 -0700
In-Reply-To: <CALxJwdM0ifKoQDMXJuuWyeXdR9-oxVpOyODBO0TXcz=d+0vq2Q@mail.gmail.com>
        (Mark Rushakoff's message of "Thu, 8 Aug 2019 15:17:43 -0700")
Message-ID: <xmqqftmbe17t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E1BEAD4-BA2C-11E9-9D73-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Rushakoff <mark@influxdata.com> writes:

> I have a shallow clone of a repository. Then sometime later, I obtain a bundle
> containing full history.
>
> I thought I could use git fetch --unshallow /path/to/repo.bundle
> mybranch:mybranch, but I've found that git does not support shallow fetches
> from a bundle and that unshallow is actually an alias for --depth=2147483647 in
> 4dcb167fc3 (fetch: add --unshallow for turning shallow repo into complete one,
> 2013-01-11).
>
> If I do a plain fetch from the bundle, I can manually modify .git/shallow to
> "unshallow" my repository like the previous email in this thread. But what I
> think I still want here is a way to tell git "here are all the objects I have;
> update the shallow boundaries accordingly."

It sounds like a quite sensible request to me.  

Offhand, I do not think of anything that would make it fundamentally
impossible to allow us to first add objects to the .git/objects
directory by whatever means available to you (including, but not
limited to, exploding the object data from a full bundle) and then
to tell Git to see if there (still) are missing commits and objects
that ought to exist but don't that necessitates the repository to be
marked "shallow", and adjust the boundary.

I however do not think there is such a code already written X-<.
