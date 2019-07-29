Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F221F462
	for <e@80x24.org>; Mon, 29 Jul 2019 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfG2Rrr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 13:47:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61177 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfG2Rrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 13:47:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06EE26A07E;
        Mon, 29 Jul 2019 13:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OYJDm+CMD+FQ
        1pbotYJQo+KPS0c=; b=MyPgpyphlCrD5cJLDGJQ8l3PL5n/B+jwhwCf1IkHEf9O
        Yz/4jgekAHiNM9CdYX0zFOGvZc26we0Xnr/edF4QyMkHXFbZPejHH6in4AONjPKc
        vPrqV7u9juuD3Fux3fukP1Sl+50dVk5n5Lr4qCdKH2QTotADoI0XVnp+RiPtAM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IC7fv3
        CMbhUtI/7I6UEVdPXIKNa22S/2QNbCYNPM25039j4ci3VfwR74aNbMHgDV6Ija2W
        7uBpxGTQQgi26/e16LtxXUqQmO4X1xAFwWPYc4W6f+/qJZpKd1Tz3KPMMIOdks3I
        tVgIY75Saw74fHLSukW+tXgJEsafSpoZkhf00=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F26356A07D;
        Mon, 29 Jul 2019 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6FA56A07B;
        Mon, 29 Jul 2019 13:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        sandals@crustytoothpaste.net, dev+git@drbeat.li,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
References: <20190728235427.41425-1-carenas@gmail.com>
        <20190729105955.44390-1-carenas@gmail.com>
        <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de>
Date:   Mon, 29 Jul 2019 10:47:39 -0700
In-Reply-To: <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 29 Jul 2019 17:11:19 +0200")
Message-ID: <xmqqh874vikk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F696C7B2-B228-11E9-BA42-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> +pcre.jit::
>> +	If set to false, disable JIT when using PCRE.  Defaults to
>> +	true.
>> +	if set to -1 will try first to use JIT and fallback to the
>> +	interpreter instead of returning an error.
>
> Why not implement only -1, without adding this config setting?

... nor command line option.  If we have an auto-fallback, I would
think that makes the most sense.  IIRC the first iteration with only
the configuration was really about working around the (non-working)
pcre-jit---if we can self-detect and skip a non-working case, that
would allow us to drop end-user facing knobs, which is ideal.

Thanks for a doze of sanity.

