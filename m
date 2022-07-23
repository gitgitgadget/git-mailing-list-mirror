Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07CC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 18:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiGWSTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiGWSTP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 14:19:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01B1A83B
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 11:19:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 037A51459E3;
        Sat, 23 Jul 2022 14:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zIUrHFaNZigTidcRp5BIZUVSIUPSOHkIhC4NfT
        EjmgY=; b=eKA124GplygL5mBtCnrFpjQbFUjnccvVQH9/oph55ztz7lNT5w+eu6
        +yqhzRwPcRdTSbCoigGs0ilKuvJwbH0jagbRxwsFqCw/RMlYo2IBxOlPBfZfqSXW
        yFRpSy3k/3MX9Oom6EVJQYb3x6pyfqSpawotaII/9gWcKPj6zVcbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF1D81459E2;
        Sat, 23 Jul 2022 14:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21D4F1459E1;
        Sat, 23 Jul 2022 14:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Yuri Kanivetsky <yuri.kanivetsky@gmail.com>, git@vger.kernel.org
Subject: Re: Dropbox and "Your local changes to the following files would be
 overwritten by merge"
References: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
        <YtwH7pOnDgv+MYmh@tapette.crustytoothpaste.net>
        <xmqqczdvaegs.fsf@gitster.g>
Date:   Sat, 23 Jul 2022 11:19:12 -0700
In-Reply-To: <xmqqczdvaegs.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        23 Jul 2022 11:09:07 -0700")
Message-ID: <xmqq7d43adzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F43EE1D4-0AB3-11ED-94EB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> E.g. after finished working at a site, prepare to take the "latest"
> to the next place you will work at in a bundle,
>
>     $ git bundle create 2022-07-23.bndl --all HEAD
>     $ mv 2022-07-23.bndl $my_dropbox_directory/.
>
> and when you get to the next place to work at, you'd "fetch" from it
> into the repository you keep, or you can choose *NOT* to maintain
> any local copy there at all and "git clone" from the bundle every
> time you restart at a different place.

A practical real-world solution would certainly involve keeping
reasonably fresh copies of repositories at each work location, and
"git fetch --mirror" into it from the bundle.  The "bundle create"
command would most likely have some bottom revisions to reduce the
size of the resulting bundle files, i.e. if you know that all copies
of repositories you'd work with surely have the version you tagged
"v53.8" a few weeks ago, then the "bundle create" command may have
"--not v53.8" at the end.

In other words, the above is *NOT* meant to be a full solution, but
merely to illustrate a possible direction to go in.


