Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E4620969
	for <e@80x24.org>; Mon, 27 Mar 2017 00:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdC0Agv (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 20:36:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52377 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751577AbdC0Agt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 20:36:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E056717D5;
        Sun, 26 Mar 2017 20:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VSuvpkWfW5ya
        8ZbtpZWcnPsvllo=; b=yDVdN9S5YRK+jjlYyiMFsQVknWLZ94M6o/rG+I/ehT+e
        bW3QfuSpweDjPNl9fPXaNs7fyKPWyqx5zvBrF9urHzSLzCcoekkgu/uPr7Td4loK
        GErWY8Qe/nvEEkcAgnS7gdzy18wjL3VbUpjurh5FhmbmBhZcSIeytmv1L5de+lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kvpHbs
        H/TMnVBLJVegGUPKigifvjuH1vAnDw/NX86U+KZL5bbDnNuuAf9sziMrsl+TrlvZ
        82WENw7vzmN+Z+4HRiACLQ0gIzkHjVvY0t9TnKoDny3Bk2Z8Docl3nhSa83Q76xS
        TV/cFKdEIBCvj7ZFdtYVfuKUmAs7MqxIX1+FQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 975AA717D4;
        Sun, 26 Mar 2017 20:36:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0743A717D3;
        Sun, 26 Mar 2017 20:36:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] rev-parse: match ^{<type>} case-insensitively
References: <20170326121654.22035-1-avarab@gmail.com>
        <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
        <20170326121654.22035-4-avarab@gmail.com>
Date:   Sun, 26 Mar 2017 17:36:21 -0700
In-Reply-To: <20170326121654.22035-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 26 Mar 2017 12:16:54 +0000")
Message-ID: <xmqq60iv4ku2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66B2DD60-1285-11E7-9C3B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the revision parsing logic to match ^{commit}, ^{tree}, ^{blob}
> etc. case-insensitively.
>
> Before this change supplying anything except the lower-case forms
> emits an "unknown revision or path not in the working tree"
> error. This change makes upper-case & mixed-case versions equivalent
> to the lower-case versions.
>
> The rationale for this change is the same as for making @{upstream}
> and related suffixes case-insensitive in "rev-parse: match
> @{upstream}, @{u} and @{push} case-insensitively", but unlike those
> suffixes this change introduces the potential confusion of accepting
> TREE or BLOB here, but not as an argument to e.g. "cat-file -t <type>"
> or "hash-object -t <type>".

It's not "potential confusion".  This closes the door for us to
introduce "TREE" as a separate object type in the future.

If we agree to make a declaration that all typenames are officially
spelled in lowercase [*1*] and at the UI level we accept typenames
spelled in any case, then we can adopt this change (and then we need
to update "cat-file -t" etc. to match it).

I do not at all mind to see if the list concensus is to make such a
declaration and permanently close the door for typenames that are
not lowercase, and after seeing such a concensus I'd gladly
appreciate this patch, but I do not want to see a change like this
that decides the future of the system, pretending as an innocuous
change, sneaked in without making sure that everybody is aware of
its implications.


[Footnote]

*1* "officially spelled in lowercase" is necessary to avoid
    confusion, because we are not making typenames case insensitive,
    allowing an object whose raw-bytes in its loose object
    representation before deflating begins with "COMMIT" and take it
    as an object of <commit> type.  Instead, such a declaration will
    make such an object an invalid one (as opposed to "object of an
    unknown type", as it currently is).

