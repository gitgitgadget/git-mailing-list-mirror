Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AE22095B
	for <e@80x24.org>; Tue, 21 Mar 2017 16:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbdCUQ4S (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 12:56:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933523AbdCUQ4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 12:56:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87D196D8BE;
        Tue, 21 Mar 2017 12:56:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P7lY+I93J2rs384KKgNEUQPrnuw=; b=lpgew0
        8SVOPZMFlN9ExM8/7QzouAsk3/y4m8vlDxhc0PzbXC9E5yvaVfFMpPhzhbTUh8NP
        pBYuJCxDR+nKy8sbmWWa3iv5tVrpuFZnxJrHaWKWiFPANYfTZaD2y2LKZp8smAnT
        ggXrhsvXIv3TCQ3MrG0gyA/C1i72LtKahUz0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VJ16pTxgfCFu8CUUmySzAu+Iq5+k+0FE
        H4Hm2th9EdEzHaLmNDhGSj0VsGem0QHeZ8aB7DQh/LSof+aNsz2rxctJlEEYQCku
        5vIG+5MNQ428g2gAS2/zbooAqjPiKjmGaKE/CrzR3w4Ml96BPaEkz8JFE7z/lPRC
        goFKb7DyPUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 800B96D8BD;
        Tue, 21 Mar 2017 12:56:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E533B6D8BC;
        Tue, 21 Mar 2017 12:56:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
References: <20170314221100.24856-1-bmwill@google.com>
        <20170317172257.4690-1-bmwill@google.com>
        <20170317172257.4690-3-bmwill@google.com>
        <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
        <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
        <20170317192103.GE110341@google.com>
        <xmqqy3w363yx.fsf@gitster.mtv.corp.google.com>
        <20170317210031.GA63813@google.com>
        <xmqqinn761f7.fsf@gitster.mtv.corp.google.com>
        <20170320223418.GB188475@google.com>
Date:   Tue, 21 Mar 2017 09:56:01 -0700
In-Reply-To: <20170320223418.GB188475@google.com> (Brandon Williams's message
        of "Mon, 20 Mar 2017 15:34:18 -0700")
Message-ID: <xmqqmvcesh5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4750DB48-0E57-11E7-ADC5-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Yes, the prefix that is found during setup of a submodule process would
> be NULL or "" as the command would be invoked from the root of that
> repository.  This series would sort of change that though.

OK, because you (eh, rather your caller) do not adjust pathnames and
pathspecs when calling into a submodule, to the process setting at
the top-level of the submodule, the paths and pathnames given by the
end user cannot be taken as-is, but needs to be adjusted inside the
context they were given, i.e. taking account the relative location
between where the user started and where the submodule is bound in
the superproject's tree.  I forgot about that and "must be NULL at
the top, no?" was a nonsense.

> That the gist of how I'm hoping to solve the problem.  Hopefully that was
> clear enough to get some feedback on.

Yup, understood (I think).  Thanks.
