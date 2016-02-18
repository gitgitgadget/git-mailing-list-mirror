From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 14/21] refs: always handle non-normal refs in files
 backend
Date: Thu, 18 Feb 2016 13:07:58 +0100
Message-ID: <56C5B41E.50502@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-15-git-send-email-dturner@twopensource.com>
 <56BDF531.7010909@alum.mit.edu> <1455763440.7528.71.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 13:15:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWNUF-0004km-Gs
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 13:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426204AbcBRMPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 07:15:05 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62884 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1425215AbcBRMPD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2016 07:15:03 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2016 07:15:03 EST
X-AuditID: 12074414-89fff70000005020-97-56c5b4206377
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 1C.BD.20512.024B5C65; Thu, 18 Feb 2016 07:08:00 -0500 (EST)
Received: from [192.168.69.130] (p548D6911.dip0.t-ipconnect.de [84.141.105.17])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1IC7wIr030423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Feb 2016 07:07:59 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1455763440.7528.71.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqKuw5WiYwc9mCYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BntJzYyFyxRrXjUodvA+F22i5GDQ0LAROJc
	v2YXIxeHkMBWRokXz5+zQzjnmSRefp3DBlIkLBAisX1peBcjJ4eIgIPE5V1HmSFqrjBK3L18
	jAUkwSagK7Gop5kJxJYQkJPo7Z4EFucV0JT4em47WJxFQFVi9dJ37CC2KNDM91+fs0LUCEqc
	nPkErJ5TwELi2bL9jCA2s4C6xJ95l5ghbHmJ5q2zmScw8s9C0jILSdksJGULGJlXMcol5pTm
	6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoSEo8gOxiMn5Q4xCnAwKvHwbnhxJEyINbGs
	uDL3EKMkB5OSKK/woqNhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4N6wHyvGmJFZWpRblw6Sk
	OViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfBKbAZqFCxKTU+tSMvMKUFIM3FwggznkhIp
	Ts1LSS1KLC3JiAfFY3wxMCJBUjxAewM2gewtLkjMBYpCtJ5iVJQS5z0EkhAASWSU5sGNhSWZ
	V4ziQF8K8xaBbOcBJii47ldAg5mABudcOgQyuCQRISXVwDiD6e9rj6fsvelblF2SK33ONm1g
	zteQKvm0VlTS5ePDvXudNhvNXzR949dLyg+jHN7fWRd5rvGxgMvvu0s2OwWJRjHsk5sm6HlD
	7XJuz8ujYeXnrq47e1d99uwZqYGZCkwVjVMuP1s2o3iBbe5K6UQOjUt3tbasWywb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286606>

On 02/18/2016 03:44 AM, David Turner wrote:
> On Fri, 2016-02-12 at 16:07 +0100, Michael Haggerty wrote:
>> On 02/05/2016 08:44 PM, David Turner wrote:
>>> Always handle non-normal (per-worktree or pseudo) refs in the files
>>> backend instead of alternate backends.
>>>
>>> Sometimes a ref transaction will update both a per-worktree ref and
>>> a
>>> normal ref.  For instance, an ordinary commit might update
>>> refs/heads/master and HEAD (or at least HEAD's reflog).
>>>
>>> Updates to normal refs continue to go through the chosen backend.
>>>
>>> Updates to non-normal refs are moved to a separate files backend
>>> transaction.
>>>
>>> Signed-off-by: David Turner <dturner@twopensource.com>
>>> ---
>>>  refs.c | 81
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 79 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/refs.c b/refs.c
>>> index 227c018..18ba356 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -9,6 +9,11 @@
>>>  #include "object.h"
>>>  #include "tag.h"
>>>  
>>> +static const char split_transaction_fail_warning[] = N_(
>>> +	"A ref transaction was split across two refs backends. 
>>>  Part of the "
>>> +	"transaction succeeded, but then the update to the per
>>> -worktree refs "
>>> +	"failed.  Your repository may be in an inconsistent
>>> state.");
>>> +
>>>  /*
>>>   * We always have a files backend and it is the default.
>>>   */
>>> @@ -791,6 +796,13 @@ void ref_transaction_free(struct
>>> ref_transaction *transaction)
>>>  	free(transaction);
>>>  }
>>>  
>>> +static void add_update_obj(struct ref_transaction *transaction,
>>> +			   struct ref_update *update)
>>> +{
>>> +	ALLOC_GROW(transaction->updates, transaction->nr + 1,
>>> transaction->alloc);
>>> +	transaction->updates[transaction->nr++] = update;
>>> +}
>>> +
>>>  static struct ref_update *add_update(struct ref_transaction
>>> *transaction,
>>>  				     const char *refname)
>>>  {
>>> @@ -798,8 +810,7 @@ static struct ref_update *add_update(struct
>>> ref_transaction *transaction,
>>>  	struct ref_update *update = xcalloc(1, sizeof(*update) +
>>> len);
>>>  
>>>  	memcpy((char *)update->refname, refname, len); /* includes
>>> NUL */
>>> -	ALLOC_GROW(transaction->updates, transaction->nr + 1,
>>> transaction->alloc);
>>> -	transaction->updates[transaction->nr++] = update;
>>> +	add_update_obj(transaction, update);
>>>  	return update;
>>>  }
>>>  
>>> @@ -1217,11 +1228,38 @@ static int dereference_symrefs(struct
>>> ref_transaction *transaction,
>>>  	return 0;
>>>  }
>>>  
>>> +/*
>>> + * Move all non-normal ref updates into a specially-created
>>> + * files-backend transaction
>>> + */
>>> +static int move_abnormal_ref_updates(struct ref_transaction
>>> *transaction,
>>> +				     struct ref_transaction
>>> *files_transaction,
>>> +				     struct strbuf *err)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < transaction->nr; i++) {
>>> +		int last;
>>> +		struct ref_update *update = transaction
>>> ->updates[i];
>>> +
>>> +		if (ref_type(update->refname) == REF_TYPE_NORMAL)
>>> +			continue;
>>> +
>>> +		last = --transaction->nr;
>>> +		transaction->updates[i] = transaction
>>> ->updates[last];
>>> +		add_update_obj(files_transaction, update);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> I think this function is incorrect. The update that was previously at
>> transaction->updates[i] never gets checked for abnormality. 
> 
> Yes it does; that's the "update" variable that we just checked.

Sorry, I meant to say "the update that was previously at
`transaction->updates[transaction->nr - 1]` never gets checked for
abnormality". Because it gets moved to `transaction->updates[i]`, then
`i` is incremented without checking it.

> [...]
>> Another alternative would be to set
>>
>>     update->flags |= REF_ABNORMAL
>> [...]
> I'm also interested in this idea. Perhaps it would also be nice to
> report *why* they fail (e.g. the conflicting ref name).  I did a
> variant of this with for the journal code, but my way of doing it
> turned out to be a bad idea (long story).  But I want to stay focused
> on the simplest thing possible, for now.

Fair enough.

> [...]
>> Does initial_ref_transaction_commit() need the same treatment?
> 
> We only use that for remote refs -- I'm not sure if those can be
> symrefs.  Wouldn't hurt.

Hmmm, good point. I think the only symrefs that can be set during a
clone are `HEAD` and `refs/remotes/origin/HEAD`. But I guess that no
other references are updated *through* these symrefs, so it's probably
OK. I haven't checked carefully, though.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
