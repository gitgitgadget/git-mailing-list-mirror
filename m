Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBBD1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeKNR3f (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:29:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58007 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKNR3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:29:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E82A19B46;
        Wed, 14 Nov 2018 02:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OoXlRwyEXgWFoo3b0/qtafCqhws=; b=M5KSIY
        GtRSX6ewQ5QI1jiBJsJ4qRyN+OmuChe0Z1y55IevjvfTQez2ouoQHk5nkosRmPa1
        5cHzQzEig5PFEddM9hZyo23MA6tXmMczpcQ1BqN6XGzCKwh3HvKzdNkt2i6cLTHS
        bF2Whav3V7OoiY6+1k4fetXbFndtMI2ymXu60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KHBIZfaAEQm6K9qZw1VMq8s3p9MGdn4j
        rQk04nONNi+x0YGQddXz0o33y4egGnqdjlx4njT08/qvsMeoMlE76R2dwXHRk/zT
        OTVz5RLPRXEoeJIzMHZp2Cjp93pn7JXU+2RPYLA6iVZDHw0v8fKX08b+eDIpCDoj
        ZMW8HkivdZ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07CA619B45;
        Wed, 14 Nov 2018 02:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E40519B44;
        Wed, 14 Nov 2018 02:27:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: align move detection error handling with other options
References: <CAGZ79kbJvX1Y8-iiAzXKKam7hy=pg-5+p_rzDse42-oCswMXSQ@mail.gmail.com>
        <20181113213357.205769-1-sbeller@google.com>
Date:   Wed, 14 Nov 2018 16:27:24 +0900
In-Reply-To: <20181113213357.205769-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 13 Nov 2018 13:33:57 -0800")
Message-ID: <xmqqa7mcnmoz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCD0EA22-E7DE-11E8-B8BB-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>Subject: Re: [PATCH] diff: align move detection error handling with other options

When sending an updated version of existing topic, please make sure
you indicate as such with v$n etc.  I will assume that this is to
replace the patch queued on sb/diff-color-moved-config-option-fixup
topic.  Please do not assume that all messages on the References:
header are visible in the readers' MUA to show which thread it is a
response to.  At least a hint like v$n (or mentioning the name of
the topic branch if the previous round is already in 'pu') would
make the reader realize that the References: header can be used if
the reader wants to find in what context the patch is relevant,
especially when redoing a change whose previous round is more than a
week old, as we see too many changes in a day already.

> This changes the error handling for the options --color-moved-ws
> and --color-moved-ws to be like the rest of the options.
>
> Move the die() call out of parse_color_moved_ws into the parsing
> of command line options. As the function returns a bit field, change
> its signature to return an unsigned instead of an int; add a new bit
> to signal errors. Once the error is signaled, we discard the other
> bits, such that it doesn't matter if the error bit overlaps with any
> other bit.

OK.  That sound better than the original.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> c.f.
> ./git -c diff.colormovedws=bogus diff HEAD
> error: unknown color-moved-ws mode 'bogus'
> fatal: unable to parse 'diff.colormovedws' from command-line config

These double messages may be something we want to fix eventually,
but I think that the issue is not specific to the config callback of
diff API, but something the config API needs to support to allow its
users produce a better single message (the first part is merely
giving a more detailed explanation why Git was unable to parse, and
should ideally be folded into the second part).

More generally, even if git_diff_ui_config() was called, as long as
we do not do the "--color-moved" and "--color-moved-ws" operations,
the user shouldn't even get an "unknown mode" message, let alone
"fatal".  The above (and other existing uses of "return -1"s in the
same config callback) should actually become an example of what not
to do, as "diff HEAD" does not *care* what value that variable has.

But again, fixing that anti-pattern is a much larger change.  Once
we move diff.c to the more modern git_config_get*() based interface,
instead of the old style git_config() callback based interface, it
would become easier to update it so that the complaint will be given
(and kill the command) only when a variable whose value actually
_matters_ is unparsable.

Thanks.
