Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A60C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6627160EFE
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhJXUh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 16:37:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54383 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhJXUh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 16:37:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F832104B8D;
        Sun, 24 Oct 2021 16:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KZNwvDgs1vm6QrZmwPizle11w+V8X/4Y3lXbMK
        4pSJg=; b=NhuD+7qdfqmlshQQA0oLbbuECgl0eiFfDUwtnwA7zlhBvYVNX2nGES
        rqqcVRBXVM9hgDuAkchWHrlVQ84Xeg6bF8Ouu7h1kE1Abxk5YWotporGyabhWOkA
        xQwCWCKF0oqTo72rNQjnenvVdh0hmX9Epte3y5J6DduXpZN9XVUoc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80313104B8C;
        Sun, 24 Oct 2021 16:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8938C104B8B;
        Sun, 24 Oct 2021 16:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marco Beck <mbeck@eaddrinuse.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
Date:   Sun, 24 Oct 2021 13:35:04 -0700
In-Reply-To: <20211024193625.148-1-mbeck@eaddrinuse.net> (Marco Beck's message
        of "Sun, 24 Oct 2021 21:36:25 +0200")
Message-ID: <xmqqsfwq40w7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF26CF12-3509-11EC-8261-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marco Beck <mbeck@eaddrinuse.net> writes:

> This allows selecting the gpg(1) key id to use for signing by setting the
> environment variable GIT_GPG_SIGNINGKEY.

Can you explain why we want to add another way to specify the key?
It appears to me that user.signingkey is an adequate "set it once,
forget it, and keep using it" way to do so.  "I cannot write to the
config file" is unlikely, as the user must be capable of writing
into the repository to sign in the first place.

Is the driving motivation "I want to sign under a different identity
from the one the repository specifies in its local configuration"?
Wouldn't that be covered with a single-shot configuration syntax:

    $ git -c user.signingkey=mbeck@eaddrinuse.net tag -s ...

Unless there is a good reason to (and these days there aren't that
many), we prefer not to add new environment variables like this.

Thanks.
