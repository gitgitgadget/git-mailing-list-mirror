Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A00C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 17:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB33206B5
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kTt9Vn1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgHIR6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:58:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61444 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHIR6U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 13:58:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2A9EDEF40;
        Sun,  9 Aug 2020 13:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5y0yV7Bhwu9hfKfXkmPlDzsYlN4=; b=kTt9Vn
        1JevqgmN3eO1z87jNG5TjrAk4m2pHKWMbHTntgL6xapUhFZitMiwPDo8sBtWskhg
        HAIYpQalxi0+z7l6LuHixKapQy6KxF4iVylkij0ji/yze3iJrMoNULPO9zmU8wgp
        oGvmRt8bgAdIV2XXHIB6svBg5SwezqCBfaCC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mrUkQRlsk8k9NTMD6kKz5/QzQplkvGQq
        BEVbtYJuZKKqz8NZdXIBjy7GvF6noE1wjehGrqmRlhP1RQ5K5zYXYiNnClGzKWkm
        OYfPZzCxvxlqKNv6LvzOUI1e1InOKHiitwiShtFi1QH2L55XU6uGFmh1ycsszsH+
        S23r9bl+POk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEB9FDEF3E;
        Sun,  9 Aug 2020 13:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F271BDEF3C;
        Sun,  9 Aug 2020 13:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
References: <C4RQMTXM9R7C.1WK5637SFISUU@ziyou.local>
Date:   Sun, 09 Aug 2020 10:58:14 -0700
In-Reply-To: <C4RQMTXM9R7C.1WK5637SFISUU@ziyou.local> (Raymond E. Pasco's
        message of "Sat, 08 Aug 2020 11:58:56 -0400")
Message-ID: <xmqqlfinem6h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E66585C6-DA69-11EA-B89B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> On Sat Aug 8, 2020 at 11:48 AM EDT, Phillip Wood wrote:
>> If I've understood correctly an i-t-a entry in the index combined with
>> nothing in the worktree is a deletion and that is why we don't want
>> --index to succeed when applying a creation patch? If so an expanded
>> explanation in the commit message to this patch would help rather than
>> just saying 'by definition'. I'm still a bit confused as we don't count
>> it as a deletion when using --cached or applying to the worktree.
>
> Nothing that complicated - --index requires that the index and worktree
> be identical, and nothing that can possibly be in a worktree is
> identical to an i-t-a entry.
>
>> > --check goes through all the same code,
>>
>> The same code as --cached or --index? (I assume it's the former but
>> wanted to be sure)
>
> "--cached --check" goes through the same code paths as "--cached",
> "--cached --index" goes through the same code paths as "--index",
> "--check" goes through the same code paths as [no options]. The option
> just makes it skip the part where it writes things out.

Well explained.  Thanks.
