Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E20C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0513D60FE8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhDKUda (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:33:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50549 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKUda (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 16:33:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E64CB59C;
        Sun, 11 Apr 2021 16:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J655TNNb+3JHDWOHFeE5hWcuNqM=; b=dP+JkU
        mgQG3X672CRb2ZZD9IaVf0CjVjwaaQyHu8KRghBZLGeaIv9E1B05lwA8codvKY4J
        6x5cj92rnINyvdh+SnuC54bxHnLD2O0Gjhm50i6MvF4emdOUidkp3bt8Nuv/h3/q
        35jgZgG9LVp0FFyazHNAEsLO5YkYBkd40dnJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjEk+bxXLy6TzfF/StP3Jn8rsIqI/Fq3
        rLKf+XYe8BChcpVVoF/vEYwtNI1QGTfHAYzNgkQa2jZQRjRpJu8IdusRgzc/qrs9
        n6CBIbhDpJSyzljY+G9mb615Q1XB8GayWw2the00SPN9cO193OwWhl2JjXjECwes
        hwaKWIgdfmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F5EACB59B;
        Sun, 11 Apr 2021 16:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9837CB59A;
        Sun, 11 Apr 2021 16:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
References: <20210411095538.34129-1-mirucam@gmail.com>
        <20210411095538.34129-4-mirucam@gmail.com>
        <xmqqy2doftrj.fsf@gitster.g>
Date:   Sun, 11 Apr 2021 13:33:12 -0700
In-Reply-To: <xmqqy2doftrj.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        11 Apr 2021 13:31:12 -0700")
Message-ID: <xmqqtuocfto7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22DEFBDE-9B05-11EB-A666-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Miriam Rubio <mirucam@gmail.com> writes:
>
>> +		if (res < 0 || 128 <= res) {
>> +			error(_("bisect run failed: exit code %d from"
>> +				" '%s' is < 0 or >= 128"), res, command.buf);
>
> Good now.

Oh, while asking for better test coverage, it is somewhat surprising
that the broken error condition check in v2 was never noticed.  Can
we add a test for this, too?

Thanks.
