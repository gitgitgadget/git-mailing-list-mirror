Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB3C20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 03:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbdDQD4S (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 23:56:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932330AbdDQD4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 23:56:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C3808C23A;
        Sun, 16 Apr 2017 23:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QiY+7lyDTatP
        mYKpld55hH7LJbM=; b=i/9Z+NVam+ySRABexQOE7EAd3hNqzjYSAfLQQJYoHTFU
        GL0rMOUysVuDKMX9RRRQ6Qm9hbB1OJJzjwdmONd6Z4AUndUkeCWbAnaf2nyhyvvL
        ZI9nVMVRY7yiBdMsyvHzTW3GtDEciYQ7IJ87pOsHf1mDuEu7Iy2OT9rFXoo1VxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=F4Y+ph
        AtfWhAPRy1gbgWWC9JEu35S4F8JAic5uSJt0Fd5CHHYZUUfScVwo35+i9nD8eGo5
        DmcN6fUEiD7Xog7ObNv7s4XLA675ZHlXbb7rTiA/b+sqyxUagubsgZo8eCxlFNgD
        l9CVvWrqoQwz4DUVgvaMCAxk2/g7rL22dlp7o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22AD58C239;
        Sun, 16 Apr 2017 23:56:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 750C88C238;
        Sun, 16 Apr 2017 23:56:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] push: document & test --force-with-lease with multiple remotes
References: <487622bf-00d0-e4fc-4a74-08e18d59336a@gmail.com>
        <20170408114100.13743-1-avarab@gmail.com>
Date:   Sun, 16 Apr 2017 20:56:13 -0700
In-Reply-To: <20170408114100.13743-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 8 Apr 2017 11:41:00 +0000")
Message-ID: <xmqqinm3k7qa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD6E8278-2321-11E7-B1F1-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Document & test for cases where there are two remotes pointing to the
> same URL, and a background fetch & subsequent `git push
> --force-with-lease` shouldn't clobber un-updated references we haven't
> fetched.
>
> Some editors like Microsoft's VSC have a feature to auto-fetch in the
> background, this bypasses the protections offered by
> --force-with-lease as noted in the documentation being added here.

That sounds like an unfortunate mix of two "feature"s that are
mutually incompatible.  Perhaps those who thought auto-fetch was a
good idea didn't think through the implications, and also it is
understandable that those who never thought auto-fetch was a good
idea would want --force-with-lease to default to the remote-tracking
branch.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 1624a35888..2f2e9c078b 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -210,6 +210,43 @@ or we do not even have to have such a remote-track=
ing branch when
>  this form is used).  If `<expect>` is the empty string, then the named=
 ref
>  must not already exist.
>  +
> +This option interacts very badly with anything that implicitly runs
> +`git fetch` on the remote to be pushed to in the background. The

This description is not accurate.  Only those who do not to specify
what is expected and instead use the remote-tracking branch are
affected (but these random "git fetch" clobbering the
remote-tracking branch is sort of known and expected).

I do not think I would mind if these two new lines were added one
paragraph above, i.e. where "--force-with-lease=3D<refname>" form is
described.  It clearly says "... as the remote-tracking branch we
have for them." and that is the best place to say "This option
interacts badly".
