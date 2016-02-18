From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 14/21] refs: always handle non-normal refs in files
 backend
Date: Thu, 18 Feb 2016 13:32:37 -0500
Organization: Twitter
Message-ID: <1455820357.7528.72.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-15-git-send-email-dturner@twopensource.com>
	 <56BDF531.7010909@alum.mit.edu> <1455763440.7528.71.camel@twopensource.com>
	 <56C5B41E.50502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 19:32:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWTNc-0001hq-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 19:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426848AbcBRScl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 13:32:41 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35774 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426516AbcBRScj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 13:32:39 -0500
Received: by mail-qk0-f180.google.com with SMTP id o6so21867467qkc.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 10:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=YkrppXKmxw1n5OYI6DMv9emu+EL+qxUpgDoz8NSkTmQ=;
        b=iQwESNz9e5RjzdofY+6ohOA9B2sFCLOguUa/GKNWHQ1o8LelIipnrVsJEfWVeBCOJX
         A77PsBXzl53gOa8MoLObG0sKnAQUZrfllSA4YZeZ7EXz6z51piE7djO9Mo6jYMq7YF+u
         GnbC7iXaPdUDsxrjvXNlxpKUyzDpV2jNO6UVM3WZBGMtCKsULD/2Vwe/cFgZjz63Cq6z
         srG/p5mmBBPtSrFk/5XtWeZl+/V3ZqraXgCFxWRhiYryJwQZBb4VJkPA6Htckcvh5U35
         vucFeB60Cj+YuysYahTqh9HTjB+ZomCqgcd4xRbfjVfU2y13IeyACTOPgCWhu/EpL6UY
         VSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=YkrppXKmxw1n5OYI6DMv9emu+EL+qxUpgDoz8NSkTmQ=;
        b=krQCD6BF/FS/TgGAqnVxBK+y7++DA+kxliMDOPnCtTRElG48p5EO345ViS60UA8t3A
         a1drSwShKfmkemM+g4pUgSt1r+vUWBT/U4VuvdOrN//2hKT8GuwUEdmnMk9hxV1/hHhl
         709eSDTvRO6uWW7eShsg52XA5PkGdp86E7k7eFPZX12b5k/8/6P9cHBomsA/7gyObsg0
         GZz3nWYAiNyiwzNLs+N5Gjswjd1bH1fvDTPVIW6PJFle7x3mW8jBYHuud9js0/wMsHPg
         DQ6qEDrKuNhMlEeIfDL2TVQUZKmGebBg6YWxTuWBd7Xrl+PmnUeR3fToGzEHs+tYakTO
         GR4g==
X-Gm-Message-State: AG10YOS/A7gCaAH9ConGpj+uyq/Ipj1jNftG8Nr3lkhg6mMIMXA7riumrkaVIn3VmVtS1w==
X-Received: by 10.55.79.86 with SMTP id d83mr10840925qkb.22.1455820358453;
        Thu, 18 Feb 2016 10:32:38 -0800 (PST)
Received: from ubuntu ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id h11sm3040872qhd.31.2016.02.18.10.32.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Feb 2016 10:32:37 -0800 (PST)
In-Reply-To: <56C5B41E.50502@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286612>

On Thu, 2016-02-18 at 13:07 +0100, Michael Haggerty wrote:
> On 02/18/2016 03:44 AM, David Turner wrote:
> > On Fri, 2016-02-12 at 16:07 +0100, Michael Haggerty wrote:
> > > On 02/05/2016 08:44 PM, David Turner wrote:
> > > > Always handle non-normal (per-worktree or pseudo) refs in the
> > > > files
> > > > backend instead of alternate backends.
> > > > 
> > > > Sometimes a ref transaction will update both a per-worktree ref
> > > > and
> > > > a
> > > > normal ref.  For instance, an ordinary commit might update
> > > > refs/heads/master and HEAD (or at least HEAD's reflog).
> > > > 
> > > > Updates to normal refs continue to go through the chosen
> > > > backend.
> > > > 
> > > > Updates to non-normal refs are moved to a separate files
> > > > backend
> > > > transaction.
> > > > 
> > > > Signed-off-by: David Turner <dturner@twopensource.com>
> > > > ---
> > > >  refs.c | 81
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > +--
> > > >  1 file changed, 79 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/refs.c b/refs.c
> > > > index 227c018..18ba356 100644
> > > > --- a/refs.c
> > > > +++ b/refs.c
> > > > @@ -9,6 +9,11 @@
> > > >  #include "object.h"
> > > >  #include "tag.h"
> > > >  
> > > > +static const char split_transaction_fail_warning[] = N_(
> > > > +	"A ref transaction was split across two refs backends.
> > > >  Part of the "
> > > > +	"transaction succeeded, but then the update to the per
> > > > -worktree refs "
> > > > +	"failed.  Your repository may be in an inconsistent
> > > > state.");
> > > > +
> > > >  /*
> > > >   * We always have a files backend and it is the default.
> > > >   */
> > > > @@ -791,6 +796,13 @@ void ref_transaction_free(struct
> > > > ref_transaction *transaction)
> > > >  	free(transaction);
> > > >  }
> > > >  
> > > > +static void add_update_obj(struct ref_transaction
> > > > *transaction,
> > > > +			   struct ref_update *update)
> > > > +{
> > > > +	ALLOC_GROW(transaction->updates, transaction->nr + 1,
> > > > transaction->alloc);
> > > > +	transaction->updates[transaction->nr++] = update;
> > > > +}
> > > > +
> > > >  static struct ref_update *add_update(struct ref_transaction
> > > > *transaction,
> > > >  				     const char *refname)
> > > >  {
> > > > @@ -798,8 +810,7 @@ static struct ref_update *add_update(struct
> > > > ref_transaction *transaction,
> > > >  	struct ref_update *update = xcalloc(1, sizeof(*update)
> > > > +
> > > > len);
> > > >  
> > > >  	memcpy((char *)update->refname, refname, len); /*
> > > > includes
> > > > NUL */
> > > > -	ALLOC_GROW(transaction->updates, transaction->nr + 1,
> > > > transaction->alloc);
> > > > -	transaction->updates[transaction->nr++] = update;
> > > > +	add_update_obj(transaction, update);
> > > >  	return update;
> > > >  }
> > > >  
> > > > @@ -1217,11 +1228,38 @@ static int dereference_symrefs(struct
> > > > ref_transaction *transaction,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Move all non-normal ref updates into a specially-created
> > > > + * files-backend transaction
> > > > + */
> > > > +static int move_abnormal_ref_updates(struct ref_transaction
> > > > *transaction,
> > > > +				     struct ref_transaction
> > > > *files_transaction,
> > > > +				     struct strbuf *err)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < transaction->nr; i++) {
> > > > +		int last;
> > > > +		struct ref_update *update = transaction
> > > > ->updates[i];
> > > > +
> > > > +		if (ref_type(update->refname) ==
> > > > REF_TYPE_NORMAL)
> > > > +			continue;
> > > > +
> > > > +		last = --transaction->nr;
> > > > +		transaction->updates[i] = transaction
> > > > ->updates[last];
> > > > +		add_update_obj(files_transaction, update);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > 
> > > I think this function is incorrect. The update that was
> > > previously at
> > > transaction->updates[i] never gets checked for abnormality. 
> > 
> > Yes it does; that's the "update" variable that we just checked.
> 
> Sorry, I meant to say "the update that was previously at
> `transaction->updates[transaction->nr - 1]` never gets checked for
> abnormality". Because it gets moved to `transaction->updates[i]`,
> then
> `i` is incremented without checking it.

Oh, right. 
