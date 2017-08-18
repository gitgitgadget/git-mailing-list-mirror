Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B64208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdHRTMV (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:12:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63412 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750984AbdHRTMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:12:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 860DDAFF92;
        Fri, 18 Aug 2017 15:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E9eSG+gLtbrLKIYXC0rjBFLipPQ=; b=e0v8bf
        x1ebyIBXyrHRDKNwEauRGI7+iJoeU9Jl+J6rUoYiTYai6a+z0ZVh0rLQ2ml+F+pY
        4dZcOZt4MCY/mIS3mQIXrhcMh61HL2yLeG6YAoE7Qoy3DUFTmaY6Z66rcw80LWVY
        UXKCRypRJnS/wjjKVtcch2VccO47HJuhlrVf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u1MC3hIg8wUPpako+UNsX9NXle/i9o/F
        rgPTp0Ky9HwLKjKOKwoCB34pLNnjzAeDqg+sw0AsaVojSiOGzbIFNFzC8En9b/gg
        EVjw0elVq6xmYzXugmLHBv8BO0DdPtTUGJiwD5FJn+Zqfpg7YVWja6RVQCdTQo1q
        L2Rmx3CgDtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DB57AFF91;
        Fri, 18 Aug 2017 15:12:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4742AFF90;
        Fri, 18 Aug 2017 15:12:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v4 4/4] commit: rewrite read_graft_line
References: <cover.1503020338.git.patryk.obara@gmail.com>
        <cover.1503079879.git.patryk.obara@gmail.com>
        <9a4548f1d0832d036cad152771339d853b5885f3.1503079879.git.patryk.obara@gmail.com>
        <CAJfL8+T3vqnmFJmx19H-v8yGiY4Se78SM+ax_q07_PF4VHDv3Q@mail.gmail.com>
Date:   Fri, 18 Aug 2017 12:12:11 -0700
In-Reply-To: <CAJfL8+T3vqnmFJmx19H-v8yGiY4Se78SM+ax_q07_PF4VHDv3Q@mail.gmail.com>
        (Patryk Obara's message of "Fri, 18 Aug 2017 20:38:25 +0200")
Message-ID: <xmqqlgmgbshg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23F536FE-8449-11E7-AA55-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Actually, I don't think I needed to remove free(graft) line, but I don't
> know if freeing NULL is considered ok in git code. Let me know if I
> should bring it back, please.

Calling free(var) when var may or may not be NULL is perfectly fine.

We even discourage people from writing:

	if (var)
		free(var);

because an unconditional call to free(var) is sufficient.

