Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8DF1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJBI7n (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 04:59:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBI7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 04:59:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D45683B2E;
        Wed,  2 Oct 2019 04:59:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yiy+6uov/mfMT/zgnQ8jlE1E2mg=; b=tXCSCC
        ux5NCHrlGlTPrBwbrl4Di66Murkdlypxw7UbvUiK3ZldgIfN5tzz4qHqAyTzIHu2
        A+TxZXRfy8f2Nr4i7W9+h2uuodd8oYUNP4Z4qFnasMROxts63wpY7kd/oTteWbse
        ej94vnHmIkxoLhGk0uFueNSuxls+A1/6ysFBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rXkZY9KQh1IF+FpQJ/zYCNlK7A49965X
        2LXlVt2ntn/0gPWrZfGcR0g8JN+RKlnaOTfax7hRwMUwRLXh5QUVwuOKPcXIXKCb
        koU8U3+t3AQybWk4cEONlfH1g7PYNdBhELKPAXJwm2Q55F511lieB7ecl+V3HlV1
        tro8nzVeZ3U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55CF683B2D;
        Wed,  2 Oct 2019 04:59:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82F3283B2C;
        Wed,  2 Oct 2019 04:59:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 1/5] sequencer: update `total_nr' when adding an item to a todo list
References: <20190925201315.19722-1-alban.gruin@gmail.com>
        <20190925201315.19722-2-alban.gruin@gmail.com>
        <xmqqbluzhp8g.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910021005050.46@tvgsbejvaqbjf.bet>
Date:   Wed, 02 Oct 2019 17:59:35 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910021005050.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 2 Oct 2019 10:06:04 +0200 (CEST)")
Message-ID: <xmqqh84red54.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F636DCE2-E4F2-11E9-B5B7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 2 Oct 2019, Junio C Hamano wrote:
>
>> Alban Gruin <alban.gruin@gmail.com> writes:
>>
>> > `total_nr' is the total amount of items, done and toto, that are in a
>> > todo list.  But unlike `nr', it was not updated when an item was
>> > appended to the list.
>>
>> s/amount/number/, as amount is specifically for something
>> that cannot be counted.
>>
>> Perhaps a stupid language question but what is "toto"?
>
> "in toto" is Latin for "in total", if I remember correctly.

And "Toto" can also be "Toyo Toki", one of the two large and well
known Japanese manufacturers of porcelain things you see in
bathrooms--oh how appropriate in this project ;-).

> But in this instance, I think it is merely a typo and should have been
> "todo" instead. That is what the "total_nr" is about: the number of
> "done" and "todo" items, added together.

If I were writing this, I would probably say "... the total number
of items, counting both done and todo,..." and with 'counting both'
I wouldn't have been so puzzled.

Thanks.

>
> Ciao,
> Dscho
>
>>
>>
>> > This variable is mostly used by command prompts (ie. git-prompt.sh and
>> > the like).
>> >
>> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> > ---
>> >  sequencer.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/sequencer.c b/sequencer.c
>> > index d648aaf416..575b852a5a 100644
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> > @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
>> >  static struct todo_item *append_new_todo(struct todo_list *todo_list)
>> >  {
>> >  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
>> > +	todo_list->total_nr++;
>> >  	return todo_list->items + todo_list->nr++;
>> >  }
>>
