From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/17] gc_boundary(): move the check "alloc <= nr" to
 caller
Date: Thu, 23 May 2013 09:09:43 +0200
Message-ID: <519DC0B7.7080401@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-10-git-send-email-mhagger@alum.mit.edu> <7vobc4nrz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 09:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfPep-0000x0-S0
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 09:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab3EWHJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 03:09:48 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:49766 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751296Ab3EWHJr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 03:09:47 -0400
X-AuditID: 1207440f-b7f0e6d000000957-bf-519dc0babb80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.02.02391.AB0CD915; Thu, 23 May 2013 03:09:46 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4N79iwV007057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 May 2013 03:09:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vobc4nrz8.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqLvrwNxAgx3/BSy6rnQzWTT0XmG2
	mHd3F5PFj5YeZgcWj0svv7N5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGZM3PGUr
	eK9a8eDKLsYGxqeyXYycHBICJhLzl65kgbDFJC7cW8/WxcjFISRwmVFiw/qtUM41Jok961vZ
	QKp4BbQl/l/8xQhiswioSrROmskMYrMJ6Eos6mlmArFFBcIk3i+bygpRLyhxcuYTsA0iAmoS
	E9sOgdnMAnESOztXgdULCwRJ9K2+xw6xbAWjxLL9b8EWcAqYSUx/tYkJokFH4l3fA2YIW15i
	+9s5zBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRu
	YoSENP8Oxq71MocYBTgYlXh4D9yYEyjEmlhWXJl7iFGSg0lJlDdl/9xAIb6k/JTKjMTijPii
	0pzU4kOMEhzMSiK8m3uAcrwpiZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4l
	CV5tYOwKCRalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNb4YGK8gKR6gvUYg7bzF
	BYm5QFGI1lOMuhwzfkx+xyjEkpeflyolDrFDAKQoozQPbgUsgb1iFAf6WJj3K8h7PMDkBzfp
	FdASJqAlS0/NAVlSkoiQkmpgXCjdWWCglqTR1/q8auc2KwkJweuCl3tSlb7tW3xnbXnH7QqV
	GZplj11+nRP5o7f12Im26FeG4h2WNuHT8i2z5uzK0Fu/rGgpp7n6nItv37+8N+3p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225219>

On 05/21/2013 07:49 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> There is no logical reason for this test to be here.  At the caller we
>> might be able to figure out its meaning.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> I do not think this change is justified, *unless* the caller later
> in the series gains a better heuristics than what can be done with
> information in the object_array (namely, alloc and nr) to decide
> when to trigger gc.
> 
> And I was hoping to see such a cleverness added to the caller, but I
> do not think I saw any.

Correct.

> I would have to say gc_boundary() knows better when it needs to gc
> with the code at this point in the series, and that is true also in
> the final code after all the patches in this series.
> 
> If we keep the "when to gc" logic inside "gc", in 11/17 this caller
> can no longer call directly to object_array_filter().  It should
> call gc_boundary(), but I see it as a merit, not a downside.  The
> "gc function can later be taught the high/low watermark logic you
> alluded to in 10/17, and the growth/shrinkage characteristic you
> would take advantage of while doing "gc" is specific to this
> codepath.  And the logic still does not have to have access to
> anything only the caller has access to; "gc" can work on what can be
> read from the object_array->{alloc,nr} that is given to it.

I don't feel strongly about this patch and if you prefer to have it
dropped I will do so.  But let me explain my reasoning:

1. The function name gc_boundary() suggests that it will do a garbage
collection unconditionally.  In fact, it might or might not depending on
this test.  At the caller, this made it look like a gc was happening
each time through the loop, which made me nervous about the performance.
 The new version makes it clear at the caller that the gc is only
happening occasionally.

2. Even assuming that gc_boundary() were renamed to maybe_gc_boundary(),
the function has hopelessly little information on which to base its
decision whether or not to gc, and the choice of policy can only be
justified based on some implicit knowledge about how the array is grown
and shrunk.  But the growing/shrinking is done at the layer of the
caller, and therefore the choice of gc policy also belongs at the layer
of the caller.

3. As you point out, if the gc policy is ever to be made more
intelligent, then gc_boundary() is unlikely to have enough information
to implement the new policy (e.g., it would have no place to record
low/high water marks).  Separating concerns at the correct level would
make a change like that easier.

At the moment I am not interested in improving the gc policy of this
code.  The only reason that I am mucking about here is to change it to
use object_array_filter(), which is needed to centralize where
object_array_entries are created and destroyed so that the "name" memory
can be copied and freed consistently.  That can be done with or without
patches 09 and 10.  Please let me know what you prefer.

Michael

>   revision.c | 27 ++++++++++++---------------
> 
>>  1 file changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 8ac88d6..2e0992b 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2437,23 +2437,19 @@ static struct commit *get_revision_1(struct rev_info *revs)
>>  
>>  static void gc_boundary(struct object_array *array)
>>  {
>> -	unsigned nr = array->nr;
>> -	unsigned alloc = array->alloc;
>> +	unsigned nr = array->nr, i, j;
>>  	struct object_array_entry *objects = array->objects;
>>  
>> -	if (alloc <= nr) {
>> -		unsigned i, j;
>> -		for (i = j = 0; i < nr; i++) {
>> -			if (objects[i].item->flags & SHOWN)
>> -				continue;
>> -			if (i != j)
>> -				objects[j] = objects[i];
>> -			j++;
>> -		}
>> -		for (i = j; i < nr; i++)
>> -			objects[i].item = NULL;
>> -		array->nr = j;
>> +	for (i = j = 0; i < nr; i++) {
>> +		if (objects[i].item->flags & SHOWN)
>> +			continue;
>> +		if (i != j)
>> +			objects[j] = objects[i];
>> +		j++;
>>  	}
>> +	for (i = j; i < nr; i++)
>> +		objects[i].item = NULL;
>> +	array->nr = j;
>>  }
>>  
>>  static void create_boundary_commit_list(struct rev_info *revs)
>> @@ -2577,7 +2573,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>>  		if (p->flags & (CHILD_SHOWN | SHOWN))
>>  			continue;
>>  		p->flags |= CHILD_SHOWN;
>> -		gc_boundary(&revs->boundary_commits);
>> +		if (revs->boundary_commits.alloc <= revs->boundary_commits.nr)
>> +			gc_boundary(&revs->boundary_commits);
>>  		add_object_array(p, NULL, &revs->boundary_commits);
>>  	}

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
