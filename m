Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8899720899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbdHQTlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:41:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752632AbdHQTlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:41:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 521538D74A;
        Thu, 17 Aug 2017 15:41:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1nA1WjJU8FBb1Whjx8vgjP+7TPM=; b=JYjcJ9
        UP9xWOUvVfLXJvwxXWrCfv3BDC6b5LNTJY5XyQTEsQV760OvtKs9VQ2FaUOtG9C4
        KijNfH3I/zTq576qO3LiZQVLePwX45OW0365rsMQmZUWkzyn08LnOML0erFcv8Ko
        X5C3baLBKX8K+geaV7HIiNJ5Q2ilANGrvu0S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q6S+kExtNotxGE48lin+s6VCQcIx05yM
        VC0UIdhVbtepnPdKiRxzcOZ8PiKOyL+jPcSuk8t7voodq6dAJGqb45bewfqlnxVv
        qIP0o5LcJSK2T9J4A4upgJ5qJ5ZcTm6A7fqUlIsI8dEhU2+82NY1IHcrqf9URgOk
        SMijY44l/7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4929E8D749;
        Thu, 17 Aug 2017 15:41:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6D2C8D747;
        Thu, 17 Aug 2017 15:41:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
References: <1502960406180.9006@arris.com> <1502960572292.1402@arris.com>
        <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
        <1502969387926.66865@arris.com>
        <20170817142233.v2c534zh6wv7ttei@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 12:41:09 -0700
In-Reply-To: <20170817142233.v2c534zh6wv7ttei@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 10:22:33 -0400")
Message-ID: <xmqqwp62f0dm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 055CEB9E-8384-11E7-8063-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it's a bit more complex because "git pull" uses "git fetch"
> under the hood. In fact, your "git fetch origin master" is exactly what
> gets run when you do:
>
>   git pull origin master
>
> That's maybe OK. But I think one-off pulls like:
>
>   git pull https://example.com/repo.git master
>
> probably wouldn't want it. I'd have to give it some thought.

I agree with both.  If you have named remote, you presumably are
keeping copies of their branches as remote-tracking branches, and it
may be fine to follow tags.  An explicit URL used for one-off should
not grab anything but the named thing, I would think.
