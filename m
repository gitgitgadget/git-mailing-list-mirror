Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F18F20960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdDMWlF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:41:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbdDMWlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:41:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9057A87B8B;
        Thu, 13 Apr 2017 18:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KFb3wZIQTzpr2VGYc10G19GDjuU=; b=PsrtVR
        aEYXVKMLGYQ7seoWVRPfNhERLocpUhlThB3DgWgQnNVAAaS0EXytT/0FzHylBrFO
        VO0CRloUd6DacSq3lsPSR4+gjlROtbooBW/MV2GmEhOKHh5e0IRXdnHxzGcDrARH
        4ooeFz7BWG5YEeYMoyekMt9T6bykrLsboYsMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uVYsNZUvijCqUhNSSsJfjQA8HEN6N+4s
        wiall2QI78c590EcCXTSB5rcYIdeBoZpv1+ni/FghxWLZq8OA5Q+eYHwL801yj5e
        Lg8a3K/9nQndozv8YE2ur1R2IMtgSHVXOsVOopaDCI4uMSB0twxqWRoehOQ8GIrH
        gMOHEyOflfc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87DD587B89;
        Thu, 13 Apr 2017 18:41:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E637987B88;
        Thu, 13 Apr 2017 18:41:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v1 0/3] travis-ci: build docs with asciidoctor
References: <20170411083309.58315-1-larsxschneider@gmail.com>
Date:   Thu, 13 Apr 2017 15:41:00 -0700
In-Reply-To: <20170411083309.58315-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Tue, 11 Apr 2017 10:33:06 +0200")
Message-ID: <xmqq37dcorr7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 456DABBC-209A-11E7-916B-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> this is a mini series to build the documentation with asciidoctor in
> addition to asciidoc on Travis-CI.

Overall, this looks sensible.  I didn't spot anything questionable
other than a minor style nit, i.e. write these

    make doc USE_ASCIIDOCTOR=1
    make -j2 doc USE_ASCIIDOCTOR=1

more like this

    make USE_ASCIIDOCTOR=1 doc
    make -j2 USE_ASCIIDOCTOR=1 doc

Having said that, I wonder if we get some interesting results out of
building the documentation twice, though.  By looking at the Travis
log with timestamps, we probably can see how long each build takes,
but that is much less interesting than learning if new versions of
text used mark-up that does not format correctly on one or the other
(i.e. catch documentation breakage early in each CI run), for
example.  I have an impression that neither AsciiDoc nor AsciiDoctor
"fails" in an obvious way that "make" can notice (i.e. they often
just silently produce nonsense output when fed a malformed input
instead).

Thanks.
