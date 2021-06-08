Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FDC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AA861183
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhFHQQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:16:43 -0400
Received: from mout.web.de ([212.227.15.4]:46103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFHQQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 12:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623168884;
        bh=5MokERLg8ogrRDqmDcYkRhCJz1oGmzwyF5WJytqliE8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T5JPS6BPk5IuB2D+JHRSro7VvCOrijQQygOWsXThnOLLVj6R7HQUfUU7IyfrwKHLu
         b/hStFsoa6a2VegqQJ02ldY8HxvZwo6CUkA0YNOr/MYpwTmEEUub0uKdjwrx8ue81n
         iqSGMVbfVH5Tpu7Vz3fSc9C4WjhcDaeDhqsluX80=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lfipe-1l1OF41JEI-00pMYV; Tue, 08 Jun 2021 18:14:44 +0200
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
Date:   Tue, 8 Jun 2021 18:14:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87wnr4394y.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORCB4o+jgZ+c7f8KnqvR1BE55ge9SAGKxCkg2HEmX5/vXKrUcZh
 Mqfo/IPnXonVmvpdWEBff18s9WtsyIOuddDvaQXwe9FnTsuehMaU37QNIUS3DgCjH7cMg2v
 w/8mgueD59DJJ8Swx7kphKmaZdLp0y+fpyhBRC8fvU5+SsCTZz975hxJdTW37jc4NB/ULVr
 224Uu6JBT4DshQf/N5jMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNeQB72T+3M=:UvN5Wn9DWfKqulL1Rrzlm3
 Q+N97BL9QDRfRjtWC52qG/YwpJheNXfGFVE5+yeDjgteK6nUCHwOkWj6jgEbuHCtlOirDTVGa
 jJnzrC7ekfgXtnph/Tb8gtAXUkJPYDHzA5BYP6lNUHQThSV56EZ8nj7szG1pQN0zBIklec9lZ
 EtZv5YOalgJdpH7LC6rN623QWUYLdwZ2TBxsfXs6r/YKox0jLBAPDjTFnbbblfkZP0I5EF9dz
 AjS+vRdqhPp67aDweNrpBQsatFQ9PAeyMsLgnyF56ifI/m59yJG5OTZ4BcEyGQXtzWdi6HOcP
 nN4Ey5MsEtjayKLk+u2lIA+gfiatjDkjXPbKAWt3vZAMCgr0uH3U6Z19lweRAX/oXtRsGStOf
 qtVrFJb+Q8/u5m7GeNIDj+j181bPeI6IYZiqxuYokrLE3NlP6jhvgXb3RTBpRvG5kzWqnSzAy
 R2ZPnLHnNzauC6Z7TCQQQLg9PAppXQK+oxEOhEijYur+W9LV1JB2kki1kKF3IFRrZz6B2IDwx
 cK+SvvYjO2iC+5j4S/oX5SYm82QEDTrTMB1ubdVQm0zwyo9HcPXf/a6ds6LPZLH3xtiov+rI2
 rozbYtNfApvj71oNe0e8GKNR0pmt8YHsgf+IODe5F8AI2Bt4chKYIf+UAtsN5/4Uxu3KS7trU
 QOzlqpWvrxTU4at7/3i8XHdjSEeQs26rpz/zvpRcmYfnBtq96nPGIoA3tnSTWgKF1kmotxJb7
 xcx4UxwKYH6MHuNLKdkUG4XAvi1zCppNWdxPuzX7GQ5Z8f7T7gSMnwKh8BTeiQOsX11p5Gyrf
 LGrrU77fz67U0BQ42dQvbuLSnIZSS3AgNQXj5T300pyv/S2DJxAKnDCPbiPA/7rxhE7m/9TmP
 K8v8vmGuqgui4ii0WRlK21T8je85NUMV/N2PvZapyDj7ohKTlgGnzpLEm+RutPaGWNgj90GkP
 e8qTpPBBFn6c6vphvF+TYBddiUdApzzzgGfL9IqWaBKIN4f18pUNSkaE/LR8rNH9u5tNTXIBB
 QZ1fGqjiw0opZ/UUcWs2CeupSRAafif7jpUtvIpgwTaVbHlGvCabvDR9clFuNL3JOLO9yXZUf
 rNqOtbVia9XmcgxeRi/izzYvO/W6LlAaaiv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.06.21 um 12:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Jun 08 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> So I think this pattern works:
>>>>
>>>> 	for (i =3D 0; i < nr; i++) {
>>>> 		display_progress(p, i);
>>>> 		/* work work work */
>>>> 	}
>>>> 	display_progress(p, nr);
>>>>
>>>> Alternatively, if the work part doesn't contain continue statements:
>>>>
>>>> 	for (i =3D 0; i < nr; i++) {
>>>> 		/* work work work */
>>>> 		display_progress(p, i + 1);
>>>> 	}
>>>
>>> But yes, I agree with the issue in theory, but I think in practice we
>>> don't need to worry about these 100% cases.
>>
>> Hmph, but in practice we do need to worry, don't we?  Otherwise you
>> wouldn't have started this thread and Ren=C3=A9 wouldn't have responded=
.
>
> I started this thread because of:
>
> 	for (i =3D 0; i < large_number; i++) {
> 		if (maybe_branch_here())
> 			continue;
> 		/* work work work */
> 		display_progress(p, i);
> 	}
> 	display_progress(p, large_number);
>
> Mainly because it's a special snowflake in how the process.c API is
> used, with most other callsites doing:
>
> 	for (i =3D 0; i < large_number; i++) {
> 		display_progress(p, i + 1);
> 		/* work work work */
> 	}

Moving the first call to the top of the loop makes sense.  It ensures
all kind of progress -- skipping and actual work -- is reported without
undue delay.

Adding one would introduce an off-by-one error.  Removing the call after
the loop would leave the progress report at one short of 100%.  I don't
see any benefits of these additional changes, only downsides.

If other callsites have an off-by-one error and we care enough then we
should fix them.  Copying their style and spreading the error doesn't
make sense -- correctness trumps consistency.

> Fair enough, but in the meantime can we take this patch? I think fixing
> that (IMO in practice hypothetical issue) is much easier when we
> consistently use that "i + 1" pattern above (which we mostly do
> already). We can just search-replace "++i" to "i++" and "i + 1" to "i"
> and have stop_progress() be what bumps it to 100%.

This assumes the off-by-one error is consistent.  Even if that is the
case you could apply your mechanical fix and leave out read-cache.
This would happen automatically because when keeping i there is no ++i
to be found.

stop_progress() doesn't set the progress to 100%:

   $ (echo progress 0; echo update) |
     ./t/helper/test-tool progress --total 1 test
   test:   0% (0/1), done.

I wonder (only in a semi-curious way, though) if we can detect
off-by-one errors by adding an assertion to display_progress() that
requires the first update to have the value 0, and in stop_progress()
one that requires the previous display_progress() call to have a value
equal to the total number of work items.  Not sure it'd be worth the
hassle..

Ren=C3=A9
