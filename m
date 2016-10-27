Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1D4203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 06:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbcJ0GWB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:22:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50555 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752275AbcJ0GWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 02:22:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 441694273D;
        Thu, 27 Oct 2016 02:21:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5lGNlxe6zR16Xujh244e3J8c0jE=; b=jeBzI1
        Nvg6X97K3WkJGc9EI7ny7Cgj4Vg6dTclXQvU8vUACPEs0ckR3+1Jlj6ixCMJ6hc+
        m7jEwzF+jQ55EwPqFHsItU2VrWs1OK7i21ZMMlNsYFL5BYRCHAFUSgNN6/EM5dyw
        Ex0uPonBf7WWEELl16JgPvgblY/ys3dIl7RRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YyYBBE5VUX75x+vtmHWxYQDIe0xo3Ws0
        hwF3Dt9DTMt2GjzoNUp7Ai7nMSeRfOtos1pWnCFD/fVw5lYWSbP4coq73o0gs6Rq
        YKCXf3CNOO3Hghg8zqUXbfnv8l4eQUUXUe9mHdVmWHWG7H7cAXz9AiEvLPloCaLQ
        h+jNNnKkwBg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39E5D4273B;
        Thu, 27 Oct 2016 02:21:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB80E42739;
        Thu, 27 Oct 2016 02:21:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, simon@ruderich.org, peff@peff.net
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
References: <20161026215732.16411-1-sbeller@google.com>
        <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
        <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
        <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
Date:   Wed, 26 Oct 2016 23:21:51 -0700
In-Reply-To: <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org> (Johannes Sixt's
        message of "Thu, 27 Oct 2016 08:10:24 +0200")
Message-ID: <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A75E1652-9C0D-11E6-B759-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> As many codepaths may not even need access to the attributes, I
>> doubt that would be a very productive direction to go.
>
> So, what is productive then? Pessimizing one (not exactly minor) platform?

Lazy on-demand initialization as needed, perhaps?  The on-demand
initialization mechanism may become no-op on some platforms that can
do static initialization.
