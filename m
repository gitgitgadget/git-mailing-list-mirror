Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27364C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE302208DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbhAQXFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:05:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58827 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbhAQXFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:05:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E704810A0A1;
        Sun, 17 Jan 2021 18:04:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6CY88Y0ERDbo
        lPCjk+fUQBJ+pUQ=; b=pysXvTkZzlTWNIHLz+GEFHSBcw9Cx/mF3fQi8sytaSUu
        az7LpwQht0pwNx7rZPdyLez6IxstN3FQMMXPDENbEnlzLh+0glLuuM5LA5eJRnxZ
        uIICad3p1O9Wskv7sCsp1KU+ptE5sTUodQMiXkQ46HGOyACyev4wlbe1q4MC3PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=udGqIg
        5JHXu5n8PwSBYr2Iyh33cUPkp9UAKEWcA+zxWJIsFCYU3TALkjExP0+gbMwl5I1U
        8ncRRTGgjXu7XEASOgv7OBl4joKv5riGDlKVbmGfU8BUeAeeRXgrSEjHMNbeCRVQ
        BGzR/1PmS/g5tdES667t+iVOp2Y3+I7l9Hpko=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA0BA10A0A0;
        Sun, 17 Jan 2021 18:04:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16F6910A09F;
        Sun, 17 Jan 2021 18:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
        <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <CAPig+cQBi7jdq64==U630Ht1YDcH+9komLNv-hZMnEhQ1Q-V9A@mail.gmail.com>
        <CAOLTT8QNhz4PrMhAt9y58n+-bEjeOE+xst8rzcg-x045Amw7iw@mail.gmail.com>
        <CAPig+cQr2kMNbhZgYn3e1V79Y5QnCbDKYzQnriEdae4FomK8Aw@mail.gmail.com>
Date:   Sun, 17 Jan 2021 15:04:23 -0800
In-Reply-To: <CAPig+cQr2kMNbhZgYn3e1V79Y5QnCbDKYzQnriEdae4FomK8Aw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 17 Jan 2021 00:11:41 -0500")
Message-ID: <xmqqo8hnkvwo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57BE1508-5918-11EB-BBE2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Jan 16, 2021 at 10:48 PM =E8=83=A1=E5=93=B2=E5=AE=81 <adlternat=
ive@gmail.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=88=
16=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=883:13=E5=86=99=E9=81=93=EF=
=BC=9A
>> > > +       git switch -c dev &&
>> >
>> > If someone adds a new test after this test, then that new test will
>> > run in the "dev" branch, which might be unexpected or undesirable. I=
t
>> > often is a good idea to ensure that tests do certain types of cleanu=
p
>> > to avoid breaking subsequent tests. Here, it would be a good idea to
>> > ensure that the test switches back to the original branch when it
>> > finishes (regardless of whether it finishes successfully or
>> > unsuccessfully).
>> >
>> >     git switch -c dev &&
>> >     test_when_finished "git switch master" &&
>> >
>> > Or you could use `git switch -` if you don't want to hard-code the
>> > name "master" in the test (since there has been effort lately to
>> > remove that name from tests.
>> >
>> I have little confuse about I can use` test_when_finished "git switch =
master" `,
>> but I can't use` test_when_finished "git switch -" `,
>> why=EF=BC=9F
>
> You may use either one. I presented both as alternative approaches.

I am sensing a bit of miscommunication here.  You sound like you
still believe either would work OK, but to me, it sounds like that
the author claims the one of them does not work for him/her.

I do not think the test framework itself mucks with the reflog to
make switching to "-" (or "@{-1}") break, so I find it implausible
that "switch -" form not to work, and unlike your "either is OK", I
have a moderately strong preference to use the "go back to the
previous one, whatever it is called" form.

Thanks.
