Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCBB1FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 18:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965596AbcJXSII (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:08:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S940018AbcJXSIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:08:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08CEF460E4;
        Mon, 24 Oct 2016 14:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4nTwAqwBxKUrspKIvM7EE5Xik7U=; b=VIb4f3
        MCGxxVSUZr+JUEJ6xx7jezAKYXhPLVDhSCAZ1Ywc+sST0BrozoO0LUl2dOdNYy2K
        MMqGtB1bqNIjJAdJksUzbfzc/wJl/DaBxPt2l14TNzeB7SfGZ9F0dnhjyBQzJDVZ
        cC+ZvaQiiTflLP1ipsOA6kw5Tc1VDcN1RjdE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XIZC2axhZ+2tPaZMBmHin8H7Dtld21nF
        ZbKrTb4t2lhthNwA0tm1GU1cSS+A2tIZIuiIz4FCwnmNGRbPER4kecWrLLrIFOXj
        5rg60/VRS9js8u+oDROTaoHxsKBKja8mm3K5OsCDtgYuS4qjYf50ePlY+CX2C0Ca
        O2LZjmMc68M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00348460E1;
        Mon, 24 Oct 2016 14:08:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 631AB460DF;
        Mon, 24 Oct 2016 14:08:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Date:   Mon, 24 Oct 2016 11:07:59 -0700
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 23 Oct 2016 11:26:29 +0200")
Message-ID: <xmqq8ttd7h8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDD76810-9A14-11E6-A872-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The design is similar as the previous work that introduced
> "core.untrackedCache". 
>
> The new "core.splitIndex" configuration option can be either true,
> false or undefined which is the default.
>
> When it is true, the split index is created, if it does not already
> exists, when the index is read. When it is false, the split index is
> removed if it exists, when the index is read. Otherwise it is left as
> is.

I admit I haven't thought it through, but this sounds OK.

> Along with this new configuration variable, the two following options
> are also introduced:
>
>     - splitIndex.maxPercentChange
>
>     This is to avoid having too many changes accumulating in the split
>     index while in split index mode. The git-update-index
>     documentation says:
>
> 	If split-index mode is already enabled and `--split-index` is
> 	given again, all changes in $GIT_DIR/index are pushed back to
> 	the shared index file.
>
>     but it is probably better to not expect the user to think about it
>     and to have a mechanism that pushes back all changes to the shared
>     index file automatically when some threshold is reached.
>
>     The default threshold is when the number of entries in the split
>     index file reaches 20% (by default) of the number of entries in
>     the shared index file. The new "splitIndex.maxPercentChange"
>     config option lets people tweak this value.

OK.

>     - splitIndex.sharedIndexExpire
>
>     To make sure that old sharedindex files are eventually removed
>     when a new one has been created, we "touch" the shared index file
>     every time it is used by a new split index file. Then we can
>     delete shared indexes with an mtime older than one week (by
>     default), when we create a new shared index file. The new
>     "splitIndex.sharedIndexExpire" config option lets people tweak
>     this grace period.

I do not quite understand this justification.  Doesn't each of the
"this hold only changes since the base index file" files have a
backpointer that names the base index file it is a delta against?

Is it safe to remove a base index file when there is still a split
index file that points at it?  

IOW, I do not see why it can be safe for the expiration decision to
be based on timestamp (I would understand it if it were based on a
refcnt, though).


