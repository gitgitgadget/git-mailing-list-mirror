Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F443C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E470F60D42
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhKNSG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:06:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64317 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhKNSGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 13:06:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6F4D14D98D;
        Sun, 14 Nov 2021 13:03:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yLpNd3i80xNp
        oAnbC35RrcJnMsEKb5CiZvLp9JpO5K8=; b=Urxsdi6JeqlLW9NYA2WXO7yEjRwW
        gmu9kRRT5nQgISOI8eGkj2+uXlUFLoj6p2dR7f5AX1t90bRXfd/qNQ3Xw05ypVcw
        gEgBa8yxfpJim/SW3iPjecGmsAIQMqHNTKKwMJpwT8OM8e1xeIofBrFWzUqUOTST
        1xNdVy8wAK0rPCY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C069614D98C;
        Sun, 14 Nov 2021 13:03:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DB3114D98B;
        Sun, 14 Nov 2021 13:03:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is 'for (int i = [...]' bad for C STD compliance reasons?
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
        <xmqq7ddbme7q.fsf@gitster.g>
        <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
Date:   Sun, 14 Nov 2021 10:03:23 -0800
In-Reply-To: <211114.868rxqu7hr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 14 Nov 2021 15:28:35 +0100")
Message-ID: <xmqqilwulims.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 298A132C-4575-11EC-AA96-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Also, our code does not introduce a new variable in the first part
>> of "for (;;)" loop control, so even if the original lacked decl for
>> "i", the posted patch is not how we write our code for this project.
>
> Just curious: Out of preference, or for compatibility with older C
> standards?

The latter.

cc0c4297 (CodingGuidelines: spell out post-C89 rules, 2019-07-16)
adds a few "weather balloons say these are OK" together with this
exact one as "not yet allowed".  We (at least, those of us who have
enough knowledge and authority to propose changes to the guidelines)
all know that particular feature is a nice thing to use if everybody
we care about supports it [*1*].

Here is the thread that resulted in the relevant part of the
guideilne.

https://lore.kernel.org/git/CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQM=
t=3DV38w@mail.gmail.com/

The "another patch that tried to use it late last year" the thread
refers to is
https://lore.kernel.org/git/20181114004745.GH30222@szeder.dev/

If I am not mistaken, Carlo added gcc-4.8 CI job to catch these
recently?

Now, "Centos 6 is no longer" cannot be called a good response to
this message.  We stopped at seeing the first failure, and breakages
on other platforms were not even counted back then.  To those whose
compilers also barfed, it was sufficient that we pulled the plug
after seeing a failure on Centos 6.

But two years may be long enough for us to try again.  If we want to
pursue it, we'd need to raise a weather balloon that would break
compilers that have been happily grokking our code loudly by being
in a central place that will never be conditionally compiled out,
and is easy to back out by being in ultra-stable location.

cbc0f81d (strbuf: use designated initializers in STRBUF_INIT,
2017-07-10) is an example that Peff found and used a great such
location.

I know you are capable of reading Documentation/CodingGuidelines and
running "git blame" on it, and then use mailing list archive to dig
to find the answer, and it was a bit of disappointment to see this
was asked as a question, rather than a well researched "now after
two years, let's try this again".


[References]

*1* https://lore.kernel.org/git/xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.=
com/
