Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8309B20988
	for <e@80x24.org>; Wed, 19 Oct 2016 01:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933980AbcJSBMM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 21:12:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55485 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755634AbcJSBMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 21:12:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFC9D493A7;
        Tue, 18 Oct 2016 21:12:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fcl8EpNvT899WxyCVXPt6WwhTSM=; b=toXSJF
        FGrEx6EWMqUlRk5dU4gQOutw91N5z7PHVQIHRj+rtFepo+Tf4g0vKyh3Ltp6SUXV
        y+v8CoHy3jm+5KhdGWhE6mXeZ8/tObNxh8gUmm1/f7U1flEOzide4nZxU6YQeP/7
        na4KtRY0IguYIv6c3+Y8UaBSonNNwRWbC7/qA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LHixwwtlUljiCF4zCRdfPyqzJkFl+n71
        1HhYUbgGZzIfEmL+d6Nl+r38O48ydgOQ1Dtveo6VxVV55wkwhQHYz7k/vy48kWeI
        5rH6tJZQf7T1TUpNCPsEWMOZ9YrzlfVUT8+Gz+cjjhXRuD2UtJ1bouMnmy5AykhH
        4dTHGNDZj4M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7165493A6;
        Tue, 18 Oct 2016 21:12:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ECE1493A5;
        Tue, 18 Oct 2016 21:12:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 05/25] sequencer: eventually release memory allocated for the option values
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <b771bfbc88734b74acda0c377446e984ca81fd9c.1476450940.git.johannes.schindelin@gmx.de>
        <xmqq4m4avlr7.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610181356460.197091@virtualbox>
Date:   Tue, 18 Oct 2016 18:12:07 -0700
In-Reply-To: <alpine.DEB.2.20.1610181356460.197091@virtualbox> (Johannes
        Schindelin's message of "Tue, 18 Oct 2016 14:03:58 +0200 (CEST)")
Message-ID: <xmqq1szdnnvc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ECAAB82-9599-11E6-8F56-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > To remedy that, we now take custody of the option values in question,
>> > requiring those values to be malloc()ed or strdup()ed
>> 
>> That is the approach this patch takes, so "eventually release" in
>> the title is no longer accurate, I would think.
>
> To the contrary, we now free() things in remove_state(), so we still
> "eventually release" the memory.

OK.  We call a change to teach remove_state() to free the resource
does more commonly as "plug leaks"; the word "eventually" gave me an
impression that we are emphasizing the fact that we do not free(3)
immediately but lazily do so at the end, hence my response.
