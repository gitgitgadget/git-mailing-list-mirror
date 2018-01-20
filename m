Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE80F1F576
	for <e@80x24.org>; Sat, 20 Jan 2018 07:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeATHOx (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 02:14:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51782 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeATHOw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 02:14:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0F85C5E7B;
        Sat, 20 Jan 2018 02:14:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x5IZxcRJHVuG
        y0uTXgVFbHOdo1I=; b=keTn7Pf0KdGN1fT+fQz7ZlmPPDESTn1iES18g9Jta4Zi
        C2oVJ0yIN61sXxfMvrwdbx2/fYXws31CMT2yHgOtXhawHIcHB9mYpW7LyaO/W+nz
        ciL1cmX5KwHhlhAwU4TtxpqkBoRKNht/SRZhcZpXyehy2wMjzA8S6tgMyVNNjAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ENxR/6
        DBZEfmg7MKbrNJfFXekbRm7w1p//RywHscU51wyDW7ev9kLdHZ1nk11jwnYa8rfx
        BzUGL/1KvNW5g2AqlVuAI5vITfIIT8l+WJa/3v8MBp2wyXxXub8xhpEzZ9AkOwFR
        dB2ScgylUXnKVD6sD9xyur1g+rMfmFkbEJuWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9400C5E7A;
        Sat, 20 Jan 2018 02:14:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DA8FC5E79;
        Sat, 20 Jan 2018 02:14:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'git mailing list'" <git@vger.kernel.org>
Subject: Re: [RFE/RFC] format-patch/diff via path
References: <018601d391b7$8e8686a0$ab9393e0$@nexbridge.com>
Date:   Fri, 19 Jan 2018 23:14:49 -0800
In-Reply-To: <018601d391b7$8e8686a0$ab9393e0$@nexbridge.com> (Randall
        S. Becker's message of "Sat, 20 Jan 2018 01:26:02 -0500")
Message-ID: <xmqqinbxngra.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9B1AC97E-FDB1-11E7-B897-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I=E2=80=99m still a bit perplexed by some behaviour seen today, and am =
looking for a clean way to deal with it that the documentation does not m=
ake clear. So, I=E2=80=99m asking in a different way. Suppose a graph of
>
> A---B---C---D---E
> \      \               /
>   \----F=E2=80=94G----/
>

An ASCII art that is not drawn for fixed-width font is by definition
understandable only by the person who drew it X-<.  I am guessing
that F is a child of both A and B (but I am not sure, as I do not
see a reason why it should even be a merge to begin with, so my
guess is likely to be wrong), and E is a merge between D and G.

IOW, I am guessing that the below is the equivalent of what you drew
for those who look at the picture in fixed-width font:

    A---B---C---D---E
     \   \         /
      .---F-------G

> When trying to perform a format-patch from B to E, I was seeing
> commits B-A-F-G-E rather than what I wanted B-C-D-E.

Assuming that E is a merge, format-patch output should not show E
anyway (i.e. think in terms of "git log --no-merges --reverse",
instead of fearing that format-patch is somehow more magical---it is
not).  So if you want to show the comit B, C and D (meaning three
patches, i.e. "diff A B", "diff B C", and "diff C D"), then you
would do "format-patch A..D", not "format-patch A..E".  If you meant
that you are not interested in the change between A and B, then the
range would be "B..D" instead of "A..D".  Ending the range at "E"
means you want to see what is reachable from E, and unless you say
you are not interested in G, you would get G, if you only say you
are not interested in A (or B), as G is not reachable from A (or B).

It is unclear how you told format-patch when "trying to perform a
format-patch from B to E" from your description, but if you said
"format-patch A^..E", it is likely that you would have seen all
commits in the depicted part of the graph except for merge commits.
