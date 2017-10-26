Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224582055E
	for <e@80x24.org>; Thu, 26 Oct 2017 04:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbdJZEM4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 00:12:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56204 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750884AbdJZEMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 00:12:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 409B09AF4B;
        Thu, 26 Oct 2017 00:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4swnx5uBNAkmVpOTQFndazrmpis=; b=FEWHus
        4FwJw70Qn9or5sgdeFd/o6fJkEgAfAGqC4QCg6cXiy7f3njMsIpkNnaE7/+SMF+o
        v2w8gw+MREJ0Td58Kl/BPBfMSAEDPhHnu7uuiy1deWO/rfLVpJyKCgdIjGaFrou8
        azQZdF7Syhr4+rO1EMGI4/xXiv/hx/1e9/ONU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4vpTLCAV6wt2xFP9dNC1lzwWr+FkKjI
        hrb/KjqLeF+iFIQpacz415b5QmGVQ1GXyyvhHZKeIFHcJ5x8lDQJdCVOmJ4k6bim
        3SC9P9JEO8vj7I0jNIHeVaxXAkeoiYUGAcVsbdH9e9xhvwypOqybs1VRSJyiklic
        loHyAT/J3Tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 393A49AF49;
        Thu, 26 Oct 2017 00:12:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6A999AF42;
        Thu, 26 Oct 2017 00:12:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 02/13] list-objects-filter-map: extend oidmap to collect omitted objects
References: <20171024185332.57261-1-git@jeffhostetler.com>
        <20171024185332.57261-3-git@jeffhostetler.com>
        <xmqqwp3jhfct.fsf@gitster.mtv.corp.google.com>
        <2f7ad5dc-821e-3fd3-bb7c-205ea5016457@jeffhostetler.com>
Date:   Thu, 26 Oct 2017 13:12:53 +0900
In-Reply-To: <2f7ad5dc-821e-3fd3-bb7c-205ea5016457@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 25 Oct 2017 15:22:04 -0400")
Message-ID: <xmqqefpqfsxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0E02986-BA03-11E7-A1D3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Sorry, I meant a later commit in this patch series.  It is used by
> commits 4, 5, 6, and 10 to actually do the filtering and collect a
> list of omitted or missing objects.

I know you meant "later commits in the series" ;-).  

It does not change the fact that readers of 02/13 haven't seen them
yet to understand patch 02/13, if the changes that drove the design
of this step is in the same series or if they are not yet posted.

> I think of a "set" as a member? or not-member? class.
> I think of a "map" as a member? or not-member? class but where each
> member also has a value.  Sometimes map lookups just want to know
> membership and sometimes the lookup wants the value.
>
> Granted, having the key and value data stuffed into the same entry
> (from hashmap's point of view, rather than a key having a pointer
> to a value) does kind of blur the line, but I was thinking about
> a map here.  (And I was building on oidmap which builds on hashmap,
> so it seemed appropriate.)

My question was mostly about "if this is a map, then a caller that
queries the map with an oid does so because it wants to know the
data associated to the oid; if this is just a set, it is mostly
interested in the membership" and "I cannot quite tell which was
meant without the caller".  

It seems that some callers do care about the "path" name from your
response above, so calling this "map" sounds more appropriate.

The answer "it can be used to speed up 'is this path excluded?'
check" is a bit worrisome, though.  A blob can appear at more than
one path, and unless all the appearances of it are in an excluded
path, omitting the blob from the repository would lead to an aborted
"rev-list --objects" run, and this "map" can record at most one path
per each object; we need to wait until seeing the optimization code
to actually see how effectively this data helps optimization and
comment on the code ;-)

>>> +	len = ((pathname && *pathname) ? strlen(pathname) : 0);
>>> +	size = (offsetof(struct list_objects_filter_map_entry, pathname) + len + 1);
>>> +	e = xcalloc(1, size);
>>> +
>>> +	oidcpy(&e->entry.oid, oid);
>>> +	e->type = type;
>>> +	if (pathname && *pathname)
>>> +		strcpy(e->pathname, pathname);
>>> +
>>> +	oidmap_put(map, e);
>>> +	return 0;
>>> +}
>>
>> The return value from the function needs to be documented in the
>> header to help callers.  It is not apparent why "we did already have
>> one" and "we now newly added" is interesting to the callers, for
>> example.  An obvious alternative implementation of this function
>> would return the pointer to an entry that records the object id
>> (i.e. either the one that was already there, or the one we created
>> because we saw this object for the first time), so that the caller
>> can do something interesting to it---again, because the reason why
>> we want this "filter map" is not explained at this stage, it is hard
>> to tell what that "sometehing interesting" would be.
>
> good point.  thanks.

I am more confused by the response ;-) But as we established that
this is a map (not a set that borrows the implementation of map),
where the data recorded in 'e' is quite useful to the caller, it
probably makes sense to make 'e' available to the caller?  It is
still unclear if the caller finds "it is the first time I saw the
object you gave me" vs "I've seen that object before already"
useful.

>>> +	for (k = 0; k < nr; k++)
>>> +		cb(k, nr, array[k], cb_data);
>>
>> Also it is not clear if you wanted to expose the type of the
>> entry to the callback function.
>
> The thought was that we would sort the OIDs so that things
> like rev-list could print the omitted/missing objects in OID
> order.  Not critical that we do it here, but I thought it would
> help callers.

I can foresee some callers would want sorted, while others do not.
I was primarily wondering why "my_cmp" is not a parameter that can
be NULL (in which case we do not sort at all).

>> An obvious alternative
>>
>> 	fn(&array[k].entry.oid, cb_data);
>>
>> would allow you to keep the type of map-entry private to the map,
>> and also the callback does not need to know about k or nr.
>> ...
> I included the {k, nr} so that the callback could dump header/trailer
> information when reporting the results or pre-allocate an array.
> I'll look at refactoring this -- I never quite liked how it turned
> out anyway -- especially with the oidmap simplifications.

And as we established that this is a map, where the data associated
with each oid is interesting to the caller, we do not want to hide
the type of array[] element by passing only &array[k].entry.oid, I
guess?

Thanks.
