From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 14/21] refs: always handle non-normal refs in files
 backend
Date: Wed, 17 Feb 2016 21:44:00 -0500
Organization: Twitter
Message-ID: <1455763440.7528.71.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-15-git-send-email-dturner@twopensource.com>
	 <56BDF531.7010909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 03:44:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWEZe-00016x-JX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 03:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424530AbcBRCoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 21:44:06 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34765 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424140AbcBRCoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 21:44:04 -0500
Received: by mail-qg0-f42.google.com with SMTP id b67so27625230qgb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 18:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=WfIJzXvl/JZFUxg91OAKtD1Oxz1i15ol+n7of1VgMNI=;
        b=NnLfaI5A7c5YFApRAtlo+GSYY5UqKuFJLdLkV0HiDG4Ux6DVs8X5yrRMiY3nt59fBS
         MPqt5pkbc5vTac1jd+OT5Qe65RHuOxFcBxKQOjQfN4YtyuhFiQ8wnbCpU9mtQ+GThpDP
         23QkEjMS2+KM0GjshTP86ZxoY9sVL2OOY1j91skk3zt/d+LWc0hnTWxFFZX9eBLmY+cU
         O55fGUmomLNOZQ0DkDHYl+osuZ48EPheLAYhxgIJ3VwZiFQmVVJJjQFV9xx7kCesaJMZ
         pe7O9AL51/K7/+HU4NMvAvJMIEH4qFP8M0eCsiygKZGxSyN8Q9CMlS8H03RC3ZQ67ZZQ
         Zskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WfIJzXvl/JZFUxg91OAKtD1Oxz1i15ol+n7of1VgMNI=;
        b=jmCiYeiaRHQ1FTD2xuid+LWexmTLD1ukxkkLw1bDkdxuJiq0paPWojKVmJBomB0rRd
         Ohp3zv+lopLitdldd9yNHs3e995diSFgxyZAMXmO4F6g3WzuZ9bnM+jcCeNnwRMy24qL
         ZbfcIBgeXgd5F1VfbLfSIfk6uUfMXVfIszRDqx0WgyrUL1pHty4sYKEgg1EiYIiU51qP
         nxMW0A0MqncdmCv/jOismTEbEdV+n2YgknItNy56oQe/CSncRviRM5mR2stFkP1peuhn
         W6MkYaqa88BAnAmp8ISuHLRXZ7PiU0c6sXz1DA01MBpvnyenwVn7jcHbAO6at5IQz3iC
         pmfQ==
X-Gm-Message-State: AG10YOTRat3IDdTQv+QQIseLCYSycLsFcKn+orcJ1eDg97ROoTUkQxZzRsMfcElZIauRHA==
X-Received: by 10.140.18.136 with SMTP id 8mr6073515qgf.64.1455763442678;
        Wed, 17 Feb 2016 18:44:02 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id n35sm16613510qgn.10.2016.02.17.18.44.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 18:44:01 -0800 (PST)
In-Reply-To: <56BDF531.7010909@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286571>

