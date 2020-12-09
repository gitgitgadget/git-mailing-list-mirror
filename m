Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF6BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 05:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8140023B23
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 05:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLIFY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 00:24:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54143 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLIFY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 00:24:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8B70FAC8B;
        Wed,  9 Dec 2020 00:24:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+ocFDVpInctnQb9d3SvC3flGFw=; b=vrzWYw
        xumbzWGyJ5jWHHUwzUP3YGDhMgBKEK+q4KjoFesGJfjp5Hi/fE5Jjq/gOHszGER4
        GmoTwytso81eJJKGzsM+gC96gHtsr8Y5ukrhzMLPnggiqwBxfg/uprmhpL2XZluA
        AQNv/2UGjBlrNtaLvJAvBiGxje6KlAH2B86Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O1JozVD95hZzYw4s1rKNVq2tU4WYWQ4P
        AAOoCju2cfGixBFFlyickrNL5IB1lJYpeZ9KLhp/wqUcnJNwnkSSsFQDnmqFuvd+
        sbDwuY7r+ujMh0cFLP2A1aVlVXehHKfbynR3YzK1ycmgHIoFlnNPIj3K/3JI9QYB
        KMlm+YkJmNQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C248AFAC8A;
        Wed,  9 Dec 2020 00:24:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0ED9EFAC89;
        Wed,  9 Dec 2020 00:24:11 -0500 (EST)
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
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
Date:   Tue, 08 Dec 2020 21:24:10 -0800
In-Reply-To: <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 20:54:31 -0800")
Message-ID: <xmqqtusv362t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C54F2C32-39DE-11EB-AFCC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> It does not mean that I do not like the current behaviour that
>> "--cc" always implies "-p"; it is convenient.  It's just I find the
>> lack of feature slightly less than ideal, but I do not care deeply
>> enough to design how to express such a feature from the command
>> line.
>
> Okay, thanks for clarifying.  It sounds like you were focusing on the
> tangentially related comment I made (diffs for merges and not for
> normal commits) while I was focusing on Sergey's question (should we
> revert --cc implies -p).  I was having a hard time understanding if
> you were answering his question or not.  This last paragraph of yours
> acknowledges the question, though you still avoid answering it.  :-)

I do like the current behaviour that "--cc" always implies "-p"; it
is convenient.  I just wish there were a way to say "enable -p only
for merges" while taking advantage of the convenience.

So, no we should not stop "--cc" or "-c" implying "-p".

When the end-user gives "-m" on the command line of either "show" or
"log", it cleanly means the user is interested in "individual"
patches shown for each parent when showing a merge commit, so "-p"
implied by "-m" would make sense just as much as "-p" implied by
"--cc".  The same comment about the lack of "want -p to be implied
but only for merges" as an add-on feature applies here, though.

I suspect that the real reason why "-m" does not imply "-p" was
merely a historical implementation detail (e.g. imagine that we
wanted *not* to show things by default in a subcommand in "log"
family, but when "-p" is used, wanted it to mean "-m -p", or
something like that.  Setting "-m" on by default without explicitly
given from the command line, and making sure that m-bit does not
imply "-p", would be an easy-to-implement such a "when '-p' is
given, take it to mean as '-m -p'" _feature_).

If I were to decide now with hindsight, perhaps I'd make "--cc" and
"-m" imply "-p" only for merge commits, and the user can explicitly
give "--cc -p" and "-m -p" to ask patches for single-parent commits
to be shown as well.

