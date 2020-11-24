Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB0C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FC9206F7
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fRjCmrED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbgKXWpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:45:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52909 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgKXWpc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:45:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46F7CFB2E7;
        Tue, 24 Nov 2020 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/eVm4WhARbfJ2Xv4J0+hI7YNrhI=; b=fRjCmr
        EDiPyxO44zHZM6aGSAVIiXSZwCNogbJ4Ui6Af/3uWycFcPlWneSBxCyHCplD4Oki
        tvCSsFFnuDdUmYZhVM7Zd9yDXetu9g0cVZZQtHXKXVSby7rv+5HZtYQWvOnC+Dgp
        onZLm77T//ZUvzTWNTsgzaTrLkFohRsuNFeos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rqXaXFtl4pIEXYfXFELfCvSpH+aSqZfE
        /NE7Y5joKYF6ltELXsf0CCcwxKUZGVGRJJduqZNbZiOPPoMTVAJTKkg/Len1LOkj
        eEpclu7heZUhZV80iLDQ4YVrpx14cQ33B/sJBs52tmN6jqcuuG3ZKTtS89c0STN0
        6rqZcZqqNFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BBF1FB2E6;
        Tue, 24 Nov 2020 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 721F3FB2E5;
        Tue, 24 Nov 2020 17:45:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
        <X7y5Wxu1eY4k6753@coredump.intra.peff.net>
        <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
        <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
Date:   Tue, 24 Nov 2020 14:45:26 -0800
In-Reply-To: <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 24 Nov 2020 16:01:45 -0600")
Message-ID: <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFF3BEF8-2EA6-11EB-9E73-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I too find that "@ is a shortcut for HEAD" looks ugly both at the UI
>> level and at the implementation level [*1*], but as long as we have
>> it, it is good to try to be consistent and allow "@" everywhere
>> where one would write "HEAD" in places where it is syntacitically
>> infeasible---at least we would be consistently ugly that way ;-).
>
> Beauty is in the eye of the beholder.

Using "@" is rather "illogical" than "ugly", and at that point it is
not so subjective.

@-mark leads a suffix that applies some "magic" to what comes before
it (e.g. next@{1}, maint@{2.weeks.ago}, and master@{-1}).  Making @
a synonym for HEAD means '@' sometimes means a ref and most of the
time means the introducer of magic that applies to a ref.

Worse yet, @{4} does not refer to HEAD@{4} but refers to the 4-th
previous commit the current branch pointed at, so a mnemonic for the
end user to remember the distinction between the two is that a bare
"@" is different from HEAD, which is a total opposite X-<.

This is all water under the bridge, though ;-)

> Given that, your suggested title makes more sense.

Sounds good.
