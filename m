Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1683F1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 17:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbcHYRZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 13:25:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753962AbcHYRZY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 13:25:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D42A4370A1;
        Thu, 25 Aug 2016 13:19:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nD40E1dir2H7
        DslC+NAAaeuspbE=; b=wNOqkcv/TrmpOrftZCcB/603yH1diAIJ5TVjDQuw/tz2
        nxqZ5cVg+VTvPjJ7+inezf1PCwHQI0gGmNEWlJBoeadqTrV3EeXuNkg9sCvZYsk3
        V3kdNMh0wdhSw0FEMbwphV6RhHy7invyulYohTCJ8y3SAPaD83DG30gTTDK0PWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RCi0hR
        07lLdU/vld6Gx+LKQMfG7wQZKudQJKvP91I9f2V5NF9D689v6C20Yp3P3lb83NNY
        4oq++oHHY6c5a1lbocq6oHmyPut6YSUgbhZpmtCnhc40KhfwaozDVUtwjMaBKKJV
        gjzPAfDlE8dLGUvduC12GECnFZL3UiJeW9J1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCE02370A0;
        Thu, 25 Aug 2016 13:19:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 622CD3709F;
        Thu, 25 Aug 2016 13:19:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] checkout: swap the order of ambiguity check for :/ syntax
References: <20160822123502.3521-1-pclouds@gmail.com>
        <xmqq7fb6rupa.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AnDoh-CZp8oa21YHcM3sxoTJZiK7fP+ecNyqd0-DBZAA@mail.gmail.com>
Date:   Thu, 25 Aug 2016 10:19:40 -0700
In-Reply-To: <CACsJy8AnDoh-CZp8oa21YHcM3sxoTJZiK7fP+ecNyqd0-DBZAA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 25 Aug 2016 16:21:25 +0700")
Message-ID: <xmqq60qoojf7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C7AA902-6AE8-11E6-B5B7-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Aug 24, 2016 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>>> It's not wonderful, but it's in line with how git-checkout stops cari=
ng
>>> about ambiguity after the first argument can be resolved as a ref
>>> (there's even a test for it, t2010.6).
>>
>> But that is justifiable because checkout can only ever take one
>> revision.  What follows, if there are any, must be paths, and more
>> importantly, it would be perfectly reasonable if some of them were
>> missing in the working tree ("ow, I accidentally removed that file,
>> I need to resurrect it from the index").  Does the same justification
>> apply to this change?
>
> I think there is a misunderstanding. My "after" is in "after the first
> argument can be resolved, check if it exists in worktree too, if so
> it's ambiguous and bail". This is usually how we detect ambiguation.
> But git-checkout does not do the "check if it exists..." clause.

Hmph.  The "case 4" in the function you touched says

         * case 4: git checkout <something> <paths>
         *
         *   The first argument must not be ambiguous.
         *   - If it's *only* a reference, treat it like case (1).
         *   - If it's only a path, treat it like case (2).
         *   - else: fail.

Did we break it recently?
