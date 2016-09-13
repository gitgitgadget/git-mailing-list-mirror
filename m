Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEC620984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758428AbcIMXcW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:32:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61545 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754521AbcIMXcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:32:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFD713F26C;
        Tue, 13 Sep 2016 19:32:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BugrHZAol2L9BY7ns/F65Fa3JFU=; b=DgzUKn
        t5Ehgoq+OAkuwOI0gMr2jF9uB7jifEL0qpnEHqGCElLHWvBP3vDtx1XYz/GNfxNo
        K7eYGZlYye4LJMASM2prS1hrD5P8bO9cBVCIwtfWkwOIugSi+vBt1AyXgp77kemW
        uR/GhNmsEJj7rzJQ9nOSSefsMulqvK7Q0COjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IZA97+7ZZY5MJdc5DhO687CS4+vQ7OMQ
        Siq5Kc7GnxhL/nKBLUnu4QSnzoPcNkZ6oVbTXKULFngYouqbrtb4r/Nbg5f9+RRc
        sx2HXCbvNrsLdceZPpRw7Z3gjaEpYfoE+lFVIG4PcM8XTochQEMLY1iyiUPVscTu
        cSpnFNtgHL0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D79203F26B;
        Tue, 13 Sep 2016 19:32:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A8D33F26A;
        Tue, 13 Sep 2016 19:32:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 16/17] diff: buffer output in emit_line_0
References: <20160913044613.1037-1-sbeller@google.com>
        <20160913044613.1037-17-sbeller@google.com>
        <xmqqlgyvtn6l.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb4Rm=AT-hFutXW5jhZRL0ThDFr789=AbxKC-o+jQ341g@mail.gmail.com>
Date:   Tue, 13 Sep 2016 16:32:17 -0700
In-Reply-To: <CAGZ79kb4Rm=AT-hFutXW5jhZRL0ThDFr789=AbxKC-o+jQ341g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Sep 2016 16:28:06 -0700")
Message-ID: <xmqq60pztlz2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 501F2554-7A0A-11E6-A602-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So would we rather want to keep the ecbdata around for each file pair and
> just reference that? I thought we deliberately want to avoid ecbdata, so maybe
> we rather want to have another struct that keeps path related information
> around (pointer to the blob and white space information).

I would expect that there would be two structs, one per path
"struct buffered_patch" that has the per-path thing, and another per
line "struct buffered_patch_line" that describes what each line is,
and has a pointer to the former.


	
