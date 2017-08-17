Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125E9208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 07:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750775AbdHQHMj (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 03:12:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750741AbdHQHMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 03:12:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5139197448;
        Thu, 17 Aug 2017 03:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4F+UvCRDTqLU
        6ZZs8fV/e06MPHk=; b=Qe8IxagF2YYgxsndIacuuwcr701pWfaaxKRL59jricTw
        5FTI5WuyShsN0sHRWqSzYldXAnhwlb8uOIHNmisLxuwmeLULzGPfwmhe3fqZuJCd
        ue77MWPGD0aWSxrll7Xlg7aaJq3VhTvgZowz2I2aE++gqKYCxyy/ZtBpotpe+XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QiET6i
        R1Zt7rMBBNpb215/g0SBaI07ESFFeHF9FWEkg0rSs1bTsRzFSiZQc5Mjkf7sI2Gx
        AjumNcj5awXdt8tmnvpDdDSvrDxqnH2GawIzDjBae8Gq+8uqnWyr25rNKDdr0XZy
        7iv6sM6P9uw7EIcLpQl8+UX/rDW73XE3X5wb8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A2AA97447;
        Thu, 17 Aug 2017 03:12:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC36E97446;
        Thu, 17 Aug 2017 03:12:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/FIXUP 6/2] apply: clarify read_old_data() is about no-index case
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
        <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
        <20170817062450.GA28592@tor.lan>
Date:   Thu, 17 Aug 2017 00:12:36 -0700
In-Reply-To: <20170817062450.GA28592@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Thu, 17 Aug 2017 08:24:50 +0200")
Message-ID: <xmqqbmneis63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7324013A-831B-11E7-971B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Unless we re-define the meaning of "NULL" into "don't do CRLF conversio=
ns,
> like SAFE_CRLF_KEEP_CRLF does.

My preference is not to use NULL as any hint.  Instead, the "flag"
parameter we already pass to convert_to_git(), just like the updated
read_old_data() uses SAFE_CRLF_KEEP_CRLF to tell it that it should
not disturb existing CRLF without looking at the istate, should be
used to tell convert_to_git() to do the opposite, but do so without
looking at the istate.

Perhaps SAFE_CRLF_FALSE should be such a flag.  Or perhaps we need
to invent another flag.  I dunno.
