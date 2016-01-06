From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 12/16] refs: always handle non-normal refs in files
 backend
Date: Tue, 05 Jan 2016 19:13:27 -0500
Organization: Twitter
Message-ID: <1452039207.3892.93.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-13-git-send-email-dturner@twopensource.com>
	 <567A5516.9070209@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 01:13:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGbjL-0002nl-4o
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 01:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbcAFANc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 19:13:32 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35822 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcAFANa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 19:13:30 -0500
Received: by mail-qk0-f178.google.com with SMTP id n135so147320532qka.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 16:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=QFFuuEtFfm+IvAjT+VSqyjfhoedgpb2EoNiOyT2ZGRY=;
        b=VkQ2QOWqYDjv/ptob5PklksUKJZYcBtOdUD1DCgXrf0MD9A6vvbQzuVd1FrQiucXET
         ntQhh+D5i48txhvLXglP2bE1t2Kk+JszB/SwC2Xt5+VvcYfDSRM2JBqyvnOXW8OC3sm6
         w3gKhTmfYhYioGOZAqEYboC1aiOkzl7o3hmqrZ1TMiLxlYZFRS5S4sp+FIS/aunxuSUe
         WCDOV4gC535nch904lAVOo9NxCa6M58U6vtD78YUHJGCXNALTKCbv7P0pvyiuVz2JyO4
         ZVncsIvSDYDySPdQMU9AB53IkSxndlOWeg2IwQa4rFT00GmiGske+wmrGnqh3drzEp4i
         WMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=QFFuuEtFfm+IvAjT+VSqyjfhoedgpb2EoNiOyT2ZGRY=;
        b=Sn+RTZvMXL7N682y6ikVWQdDce2aw+aAe3tz8rdGRj3HwYmMvo7Wib0Z6QT3uFuCDO
         L+iFhoabYAumitj1njUrq4FRITCRM0w6XU7nhxtYXhvHqO06XRT+NPju07PaiyzYz8dK
         MCQdnyPgmhRPM8OMVa6mBGnYi59AbkkvndRoFhkoHQkjF/hR7N98iTHAnmD645Qwqirh
         GPlBpz3rVcW8qPY0wSkFaxHnYO03wb01Ii7D/frFY/ccumnsJcAL9yX95a2x1KYY+hrv
         Pub4bC48Dj81hnhmxsyzDkGH4HQo/CLl4T9db5qoNerEVjJnEYarnw30uL4CbFwMHMCp
         /U+A==
X-Gm-Message-State: ALoCoQlMtWfGhYReR0pyHFE6uNLqz2eXfvVtshAnzoMF8gbkxsyhhHGhjsJhhLYz4lP1P4bvZ3oIJIG1iaehit5PQb2sCO2kqQ==
X-Received: by 10.55.22.29 with SMTP id g29mr126607820qkh.100.1452039209541;
        Tue, 05 Jan 2016 16:13:29 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a129sm14108246qkb.45.2016.01.05.16.13.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 16:13:28 -0800 (PST)
In-Reply-To: <567A5516.9070209@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283408>

On Wed, 2015-12-23 at 09:02 +0100, Michael Haggerty wrote:
> + * We move other non-normal ref updates with into a specially
> > -created
> > + * files-backend transaction
> > + */
> 
> Extra word? s/with//?

Fixed, thanks.

> > +			add_update_obj(files_transaction, update);
> > +			/*
> > +			 * Replace this transaction with the
> > +			 * last transaction, removing it from
> > +			 * the list of backend transactions
> > +			 */
> > +			last = --transaction->nr;
> > +			transaction->updates[i] = transaction
> > ->updates[last];
> 
> The "last" temporary variable could be trivially inlined.

Yes, but then the line would be > 80 characters.

