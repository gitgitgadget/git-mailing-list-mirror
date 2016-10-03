Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD1D207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbcJCWyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:54:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62274 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751725AbcJCWyE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:54:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3805428DB;
        Mon,  3 Oct 2016 18:54:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9zWfi+XL20KdBL7K7bOsGG83cnU=; b=VczzV8
        doQHIxvnAK0ISO5jZnMl/Edr9WZAifNLveFqNADT8/LH7swivndR7qcyJYwgaLSC
        9hV5Qq4bWXo9uGjPhM5Xt9oB/8yJwWt2s6V/xj1BC5UpTZkZfDoUgiVdwmGcRndB
        P6N0aiP9DiEQB+w8QMmlgi2ZgjrSRIMT8a5HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yWXeHYMMRif2fw0+jGfTiKebgOHNyU9r
        JSGrHlNvOX2ht59aRZHt8f/453Ju/gSJxTARa4Brx1dUM0OlmOo8sFajzj62Jci2
        PlHETNYIZ37IzTvWfGu+SxtTkIZR637dM7AIU9bpVRiP60dog4W77pMPBUq4zF04
        r98swQw444Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC635428DA;
        Mon,  3 Oct 2016 18:54:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 786CE428D9;
        Mon,  3 Oct 2016 18:54:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Jeff King' <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http: http.emptyauth should allow empty (not just NULL) usernames
References: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
        <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
        <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
        <20161003215840.6ihqjtplkcsporiw@sigill.intra.peff.net>
        <b7e31e9b13494f94b5bd6fff5fc55af0@exmbdft7.ad.twosigma.com>
Date:   Mon, 03 Oct 2016 15:54:00 -0700
In-Reply-To: <b7e31e9b13494f94b5bd6fff5fc55af0@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Mon, 3 Oct 2016 22:26:00 +0000")
Message-ID: <xmqqk2dp3uyf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47563B76-89BC-11E6-8303-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

>> > > I dunno. The code path you are changing _only_ affects anything if
>> > > the http.emptyauth config is set. But I guess I just don't
>> > > understand why you would say "http://@gitserver" in the first place.
>> Is that a common thing?
>> >
>> > I have no idea if it is common.  I know that we do it.
>> 
>> I guess my question is: _why_ do you do it? Or more specifically, does
>> http://gitserver.example.com" with http.emptyauth not work, and why?
>> 
>> From your response, I _think_ the answer is "no, it doesn't, and I have no
>> clue why".
>
> That was true historically. 
>
> I just tried our old version of git 2.8 (that is, before this patch, and before the libcurl upgrade), and http://gitserver.example.com *does* seem to work with http.emptyauth (and does not work without).  However, http://@gitserver.example.com does *not* work with http.emptyauth, and *does* work without.
>
> After the libcurl upgrade, but before this patch, http://@gitserver.example.com does *not* work with http.emptyauth, while http://gitserver.example.com does.
>
> And finally, after the upgrade and with this patch, both urls work.
>
>> So I dunno. It is annoying not to know what is actually going on, but I'm
>> OK with it if we don't think there's a high chance of regressing any other
>> workflows (which I guess not, because http.emptyauth seems to be a
>> Kerberos-specific hack in the first place).
>
> Yes, I think this is all Kerberos-only.

Now, perhaps with these back-and-forth, hopefully you have enough
material to update the proposed log message to clarify so that next
Peff won't have to ask "would it be common?  why would you do so?"

Thanks.
