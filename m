Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575421F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfHZSyw (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:54:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60653 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732976AbfHZSyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:54:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 072D0177FA6;
        Mon, 26 Aug 2019 14:54:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TWB716xSdx6g
        HIwq8XHN+NJh3+A=; b=EWocJu451J2pkFx/ULTQTPmv+puJMX2PebWe1IxTsY86
        ABtYpr1q/l0NTS/Wf8qetmj4NfqQpZJZVAMoGllCjXUgzTtJhQrseqAkSVD7lwNj
        Mhf+aV7Z18R2+9qvMDxQPoEayvmt0038GnLHMgYxt9G6KbLlmkrjRFeIrqKzVnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NvRB9f
        dkQkXRAOXOMSXj9gMmYSPCWcna0Ur/00BPb3X9ezhZ+a6Ixsx4+KaBBmWHLdx77C
        vf4JG7HfAaWlD1kYfpZrQFxUf9aKoTQn062RMAkERD07mYDxcdtKQaxepGZgsnOS
        uoXbWee+Cgq4x6zWBeOFE1kx3k71OdUptqXso=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F201C177FA5;
        Mon, 26 Aug 2019 14:54:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44A8B177FA4;
        Mon, 26 Aug 2019 14:54:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, cbailey32@bloomberg.net, avarab@gmail.com
Subject: Re: [PATCH 1/2] grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
References: <20190825182223.76288-1-carenas@gmail.com>
        <20190825182223.76288-2-carenas@gmail.com>
Date:   Mon, 26 Aug 2019 11:54:48 -0700
In-Reply-To: <20190825182223.76288-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Aug 2019 11:22:22 -0700")
Message-ID: <xmqq36hnhi4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FACC7A3C-C832-11E9-8422-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> e87de7cab4 ("grep: un-break building with PCRE < 8.32", 2017-05-25)
> added a restriction for JIT support that is no longer needed after
> pcre_jit_exec() calls were removed.

I was initially puzzled by this statement, until I realized that the
removal of pcre_jit_exec() happens in the topic still in flight that
this patch builds on top of, namely 685668fa ("grep: stop using a
custom JIT stack with PCRE v1", 2019-07-26).

So the logic is that because we do no longer call pcre_jit_exec()
that weren't available between 8.20 and 8.32, these slightly older
versions can now do JIT just like the ones post 8.32?

Thanks.  Queued.
