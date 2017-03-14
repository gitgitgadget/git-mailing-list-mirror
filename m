Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494FB201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 20:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbdCNUU3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 16:20:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50466 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751071AbdCNUU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 16:20:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7200D71212;
        Tue, 14 Mar 2017 16:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oiyUWYEXPHcxQESFtlwJH0CvCfQ=; b=OIBMOH
        UyfWZv74smSqeg/HXMTpQOpLlQmrD4iGIVaChFaraVJvPHstJ2Ax8t6jXc4evRFc
        qSDlsrrv29YGwCDWVJzW6osIpTI1jcRZUK3HvpirQ3pjzFlJh6yUYaqDG24kiVfF
        1dkfnQRU2FYPMJudJEzmVvo2kOx3ZXjiUiLQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQMf6GW3sSollkSw1QyFatDRz6zJRupM
        Kq+OUx0IA7aTJJquarkwG8izRsgfWd3DrSdCb4MUkVjRwhFx9iNxULIVOSENGn9I
        9S4Bhaj17OgKpZ7rawlnuTKKVco3o25ltHbVbLXb8nsVFPN9R1BJIBrSQtT7fEbK
        hVsXJGWH3JY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69A5471211;
        Tue, 14 Mar 2017 16:20:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B50E871210;
        Tue, 14 Mar 2017 16:20:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] submodule status: use submodule--helper is-active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-3-bmwill@google.com>
        <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ6noz7RGbmNwg=NhuWYH=KbNPYUWL7We9YjbHn6uf2Jg@mail.gmail.com>
Date:   Tue, 14 Mar 2017 13:20:24 -0700
In-Reply-To: <CAGZ79kZ6noz7RGbmNwg=NhuWYH=KbNPYUWL7We9YjbHn6uf2Jg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Mar 2017 11:16:29 -0700")
Message-ID: <xmqqa88nip9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8A578B8-08F3-11E7-88FC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There we take the path as name and if a real name exists, the name
> is overwritten with the real name, i.e.
>
>     name = name_for_path(path) ? name_for_path(path) : path;
>
> which IMHO is overly accepting and we should just die in case of
> !name_for_path.

Yes, I agree that falling back (unless path is a submodule yet to be
added to .gitmodules) is bad.
