Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02F71F404
	for <e@80x24.org>; Tue, 16 Jan 2018 23:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeAPXqk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 18:46:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56923 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeAPXqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 18:46:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F52AD1055;
        Tue, 16 Jan 2018 18:46:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=djaQHK7ROa3/
        Si1QP0E4luX2Xyk=; b=L2F4cYQ3Uqwf5Qbs16w7V9wZUuC3mVDTmAEzHNsFk9FX
        wr6d2rIjJJyAFC1/klWR3P/uwTq+4Oy2FCH5nuGOrZfIlp7Dp3gF3wivqrvrNbov
        LBR7hpT45NQz+f92lyzsC8YqFRvr8GsvqvOW7TH+aoBZWya3gZ2eIcsuO2OORDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fIiPp3
        h6zEKYMjpMUu+IWC8LaEkeaMtqj2W0T2wdx0mAHzIKxIrfc9eRAfjfhAYu2N9zBW
        uOu1INSIAiFe6iGDtmHWQwtzLUZor2zFYMySeQPngsGToIZvc7FCW4f7voWcN9cf
        r57frCaILJl/jah5IYbwNaJ8FMRfZHXkgDl7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37E22D1054;
        Tue, 16 Jan 2018 18:46:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADB66D1053;
        Tue, 16 Jan 2018 18:46:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: support --git-completion-helper
References: <20180116103700.4505-1-pclouds@gmail.com>
        <20180116103700.4505-2-pclouds@gmail.com>
Date:   Tue, 16 Jan 2018 15:46:37 -0800
In-Reply-To: <20180116103700.4505-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 16 Jan 2018 17:36:59 +0700")
Message-ID: <xmqq4lnltlia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7EBDB26A-FB17-11E7-BA9B-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This option is designed to be used by git-completion.bash. For many
> simple cases, what we do in there is usually
>
>     __gitcomp "lots of completion options"
>
> which has to be manually updated when a new user-visible option is
> added. With support from parse-options, we can write
>
>     __gitcomp "$(git command --git-completion-helper)"
>
> and get that list directly from the parser for free. Dangerous/Unpopula=
r
> options could be hidden with the new "NO_GITCOMP" flag.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  parse-options.c | 37 +++++++++++++++++++++++++++++++++++++
>  parse-options.h |  6 ++++--
>  2 files changed, 41 insertions(+), 2 deletions(-)

I do not know if you need PARSE_OPT_NO_INTERNAL_GITCOMP.  The only
way to trigger this is by passing a rather long option (intended to
be used only by scripts), so unlike PARSE_OPT_NO_INTERNAL_HELP which
was an escape hatch to free a short-and-sweet "-h" to be retargetted
by a selected few commands, there may not be need for it.

Some day when everybody uses parse-options, it would be trivially
correct to declare that this is the right approach ;-) I am not sure
how much of the current completion script's hardcoded option list
can be reduced with this approach with today's code, given that the
bigger ones (diff and log family) are not using parse-options API at
all, but for the ones that already do use parse-options, I think
this makes sense.

Thanks for a fun read ;-)

