Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112FAC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803D20715
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="grMzaLw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgBGUOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:14:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56472 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 15:14:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DC6C4C505;
        Fri,  7 Feb 2020 15:14:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6kPSs0eFGVKyLHqFfLD7RjtReKg=; b=grMzaL
        w2s2L/CYPkpdg4DdKVBRsW60lRkjT6Gury/KNwexjQXHwz+PY3dWHpQz5SvPN7UD
        cCWLflIGaHj5sxYZI0Tob4bM2iAubtdRpKkSAju6nytqE0V4G3Ur65eNRB8HFLII
        9UncspcLUm4Nd3PqXYDdL1O1QsLi5gIiK1uMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jJNdBBkNJgJduCyqx17CBuC0+AhWPC4l
        CGoDiEES9dOwpa+4l2aWsvYBnLxiXLoQkBLfxv2nku9Mmnjefaz+PESKmpBgn1k2
        L98z3fZM1o/OKB4qBzaDNcg8FE0+WVPrNnFxU8udFJGwqLP1SlWC1EWp5fw8Q2WU
        XtpJXNbBNGk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13C044C504;
        Fri,  7 Feb 2020 15:14:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 542B24C503;
        Fri,  7 Feb 2020 15:14:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased branch during rebase
References: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
        <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
        <20200112121402.GH32750@szeder.dev>
        <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
        <20200124224113.GJ6837@szeder.dev>
        <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
        <20200131155228.GF10482@szeder.dev>
        <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
        <20200131161630.GG10482@szeder.dev>
        <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
        <20200207100247.GA1111@szeder.dev>
        <CAJ+F1CJc4kEvxLr-wLXpvXOC8YRVf5xP1HuJh9-cYa6mGmbyXg@mail.gmail.com>
        <xmqq1rr6444s.fsf@gitster-ct.c.googlers.com>
        <CAJ+F1C+qGo=6QrRw2299Apr2+-CHNWQyzWjvWbXJN5KC+T63AQ@mail.gmail.com>
        <xmqqwo8y2ovu.fsf@gitster-ct.c.googlers.com>
        <CAPig+cTWxj+dRiYZEEbfUA7=NiEF3crTaYCVGPR2qG-VEV+Y0w@mail.gmail.com>
Date:   Fri, 07 Feb 2020 12:14:29 -0800
In-Reply-To: <CAPig+cTWxj+dRiYZEEbfUA7=NiEF3crTaYCVGPR2qG-VEV+Y0w@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Feb 2020 14:29:11 -0500")
Message-ID: <xmqqpneq2lzu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7348951A-49E6-11EA-B7A5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> > > How about teaching "git branch --edit-description [HEAD]" notice
>> > > when/if HEAD is detached and always error out, no matter what
>> > > operation is in progress?
>>
>> What I meant by "no matter what is in progress" is not to special
>> case "during rebase", either.
>
> That would defeat the original purpose[1] of this submission, I think.
> As I understand it, the idea all along was to make this operation work
> during a rebase.

I know.  But I do not think it is a good thing to begin with.

While you are rebasing the branch X and get control back before
rebase finishes, you are *not* on branch X.  You are *preparing* a
new version of the history leading to the tip of branch X, in the
hope that once you are done, you would make that new version of the
history the history of branch X.  Until that happens, you are not on
branch X.

If you were on branch X, then "git checkout -m another-branch"
followed by some other operations, and then finally coming back with
"git checkout -m X" would work.  But it would not, because you are
not on branch X.

After all, you may well say "git rebase --abort" before you are
done.  Would "edit description" you do in the middle be reverted
if you did so?

It is bad for the user to blur the distinction between "detached and
not on X but preparing to update X" and "working on X to advance X",
and I think the original patch that started the thread takes us in
that direction.

Thanks.
