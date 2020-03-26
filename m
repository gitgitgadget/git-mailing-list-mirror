Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC75C2D0E7
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE720714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D90FEKhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCZXOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:14:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37543 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgCZXOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 19:14:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so3658032pga.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mFWDjBuGORl9Xj08T5hYFG8jFXZVX1jXrf+cNVZgNdI=;
        b=D90FEKhVGw8AkKV95yvtnDk1rr6S+FHD7KgivPcrZS/83A6c1aOUFI7Z7gBJzmqSCi
         MXn7ivyzfLXrbINK7xISnY+Im4p/XnLv7pefjj+DDKxcnvJxd4bKJ/A/E2KBJjSw21j8
         ++m8XZQMe7kWun52CWyKKEtaOgZVqbGl7+yl1IayQnWT+VDu8W514d46U7InedX/qX4U
         K50gqgU2eX1Xw2UYo1u5UH0Qdg7BGitHbIaOuujajw26gFOASA0XIIpoS6bF9ax2kpdA
         2AuQEo7dh0itnWFsOhoDIS7lF6rgqc+jHwQTU+gJ7qONOlfV0pqJTMxVFBDn/Z/XtOb5
         CcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mFWDjBuGORl9Xj08T5hYFG8jFXZVX1jXrf+cNVZgNdI=;
        b=Yeyg6UTx/HxF4eB9OeH3KLK1bhH5fbsKAbYv8YP5SngbLIneauxvShf2Ow6BF0EY/M
         YSrhUsvPgKDddAkSZpFfJ6PUHuCi/faTPH7ts0VU9w+4YYeXmElgX1xab3y9+HzHh8Lk
         0MG6gkHNTOy7zHyl+5i69muL5Iv6CObokQ6nJiXSUEhLc+jc/OobPCnU62+b+d/Bz2aN
         cf1WRytAtv5PIg1Ctywf5Yv1AndshwunlwQ0id02UFG/b5Io9k5eeYMfVzarnp4Jw9ZF
         8wF8/DLZRMIZpnZezMMQg2J4ychARh1nquhlaxjorU+AzYhXns/7NrBDMUQt6o3+jPdy
         Ld/A==
X-Gm-Message-State: ANhLgQ2UyZs9lJdoX987D2f6pi+nBPDXrgGdL/3oiNSf65xzqbm3esxq
        OGo9Z3QeKeTag5lcwUlj/GZTZg==
X-Google-Smtp-Source: ADFU+vul63v3b5C5gz5CJJa78phh0bNxqIkN2HgunC9ZECnUQczRxm0gMQ7EGw0YiIQjfBpINmQNsg==
X-Received: by 2002:a62:5c07:: with SMTP id q7mr11681327pfb.200.1585264461971;
        Thu, 26 Mar 2020 16:14:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id h64sm2513463pfg.191.2020.03.26.16.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 16:14:21 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:14:16 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
Message-ID: <20200326231416.GC12694@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20200320220045.258462-1-jonathantanmy@google.com>
 <20200326211156.GA37946@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326211156.GA37946@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.03.26 14:11, Emily Shaffer wrote:
> On Fri, Mar 20, 2020 at 03:00:45PM -0700, Jonathan Tan wrote:
> > With 50033772d5 ("connected: verify promisor-ness of partial clone",
> > 2020-01-30), the fast path (checking promisor packs) in
> > check_connected() now passes a subset of the slow path (rev-list) - if
> > all objects to be checked are found in promisor packs, both the fast
> > path and the slow path will pass; otherwise, the fast path will
> > definitely not pass. This means that we can always attempt the fast path
> > whenever we need to do the slow path.
> > 
> > The fast path is currently guarded by a flag; therefore, remove that
> > flag. Also, make the fast path fallback to the slow path - if the fast
> > path fails, the failing OID and all remaining OIDs will be passed to
> > rev-list.
> 
> It looks like a pretty simple change. I had one probably-biased
> complaint about gotos below, otherwise it looks reasonable to me.

[snip]

> > diff --git a/connected.c b/connected.c
> > index 7e9bd1bc62..846f2e4eef 100644
> > --- a/connected.c
> > +++ b/connected.c
> > @@ -52,7 +52,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
> >  		strbuf_release(&idx_file);
> >  	}
> >  
> > -	if (opt->check_refs_are_promisor_objects_only) {
> > +	if (has_promisor_remote()) {
> >  		/*
> >  		 * For partial clones, we don't want to have to do a regular
> >  		 * connectivity check because we have to enumerate and exclude
> > @@ -71,13 +71,18 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
> >  				if (find_pack_entry_one(oid.hash, p))
> >  					goto promisor_pack_found;
> >  			}
> > -			return 1;
> > +			/*
> > +			 * Fallback to rev-list with oid and the rest of the
> > +			 * object IDs provided by fn.
> > +			 */
> > +			goto no_promisor_pack_found;
> >  promisor_pack_found:
> >  			;
> >  		} while (!fn(cb_data, &oid));
> >  		return 0;
> >  	}
> >  
> > +no_promisor_pack_found:
> 
> Having a look at the final structure of the loop with these gotos, I'm a
> little confused. Could be this isn't C-idiomatic but I think the code
> could be easier to read with helpers instead of gotos. I realize it's
> longer but I have a hard time understanding that your gotos are used to
> double-continue or double-break; nested loops tend to make me want to
> use helpers. But - I'm a lowly barely-reformed C++ developer, so what do
> I know ;)
> 
>   int oid_in_promisor(oid) {
>     for (p = get_all_packs(the_repository); p; p = p->next) {
>       if (!p->pack_promisor)
>         continue;
>       if (find_pack_entry_one(oid.hash, p)
>         return 1;
>     }
>   }
> 
>   int all_oids_in_promisors(oid, fn, cb_data)
>   {
>     do {
>       if (! oid_in_promisor(oid))
>         return 0;
>     } while (!fn(cb_data, &oid));
>     return 1;
>   }
> 
>   int check_connected(...)
>   {
>     ...
>     if (has_promisor_remote()) {
>       if (all_oids_in_promisors(oid, fn, cb_data))
>         return 0;
>       if (opt->shallow_file) {
>        ...
>   }

I like this version better as well.
