Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B230320986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbcI0WXI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:23:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54050 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752240AbcI0WXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 18:23:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69C633F306;
        Tue, 27 Sep 2016 18:23:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KPkDKPbuPzn8IyKpwBJIqLPTPHE=; b=fDlpdz
        uo5bTJvYueKJgNUtofDVUXcn/lB4is9JVKognkiJjCBIpzKKalkEsx5ADcZT8xKp
        9PNggQCbUEkQdspRWLg8msAaizMTtUvW7oreIwT3s/SFUudI9XdI11R/+m3hDjOe
        07rltr0KSXyMdrad/TcHuJpCfgiLJcZaGKOiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pEuOjcT6dh72ljDP6Hydy3EApIe34XWU
        aw5nzjw+FB5QJIHHIogLcWiPXpNuOl2kOkXIqtxY6c9nzADzONFHSViHDrAZC84a
        oPCweu8TvMncjMuumDUpKJx4GioMB5T79gZZdoBTv9n6jRY0me6OcX7Tj0+wLhKU
        Ia4AwOo4/ng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60B363F305;
        Tue, 27 Sep 2016 18:23:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D66223F301;
        Tue, 27 Sep 2016 18:23:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
        <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
        <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
        <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
        <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
        <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
        <xmqq60phm39w.fsf@gitster.mtv.corp.google.com>
        <20160927214854.GA180705@google.com>
        <xmqqwphxknoj.fsf@gitster.mtv.corp.google.com>
        <20160927220955.GA38615@google.com>
Date:   Tue, 27 Sep 2016 15:23:02 -0700
In-Reply-To: <20160927220955.GA38615@google.com> (Brandon Williams's message
        of "Tue, 27 Sep 2016 15:09:55 -0700")
Message-ID: <xmqqh991kmnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5A225AC-8500-11E6-A22A-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> If you are in a subdirectory of your superproject, say, a/,
>> 
>>     cd a && git ls-files --recurse-submodules -- "b*"
>> 
>> I would expect we would recurse into the submodule at "a/b" and find
>> "b/file-at-top-of-B".  What does the internal invocation to do so
>> would look like?  I would think "git -C b --super=b ls-files" that
>> is run from "a".

Actually, the internal invocation may have to be

	$ git --super=a/b ls-files -- "a/b*"

if the desired overall output needs to be in the "--full-name" mode.
That is, the top-level recursive one may be

    cd a && git ls-files --recurse-submodules --full-name -- "b*"

This top-level "ls-files" will have "prefix" set to "a/".  Because
it is run in the "--full-name" mode, after finding that the
submodule at "a/b" matches the given pathspec and deciding to
recurse into it, it needs to arrange that paths stored in the index
of the submodule are prefixed with "a/b/", not with "b/", when
shown.

