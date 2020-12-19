Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FEC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DC223B54
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgLSSw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 13:52:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59774 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLSSw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 13:52:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 002B0117FFC;
        Sat, 19 Dec 2020 13:52:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r8YFcYZZs2RzOvBYrgkpo08XqqU=; b=XIkB6y
        r1H12ohiwgFWClaw60b0j1ETEdj64NzjwrcsCd4TCTixVxnEVgShIQ538FkzKzz2
        KIK5bPz92oYmuzjzPU55LnqGOGA7hDFOxAu6fbdC0nwiJeSSrLmL8mS4iFf04VAY
        P0U8HC7X3cS9P3ptZNlJKRCQ7M2iDVZnWvJSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BO1IR7xAny47jUyANnNn1bwo0mx/vfN4
        12WCHRhBfyo8RalyNcx7+NzRLI6hbQC+lGBA/W0amvjg+Jvd2JuLTBngTD4T7CPe
        ic89D3dMoYTCcp+Nq7hRcW/azidpFJkuPirkOHWZDU5orjhua+UQjhZUm/ud6RZo
        5t+GDrBqbdk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECF7C117FFB;
        Sat, 19 Dec 2020 13:52:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D905117FF7;
        Sat, 19 Dec 2020 13:52:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
        <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
        <5fdaef83a40ba_d0e26208f6@natae.notmuch>
        <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
        <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
        <20201217175037.GA80608@ellen>
        <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
        <20201218023534.GA117762@ellen>
        <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <xmqq3603v3a0.fsf@gitster.c.googlers.com>
        <5fdc998216c89_104e15208da@natae.notmuch>
Date:   Sat, 19 Dec 2020 10:52:09 -0800
In-Reply-To: <5fdc998216c89_104e15208da@natae.notmuch> (Felipe Contreras's
        message of "Fri, 18 Dec 2020 05:58:58 -0600")
Message-ID: <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D4A5FEA-422B-11EB-A1DE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Another reason why allowing users to disable the feature per tool is
>> important is because as far as I know we have kept the mergetool
>> framework to allow adding a tool that can merge binary data, and
>> leaving these three files pristine was one ingredient for that.
>> With only a single knob, we would be making a decision to declare
>> that such a tool is unwelcome, which is not quite acceptable.  I
>> expect that users would want the new feature most of the time
>> because they would be managing text files more of the time, and
>> having only a single knob would force an unnecessary choice on those
>> who want to use such a binary-capable tool as well.
>
> I can't imagine what that binary data could look like, and how any tool
> could represent that to the user.

What I had in mind are use cases like merging "comment"-ish part of
media files (e.g. exif in jpeg, id3 in mp3---things like that), as
I've heard some people do use Git to manage their photo collection.

Of course, I can imagine that a cartoonist first draws a background
picture, cop es it twice, and then draws a dog on top of the
background in one copy while drawing a cat in the other.  You should
be able to merge the resulting two pictures cleanly by following the
three-way merge idea (take what got changed on only one side plus
what did not change--anything else is a conflict) as long as these
animals do not overlap.  You probably can even do an equivalent of
-Xours (not --ours) to essentially say which object is closer to the
viewer in a conflicting case.

> But either way "git merge-file" fails on those cases, so we can just
> check if the file is empty, and bail out.

Catching failures from merge-file and reverting back to the original
behaviour would be an improvement, if the code in the earlier
iteration was not checking errors.  But I would prefer not count on
the tool always to fail, as there are image file formats that appear
to be text that are unreadable to humans (like pnm), and my primary
reason for configurability is as an escape hatch to be used in cases
where we do not anticipate here.  Listing "what about this case, it
does not break" million times would not help us here.

With per-tool enable/disable option, the users do not have to rely
on failure from merge-file anyway.

Thanks.
