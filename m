Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51884C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 22:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B1D207FF
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 22:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmLv40UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAFWru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:47:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45868 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 17:47:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so27592886pfg.12
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3/E2yDWgx06aLcPf+lprIgDWB4FAuXQ2CoXoNvmjFQY=;
        b=XmLv40UDzD9Vp9zOEYcGkuypMJ5ns77eXW+Tx4qruSseQj8fPm8RfWcA2nqFnREAOT
         wiX+M+s5v6I3MPUgQC+kQy+5x6lvfiqPycLAbE1/WsvNgi9V0EwWyY6xJ7ODd8l/TAEv
         8MSt9bizLlEr94wzalewePXwZseaTwZmgbOcjcBouA5Xwb2PfBIYdM2kPfjXYYHxqwiI
         LTjSOElTrRmcCKcizQTW1CRTMVGNnGjM+d24ZwKzVe9ycs52KUngei1dEQ6MWNzpmmtF
         ZgZZCxf9vEax8wZDCeNkWy5SHiHOTT6NllLsiAUtHceEeUxOtrQNTQp7uko5oB9IVPX8
         KdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3/E2yDWgx06aLcPf+lprIgDWB4FAuXQ2CoXoNvmjFQY=;
        b=c13A2QLpcX67R4RhVr/K4ZrWhL6gFx+xdtzhX9b1vcJqaZRTe4FSP1+a/47W6BpgpH
         g1nGnVPkF0GHFWQC+yQ0w+z0bkIfrX8cazWsgiz/OrHkQ9Ev/+1wl7zBErlDkpHuOR+V
         +qoNJOsUqBcGC1h4VJ0I3Aq0JndOlLZcETjXNDwCdSnwhB+kYIa5kPwUVEk+JlZhsJ4t
         5Ek0T2FKXNiAEuQ0VvP4FxAmuBd2IaIjvWeheN1OCnbgzcNwpj2l9rsrH+cwx0aWFTdP
         Q18nwgF22TJ5e/5d8NKxt0n3MQPMhAtW0lA/oQQD2j5DCPNenSH7blucZTmb8+pgF6Eg
         nBlQ==
X-Gm-Message-State: APjAAAW6fAfquO/qyOAtH7ThcDF8OQKRZX+1sCyuHmjdRcYZ0uvEuzvl
        /tcVgaDv/u+nuk6zv1CcSec=
X-Google-Smtp-Source: APXvYqyme+6ewoyyXGIt/uRIuk9VOWiaYPBn75JZRY+hG0Pzo2ayAhf8rfBMNr7b0r+t0i5SBEpyDw==
X-Received: by 2002:a63:5818:: with SMTP id m24mr113760695pgb.358.1578350869484;
        Mon, 06 Jan 2020 14:47:49 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id g11sm72675128pgd.26.2020.01.06.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:47:49 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:47:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [Outreachy] Return value before or after free()?
Message-ID: <20200106224747.GA92456@google.com>
References: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
 <20200106213051.GD980197@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106213051.GD980197@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Mon, Jan 06, 2020 at 10:15:53PM +0100, Miriam R. wrote:

>> in run-command.c file `exists_in_PATH()` function does this:
>>
>> static int exists_in_PATH(const char *file)
>> {
>>	char *r = locate_in_PATH(file);
>>	free(r);
>>	return r != NULL;
>> }
>>
>> I wonder if it is correct to do return r != NULL; after free(r);
>
> It is technically undefined behavior according to the C standard, but I
> think it would be hard to find an implementation where it was not
> perfectly fine in practice.
>
> Ref: http://c-faq.com/malloc/ptrafterfree.html
>
> I'd probably leave it alone unless it is causing a problem (e.g., a
> static analyzer complaining).

Today I learned.

Miriam, do you have more context?  Did you notice this while reading or
did a tool bring it to your attention?

(Because I was curious, here's what I chased down in C99:

7.20.3.2 "The free function" says: "The free function causes the space
pointed to by ptr to be deallocated, that is, made available for
further allocation."

6.2.4 "Storage durations of objects" says: "The value of a pointer
becomes indeterminate when the object it points to reaches the end of
its lifetime."

6.2.5 "Types" says: "A pointer type describes an object whose value
provides a reference to an entity of the referenced type."

6.5.9 "Equality operators": "Two pointers compare equal if and only if
both are null pointers, both are pointers to the same object
(including a pointer to an object and a subobject at its beginning) or
function, both are pointers to one past the last element of the same
array object, or one is a pointer to one past the end of one array
object and the other is a pointer to the start of a different array
object that happens to immediately follow the first array object in
the address space."

J.2 "Undefined behavior": "The behavior is undefined in the following
circumstances: [...] The value of an object with automatic storage
duration is used while it is indeterminate (6.2.4, 6.7.8, 6.8)"

The reference to automatic storage duration there is interesting.  Of
course `r` here does have automatic storage duration, but the
distinction from

	char **r = xmalloc(sizeof(*r));
	*r = locate_in_PATH(file);
	free(*r);
	/* leak r */
	return *r != NULL;

is peculiar.  It looks like exists_in_PATH is indeed producing
undefined behavior, but the intention of the standard was probably to
make the behavior implementation defined.)

Thanks,
Jonathan
