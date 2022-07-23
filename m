Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82EC43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiGWSJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGWSJO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 14:09:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3EA14001
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 11:09:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38DC4192A45;
        Sat, 23 Jul 2022 14:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oznmsUFR0xXdShGQz+h06OxzFba3eDAN+qSwC2
        kMViM=; b=tsWPOLIi723VREako4bKqPz8vocdqGyjtvFN6nU9cOZxTDsy2wD8e8
        Ybf2/3tkVIxO2lUwB++GUUGZQJulteVxmzXwTaZ1DLkbWww+8c4cbcwubNGjlLet
        KXc4xTdVkKsG4AltOjd341pE4qkKFvnUuePXT5U36bOJ6TLJq8qlw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 267FB192A44;
        Sat, 23 Jul 2022 14:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB3FB192A42;
        Sat, 23 Jul 2022 14:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Yuri Kanivetsky <yuri.kanivetsky@gmail.com>, git@vger.kernel.org
Subject: Re: Dropbox and "Your local changes to the following files would be
 overwritten by merge"
References: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
        <YtwH7pOnDgv+MYmh@tapette.crustytoothpaste.net>
Date:   Sat, 23 Jul 2022 11:09:07 -0700
In-Reply-To: <YtwH7pOnDgv+MYmh@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 23 Jul 2022 14:38:38 +0000")
Message-ID: <xmqqczdvaegs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C03610E-0AB2-11ED-8460-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It's known that Dropbox and other cloud syncing services can corrupt
> repositories.  They can cause files to be removed, renamed, or reappear
> after being deleted, and I suspect that's what's happening here.
> ...
> I'd recommend moving the data out of the Dropbox repository regardless,
> since, as I mentioned, it is known to cause corruption, and you won't
> know it until it's too late.  You may want to additionally run "git
> fsck" to see if that finds any problems other than dangling objects.

An anticipated follow-up question is "but then how do I replicate
the repository across my machines? that is the reason why I have it
in Dropbox in the first place", and the above is a hard-to-follow
advice until it has a good answer.

E.g. after finished working at a site, prepare to take the "latest"
to the next place you will work at in a bundle,

    $ git bundle create 2022-07-23.bndl --all HEAD
    $ mv 2022-07-23.bndl $my_dropbox_directory/.

and when you get to the next place to work at, you'd "fetch" from it
into the repository you keep, or you can choose *NOT* to maintain
any local copy there at all and "git clone" from the bundle every
time you restart at a different place.






