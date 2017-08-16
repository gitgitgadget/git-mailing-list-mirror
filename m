Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD011F667
	for <e@80x24.org>; Wed, 16 Aug 2017 17:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdHPRGs (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 13:06:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751780AbdHPRGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 13:06:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E7CA22D9;
        Wed, 16 Aug 2017 13:06:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b/KDOlJvdTHbOXAw0Be9G8OL9Rs=; b=o11/S5
        u+RoFHzAXulH5Vw2HbyC0GGwtthBz54LJoUE84IX/WhddKhJmOMd6q0tkwIKvNGj
        dYQEjLOD3g1XCuhYRsbFddDgflQPuxxdbIy6VzV2S7aOxhADlzIqJ0MqFnDxvC/A
        y9ikqtMsCGM0mOYdTr+kc0ckegM0eE2HmSQz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IoDBjHHSNFd4vgNkfp+U5pszyoZ9enDn
        3RF5PNPOJ3BcBO6VSMEr+2Z/vr3TmueOYKX07zbfkhPkP3R7g8XmF9cQp9tKkX4n
        TXvpTV8M4vcorEp1lEV8It9wdm5nZwCSAR3b9yrbriVYSSiAOexKZVkj0JJ2CLq9
        A97fAvg+TMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28C28A22D8;
        Wed, 16 Aug 2017 13:06:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D9CAA22D7;
        Wed, 16 Aug 2017 13:06:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Efim Goncharuk <efimster@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git reset
References: <34910856-7DE9-41A0-A7A6-B572B1C88C1F@gmail.com>
Date:   Wed, 16 Aug 2017 10:06:38 -0700
In-Reply-To: <34910856-7DE9-41A0-A7A6-B572B1C88C1F@gmail.com> (Efim
        Goncharuk's message of "Wed, 16 Aug 2017 14:21:46 +0200")
Message-ID: <xmqqziazo31d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44C88868-82A5-11E7-B6BE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Efim Goncharuk <efimster@gmail.com> writes:

> Starting from git v.2.13.0 onwards (v 2.12.2 works fine)
>
> git reset --hard with --work-tree and --git-dir options does not move HEAD to hash/tag specified. HEAD remains on same position.
>
> Example:
>
>> git --work-tree=lib/core --git-dir=lib/core/.git/ reset --hard 0.1.0
>
>
> Note:
> on another hand
>> git -C lib/core reset --hard 0.1.0

... "works", I presume.

Thanks for a report.

A quick bisection points at f57f37e2 ("files-backend: remove the use
of git_path()", 2017-03-26), which is not unexpected.  I didn't dig
further and do not expect have time to do so myself for some time,
though.

