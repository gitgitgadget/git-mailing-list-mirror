Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDAA1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 17:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdC0Rqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 13:46:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59154 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751287AbdC0Rqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 13:46:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A14B27FA22;
        Mon, 27 Mar 2017 13:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZZ1RZhiyGom3
        S+ktgLv68cU0eXk=; b=VEbKGOh1FcBxJkWIGb2q6UhMiecjH++TaPulDoDfOCGK
        uiZH/zNPnAWD6mwHuVbCYRAqHL53tK56j8SFfx4t6K6Xt3k5YZPR2xil5dZ7tr9w
        Wvyic1OdqRzVG+1bBaOQwR69GtPGXGDkQIdAvr8tlCRZ6OdieSAbfWYInx/nZuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=etd1Cu
        zbNpjFDdhDXYleSpnz9IWaSCHQSarG1BcgZApgqGZEfRZhAMGUEpKcQu2/sE6/Xa
        bbPGhGU0euktFhW8TQRtKsmQlYf6fDCInxPEWClebB1x4neWYA/pIxVWAx0q51+v
        cYI9321JSmTCFjB19NaT/IPx+Q7dvIKbR1mig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 978C07FA21;
        Mon, 27 Mar 2017 13:45:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C16B17FA20;
        Mon, 27 Mar 2017 13:45:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] rev-parse: match @{upstream}, @{u} and @{push} case-insensitively
References: <xmqqa8874l8t.fsf@gitster.mtv.corp.google.com>
        <20170327111655.29941-1-avarab@gmail.com>
Date:   Mon, 27 Mar 2017 10:45:39 -0700
In-Reply-To: <20170327111655.29941-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 27 Mar 2017 11:16:55 +0000")
Message-ID: <xmqqshly1um4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31CB0DF8-1315-11E7-BB27-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Before this change:
>
>     |----------------+-----+------+-----|
>     | What?          | CI? | CIP? | AG? |
>     |----------------+-----+------+-----|
>     | sha1           | Y   | -    | N   |
>     | describeOutput | N   | N    | N   |
>     | refname        | N   | N    | N   |
>     | @{<date>}      | Y   | Y    | Y   |
>     | @{<n>}         | N/A | N/A  | N   |
>     | @{-<n>}        | N/A | N/A  | N   |
>     | @{upstream}    | N   | Y    | N   |
>     | @{push}        | N   | Y    | N   |
>     | ^{<type>}      | N   | Y    | N   |
>     | ^{/regex}      | N   | N    | N   |
>     |----------------+-----+------+-----|
>
> After it:
>
>     |----------------+-----+------+-----|
>     | What?          | CI? | CIP? | AG? |
>     |----------------+-----+------+-----|
>     | sha1           | Y   | -    | N   |
>     | describeOutput | N   | N    | N   |
>     | refname        | N   | N    | N   |
>     | @{<date>}      | Y   | Y    | Y   |
>     | @{<n>}         | N/A | N/A  | N   |
>     | @{-<n>}        | N/A | N/A  | N   |
>     | @{upstream}    | Y   | -    | N   |
>     | @{push}        | Y   | -    | N   |
>     | ^{<type>}      | N   | Y    | N   |
>     | ^{/regex}      | N   | N    | N   |
>     |----------------+-----+------+-----|

As we are not touching ^{<type>} or ^{/regex}, and it is obvious
numbers do not have cases, I'll trim this down to focus only on
things that are relevant while queuing:

    Before this change:

        |----------------+-----+------+-----|
        | What?          | CI? | CIP? | AG? |
        |----------------+-----+------+-----|
        | @{<date>}      | Y   | Y    | Y   |
        | @{upstream}    | N   | Y    | N   |
        | @{push}        | N   | Y    | N   |
        |----------------+-----+------+-----|

    After it:

        |----------------+-----+------+-----|
        | What?          | CI? | CIP? | AG? |
        |----------------+-----+------+-----|
        | @{<date>}      | Y   | Y    | Y   |
        | @{upstream}    | Y   | Y    | N   |
        | @{push}        | Y   | Y    | N   |
        |----------------+-----+------+-----|

should be sufficient to highlight that it was possible to safely
make these two things case insensitive, and we made so. =20

For that matter, I do not know the value of AG? field---it only
serves to show that @{<approxidate>} is an odd-man out and cannot be
used as a good example to follow, but I am too lazy to remove it ;-)

> Makes sense, replaced that note with that summary. Here's hopefully a
> final v3 with that change. I've omitted the other two patches as noted
> in the discussion about those two, I don't think it makes sense to
> include them.

Thanks.

> @@ -122,6 +123,9 @@ refs/remotes/myfork/mybranch
>  Note in the example that we set up a triangular workflow, where we pul=
l
>  from one location and push to another. In a non-triangular workflow,
>  '@\{push}' is the same as '@\{upstream}', and there is no need for it.
> ++
> +This suffix is accepted when spelled in uppercase, and means the same
> +thing no matter the case.

As the above text (including the original) does not explicitly say
that lowercase spelling is canonical, the new text is prone to be
misinterpreted that only the uppercase version is accepted.  I'll
do s/is accepted/is also accepted/ while queuing, but please holler
if there are better ways to phrase this.

Thanks.
