Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34607C433E6
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADD22080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="auwqTmPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgH0XXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:23:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63177 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgH0XXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 19:23:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 895C775CD0;
        Thu, 27 Aug 2020 19:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PpIjePlyFFlABasOuMXmSDLB6Hg=; b=auwqTm
        PHUedKdkdqoyCuNIXladCjrEtGIYzKHTC7leUfb4eLNooCL+t1JXsUFrwpP0CL9q
        vmMsW2OraSReHhwYkyls7Jgk/AkjwshUU4oHjbv+gDs72bL08AvK6e6/S/HVQDYd
        q3JTpVSV7GKSNJf6uDQI+j+mpwvImFHaT5h7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W1vep2aqSNPOqyijEUpot3lwYoSLEdbV
        k4KBsRBFr/8m08JoS7HL++LMNZYX6y0ofOTQ25uQMZFHcr2nrt95bmEruVe8mSLr
        uW2v+x7MnVOgWyyXLC9NBEFjXqKsq+oF/ek8fsy5QpIgV0pK/nNlOt5tfDDaBsEC
        EWtwNdx7Elc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8222175CCF;
        Thu, 27 Aug 2020 19:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F15B675CCE;
        Thu, 27 Aug 2020 19:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <C585GT9K2V93.4O470Q21FXFD@homura>
Date:   Thu, 27 Aug 2020 16:23:40 -0700
In-Reply-To: <C585GT9K2V93.4O470Q21FXFD@homura> (Drew DeVault's message of
        "Thu, 27 Aug 2020 18:59:01 -0400")
Message-ID: <xmqq4konptab.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57A38FD4-E8BC-11EA-B17C-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> On Thu Aug 27, 2020 at 6:57 PM EDT, Junio C Hamano wrote:
>> To help those who do not want to add this header, it would probably
>> be more helpful to tell what to do when prompted (like "you can give
>> an empty answer to tell the command that you are not responding to
>> any message").
>
> I don't like this solution. We should make it harder to do the wrong
> thing, and easier to do the right thing.

Carlo and I were discussing how best to describe the behaviour we
have better to the users, which is unrelated to any code change that
would be required to "make it harder make it easier."  

We need to do so to help users in the meantime, before any behaviour
change (which need to happen over several releases, as outlined
earlier) happens.




