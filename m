Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1794D20229
	for <e@80x24.org>; Fri, 21 Oct 2016 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934311AbcJUPke (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 11:40:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52748 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933754AbcJUPkd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 11:40:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9669046B0B;
        Fri, 21 Oct 2016 11:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=By0HZIv25wxJU20GrwXK6WtdOck=; b=Ms9UDk
        pK1IbaviCSuoCnIO5rwpfN1XulBc18l/0fkuMutSQnvx119Hny/+wSNVNhjCIsgF
        vcGas1MbWBkJqqeCUxX2pM4Zr9DR4f7z8GZ0vnynRZNygBTAWXRzfMiZovyzfGij
        rdZ0yqkWatjLiii37S11yuLL5agBUI5f2VUZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xYOV9WYTBdJAEC3Y+7qber1MrQCWr34l
        gvp8g0+sVNXGVqlq/ddXZD43gep26sSlTgEVomr53gedzJ1jV3sShTX99s55VZcK
        jocaY6t1rTd0+iNl9zC4rJoAHXRRPjSbqTli6DPboha4/k+eE9lYe/OFqTdMJv4a
        k17BG4vP8vU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D3D246B0A;
        Fri, 21 Oct 2016 11:40:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECE3446B08;
        Fri, 21 Oct 2016 11:40:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 20/25] sequencer: refactor write_message()
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de>
        <xmqqh986g49i.fsf@gitster.mtv.corp.google.com>
        <xmqqd1iug42f.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610211343310.3264@virtualbox>
Date:   Fri, 21 Oct 2016 08:40:28 -0700
In-Reply-To: <alpine.DEB.2.20.1610211343310.3264@virtualbox> (Johannes
        Schindelin's message of "Fri, 21 Oct 2016 13:43:41 +0200 (CEST)")
Message-ID: <xmqqr379d82b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2BCEEB4-97A4-11E6-8DAF-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Ah, make that four steps.  The final one is:
>> 
>>     - add append_eol parameter that nobody uses at this step in the
>>       series.
>>
>> This is a new feature to the helper.  While it is OK to have it as a
>> preparatory step in this series, it is easier to understand if it
>> kept as a separate step.  It is even more preferrable if it is made
>> as a preparatory step in a series that adds a caller that passes
>> true to append_eol to this helper...
>
> Done,
> Dscho

Hmm, what has been done exactly?  I still see append_eol in v5 where
nobody uses it yet.  Confused...

