Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47CC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 03:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BD2224D4
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 03:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgLIDXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 22:23:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63070 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLIDXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 22:23:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DDCDFA01C;
        Tue,  8 Dec 2020 22:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qMg/M+kZz5Nfa/uqhZ5UYhu3YYM=; b=ntq0zg
        Gb4e+Rxt0kG76V4yFHAZmn8WS/dwxzDCajTftNZQvt7KLLUCtJOPXoVlanhmN0J+
        HPIbSBQw/mpL6XhbUfhAtG1njNxO7boTkXVCpwdmpOLPNUGCTV8txK/GkAA0NTTo
        IfDYmTYN8byoMtrVS84eVF6OyS+1/e1BrYlec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kewGsc9uzC+YYgZRvUJfUge8Vo1pno8Y
        SlbQHI8o/aYl4+NrcvwFWxC8r4Py1nTi2Fpz/LmbpPkIq8jBMs/0zeC+zbbEQcTR
        RBD0y+3VfHeiEBkLpqiJpA3EhrK5oYn2frg8IEbCNa8++jnARiBxbThDIEEIkxE0
        +wM8AFk/jYw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25F6CFA01B;
        Tue,  8 Dec 2020 22:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D37BFA01A;
        Tue,  8 Dec 2020 22:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
Date:   Tue, 08 Dec 2020 19:22:31 -0800
In-Reply-To: <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 19:06:43 -0800")
Message-ID: <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6FF6184-39CD-11EB-9681-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ...  As I said, I'm not sure why
> anyone would ever want to see diffs for merges and not for normal
> commits, the closest useful thing I can imagine is commit messages +
> diffs for just merges, stripping the normal commits.

If I can run "git log --some-options master..next" (or more
realistically, over the range ko/next..next) to get individual
commits (without patch) and merges (only when --cc gives some
interesting nearby-changes), I would be very happy.  But is there a
set of options that lets me do so?