On Fri, 2016-02-12 at 16:07 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > Always handle non-normal (per-worktree or pseudo) refs in the files
> > backend instead of alternate backends.
> > 
> > Sometimes a ref transaction will update both a per-worktree ref and
> > a
> > normal ref.  For instance, an ordinary commit might update
> > refs/heads/master and HEAD (or at least HEAD's reflog).
> > 
> > Updates to normal refs continue to go through the chosen backend.
> > 
> > Updates to non-normal refs are moved to a separate files backend
> > transaction.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs.c | 81
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 79 insertions(+), 2 deletions(-)
> > 
> > diff --git a/refs.c b/refs.c
> > index 227c018..18ba356 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -9,6 +9,11 @@
> >  #include "object.h"
> >  #include "tag.h"
> >  
> > +static const char split_transaction_fail_warning[] = N_(
> > +	"A ref transaction was split across two refs backends. 
> >  Part of the "
> > +	"transaction succeeded, but then the update to the per
> > -worktree refs "
> > +	"failed.  Your repository may be in an inconsistent
> > state.");
> > +
> >  /*
> >   * We always have a files backend and it is the default.
> >   */
> > @@ -791,6 +796,13 @@ void ref_transaction_free(struct
> > ref_transaction *transaction)
> >  	free(transaction);
> >  }
> >  
> > +static void add_update_obj(struct ref_transaction *transaction,
> > +			   struct ref_update *update)
> > +{
> > +	ALLOC_GROW(transaction->updates, transaction->nr + 1,
> > transaction->alloc);
> > +	transaction->updates[transaction->nr++] = update;
> > +}
> > +
> >  static struct ref_update *add_update(struct ref_transaction
> > *transaction,
> >  				     const char *refname)
> >  {
> > @@ -798,8 +810,7 @@ static struct ref_update *add_update(struct
> > ref_transaction *transaction,
> >  	struct ref_update *update = xcalloc(1, sizeof(*update) +
> > len);
> >  
> >  	memcpy((char *)update->refname, refname, len); /* includes
> > NUL */
> > -	ALLOC_GROW(transaction->updates, transaction->nr + 1,
> > transaction->alloc);
> > -	transaction->updates[transaction->nr++] = update;
> > +	add_update_obj(transaction, update);
> >  	return update;
> >  }
> >  
> > @@ -1217,11 +1228,38 @@ static int dereference_symrefs(struct
> > ref_transaction *transaction,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Move all non-normal ref updates into a specially-created
> > + * files-backend transaction
> > + */
> > +static int move_abnormal_ref_updates(struct ref_transaction
> > *transaction,
> > +				     struct ref_transaction
> > *files_transaction,
> > +				     struct strbuf *err)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < transaction->nr; i++) {
> > +		int last;
> > +		struct ref_update *update = transaction
> > ->updates[i];
> > +
> > +		if (ref_type(update->refname) == REF_TYPE_NORMAL)
> > +			continue;
> > +
> > +		last = --transaction->nr;
> > +		transaction->updates[i] = transaction
> > ->updates[last];
> > +		add_update_obj(files_transaction, update);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> I think this function is incorrect. The update that was previously at
> transaction->updates[i] never gets checked for abnormality. 

Yes it does; that's the "update" variable that we just checked.

> You could
> fix that and also avoid gratuitously changing the order of the
> updates
> like this:
> 
> static int move_abnormal_ref_updates(struct ref_transaction
> *transaction,
> 				     struct ref_transaction
> *files_transaction,
> 				     struct strbuf *err)
> {
> 	int i, normal_nr = 0;
> 
> 	for (i = 0; i < transaction->nr; i++) {
> 		struct ref_update *update = transaction->updates[i];
> 
> 		if (ref_type(update->refname) == REF_TYPE_NORMAL)
> 			transaction->updates[normal_nr++] = update;
> 		else
> 			add_update_obj(files_transaction, update);
> 	}
> 
> 	transaction->nr = normal_nr;
> 	return 0;
> }

Sure, I can make that change.

> Another alternative would be to set
> 
>     update->flags |= REF_ABNORMAL
> 
> for the abnormal references and *leave them* in the original
> transaction
> while also adding them to files_transactions. Then teach non-files
> backends to skip over updates with REF_ABNORMAL.
> 
> The reason I thought of this is that long-term I'd like to make it
> possible for some reference updates to fail without aborting the
> transaction. To implement that, we would want a way for
> ref_transaction_commit() to report back to its caller *which* updates
> failed, and an obvious way to do that would be to store the
> reference-specific errors in struct ref_update. If you leave the
> abnormal ref_updates in the main transaction, then my hoped-for
> change
> would be easier.
> 
> But that's a separate and hypothetical idea, so you don't have to let
> it
> influence how you implement this patch.

I'm also interested in this idea. Perhaps it would also be nice to
report *why* they fail (e.g. the conflicting ref name).  I did a
variant of this with for the journal code, but my way of doing it
turned out to be a bad idea (long story).  But I want to stay focused
on the simplest thing possible, for now.

> >  int ref_transaction_commit(struct ref_transaction *transaction,
> >  			   struct strbuf *err)
> >  {
> >  	int ret = -1;
> >  	struct string_list affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +	struct string_list files_affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +	struct ref_transaction *files_transaction = NULL;
> >  
> >  	assert(err);
> >  
> > @@ -1237,6 +1275,26 @@ int ref_transaction_commit(struct
> > ref_transaction *transaction,
> >  	if (ret)
> >  		goto done;
> >  
> > +	if (the_refs_backend != &refs_be_files) {
> > +		files_transaction = ref_transaction_begin(err);
> > +		if (!files_transaction)
> > +			goto done;
> > +
> > +		ret = move_abnormal_ref_updates(transaction,
> > files_transaction,
> > +						err);
> > +		if (ret)
> > +			goto done;
> > +
> > +		/* files backend commit */
> > +		if (get_affected_refnames(files_transaction,
> > +						 &files_affected_r
> > efnames,
> > +						 err)) {
> > +			ret = TRANSACTION_GENERIC_ERROR;
> > +			goto done;
> > +		}
> > +	}
> > +
> > +	/* main backend commit */
> >  	if (get_affected_refnames(transaction, &affected_refnames,
> > err)) {
> >  		ret = TRANSACTION_GENERIC_ERROR;
> >  		goto done;
> > @@ -1244,8 +1302,24 @@ int ref_transaction_commit(struct
> > ref_transaction *transaction,
> >  
> >  	ret = the_refs_backend->transaction_commit(transaction,
> >  						  
> >  &affected_refnames, err);
> > +	if (ret)
> > +		goto done;
> > +
> > +	if (files_transaction) {
> > +		ret =
> > refs_be_files.transaction_commit(files_transaction,
> > +						      
> >  &files_affected_refnames,
> > +						       err);
> > +		if (ret) {
> > +			warning(split_transaction_fail_warning);
> > +			goto done;
> > +		}
> > +	}
> > +
> >  done:
> >  	string_list_clear(&affected_refnames, 0);
> > +	string_list_clear(&files_affected_refnames, 0);
> > +	if (files_transaction)
> > +		ref_transaction_free(files_transaction);
> >  	return ret;
> >  }
> >  
> > @@ -1285,6 +1359,9 @@ int peel_ref(const char *refname, unsigned
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
> Does initial_ref_transaction_commit() need the same treatment?

We only use that for remote refs -- I'm not sure if those can be
symrefs.  Wouldn't hurt.

> I think files_rename_ref() will break if one of the references is
> normal
> and one is abnormal. I think it would be OK to prohibit renaming
> abnormal refs entirely (can anybody think of an important use case?),
> but that function should at least do the checks.

The files backend would work fine, but I guess I'll add the check
anyway, since that would be a weird thing to do.  
