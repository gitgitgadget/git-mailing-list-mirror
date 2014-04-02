From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 19/27] refs: Add a concept of a reference transaction
Date: Wed, 02 Apr 2014 06:57:04 +0200
Message-ID: <533B98A0.7030305@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-20-git-send-email-mhagger@alum.mit.edu> <xmqqtxaczvod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:35:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIJ-0006sp-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbaDBE5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 00:57:12 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58948 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754344AbaDBE5K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 00:57:10 -0400
X-AuditID: 1207440c-f79656d000003eba-f6-533b98a4182d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 04.60.16058.4A89B335; Wed,  2 Apr 2014 00:57:09 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s324v51q025400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 00:57:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqtxaczvod.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsUixO6iqLt0hnWwweFZTBY710lYdF3pZrJo
	6L3CbDHv7i4mix8tPcwWHzsXMDuweeycdZfd49LL72weH58tZ/d41ruH0ePiJWWPz5vkAtii
	uG2SEkvKgjPT8/TtErgzPi65xlTwxr/i7slXzA2Mi+27GDk5JARMJJ483M4CYYtJXLi3nq2L
	kYtDSOAyo8T+TRcZIZxzTBKntv9h7WLk4OAV0JZY/YEHpIFFQFXi94S7TCA2m4CuxKKeZjBb
	VCBI4vCGU6wgNq+AoMTJmU/AFogIqElMbDvEAjKTWWA1o8TSKTPYQBLCAj4SzTMfg9lCAmuB
	Ns/WA7E5BawlZi6ZwwyyV0JAXKKnMQgkzCygI/Gu7wEzhC0vsf3tHOYJjIKzkKybhaRsFpKy
	BYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCooFnB+O3dTKHGAU4GJV4
	eA+ctwoWYk0sK67MPcQoycGkJMp7dYp1sBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXs5JQDne
	lMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRv23SgRsGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQBMcXA2MYJMUDtNcBpJ23uCAxFygK0XqK0Zhjw7Y1jUwc
	t5ZvbGQSYsnLz0uVEudlASkVACnNKM2DWwRLg68YxYH+FubtBaniAaZQuHmvgFYxAa3iXmcF
	sqokESEl1cBYM2FZzMEjp728jjXtuBRz6JCQ97y/05dfMw6ez8yhsrHU+j/XkV9v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245684>

On 04/01/2014 09:39 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Build out the API for dealing with a bunch of reference checks and
>> changes within a transaction.  Define an opaque ref_transaction type
>> that is managed entirely within refs.c.  Introduce functions for
>> beginning a transaction, adding updates to a transaction, and
>> committing/rolling back a transaction.
>>
>> This API will soon replace update_refs().
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  refs.h | 65 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 161 insertions(+)
>>
>> diff --git a/refs.c b/refs.c
>> index 1305eb1..e788c27 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3267,6 +3267,93 @@ static int update_ref_write(const char *action, const char *refname,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Data structure for holding a reference transaction, which can
>> + * consist of checks and updates to multiple references, carried out
>> + * as atomically as possible.  This structure is opaque to callers.
>> + */
>> +struct ref_transaction {
>> +	struct ref_update **updates;
> 
> Don't we try to name an array update[] (not plural updates[]) so
> that we can say update[7] to mean the seventh update?

I know that some people prefer to name their arrays using singular, but
I wasn't aware that this is a project rule.  If it is, I think it is a
bad rule.  If followed, it would basically rule out the use of plural
nouns as identifiers, and why would we want to deprive ourselves of the
ability to use the singular/plural distinction to help clarify our code?

I like to use plural names to make it clear that an identifier refers to
a collection of objects.  This leaves the singular noun available to
refer to single objects taken out of the aggregate like

    for (i = 0; i < nr; i++) {
            struct ref_update *update = updates[i];
            /* ... work with update... */
    }

The singular/plural distinction can also be used to give a good hint
about a pointer: does it point at a single object, or does it point at
the start of an array, linked list, etc?  This convention is especially
useful in C, given that C declarations mostly don't distinguish between
pointers and arrays.

In SQL, the "name aggregates using singular noun" convention makes
sense.  SQL table names appear directly in expressions, and there is no
need to "assign" a record to an iteration variable.  I suspect that this
convention, sensible in SQL, has been carried over to traditional
programming languages where it is not (IMHO) sensible.

But...you're the maintainer.  If you would like to make this a
CodingGuidelines-level policy, I will of course conform to it.

>> +	size_t alloc;
>> +	size_t nr;
>> +};
>> +
>> +struct ref_transaction *ref_transaction_begin(void)
>> +{
>> +	return xcalloc(1, sizeof(struct ref_transaction));
>> +}
>> +
>> +static void ref_transaction_free(struct ref_transaction *transaction)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < transaction->nr; i++) {
>> +		struct ref_update *update = transaction->updates[i];
>> +
>> +		free((char *)update->ref_name);
>> +		free(update);
>> +	}
>> +
>> +	free(transaction->updates);
>> +	free(transaction);
>> +}
> 
> OK.
> 
>> +void ref_transaction_rollback(struct ref_transaction *transaction)
>> +{
>> +	ref_transaction_free(transaction);
>> +}
> 
> OK.
> 
>> +static struct ref_update *add_update(struct ref_transaction *transaction,
>> +				     const char *refname)
>> +{
>> +	struct ref_update *update = xcalloc(1, sizeof(*update));
>> +
>> +	update->ref_name = xstrdup(refname);
>> +	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
>> +	transaction->updates[transaction->nr++] = update;
>> +	return update;
>> +}
>> +
>> +void ref_transaction_update(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *new_sha1, unsigned char *old_sha1,
>> +			    int flags, int have_old)
>> +{
>> +	struct ref_update *update = add_update(transaction, refname);
>> +
>> +	hashcpy(update->new_sha1, new_sha1);
>> +	update->flags = flags;
>> +	update->have_old = have_old;
>> +	if (have_old)
>> +		hashcpy(update->old_sha1, old_sha1);
>> +}
>> +
>> +void ref_transaction_create(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *new_sha1,
>> +			    int flags)
>> +{
>> +	struct ref_update *update = add_update(transaction, refname);
>> +
>> +	hashcpy(update->new_sha1, new_sha1);
>> +	hashclr(update->old_sha1);
>> +	update->flags = flags;
>> +	update->have_old = 1;
>> +}
>> +
>> +void ref_transaction_delete(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *old_sha1,
>> +			    int flags, int have_old)
>> +{
>> +	struct ref_update *update = add_update(transaction, refname);
>> +
>> +	update->flags = flags;
>> +	update->have_old = have_old;
>> +	if (have_old)
>> +		hashcpy(update->old_sha1, old_sha1);
>> +}
>> +
> 
> I can see that the chosen set of primitives update/create/delete
> mirrors what update-ref allows us to do, but given the explanation
> of "update" in refs.h, wouldn't it make more sense to implement the
> others in terms of it?

