Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB741F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757690AbdKHAhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:37:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63049 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753513AbdKHAhV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:37:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11AF3B77F6;
        Tue,  7 Nov 2017 19:37:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LzPWG4DntI//
        g71DqtXsSDEfmgo=; b=tk5RZTGjJUbppwK/ZAZRgJ2QlwproE4WGrePVal23dw4
        6zuObriGCkJDXslX1SSwDFRBdCoXhYA1T7eyB92+PfWAbbHL/qqCBia0xWeX7drh
        N9Gff8qosbx8R5Q+GqrXersAVbCZJQK4fogm9FWuKF3AxtLvPfbzo73JCPrmq8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kw8Qes
        YeeoN5up1yhiE4tcD4A2ePVDxg9VVGx6dZFOh/oA1WdpCiyKJR/NUuLpNBpGzDCB
        7CsjrOGNShlA4T1ZXG21ZgQr2qsrfaDT6NjqRHhMh6UN3TEfF8XaVuGJKrpg6KLy
        3JliAG+fp/nfOeZXJvoZG/cfMRuVp1/sNy0O8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0999CB77F5;
        Tue,  7 Nov 2017 19:37:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75432B77F3;
        Tue,  7 Nov 2017 19:37:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Introduce git add --renormalize .
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
        <20171030162913.23164-1-tboegi@web.de>
        <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
        <20171107172659.GA11119@tor.lan>
Date:   Wed, 08 Nov 2017 09:37:19 +0900
In-Reply-To: <20171107172659.GA11119@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Tue, 7 Nov 2017 18:26:59 +0100")
Message-ID: <xmqqlgjhobb4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FADC07B6-C41C-11E7-BBBE-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> > +--renormalize::
>> > +	Normalizes the line endings from CRLF to LF of tracked files.
>> > +	This applies to files which are either "text" or "text=3Dauto"
>> > +	in .gitattributes (or core.autocrlf is true or input)
>> > +	--renormalize implies -u
>> > +
>>=20
>> OK.
>
> I think the fact, that clean filters are re-run, and re-evaluated
> in case they are changed, should be made more clear here.
> I don't know how to explain it better that CRLF conversion and/or filte=
rs are
> re-applied, this is an attempt:
>
>
> --renormalize::
> 	Normalizes the line endings from CRLF to LF of tracked files,
> 	if the .gitattributes or core.autocrlf say so.
> 	Additionally the clean and ident filters, if any, are re-run.
> 	--renormalize implies -u

That is certainly better.  Do we have an end-user facing phrase to
collectively call everything the "convert_to_git()" processing does?
When I talk casually about it, I'd call it the "clean" process (as
opposed to the "smudge" process) as a term that includes all the
things that Git does to massage contents in the working tree to
in-repository representation.

If we had such a term in Documentation/glossary-contents.txt, we
could even say

	Add contents of all paths to the index by freshly applying
	the "clean" process, even to the ones Git may think are
	unmodified in the working tree since they were added the
	last time (based on the file timestamps etc.).  This is
	often useful after updating settings like `core.autocrlf` in
	the `.git/config` file and the `text` attributes in the
	`.gitattributes` file to correct the index entries that
	records lines with CRLF to use LF instead, or changing what
	the `clean` filter does.  This option implies `-u`.

The point is to express that the CRLF/LF is a consequence (even
though it may be the most prominent one from end-users' point of
view) of a larger processing.

> [snip the TC. Adding line endings is good)

What is TC in this context?
