Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E226C001DC
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 15:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjGLPE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjGLPEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 11:04:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A461BC6
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:04:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DE9B32B89;
        Wed, 12 Jul 2023 11:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QbAZVPXilBiOZqYXdyKXAoQNdqO4c9XKtaKucU
        /CS1c=; b=B3QXQ8XsU9gwJv2PDWnvahUJmhMLG4dwY+yJzjRRSOU6v5lvAGl8gD
        AKfTXs6lgXvRIeAoLIX2J9ZYDCTVmnQHnO7mxcfdarZQ9FIC2ftxyNklmTljyvJ9
        SYoLr37WdoCxiTcDyBIV93Bmpwrr117D/Zd9Ux+9P8USkiDW62hAw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 862BD32B88;
        Wed, 12 Jul 2023 11:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F3E632B86;
        Wed, 12 Jul 2023 11:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Soref <jsoref@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [rebase] `fatal: cannot force update the branch ... checkout
 out at ...` is confusing when it isn't active
References: <CACZqfqAB7zyn56+NOL=E8Y3bXNiQnJdmVXgzsnj78C-Anw-h2Q@mail.gmail.com>
Date:   Wed, 12 Jul 2023 08:04:42 -0700
In-Reply-To: <CACZqfqAB7zyn56+NOL=E8Y3bXNiQnJdmVXgzsnj78C-Anw-h2Q@mail.gmail.com>
        (Josh Soref's message of "Tue, 11 Jul 2023 20:45:54 -0400")
Message-ID: <xmqqbkghw4qd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F2A9ADC-20C5-11EE-AB9A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

> Consider this series of unfortunate commands:
> ```sh
> % (cd $(mktemp -d); git init; (touch a; git add a; git commit -m a;
> touch b; git add b; git commit -m b; git bisect start; git branch next
> HEAD~; git checkout next ) 2>/dev/null >/dev/null; git log --oneline
> -1 HEAD; git branch -f main HEAD;)
> Initialized empty Git repository in
> /private/var/folders/r3/n29fz25x72x191fdv6mhhr3m0000gp/T/tmp.fGD64HAf/.git/
> accc238 (HEAD -> next) a
> fatal: cannot force update the branch 'main' checked out at
> '/private/var/folders/r3/n29fz25x72x191fdv6mhhr3m0000gp/T/tmp.fGD64HAf'
> ```
>
> It's true git in the repository does have a pin of sorts for the
> `main` branch and that `git-rebase` would be very upset if the
> branch's location were changed, but as an end user, the `main` branch
> is not checked out, the `next` branch is checked out.

Fair enough.  Perhaps "cannot force update the branch 'main' in use"
would alleviate the confusion?