I didn't want to put a lot of thought and refactoring into the
implementation yet, because I still have plans to change ref_update but
I haven't yet had time to decide how.  The two possibilities that I am
considering are:

1. Change ref_update to have not just have_old but also a have_new
boolean attribute (perhaps inserting both into the flags field).  This
would allow a neater coding of all of the elementary operations,
including "verify", which currently is implemented as "update
$EXPECTED_VALUE to $EXPECTED_VALUE", which is a bit silly.

2. Simplify each ref_update object to do only one operation: either
verify an old value, or set a new value.  It would then only need one
SHA-1 field.  A new flag bit would tell whether the old or new value is
being operated on, and no "have_old" attribute would be needed at all.
This approach would require a general "update <newvalue> <oldvalue>" to
be decomposed into two ref_update records, but many other operations
would only require one.  If I go this route, then it would make more
sense to implement ref_transaction_update() and the others in terms of a
"verify" and/or a "set" operation.

So this patch series has mostly focused on putting a new API between
users and refs.c and I'd rather put off this decision.

>>  int update_ref(const char *action, const char *refname,
>>  	       const unsigned char *sha1, const unsigned char *oldval,
>>  	       int flags, enum action_on_err onerr)
>> @@ -3378,6 +3465,15 @@ cleanup:
>>  	return ret;
>>  }
>>  
>> +int ref_transaction_commit(struct ref_transaction *transaction,
>> +			   const char *msg, enum action_on_err onerr)
>> +{
>> +	int ret = update_refs(msg, transaction->updates, transaction->nr,
>> +			      onerr);
>> +	ref_transaction_free(transaction);
>> +	return ret;
>> +}
> 
> OK.
> 
>>  char *shorten_unambiguous_ref(const char *refname, int strict)
>>  {
>>  	int i;
>> diff --git a/refs.h b/refs.h
>> index 08e60ac..476a923 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -24,6 +24,8 @@ struct ref_update {
>>  	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>>  };
>>  
>> +struct ref_transaction;
>> +
>>  /*
>>   * Bit values set in the flags argument passed to each_ref_fn():
>>   */
>> @@ -220,6 +222,69 @@ enum action_on_err {
>>  	UPDATE_REFS_QUIET_ON_ERR
>>  };
>>  
>> +/*
>> + * Begin a reference transaction.  The reference transaction must
>> + * eventually be commited using ref_transaction_commit() or rolled
>> + * back using ref_transaction_rollback().
>> + */
>> +struct ref_transaction *ref_transaction_begin(void);
>> +
>> +/*
>> + * Roll back a ref_transaction and free all associated data.
>> + */
>> +void ref_transaction_rollback(struct ref_transaction *transaction);
>> +
>> +
>> +/*
>> + * The following functions add a reference check or update to a
>> + * ref_transaction.  In all of them, refname is the name of the
>> + * reference to be affected.  The functions make internal copies of
>> + * refname, so the caller retains ownership of the parameter.  flags
> 
> Good to see the ownership rules described.
> 
>> + * can be REF_NODEREF; it is passed to update_ref_lock().
>> + */
>> +
>> +
>> +/*
>> + * Add a reference update to transaction.  new_sha1 is the value that
>> + * the reference should have after the update, or zeros if it should
>> + * be deleted.  If have_old is true, then old_sha1 holds the value
>> + * that the reference should have had before the update, or zeros if
>> + * it must not have existed beforehand.
>> + */
>> +void ref_transaction_update(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *new_sha1, unsigned char *old_sha1,
>> +			    int flags, int have_old);
>> +
>> +/*
>> + * Add a reference creation to transaction.  new_sha1 is the value
>> + * that the reference should have after the update, or zeros if it
>> + * should be deleted.  It is verified that the reference does not
>> + * exist already.
>> + */
> 
> Sounds a bit crazy that you can ask "create", which verifies the
> absense of the thing, to delete a thing.

Yes, you are right.  I can't remember why I defined it this way.  Maybe
I just wanted to avoid the extra call to is_null_sha1() as a consistency
check?  In any case, I'll change "create" to require a nonzero new
value.  I think an assert() will be adequate, since it would be a
programming error to call it with a zero hash.

By analogy, ref_transaction_delete() should insist that if have_old is
set, then old_sha1 is not zeros.  I will make that change as well.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
