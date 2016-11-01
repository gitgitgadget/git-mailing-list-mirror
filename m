Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3AD20229
	for <e@80x24.org>; Tue,  1 Nov 2016 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbcKAT2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 15:28:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54009 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbcKAT2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 15:28:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D5C64AE91;
        Tue,  1 Nov 2016 15:28:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k491NHen9w9p3BNuw/+vmDWPu2Y=; b=JIV5yc
        DsSCyP/MDWuQsC0N2djHQSOgUKo1fsZnAzCPt0ArsC0NDAOwH/7oyuDV3UeHOOUb
        p4AxAacZnjp64OnrkXger4MGgKv5WaMJnlZcvqllWQ60xdBqV3A9sYWOf6daTWM1
        u9VUPX0EvwehsIqsjqSmkwOLOT5ev6kaMe7sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=asClf7xkWTG3x/prvrRAFS005G4mL1UH
        urI78XxNVABhsCMmQHwIdhwLeiLscTS7g4VuOMtDM15dG8Ys/RiRTjt+97A85Bla
        C04MNQHMIBKLEpga29auQTJs+xiNEAoRC0PK7QSCXP93+4n+foF2iv/DOf3SfbqW
        a6NkDnr4qbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44AD04AE90;
        Tue,  1 Nov 2016 15:28:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6F954AE8F;
        Tue,  1 Nov 2016 15:28:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 15/19] config: add git_config_get_date_string() from gc.c
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-16-chriscool@tuxfamily.org>
Date:   Tue, 01 Nov 2016 12:28:18 -0700
In-Reply-To: <20161023092648.12086-16-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 23 Oct 2016 11:26:44 +0200")
Message-ID: <xmqqziljngod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5881956C-A069-11E6-87AE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This function will be used in a following commit to get the expiration
> time of the shared index files from the config, and it is generic
> enough to be put in "config.c".

Is it generic enough that a helper that sounds as if it can get any
date string dies if it is given a future date?  I somehow doubt it.

At the minimum, it must be made clear that there is an artificial
limitation that the current set of callers find useful in cache.h as
a one-liner comment next to the added declaration.  Then people with
the same need (i.e. they want to reject future timestamps) can
decide to use it, while others would stay away from it.  

If you can come up with a better word to use to encode that
artificial limitation in its name, renaming it is even better.
