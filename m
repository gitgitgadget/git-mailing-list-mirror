Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7628A2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcGSTSB (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:18:01 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38596 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbcGSTRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:17:52 -0400
Received: by mail-it0-f47.google.com with SMTP id j124so29542480ith.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 12:17:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bg1Tn9stzAxOFnsIydlI16TKpfUlezRJw+bSdg0Au1U=;
        b=Do5FH4/42ZrM+vhzVKQm5Zqf2QI4GcU840baOQ2hmViifQ8ZTPly+9T/Kbb80xCbYu
         p9ZMXNRHF50cJWlKkXXU0DKEyVbYSiKF0BXZXVVm5/EKwzOX6mKUpp9PTVL0RE+WODgi
         Fs17ZZA//56KLpsub7//SNrrwqu1PNQZx6yfB13EREkAGJX3RNMcqGCWp4EkYiT4HiN1
         dT7OjNu/0YIXYdEQT+T2HEOavFcqwonitoDp1VzapOt0p7dgkltnp2R2+tRJeUTblJhj
         yBdA1EC/XwD5qIU0mCjUdVgxyZ9nvY8pae1WkOWvHHBEv4JObCWJtJ1+3YFWxL+hJ8VP
         TjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bg1Tn9stzAxOFnsIydlI16TKpfUlezRJw+bSdg0Au1U=;
        b=bpD9CdM8r69IeBEJe5OJzsjJtzwtktm52IEr7QQXgtl2k9CUIRufqasYB8C791Tiz2
         vewttsf+pblKLzANbe6WyrGmW7plLo2ssEbGoQijriW8V0oMTMBOjw4wcDkxo7G0qQ4j
         j0XPw4TeivMM0he8TKSMOzGg3xGcgKfztuR482RTtOxaKMUrm6as79nJAZ+kmKFwn9tj
         XGhXV9/xvQr+UVCjaSoMQkhbkUWUbgioqBG1rzJswy2ELK0/f68b0882Ojh4iDbMJ4Ll
         IsaDzlNbNfMt92qgVorpoQlu/oCKn3zrMkZmUGvEfdp9jq6O1Km/GfeBttSxXKH9pbHG
         sJfA==
X-Gm-Message-State: ALyK8tLa2RJzLxhlMLOCtr1qVP+G7w5gVZYYaj7TEWOO7HP9MjHrNgUoa+9+lELt05xZ+xZjUB4dcmyMX+4Ej+1E
X-Received: by 10.36.217.12 with SMTP id p12mr6135450itg.46.1468955870954;
 Tue, 19 Jul 2016 12:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 19 Jul 2016 12:17:50 -0700 (PDT)
In-Reply-To: <CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com> <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
 <CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com> <CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 19 Jul 2016 12:17:50 -0700
Message-ID: <CAGZ79kZxN9uYprMUXMuWpO3mKfw6WTa3uoG=SXWny7St1OfGzA@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 12:03 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, Jul 19, 2016 at 9:46 AM, Stefan Beller <sbeller@google.com> wrote:
>> Care to elaborate on why you choose 11/10 as growth factor?
>>
>> (As someone who has a tick in micro optimizing:
>> 9/8 is roughly the same exponent, but the division
>> by 8 is easier as it is just a shift by 3. Similar 17/16)
>
> I don't have a specific reason for 11/10 as opposed to, say, 9/8 - I
> think that the time taken to execute this line is negligible compared
> to what's done in the calling code, but I'll change it to 9/8 if there
> is another reason for me to send another patch.
>
>> I guess one design criterion was 10 being a round number?
>> Does it make sense to experiment with the factor at all?
>> Digging into that, LARGE_FLUSH originates from 6afca450c3f,
>> (2011-03-20, fetch-pack: progressively use larger handshake windows),
>> and before we only had a linear growth.
>>
>> So I guess what I do not understand is why we need to slow down the
>> exponential growth at all?
>
> The current code has an exponential (a' = a * 2) then a linear (a' = a
> + 1024) growth. I'm not slowing down the exponential growth - that
> part is retained. I'm replacing the linear growth with another
> conservative exponential growth (a' = a * 11 / 10).

Sorry for the miss understanding. Once we have the new conservative
exponential, we'd have a fast exponential first (a=2*a) and then after a while
a slower exponential (a=1.1*a). So we have 2 exponential curves with different
growth properties.

So my question could be reworded as: Why do we need two different exponential
growth phases (as they are both exponential)? And I answered myself with: Oh,
the exponents are different, so that's why.

But then I tried to understand why we choose the 2 exponents as of this patch.
(Why start with 2 and drop back to 1.1?) Could one exponential phase be
sufficient with an exponent in between (e.g. a=1.3*a with a larger starting a to
compensate for the reduced early growth) ?

Or to reword it another way: Using just one exponential growth is simpler than
2 different exponential growth phases, so how do we explain the added
complexity?

Thanks,
Stefan
