Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C391F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 02:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfJICTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 22:19:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59608 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJICTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 22:19:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F4C2397AC;
        Tue,  8 Oct 2019 22:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=flWcGgDHbELv
        q57ZaN/g2uBn0yg=; b=OO9Or/tq8HKtfuSbIOHvudAo7mpH/TO3ITQuFmHDDkc2
        vwscBZ6H+80Zat1csafnR8SY4TqQXo6iif+CRh78q3+f9vvr8h/ISWjkKCyjPmWF
        RRwRC2v/YERM4evBRS0DpIOKc7fyLbKJYXgmv5zE8P2YJK53uPJ6xCSHzKPrWWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wr3WCH
        qxhXqXH2zOTGugYlbwM5a4E0FQRQ+F3pB7HEN7LLNAL6ZwXCSRowVAP2HCYni152
        jqxhH8S+nAn2PWWsyxVu7wllJ81uuwklgyKWAB0W2O6l5xPQ+FDlWtjPWnnBAvu8
        WpEcp8W5Ex+s+mOD1cGKFq8NVd0WuJ/wXz850=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8700E397AB;
        Tue,  8 Oct 2019 22:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E556F397AA;
        Tue,  8 Oct 2019 22:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
References: <20191008074935.10972-1-toon@iotcl.com>
        <20191009014039.GA10802@szeder.dev>
Date:   Wed, 09 Oct 2019 11:19:47 +0900
In-Reply-To: <20191009014039.GA10802@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 9 Oct 2019 03:40:39 +0200")
Message-ID: <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44C9F860-EA3B-11E9-8A25-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Oct 08, 2019 at 09:49:35AM +0200, Toon Claes wrote:
>> Add support to provide the Co-author when committing. For each
>> co-author provided with --coauthor=3D<coauthor>, a line is added at th=
e
>> bottom of the commit message, like this:
>>=20
>>     Co-authored-by: <coauthor>
>>=20
>> It's a common practice use when pairing up with other people and both
>> authors want to in the commit message.
>
> I wonder how we are supposed to use this trailer in the Git project,
> in particular in combination with Signed-off-by.  Should all
> (co)authors sign off as well?  Or will Co-authored-by imply
> Signed-off-by?

I think we have been happy with (1) a comment at the end of the log
message that says X worked together with Y and Z to produce this
patch, and (2) the trailer block that has S-o-b: from X, Y and Z,
without any need for Co-authored-by: trailer so far, and I do not
see any reason to change it in this project.

If other projects wants to use such a footer, that's their choice,
but I am fairly negative to the idea to open the gate to unbounded
number of new options for new trailer lines.  We do not even have
such options like --acked=3D<acker>, --reported=3D<reporter>, for the
trailers that are actively used already (and to make sure nobody
misunderstands, I do not think it is a good idea to add such
individual options).

Thanks.

