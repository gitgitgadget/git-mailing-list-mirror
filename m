Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6967BC2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7922465A
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mOdGBNIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAVUYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:24:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58200 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 15:24:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBA4FAC5BE;
        Wed, 22 Jan 2020 15:24:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/mfQc/FFiltNDPYqrjkdtHF2Kb8=; b=mOdGBN
        IrgNn4agMozRCVOdg9lhj40m1WYdm4roZx6FLLZjeZBLMaqLWCZkTLMSIsc/5QBl
        Spe/nvrofqIC9BUuRqR47Gf+BIEKyEy3xi8Bw3t2CBJfZGYWrpw5qxNRffgkXy7z
        vChgo4WU46YcwaQ3do1bAGen4BcsyU3E42GUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vWNBTq3b+LyEA0YyYaAprEiJ26BcBJVS
        O/wLhyjcRh4IYlCd+7WFsqknV7pnmz7sNA6k/wyxyrjjg1Qz8BZ/lJs1wwoOi6up
        UL91jrl3SvgEVASI2f3LGNTyvLk/2aAxkjV3A56q/PEATcvItncxkp7hFAbdT3y8
        Mgs5Bul8rTE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C36ABAC5BD;
        Wed, 22 Jan 2020 15:24:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6EF2AC5BC;
        Wed, 22 Jan 2020 15:24:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
        <avarab@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v1] rebase -i: stop checking out the tip of the branch to rebase
References: <20200109150332.GF32750@szeder.dev>
        <20200121191857.23047-1-alban.gruin@gmail.com>
Date:   Wed, 22 Jan 2020 12:24:06 -0800
In-Reply-To: <20200121191857.23047-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 21 Jan 2020 20:18:57 +0100")
Message-ID: <xmqqa76f6xzt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24F2A024-3D55-11EA-8CBC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This introduces a visible change: as we do not switch on the tip of the
> branch to rebase, no reflog entry is created at the beginning of the
> rebase for it.

Fortunately, this does not mean "git log @{-1}.." during a rebase
starts to behave differently.  If it were the case, that would have
been a bad regression, but that is not the case.

If you omit one reflog entry, you are creating TWO changes.  The
detaching of the HEAD to the "onto" commit would record, just like
any other reflog entry, would record from which commit we detached
HEAD from.  That reflog entry will also be different, as you'd be
switching from a different commit.  

I am not sure what the implication of this difference will be in
practice, though, but it must be smaller than the effect of the
missing reflog entry discussed earlier.
