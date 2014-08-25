From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Loop index increases monotonically when reading unmerged entries
Date: Mon, 25 Aug 2014 10:09:59 -0700
Message-ID: <xmqq1ts4o5qw.fsf@gitster.dls.corp.google.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<1408903047-8302-2-git-send-email-jsorianopastor@gmail.com>
	<CAPuZ2NEPcRm4S8m76kJ+8L7zR2RiVwu3Z6bNbZgfzAcVTYgOKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxo0-0007Ib-83
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbaHYRLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:11:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56106 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185AbaHYRLk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:11:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E8AF328AB;
	Mon, 25 Aug 2014 13:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1d2XSSGadW19JPc5gSSi9UEZ00k=; b=ZNd5w5
	3HTfIhrZ4bAHbsedxHY0mAtanvXK6kwD5DKnnjqTsu8JtlfaWCRkvHGbJoBOyfq8
	q416WIwurjPntJAFWucb8dRKZSGBevkrrzKEnwoZJAwrmipw8ANVIHQYEQAGAkNa
	zSoB8Byzou90r11sQ1vBU71V1Mb6m+oN2X+4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=quy+Gvkquogh4U5ZI+s8IVi8Yir7f9mF
	NJMXjHkTmGSQmMMzHXdrBSGOvek61VjNEukHl9f596e6ny5ZrQ6Oi+E1/u+IARRB
	mToTKNNqY2IWVdEypRgejFLkQH0NPkRclzIqdFGCCqNdvgVZfl5cIQtRV5D2ag+m
	hkZJ4ZksmXI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 033C6328AA;
	Mon, 25 Aug 2014 13:11:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 00D0132869;
	Mon, 25 Aug 2014 13:10:17 -0400 (EDT)
In-Reply-To: <CAPuZ2NEPcRm4S8m76kJ+8L7zR2RiVwu3Z6bNbZgfzAcVTYgOKA@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Sun, 24 Aug 2014 20:04:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B90C1D7C-2C7A-11E4-9726-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255836>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> I think this line is dangerous, if add_cache_entry is not able to
> remove higher-stages it will be looping forever, as happens in the
> case of this thread.
> I cannot see why it's even needed, and removing it doesn't break any test.
>
> On Sun, Aug 24, 2014 at 7:57 PM, Jaime Soriano Pastor
> <jsorianopastor@gmail.com> wrote:
>> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
>> ---
>>  read-cache.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index c1a9619..3d70386 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1971,7 +1971,6 @@ int read_index_unmerged(struct index_state *istate)
>>                 if (add_index_entry(istate, new_ce, 0))
>>                         return error("%s: cannot drop to stage #0",
>>                                      new_ce->name);
>> -               i = index_name_pos(istate, new_ce->name, len);

I think the original idea was that regardless of how many entries
with the same name were removed because of the replacement (or
addition) of "new_ce", by making "i" point at the newly added
"new_ce", we would make sure that the loop will continue from the
next entry.  The if/return expected that add_index_entry() will get
rid of all the other entries with the same name as "new_ce" has or it
will return an error.

Without the "bug" in add_index_entry(), because "new_ce" always has
the same name as "ce", the entry we found at "i" by the loop, we know
that index_name_pos() will give the same "i" we already have, so
removing this line should be a no-op.

Now, add_index_entry() in your case did not notice that it failed to
remove all other entries with the same name as "new_ce", resulting
in your "looping forever".  Among the "merged and unmerged entries
with the same name exists in the index file" class of index file
corruption, we could treat the "merged and unmerged entries with the
same name not just exists but next to each other, unmerged ones
coming immediately after merged one" case specially (i.e. declaring
that it is more likely for a broken software to leave both next to
each other than otherwise) and try to accomodate it as your original
patch did.  I am not absolutely sure if such a special case is worth
it, and with your updated "[1/2] read_index_from(): check order of
entries when reading index" we will not be doing so, which is good.

With that safety in place, the "bug" in add_index_entry() will
disappear; it is safe not to adjust "i" by calling index_name_pos()
and this patch, "[2/2] read_index_unmerged(): remove unnecessary
loop index adjustment", will be a good thing to do.

Thanks.

>>         }
>>         return unmerged;
>>  }
>> --
>> 2.0.4.1.g0b8a4f9.dirty
>>
