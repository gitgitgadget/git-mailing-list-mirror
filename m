From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous
 updates
Date: Sat, 31 Aug 2013 20:19:04 +0200
Message-ID: <52223398.2080109@alum.mit.edu>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Martin Fick <mfick@codeaurora.org>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 20:26:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFpsG-0003NJ-2p
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 20:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab3HaS0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 14:26:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51454 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754357Ab3HaS0L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 14:26:11 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2013 14:26:10 EDT
X-AuditID: 12074411-b7f296d000001209-0c-5222339c4630
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F7.84.04617.C9332225; Sat, 31 Aug 2013 14:19:08 -0400 (EDT)
Received: from [192.168.69.9] (p57A2512F.dip0.t-ipconnect.de [87.162.81.47])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7VIJ5ex001428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 31 Aug 2013 14:19:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqDvHWCnI4Gcbq8XOdRIWXVe6mSwa
	eq8wW9x/v47JgcXjcl8vk8fHZ8vZPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvj3YJPzAUn
	3Cq29jxmamDcYN7FyMkhIWAisaVzHSuELSZx4d56ti5GLg4hgcuMEptWTGeEcM4wScw88oS5
	i5GDg1dAW+LGizCQBhYBVYnerjOMIDabgK7Eop5mJhBbVCBMYsf0iWwgNq+AoMTJmU9YQGwR
	oPpV6xrA4swCfhJdT2aDLRYWCJWY9nUjE8SurYwSW+5+YAdJcArESKzYt5cdokFH4l3fA2YI
	W15i+9s5zBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluil
	ppRuYoSEs+AOxhkn5Q4xCnAwKvHwJixVCBJiTSwrrsw9xCjJwaQkyuuhrxQkxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYT39ErFICHelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgRvqRHQUMGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQrMYXA6MVJMUDtDcf
	pJ23uCAxFygK0XqK0Zjjz8q5nxg53jXN+8QoxJKXn5cqJc7rDFIqAFKaUZoHtwiWyF4xigP9
	LcxrDFLFA0yCcPNeAa1iAlp1bSLIi8UliQgpqQbG9nv+hYZyxg8FdkgWBHQUGd2pkp4gqXcy
	nvnHG61fjtOaPx8W9ZHUiy7/+DspcgnLwrc9wUpLuj+euPZ37Z8pdhtXG+ddaTb+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233528>

On 08/30/2013 08:12 PM, Brad King wrote:
> Add 'struct ref_update' to encode the information needed to update or
> delete a ref (name, new sha1, optional old sha1, no-deref flag).  Add
> function 'update_refs' accepting an array of updates to perform.  First
> sort the input array to order locks consistently everywhere and reject
> multiple updates to the same ref.  Then acquire locks on all refs with
> verified old values.  Then update or delete all refs accordingly.  Fail
> if any one lock cannot be obtained or any one old value does not match.
> 
> Though the refs themeselves cannot be modified together in a single

s/themeselves/themselves/

> atomic transaction, this function does enable some useful semantics.
> For example, a caller may create a new branch starting from the head of
> another branch and rewind the original branch at the same time.  This
> transfers ownership of commits between branches without risk of losing
> commits added to the original branch by a concurrent process, or risk of
> a concurrent process creating the new branch first.
> 
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  refs.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h |   14 ++++++++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 3bcd26e..901a38a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3238,6 +3238,127 @@ int update_ref(const char *action, const char *refname,
>  	return update_ref_write(action, refname, sha1, lock, onerr);
>  }
>  
> +static int ref_update_compare(const void *r1, const void *r2)
> +{
> +	struct ref_update *u1 = (struct ref_update *)(r1);
> +	struct ref_update *u2 = (struct ref_update *)(r2);

If you declare u1 and u2 to be "const struct ref_update *" (i.e., add
"const"), then you have const correctness and don't need the explicit
casts.  (And the parentheses around r1 and r2 are superfluous in any case.)

> +	int ret;

Style: we usually put a blank line between variable declarations and the
first line of code.

> +	ret = strcmp(u1->ref_name, u2->ref_name);
> +	if (ret)
> +		return ret;
> +	ret = hashcmp(u1->new_sha1, u2->new_sha1);
> +	if (ret)
> +		return ret;
> +	ret = hashcmp(u1->old_sha1, u2->old_sha1);
> +	if (ret)
> +		return ret;
> +	ret = u1->flags - u2->flags;
> +	if (ret)
> +		return ret;
> +	return u1->have_old - u2->have_old;
> +}

Is there a need to compare more than ref_name?  If two entries are found
with the same name, then ref_update_reject_duplicates() will error out
anyway.  So the relative order among entries with the same name is
irrelevant.  I think it would be OK to return 0 for any entries with the
same ref_name, even if they differ in other fields.

