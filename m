Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E4DC433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiAZVvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:51:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54785 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiAZVvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:51:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F08911E30C;
        Wed, 26 Jan 2022 16:51:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L63TLHE4H+Fml5+6UA1dUKBII2ZARH1/uDZyr6
        eKwFg=; b=Gp4n6zQdlayUwxbFYj4e60NIb+WVO+prT6FkEgDLRpUYervq1TGj5s
        0gygU+SYHTAQLjA37+eYMxnWvgqjnZvqvgPE5hUQ9UUbkp/kejK/ht4di+aAAt9U
        y6Tn1B3mhoQUW3KH34+YCsRtjxRLYFKxYUE9C6cnXHAgmMKJ+Sziw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 519B311E30B;
        Wed, 26 Jan 2022 16:51:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01FCF11E309;
        Wed, 26 Jan 2022 16:51:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: support unusual remote ref configurations
References: <20220124180909.2437002-1-jonathantanmy@google.com>
Date:   Wed, 26 Jan 2022 13:51:04 -0800
In-Reply-To: <20220124180909.2437002-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 24 Jan 2022 10:09:09 -0800")
Message-ID: <xmqqwnimp3nb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1034A91C-7EF2-11EC-8268-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning a branchless and tagless but not refless remote using
> protocol v0 or v1, Git calls transport_fetch_refs() with an empty ref
> list. This makes the clone fail with the message "remote transport
> reported error".

Despite what the title says, I do not think this would be so
"unusual".  To a freshly created repository, if you added a remote
or two, fetched from them, but haven't created a commit of your own
(or forked from these remotes) yet, you'd have no refs in heads/ and
tags/ but refs in refs/remotes/.

2.35 would fail as expected with "remote transport reported error"
in such a situation.  With your fix, it creates an empty repository
with expected fetch refspec.

Which looks good.

