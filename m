Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04E11FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 18:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbdFMSaC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:30:02 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34348 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdFMSaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:30:01 -0400
Received: by mail-pg0-f51.google.com with SMTP id v18so64306751pgb.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WgP+UKSXKWcPY5iUWhOo9z7g8Fkj5+0BK9tlp/D3wUY=;
        b=VRGkCTF5Ywv+ZU5Z778IXgJHiQZpc1eVv2rfMvE83h/SnnAGaNu7J+bQ9lXy/F4z0q
         JPWwzCO7QinK7j0emItwX5SrQk+uF/EmRRAvuW1UigbDjURJW80+45WLKPDKTPFmucj5
         /rFuJOszesWQWYl3mpZU+NTA/BAc6rY9FziFSybTsa7E6hmMgZx+R8NXvuxxNUl2OOMB
         bt2j1WQxjAFnhrwi7M6ullC+gn8GHGA5yjJe+oQqwDvs3vhz5HMZULArqCVnALYuPElD
         rYkA+AL1D/MHnz6rFUaV1PigrLUtNBtCXvmspiydRZd3r3peHgPb6BE6Ws/0iopmOZN1
         IvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WgP+UKSXKWcPY5iUWhOo9z7g8Fkj5+0BK9tlp/D3wUY=;
        b=YDhyNiN3vbTkEQlsUGYxuWt8QJa0uu1ZNSa0WZjvzLlco/XGNIaqqgMYZQYlAjBopK
         SEK5CcsPxX06y4lJyJ9C6StCLt/cLpgSY2JyJqAugRCCzN0nUP/me0pjJVXturzFQhHc
         q+yry6GI2JmCVXAB6To/Rxbg4g7KEwZa5MEAJ00riR+Pze5aWqJvK3ND4Ydt4wqQK+qd
         X8kHtmvXQc7BTb0BeJ3eRMdocSEICPk1IA2t4kLXBclAfN10At/288IkCk/IxIl5gg5p
         yQR6gbLRIdJrQU6W+6GAtqL9or4URRPZTIlEZBQtMtldCb4oKmc7STW5GukJcrwyJtEL
         r+7A==
X-Gm-Message-State: AKS2vOy88oeuDVcw7kAgxrkKDVZ7TgoZxDSFjlYK5DJxqphIDhM/sMeg
        6+Sw8Lk9HRgaJbkg1yU=
X-Received: by 10.98.100.8 with SMTP id y8mr821403pfb.79.1497378600807;
        Tue, 13 Jun 2017 11:30:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id p186sm21178827pga.32.2017.06.13.11.29.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 11:30:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org
Subject: Re: [BUG] add_again() off-by-one error in custom format
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
        <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
        <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
Date:   Tue, 13 Jun 2017 11:29:59 -0700
In-Reply-To: <d229403a-d078-87b4-f3e8-89058fa4b548@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 13 Jun 2017 20:09:17 +0200")
Message-ID: <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Indeed, a very nice bug report!
>
>> I think the call to format_commit_one() needs to be taught to pass
>> 'magic' through, and then add_again() mechanism needs to be told not
>> to cache when magic is in effect, or something like that.
>>
>> Perhaps something along this line...?
>>
>>   pretty.c | 64 ++++++++++++++++++++++++++++++++++++++--------------------------
>>   1 file changed, 38 insertions(+), 26 deletions(-)
>
> That looks quite big.  You even invent a way to classify magic. 

Hmph, by "a way to classify", do you mean the enum?  That thing was
there from before, just moved.

Also I think we do not have to change add_again() at all, because
chunk->off tolerates being given a garbage value as long as
chunk->len stays 0, and add_again() does not change chunk->len at
all.

Which cuts the diffstat down to

 pretty.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

> Does the caching feature justify the added complexity?

That's a good question.  I thought about your second alternative
while adding the "don't cache" thing, but if we can measure and find
out that we are not gaining much from caching, certainly that sounds
much simpler.

>
> - Don't cache anymore, now that we have placeholders that change output
>   on top of the original append-only ones.  Yields a net code reduction.
>   Duplicated %h, %t and %p will have to be resolved at each occurrence.
>
> - Provide some space for the cache instead of reusing the output, like
>   a strbuf for each placeholder.  Adds a memory allocation to each
>   first occurrence of %h, %t and %p.  Such a cache could be reused for
>   multiple commits by truncating it instead of releasing; not sure how
>   to pass it in nicely for it to survive a sequence of calls, though.
>
> René
