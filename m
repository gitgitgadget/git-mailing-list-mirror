Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2621F404
	for <e@80x24.org>; Tue, 11 Sep 2018 10:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeIKPEY (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 11:04:24 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:48267 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKPEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 11:04:24 -0400
Received: from [192.168.2.201] ([89.242.190.162])
        by smtp.talktalk.net with SMTP
        id zfYHfbAnKdJAezfYHfwZRm; Tue, 11 Sep 2018 11:05:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536660346;
        bh=m8jroIbK3OsPTPKFqoWVPWkQyM8q+mA6619DA+6BOfU=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=g3EFyqr5+A9GRH3YNpsQguVIGRhkfwCzLnl39CtCgaFQRKCOKqFrjFYssNB6UdWPD
         b3SiPQfN3RjA9/asZSCgT2GUNgASic4nuBcTyNMGNqLd3j3KJX31UGbqvSZ1lTfdtc
         wG6Dg/vmaj1p6oUeAj0fcYXaN6bzJkvoOR/8NKcs=
X-Originating-IP: [89.242.190.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yWw/b5KBQb65dAU66aqL/Q==:117
 a=yWw/b5KBQb65dAU66aqL/Q==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=vW06Cmzq3B_ytqjzD04A:9 a=kKNw0eDKpB8CYwHh:21
 a=Eo-m3r8oQz9d49Zw:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
References: <20180904135258.31300-1-phillip.wood@talktalk.net>
 <CAGZ79kaBBzG6-QKruCeybN_do735h9tAXHZ7Rjx_YXeh85ax6A@mail.gmail.com>
 <b78b467c-6cae-2e2e-533c-48a4552539f5@talktalk.net>
Message-ID: <5cff63d6-d9ec-d28f-d34a-e610ac19dbcb@talktalk.net>
Date:   Tue, 11 Sep 2018 11:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b78b467c-6cae-2e2e-533c-48a4552539f5@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFJkOQa3If0U7EaeGBZuWb58yzFH9h0UvYH0Hx6RrJsq2sk1Z90poZkTlII1C0e1MAxCTePicETq3zl8T91hgKy3TTqvn639k37xGaCg+5EQ/eieojqG
 OwkBb1XTqHEoOkd879kxn5UMT5tpFBvEaom7wHEnr7WtNKO5lA/ulKXS2KPO1TPQnn1LE4/nXnICATDC4bwiWBQOnBWZet2ErpB0R3cYX9XNEwUKc3/0fg6H
 Qs5tck+l51joj1cQxCuryej+ALnIUr0RB0fSK5nmevg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/2018 19:51, Phillip Wood wrote:
> Hi Stefan
> 
> On 04/09/2018 19:08, Stefan Beller wrote:
>> On Tue, Sep 4, 2018 at 6:53 AM Phillip Wood
>> <phillip.wood@talktalk.net> wrote:
>>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> If there is more than one potential moved block and the longest block
>>> is not the first element of the array of potential blocks then the
>>> block is cut short. With --color-moved=blocks this can leave moved
>>> lines unpainted if the shortened block does not meet the block length
>>> requirement. With --color-moved=zebra then in addition to the
>>> unpainted lines the moved color can change in the middle of a single
>>> block.
>>>
>>> Fix this by freeing the whitespace delta of the match we're discarding
>>> rather than the one we're keeping.
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>
>>> While I was working on this I spotted a couple of other issues I don't
>>> have time to fix myself at the moment, so I thought I mention them in
>>> case someone else wants to pick them up
>>>
>>> 1) I think there is a potential memory leak at the end of
>>>     mark_color_as_moved(). If pmb_nr > 0 then the whitespace deltas
>>>     need freeing before freeing pmb itself.
>>>
>>> 2) The documentation could be improved to explain that
>>>     allow-indentation-change does not work with indentation that
>>>     contains a mix of tabs and spaces and the motivation for that
>>>     (python?) [I've got some code to add an option that supports that
>>>     which I'll post when I've written some tests after 2.19 is
>>>     released]
>>>
>>>   diff.c | 11 ++++++-----
>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/diff.c b/diff.c
>>> index 145cfbae5..4e8f725bb 100644
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -968,8 +968,13 @@ static void
>>> pmb_advance_or_null_multi_match(struct diff_options *o,
>>>                          /* Carry the white space delta forward */
>>>                          pmb[i]->next_line->wsd = pmb[i]->wsd;
>>>                          pmb[i] = pmb[i]->next_line;
>>> -               } else
>>> +               } else {
>>> +                       if (pmb[i]->wsd) {
>>> +                               free(pmb[i]->wsd->string);
>>> +                               FREE_AND_NULL(pmb[i]->wsd);
>>> +                       }
>>>                          pmb[i] = NULL;
>>> +               }
>>
>> I agree on this hunk, as it will fix the mem leak in the case of
>> allow-indentation-change, wondering if we need the same in
>> pmb_advance_or_null as well (and anywhere where there is a
>> 'pmb[i] = NULL' assignment outside the swapping below.).
> 
> I don't think we don't call pmb_advance_or_null() if we're using
> pmb[i]->wsd. I'm not sure if there are other sites that set 'pmb[i] =
> NULL' when pmb[i]->wsd has been allocated.

Oops there's an extra don't there. Anyway I've had a proper look through
the code and pmb_advance_or_null() is the only other place where pmb[i]
is set to NULL and that code path isn't used when pmb[i]->wsd has been
allocated. So this should be sufficient.

Best Wishes

Phillip

>>
>>
>>>          }
>>>   }
>>>
>>> @@ -990,10 +995,6 @@ static int shrink_potential_moved_blocks(struct
>>> moved_entry **pmb,
>>>
>>>                  if (lp < pmb_nr && rp > -1 && lp < rp) {
>>>                          pmb[lp] = pmb[rp];
>>> -                       if (pmb[rp]->wsd) {
>>> -                               free(pmb[rp]->wsd->string);
>>> -                               FREE_AND_NULL(pmb[rp]->wsd);
>>> -                       }
>>
>> Eh, this makes sense, though I had to think about it for a
>> while as I was confused. By the first line in the condition we
>> also keep around the ->wsd pointer as is.
> 
> Yes, it took me ages to work out that this is what was breaking the
> highlighting.
> 
> Best Wishes
> 
> Phillip
> 
>>
>> Thanks!
>> Stefan
>>