> > +			continue;
> > +		}
> > +
> > +		if (resolved) {
> > +			struct ref_update *new_update;
> > +			struct string_list_item *item;
> > +
> > +			if (ref_type(resolved) != REF_TYPE_NORMAL)
> > +				die("Non-normal symbolic ref `%s`
> > points to non-normal ref `%s`", update->refname, resolved);
> 
> We don't usually use backticks in error messages. Please use "'"
> instead.

Fixed.

> Also, please store this error message into a "strbuf *err" and report
> it
> via the usual mechanism.

Fixed.

> > +			new_update = xmalloc(sizeof(*new_update) +
> > +					     strlen(resolved) +
> > 1);
> > +			memcpy(new_update, update,sizeof(*update));
> z
> Wouldn't it be preferable to replace this messy replacement code
> (including the memcpy(), which can't be checked by the type system)
> with
> a call to ref_transaction_update() followed by moving the new update
> to
> this position in the list and possibly tweaking some of its fields?
>
> > +			if (update->flags & REF_HAVE_OLD &&
> > +			    hashcmp(sha1, update->old_sha1)) {
> > +				/* consistency check failed */
> > +				free(new_update);
> > +				return -1;
> 
> We need an error message to be reported in this case; i.e., via a
> "struct strbuf *err" argument.
>
> But actually, I don't understand why this check is needed here at
> all.
> Isn't it redundant with a similar check that will be done later (and
> properly, under lock) as part of the main ref_transaction_commit(

Looks like probably yes.

> > +			} else {
> > +				hashcpy(update->old_sha1, sha1);
> > +			}
> > +
> > +			strcpy((char *)new_update->refname,
> > resolved);
> > +			transaction->updates[i] = new_update;
> > +
> > +			item = string_list_append(symrefs, update
> > ->refname);
> > +			item->util = new_update;
> > +			free(update);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int ref_transaction_commit(struct ref_transaction *transaction,
> >  			   struct strbuf *err)
> >  {
> >  	int ret = -1;
> >  	struct string_list affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +	struct string_list files_affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +	struct string_list symrefs = STRING_LIST_INIT_DUP;
> > +	struct string_list_item *item;
> > +	struct ref_transaction *files_transaction = NULL;
> >  
> >  	assert(err);
> >  
> > @@ -1146,6 +1233,26 @@ int ref_transaction_commit(struct
> > ref_transaction *transaction,
> >  		return 0;
> >  	}
> >  
> > +	if (the_refs_backend != &refs_be_files) {
> > +		files_transaction = ref_transaction_begin(err);
> > +		if (!files_transaction)
> > +			die("%s", err->buf);
> 
> I think dying here is too abrupt. Some callers try to recover from a
> failed ref_transaction_commit(). Couldn't you "goto done" and let the
> caller deal with err?

Sure.

> > +		ret = move_abnormal_ref_updates(transaction,
> > files_transaction,
> > +						&symrefs);
> > +		if (ret)
> > +			goto done;
> > +
> > +		/* files backend commit */
> > +		if
> > (ref_update_reject_duplicates(files_transaction,
> > +						 &files_affected_r
> > efnames,
> > +						 err)) {
> > +			ret = TRANSACTION_GENERIC_ERROR;
> > +			goto done;
> > +		}
> 
> Is it correct to reject_duplicates among "abnormal" references and
> "normal" references separately? ***

Yes.  No reference is both normal and abnormal.  

> > +	}
> > +
> > +	/* main backend commit */
> >  	if (ref_update_reject_duplicates(transaction,
> > &affected_refnames, err)) {
> >  		ret = TRANSACTION_GENERIC_ERROR;
> >  		goto done;
> > @@ -1153,8 +1260,35 @@ int ref_transaction_commit(struct
> > ref_transaction *transaction,
> >  
> >  	ret = the_refs_backend->transaction_commit(transaction,
> >  						  
> >  &affected_refnames, err);
> > +	if (ret)
> > +		goto done;
> > +
> > +	if (the_refs_backend != &refs_be_files) {
> 
> This conditional would perhaps be more to the point if expressed as
> "if
> (files_transaction)".

OK.

> > +		ret =
> > refs_be_files.transaction_commit(files_transaction,
> > +						      
> >  &files_affected_refnames,
> > +						       err);
> > +		if (ret) {
> > +			warning(split_transaction_fail_warning);
> > +			goto done;
> > +		}
> > +
> > +		/* reflogging for dereferenced symbolic refs */
> > +		for_each_string_list_item(item, &symrefs) {
> > +			struct ref_update *update = item->util;
> > +			if (files_log_ref_write(item->string,
> > update->old_sha1,
> > +						update->new_sha1,
> > +						update->msg,
> > update->flags, err))
> > +				warning("failed to log ref update
> > for symref %s",
> > +					item->string);
> > +		}
> 
> I think this code is incorrect because it doesn't lock the symbolic
> reference before modifying its reflog (though I seem to recall that
> the
> old code was buggy in this respect, too).

> I wonder whether it would be simpler overall to leave the ref_update
> for
> the symbolic ref in the files_transaction, but set a special internal
> internal flag like REF_LOG_ONLY which tells the usual
> transaction_commit
> code to add a reflog entry for update->old_sha1 to update->new_sha1,
> without actually changing the reference.

Hm.  This seems to work -- see below for more details.

> > +	}
> > +
> >  done:
> >  	string_list_clear(&affected_refnames, 0);
> > +	string_list_clear(&files_affected_refnames, 0);
> > +	if (files_transaction)
> > +		ref_transaction_free(files_transaction);
> > +	string_list_clear(&symrefs, 0);
> >  	return ret;
> >  }
> >  
> > @@ -1210,6 +1344,9 @@ int peel_ref(const char *refname, unsigned
> > char *sha1)
> >  int create_symref(const char *ref_target, const char
> > *refs_heads_master,
> >  		  const char *logmsg)
> >  {
> > +	if (ref_type(ref_target) != REF_TYPE_NORMAL)
> > +		return refs_be_files.create_symref(ref_target,
> > refs_heads_master,
> > +						   logmsg);
> >  	return the_refs_backend->create_symref(ref_target,
> > refs_heads_master,
> >  					       logmsg);
> >  }
> > 
> 
> I very much like the idea of introducing special handling for 
> symbolic reference updates within a transaction. In fact, I think I 
> would go even farther:
> 
> Let's take the example of an update to HEAD, which currently points
> at
> refs/heads/master. I think it would *always* be a good idea (i.e., 
> even when only the files backend is in use) to split that ref_update 
> into two ref_updates:
> 
> 1. One to update refs/heads/master and add a reflog entry for that
>    reference.
> 
> 2. One to add a reflog entry for HEAD (i.e. using the new 
> REF_LOG_ONLY flag suggested above).
> 
> Why?
> 
> * It ensures that both references are locked correctly while their
>   reflogs are updated. (I believe the current code gets this wrong.)

It's true that both refs are locked while their reflogs are updated.
However, the symbolic ref isn't locked while the update to its referent
happens, which is still bad.  I guess we could fix that later, since I
don't think this would make the situation any worse.

One thing to note is that there's a bunch of dereferencing code in
files-backend.c which we could eliminate by doing the split outside the
backend.  I've made the basic version of this change, but haven't yet
looked at whether and how we can eliminate that code.  Tomorrow (I
hope), I'll do some more work on that.

> * It improves the reject_duplicates coverage, which (I think)
> currently
>   wouldn't detect the conflict between a direct update of
>   refs/heads/master with a simultaneous update of the same reference
>   via HEAD.

As it happens, the current code handles this case indirectly; the ref
is locked by the first update, so the update through the second can't
do get the lock, causing the whole transaction to fail.  After this
patch, it is handled directly (since the main transaction now contains
the referent of HEAD).

> * It could later be generalized to an update that goes through
> multiple
>   layers of symref indirection (though this would be a very low
>   priority).
> 
> This might benefit the split-backend situation that you are
> implementing
> here. You could first do the symref-splitting step I just described,
> and
> *then* separate the non-normal from the normal refs. I think the net
> result would be simpler.
> 
> This patch is a lot to digest. I'm not yet confident that I have
> thought
> through all of the ramifications of this patch. I guess a few
> iterations
> will be needed in any case.

I'm sure that's true.

> By the way, all of the patches preceding this one that I haven't
> commented on look OK to me.

Thanks.
