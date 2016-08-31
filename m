Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E031F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933993AbcHaUxf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:53:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55227 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752745AbcHaUxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:53:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5B97395B2;
        Wed, 31 Aug 2016 16:53:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4lJM+bhsaeqCeoWf13BF4oPwak4=; b=S7c0u4
        axPW82mCXkanJBhaJmtUZ0oLO/GYjW/36zSf5fLZvtjNfNTXbA86WtzsvHduSD9Z
        upYLuoiYYiVkXykN8cBnz1+2h17uygYrjMMBZkPfaPReOSX/Os2vFSKT9Ehl6tIi
        upEcDCmQGGSISgoMhemyJYvBER/zzhftFNaJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aUSMzO25RwUQ9A/Lj3RFaoWIx2SgMB6D
        D4rc1i6QW+OqM8dcwE74ojmNrApI9JEm5MpUQcgOOYzeCIi+gz4Zmvk8rAKWzmy1
        cvPfTY5JFahH1adwKBfB8ZI/4SdSGDi6NTkx8riemgTHGipmkO/JYyi6/a+YvHR6
        75mtiSpxBrE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B90395B1;
        Wed, 31 Aug 2016 16:53:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 201F2395B0;
        Wed, 31 Aug 2016 16:53:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] cat-file: introduce the --filters option
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <320f5e862e8df12bbd1d918f0b347aeacbd25d17.1472041389.git.johannes.schindelin@gmx.de>
        <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608312153030.129229@virtualbox>
Date:   Wed, 31 Aug 2016 13:53:27 -0700
In-Reply-To: <alpine.DEB.2.20.1608312153030.129229@virtualbox> (Johannes
        Schindelin's message of "Wed, 31 Aug 2016 22:31:55 +0200 (CEST)")
Message-ID: <xmqqa8fszmm0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8494E1A-6FBC-11E6-871B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	if (S_ISREG(mode)) {
>> > +		struct strbuf strbuf = STRBUF_INIT;
>> > +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
>> > +			free(*buf);
>> > +			*size = strbuf.len;
>> > +			*buf = strbuf_detach(&strbuf, NULL);
>> > +		}
>> > +	}
>> 
>> When we see a blob that is not ISREG, what is expected to happen?
>> Is it an error?
>
> This is not a user-facing command, therefore we have to trust the caller
> that they know what they are doing.

The caller that knows what s/he is doing would rely on a documented
behaviour out of the command.  That behaviour hopefully is an
intuitive and useful one for script writers.

You say

> Quite frankly, as cat-file is not an end-user-facing command, I think it
> is serious overkill to add more testing here.

and I think you would need a serious attitude adjustment here.
Scriptors are also an important class of end-users and cat-file
directly faces them.

Thinking about this one a bit more, as 'cat-file' especially with
the "--filters" option is the lowest-level way for scriptors to
externalize the data stored in Git object database to the
representation used in the outside world (in other words, it would
be a good ingredient if they want to implement what "checkout"
does), I would expect that an intuitive behaviour for

	git cat-file --filters HEAD:Makefile >Makefile
	git cat-file --filters HEAD:RelNotes >Relnotes
	git cat-file --filters HEAD:t >t

to send the requested contents to the standard output stream, but
error out when the result of the command shown above would not
mimick what "checkout" would leave in the filesystem.  IOW, the
first one should succeed, the second and the third ones should fail
the same way to signal what is requested cannot be performed to the
script that is calling these commands.

