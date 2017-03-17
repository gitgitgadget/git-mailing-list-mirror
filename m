Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4662020951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdCQV0P (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:26:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56009 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751174AbdCQV0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:26:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5F4F77F9B;
        Fri, 17 Mar 2017 17:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AvrEUOENPYpV5kPvg/5uiW3LI5g=; b=V3Pkc3
        vLuXt5JIuD1m6YUc2QqN/M6WfcCqNI9ATOIyoOgw3XDOkXeK3VoOdHMm7Liwyvxg
        335A9Esn4+sJNiXNhRmz5xdNKfOjcQ96cmsEHBbDEai7hajgBXUs6saHIwcTcQ4V
        khVPUfHAlxzMZheVq4+Z0433OhQVjifC3zN9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YiFpWiHyIIz+JWlbga1ToQVEMpswg2Ii
        cIbBrLgE8J8GJ312PiLMRnccTVu8Z/BfnKyiLX8COKnetFm4RLz+nXYLEMDPIKcn
        Zuin7bS/qBJtjMlhZULcIsgdMAi/E7sga1YWSupiUjtRmK95Rg7nnn1AsJODMHZB
        /jLHQ4zsKOo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE62F77F9A;
        Fri, 17 Mar 2017 17:25:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B21377F99;
        Fri, 17 Mar 2017 17:25:33 -0400 (EDT)
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
Date:   Fri, 17 Mar 2017 14:25:32 -0700
In-Reply-To: <20170317210031.GA63813@google.com> (Brandon Williams's message
        of "Fri, 17 Mar 2017 14:00:31 -0700")
Message-ID: <xmqqinn761f7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41039282-0B58-11E7-AFB6-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I don't think that prefix can ever have ".." in it.  From what I
> understand it is always a path from the root of the repository to the
> cwd that the git command was invoked by.  So in your example prefix
> would be "src/".

The prefix would be NULL or "", as you will be at the root-level of
the working tree when you are running _IN_ the submodule (by
recursing into it).  Not src/, nor anything with ../ in it, I would
think.