> +
> +static int ref_update_reject_duplicates(struct ref_update *updates, int n,
> +					enum action_on_err onerr)
> +{
> +	int i;
> +	for (i = 1; i < n; ++i)
> +		if (!strcmp(updates[i - 1].ref_name, updates[i].ref_name))
> +			break;

The error handling code could be right here instead of the "break"
statement, removing the need for the "if" conditional.

> +	if (i < n) {
> +		const char *str = "Multiple updates for ref '%s' not allowed.";
> +		switch (onerr) {
> +		case MSG_ON_ERR: error(str, updates[i].ref_name); break;
> +		case DIE_ON_ERR: die(str, updates[i].ref_name); break;
> +		case QUIET_ON_ERR: break;
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +int update_refs(const char *action, const struct ref_update *updates_orig,
> +		int n, enum action_on_err onerr)
> +{
> +	int ret = 0, delnum = 0, i;
> +	struct ref_update *updates;
> +	int *types;
> +	struct ref_lock **locks;
> +	const char **delnames;
> +
> +	if (!updates_orig || !n)
> +		return 0;
> +
> +	/* Allocate work space: */
> +	updates = xmalloc(sizeof(struct ref_update) * n);

It seems preferred here to write

	updates = xmalloc(sizeof(*updates) * n);

as this will continue to work if the type of updates is ever changed.
Similarly for the next lines.

> +	types = xmalloc(sizeof(int) * n);
> +	locks = xmalloc(sizeof(struct ref_lock *) * n);
> +	delnames = xmalloc(sizeof(const char *) * n);

An alternative to managing separate arrays to hold types and locks would
be to include the scratch space in struct ref_update and document it
"for internal use only; need not be initialized by caller".  On the one
hand it's ugly to cruft up the "interface" with internal implementation
details; on the other hand there is precedent for this sort of thing
(e.g., ref_lock::force_write or lock_file::on_list) and it would
simplify the code.

> +
> +	/* Copy, sort, and reject duplicate refs: */
> +	memcpy(updates, updates_orig, sizeof(struct ref_update) * n);
> +	qsort(updates, n, sizeof(struct ref_update), ref_update_compare);

You could save some space and memory shuffling (during memcpy() and
qsort()) if you would declare "updates" to be an array of pointers to
"struct ref_update" rather than an array of structs.  Sorting could then
be done by moving pointers around instead of moving the structs.  This
would also make it easier for update_refs() to pass information about
the references back to its caller, should that ever be needed.

But I suppose that n will usually be small, so this suggestion can be
considered optional.

> +	if (ref_update_reject_duplicates(updates, n, onerr)) {
> +		free(updates);
> +		free(types);
> +		free(locks);
> +		free(delnames);
> +		return 1;
> +	}
> +
> +	/* Acquire all locks while verifying old values: */
> +	for (i = 0; i < n; ++i) {
> +		locks[i] = update_ref_lock(updates[i].ref_name,
> +					   (updates[i].have_old ?
> +					    updates[i].old_sha1 : NULL),
> +					   updates[i].flags,
> +					   &types[i], onerr);
> +		if (!locks[i])
> +			break;

The error handling code could go here in place of the "break",
especially if it's only "ret = 1; goto label;" as suggested below.

> +	}
> +
> +	/* Abort if we did not get all locks: */
> +	if (i < n) {
> +		while (--i >= 0)
> +			unlock_ref(locks[i]);
> +		free(updates);
> +		free(types);
> +		free(locks);
> +		free(delnames);
> +		return 1;
> +	}
> +
> +	/* Perform updates first so live commits remain referenced: */
> +	for (i = 0; i < n; ++i)
> +		if (!is_null_sha1(updates[i].new_sha1)) {
> +			ret |= update_ref_write(action,
> +						updates[i].ref_name,
> +						updates[i].new_sha1,
> +						locks[i], onerr);
> +			locks[i] = 0; /* freed by update_ref_write */
> +		}
> +

Hmmm, if one of the calls to update_ref_write() fails, would it be safer
to abort the rest of the work (especially the reference deletions)?

> +	/* Perform deletes now that updates are safely completed: */
> +	for (i = 0; i < n; ++i)
> +		if (locks[i]) {
> +			delnames[delnum++] = locks[i]->ref_name;
> +			ret |= delete_ref_loose(locks[i], types[i]);
> +		}
> +	ret |= repack_without_refs(delnames, delnum);
> +	for (i = 0; i < delnum; ++i)
> +		unlink_or_warn(git_path("logs/%s", delnames[i]));
> +	clear_loose_ref_cache(&ref_cache);
> +	for (i = 0; i < n; ++i)
> +		if (locks[i])
> +			unlock_ref(locks[i]);
> +
> +	free(updates);
> +	free(types);
> +	free(locks);
> +	free(delnames);
> +	return ret;
> +}

There's a lot of duplicated cleanup code in the function.  If you put a
label before the final for loop, and if you initialize the locks array
to zeros (e.g., by using xcalloc()), then the three exits could all
share the same code "ret = 1; goto cleanup;".

> +
>  struct ref *find_ref_by_name(const struct ref *list, const char *name)
>  {
>  	for ( ; list; list = list->next)
> diff --git a/refs.h b/refs.h
> index 2cd307a..a8a7cc6 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -214,6 +214,20 @@ int update_ref(const char *action, const char *refname,
>  		const unsigned char *sha1, const unsigned char *oldval,
>  		int flags, enum action_on_err onerr);
>  
> +struct ref_update {
> +	const char *ref_name;
> +	unsigned char new_sha1[20];
> +	unsigned char old_sha1[20];
> +	int flags;
> +	int have_old;
> +};

Please document this structure, especially the relationship between
have_old and old_sha1.

> +
> +/**
> + * Lock all refs and then perform all modifications.
> + */
> +int update_refs(const char *action, const struct ref_update *updates,
> +		int n, enum action_on_err onerr);
> +
>  extern int parse_hide_refs_config(const char *var, const char *value, const char *);
>  extern int ref_is_hidden(const char *);
>  
> 

Overall, thanks; it looks good.  I think this change is useful by itself
and is also a good start towards implementing true reference
transactions (which I think will be necessary pretty soon, at least for
some applications).  I will write another email discussing how your
changes are related to some changes that I have been working on lately.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
