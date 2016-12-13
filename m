Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6A5203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936227AbcLMSK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:10:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936053AbcLMSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:10:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49FC954EBC;
        Tue, 13 Dec 2016 13:10:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cNgzkLTpmWRILlLAR94PuxTYk2M=; b=MTdsgX
        GUfuLyq8yjEdQKh+yQ2xvBcgi/Esr93qAPbuKsf9pOxjiL9V2wa3DGqJtHSMShVU
        AJiV/+MXQNVVSqXJfSLB2aIeT+wHCWBRCJOl8aNHPPwkyNTFTk6CIY7mHlgvmttV
        wfDlI+9+RJh3iru4c5EeLmM3wYocsuIbzI9oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e0F5U57FPRAlPhUto1pZz6+axVJ4T/j3
        oKBHOq0H4RfGabNFgkU/MSg91IWzwnmvS+hIaozXCXrkDFDNqChgNgjHasndO6ae
        RDgu9SpsWEfhjWxeW7H+mkrnOjCiT/Jo59O86bMdcWGSbUQK/voDEtn6uU0Y7Wvg
        zqYuDCZeaY0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A8254EBA;
        Tue, 13 Dec 2016 13:10:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A639654EB9;
        Tue, 13 Dec 2016 13:10:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] handling alternates paths with colons
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
        <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
        <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
        <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
        <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
        <xmqqvauo7p0r.fsf@gitster.mtv.corp.google.com>
        <20161213115018.quulwlheycjtlsub@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 10:10:54 -0800
In-Reply-To: <20161213115018.quulwlheycjtlsub@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 06:50:18 -0500")
Message-ID: <xmqqshpr4s41.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DBD881A-C15F-11E6-9B5C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Dec 12, 2016 at 02:37:08PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So here are patches that do that. It kicks in only when the first
>> > character of a path is a double-quote, and then expects the usual
>> > C-style quoting.
>> 
>> The quote being per delimited component is what makes this fifth
>> approach a huge win.  
>> 
>> All sane components on a list-valued environment are still honored
>> and an insane component that has either a colon in the middle or
>> begins with a double-quote gets quoted.  As long as nobody used a
>> path that begins with a double-quote as an element in such a
>> list-valued environment (and they cannot be, as using a non-absolute
>> path as an element does not make much sense), this will be safe, and
>> a path with a colon didn't work with Git unaware of the new quoting
>> rule anyway.  Nice.
>
> We do support non-absolute paths, both in alternates files and
> environment variables. It's a nice feature if you want to have a
> relocatable family of shared repositories. I'd imagine that most cases
> start with "../", though.

Yes.  I was only talking about the environment variable, as you can
tell from my mention of "colon" there.
