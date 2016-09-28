Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2E11F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754367AbcI1Vtb (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:49:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50949 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754273AbcI1Vtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:49:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2A52436A0;
        Wed, 28 Sep 2016 17:49:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aThTNx5X8ldyt06e5XX5eTmDns0=; b=PkglNT
        DN+j2WqTxoXobPd4WCSYpy3pbaR/pfREVyncPqwm8GbbRXmroFv19WJoKfc3yBwz
        SmqZ7O+39JxR87MYKv5ZPUKiwr2Qd0d+yS15ovlXJ/a2THH5sk6Qs4UpEisWclcx
        TYZmOtDHtHwo36Qkg4Q5wsa9KUDbxId2O/+Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JkJS5255bKxW59XpteDhY6/CeW5p94BX
        lBfRlQ/t8bU/6270Fjhuv+MwbmVmCZhfaU2TQrefwRalogee9GYj+R2VxzCf6zSF
        /i8e50c/slDAal6HLqcPEnZzAO2K9xvYdRl+Tv5vBTlzbwuPD71DwdPSPqmmBlSJ
        W/QgZawI9KM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB46E4369F;
        Wed, 28 Sep 2016 17:49:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AE674369E;
        Wed, 28 Sep 2016 17:49:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Date:   Wed, 28 Sep 2016 14:49:27 -0700
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Tue, 20 Sep 2016 21:02:36
        +0200")
Message-ID: <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6ECA4832-85C5-11E6-9871-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suspect that you are preparing a reroll already, but the one that
is sitting in 'pu' seems to be flaky in t/t0021 and I seem to see
occasional failures from it.

I didn't trace where the test goes wrong, but one easy mistake you
could make (I am not saying that is the reason of the failure) is to
assume your filter will not be called under certain condition (like
immediately after you checked out from the index to the working
tree), when the automated test goes fast enough and get you into a
"racy git" situation---the filter may be asked to filter the
contents from the working tree again to re-validate what's there is
still what is in the index.


