Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4834E1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJFEXO (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:23:14 -0400
Received: from mout.web.de ([212.227.15.3]:33885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbeJFEXO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:23:14 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjaR6-1fbPj002Mi-00bZn4; Fri, 05
 Oct 2018 23:22:34 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjaR6-1fbPj002Mi-00bZn4; Fri, 05
 Oct 2018 23:22:34 +0200
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
 <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004220711.GA28287@sigill.intra.peff.net>
 <c75fa650-d2b4-9979-a1f2-25d75c6f447b@web.de>
 <20181005202737.GA22460@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a5a5b0c5-cc97-dc50-56dd-25ec64c03e48@web.de>
Date:   Fri, 5 Oct 2018 23:22:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005202737.GA22460@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MRvq3qoW4Kge7xxF8bEvQC8LS3ed9RPzfmXFmdf6qMXIQzlK3Qx
 +RAsBA0nAXQgdVbCcT7JIMZ9ql9jhU/RYreYQM9hPey31rV3rvGKzUl2CiW/3D+4yNlKImH
 H3LzSr6aTHIdhifl8ZEcr2hKK+AkLA31OQG5vFqz9cT78X27Kl0fPFnSIRnxlUP18/L8y1w
 NNpSvAVkEO1ZFVWYXC1Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OBjzhyLBNxQ=:M6heyKpvQQZ83zKuS3sslI
 EVo/spWOHvY7MwyJAI1DZDJ6JJFqDHjDGH20leYlv9Cm3pUiO0Mjt/BrxRP5jGiCCnzafvKwO
 7QBzflQcIRoqwtGK4tlXAfuGgjnX2NRxVCFJVvxJ3LGHZhHSG4iHlI3/mOj2CdceFKI0/6qsc
 jCaQ8iGAchEpn8TdFcUCfXYRCOMYhZ8LBfe1ORoWYo/G4y5wge8gCvqJkn7fNQOxzn5SfPk2P
 cMZuz4SPbxbIjnQRX87hrmuf7mVE3frvgwsLEXwQGRb2szPDU2W3qRAzockp0GrRrF+eMIQ50
 oLqpJ5gecsuqrHRCi/kR7gSaLyzyRc04vyKlJ0KfE9fOT62n/F3vdgcn72VdF9PiPiDwoivde
 faDPjckwNcGGyDSqLhTb0FAtyTESqJh8Sc1OdJaGxP8W9Zlk+58nA8rIdg/LAuHYiVdBTVu04
 0WuZG0vM1PsInexmkbzwyZRk9RMeFvY4gSPahWb0IWZt0kKhkk+ZsEzjJoC6I5J0bWeoz00rG
 /2yABgTvX9J/XD2tzA5itqB4Lry3wHXQJVUjY+cXArcdc2+ZNZ9GXAYR2eMVCoWRFKHqfURlT
 hYLqondgaif0Id7mqPWKshvRy4gQo9NFmNsFJS2AIRIWIIhMokqdE5iX/l8DXKvmLVueeI79F
 nMO/aMqapAk1AatKlmYcLlz9WMUqbjhQvFbInkpvf7yo5Ek6Rm8rXG3Pge1gFbAbJ8plP+Lg4
 ZDQaA0K4DDOVSr8CcJbNe6FuzJ9T9Eksf8XDDTep+y7IEWVRQFuBOEsa0jHyC6xaCxWUwTjYn
 uuwr2+YIVUeAkhVSympjuum3JZwuE6akP0v2B3X7t1GdR4fqHM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 22:27 schrieb Jeff King:
> On Fri, Oct 05, 2018 at 10:13:34PM +0200, René Scharfe wrote:
> 
>>>> -{
>>>> -	/*
>>>> -	 * Note that this only looks at the ref lists the first time it's
>>>> -	 * called. This works out in filter_refs() because even though it may
>>>> -	 * add to "newlist" between calls, the additions will always be for
>>>> -	 * oids that are already in the set.
>>>> -	 */
>>>
>>> I don't think the subtle point this comment is making goes away. We're
>>> still growing the list in the loop that calls tip_oids_contain() (and
>>> which now calls just oidset_contains). That's OK for the reasons given
>>> here, but I think that would need to be moved down to this code:
>>>
>>>> +	if (strict) {
>>>> +		for (i = 0; i < nr_sought; i++) {
>>>> +			ref = sought[i];
>>>> +			if (!is_unmatched_ref(ref))
>>>> +				continue;
>>>> +
>>>> +			add_refs_to_oidset(&tip_oids, unmatched);
>>>> +			add_refs_to_oidset(&tip_oids, newlist);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>
>>> I.e., we need to say here why it's OK to summarize newlist in the
>>> oidset, even though we're adding to it later.
>>
>> There is already this comment:
>>
>> 	/* Append unmatched requests to the list */
>>
>> And that's enough in my eyes.  The refs loop at the top splits the list
>> into matched ("the list") and unmatched, and the loop below said comment
>> adds a few more.  I see no subtlety left -- what do I miss?
> 
> It looks like tip_oids is meant as a fast lookup into what's in
> unmatched and newlist. But in the second loop we continue appending to
> newlist. Why is it OK that we do not update tip_oids when we do so?

`tip_oids` contains the object_ids of the all `refs` passed to
filter_refs().  Instead of adding them at the top of the function that
is done only when it has become clear that there are unmatched ones,
as an optimization.  (That optimization was implemented by lazy-loading
in tip_oids_contain() earlier.)  At that point the list has been split
into `newlist` and `unmatched`, so we load from them instead of `refs`.

> 
> I.e., something like this explains it:
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 53914563b5..c0a1b80f4c 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -606,6 +606,12 @@ static void filter_refs(struct fetch_pack_args *args,
>  			ref->match_status = REF_MATCHED;
>  			*newtail = copy_ref(ref);
>  			newtail = &(*newtail)->next;
> +			/*
> +			 * No need to update tip_oids with ref->old_oid; we got
> +			 * here because either it was already there, or we are
> +			 * in !strict mode, in which case we do not use
> +			 * tip_oids at all.
> +			 */
>  		} else {
>  			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
>  		}

This comment puzzles me -- why ask the question it answers?
`tip_oids` has been loaded with all `refs` at that point; adding
more seems odd.

I feel the code needs be simplified further; not sure how, though,
except perhaps by using the `unfound` array added in another reply.

René
