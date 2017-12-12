Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555861F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdLLTbD (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:31:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752354AbdLLTbC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:31:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49098C7D4F;
        Tue, 12 Dec 2017 14:31:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s2PmUYlahUprVZP+UD1Q303N6Ks=; b=UVQIMO
        h9ZhHOg7gMppIua0w7Cx13+4TKI9mFCNxWPFJ8KT6MtSGWntyhpoPcfTeHFc/v5C
        Ck57Gr7f3PbVTxrePziEbECDVoPi/QTYrSE7IbMjm+tLp1kn9LYhF2E3NLBnovrz
        1PXchgkA0SDI23h/daQjs57TbMxtcYYS0AF+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t0qRtdqJPazV1xoyUiMNMT+aYQSlkgK0
        +jv96Vxg6RgHwn9co3O6hDNjQFJV4QAR5mYWjSKflLb/43Zv5SPR3hlcX6AFsrww
        RXI23n8TYxHN4fRtU7R83dtOer8OOHmIKrFk16aZ4yZzvwOy2rrte33MLaCYX7Wg
        AqwN5HhtVFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41C25C7D4E;
        Tue, 12 Dec 2017 14:31:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2645C7D4D;
        Tue, 12 Dec 2017 14:31:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        peff@peff.net, patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
        <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
        <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
        <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com>
        <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org>
        <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com>
Date:   Tue, 12 Dec 2017 11:31:00 -0800
In-Reply-To: <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com> (Lars
        Schneider's message of "Tue, 12 Dec 2017 11:55:53 +0100")
Message-ID: <xmqq1sjz3frf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCBA8BFE-DF72-11E7-A90B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Our favorite is "treat-encoding-as". Do you consider this better
> or worse than "checkout-encoding"?

I am afraid that "treat as" is not sufficiently specific and would
invite a misinterpretation, e.g. "You record the bytes I throw at
you as-is in the object store, but treat them appropriately as
contents that are encoded in cp1252 when presenting".

what is missing is at what stage in the overall user experience does
that "treating" happens.  That causes such a misinterpretation.

So from that point of view, "checkout-" or" working-tree-" would be
a better phrase to accompany "encoding" to clarify what this attr is
for than "treat-as".

Having said all that, this "feature" would need a moderate amount of
clear description in the documentation, and between the perfect and
a suboptimal name, the amount of explanation required would not be
all that different, I suspect.  We need to say that those who wish
to use this attribute are buying into recording their contents in
UTF-8 and when the contents are externalized to the working tree,
they are converted to the encoding the value of this attribute
specifies and vice versa.

