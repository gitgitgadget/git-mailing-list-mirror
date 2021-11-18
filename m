Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B9C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A67961B73
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbhKRJcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 04:32:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50285 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243399AbhKRJcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 04:32:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ECC5E37D5;
        Thu, 18 Nov 2021 04:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=exI/1ugmxEt/wLAdPQWIdrFr6D/v0f9nL2+zvqhIL+0=; b=tbOg
        X71B8iFyIt+vyb2N3RWP8Ewpz+KEcx/0/VF9ShQh7jRVE23+NXx95EME5N6z4gEr
        CNfS+1rAJQ9xco3V33+RCxPwcDFxscbfpDuGHNMCzgyG22YYcCoj1qCCjc9gfQON
        zDmr2OJ6hwqWMlSRKHSc/PVAnEWGs+xyKC2a3Zk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 559E3E37D4;
        Thu, 18 Nov 2021 04:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C051AE37D2;
        Thu, 18 Nov 2021 04:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Junio C Hamano <junio@pobox.com>
Cc:     ebiederm@xmission.com (Eric W. Biederman),
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [GIT PULL] per signal_struct coredumps
References: <878ry512iv.fsf@disp2133>
        <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
        <871r3uy2vw.fsf@disp2133>
        <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
        <xmqqbl2nmemx.fsf@gitster.g>
        <87pmr2k68f.fsf@email.froward.int.ebiederm.org>
        <xmqq8rxobj1k.fsf@gitster.g>
Date:   Thu, 18 Nov 2021 01:29:08 -0800
Message-ID: <xmqqk0h5yfq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBF0C9C6-4851-11EC-A9CB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junio@pobox.com> writes:

>                               Y--- (Linus's tree)
>                              / Linus pulls from subsystem maintainer
>       \   \       \   \     /
>     ---x---x---M---x---x---N (Subsystem maintainer's tree)
>               /           /
>              /           /
>   ...---o---o---p---p---p (Your tree)
>
> The above picture only depicts two topics, one directly building on
> top of the other, from you, but that is simplified merely for
> illustration purposes.  The real history may have more topics, some
> are dependent on others, while some are independent.
>
> Now, if you have many related but more or less independent topic
> branches that will support a larger theme, it would be quite natural
> if you acted as your own "subsystem" maintainer, in other words, in
> ...
> and offer 'N' as the tip of a "larger" topic that has internal
> structure, not just a single strand of pearls, by adding a signed
> tag on 'N' and throwing a pull request at Linus (or whoever is
> immediately above your level).
> 
> Is that what happened (as I said, I lack context)?  If so, I do not
> see much problem in the situation.  But this assumes that these so
> called "fake" merges are merging into right first parents.

Addendum.

If you have only one topic (i.e. you do not have o-o and p-p-p in
the above picture, but just o-o), then it would be quite strange to
create M and offer it to the upstream, as M's first parent, as well
as the bottom of the o-o chain, would be something the upstream has
and the merge would look redundant from upstream's point of view, as
they will be creating another merge of their tip and M, at which
point they'd rather merge the topmost commit in the o-o chain
directly without having to deal with M.

