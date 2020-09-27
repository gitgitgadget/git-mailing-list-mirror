Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B268C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 12:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2222D2389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 12:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYZyjN3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgI0M1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0M1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 08:27:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A4C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 05:27:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so2041102pjr.3
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+Gn7uYyZajsDudwhm/2hKUllPl/VapDBzbFIC29Evs=;
        b=WYZyjN3jVW1vRI/C6o9GMnISHHMWJD2I1G69ufE14beuRDfprkhk/F7a82rqKee1yE
         oR8mt6gvBNU5X8sriMuY3XCwtG1PRFox1XkKr/gtPDKhENf4qo0wUoNHOvjpvwRr37Xl
         XTuoBBTsWtOopoJ45rfw41F26N1zrN4IDNVqK1ChfqGoiQLF/htd1HjXR9CmbaO7hOlQ
         vMSyTVgOe5ck5VtZdmGE6K/f61L5N5s1hp5/nmRjcpOqXZeSCIcG0H+4Ap0N+nCt6+58
         ZS5MC5bUNmF+tYWvhGgt49Uqap2COtk4jHoPCxpdBk6jAXC4XkW7GN1MOpDziwj1JKa7
         5Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+Gn7uYyZajsDudwhm/2hKUllPl/VapDBzbFIC29Evs=;
        b=BfwM2awVSVPw3WkdOH6KPZEdXYXL4g0mmzd2fb9VEoFYKJSv3g3nylaQ44AcdEEbBa
         nDNwDFSerpAS3jKrzOoXZdYUbgItRinZBostyCw+sHNjFN0GLcbjL1/Qe8JJjVmg0w9L
         zLmrBEKg9pfnw1VjhiEzJlMZf+F4ZLhgLwWVJKShr5VXedrU0qVVFLLc2TK2LMnOoZLx
         qQ3dyQQuYDId0ASkEaO8tfvWMc0+HngFV63EwqJCi5eLkGE1PG7/cpPxlHRlaFSaxw4u
         bjw18p8oXzQE21GFxF8lta+5+XUA31o5D1veGfXVqEtddsdMsJ4RbngmVb9ewZpc/kFC
         wcZA==
X-Gm-Message-State: AOAM5311AQjiZxNZqkNwBfBk7MUTeoH+opFjN2gR9Rpge0ur0kSpebz2
        8v2ntaT5+Jz+x9BuemA4NS3RO8hCmx0Ntnnz
X-Google-Smtp-Source: ABdhPJyx0NYE/21B81/EhNxPrhUzxxqVKzIktZHKosWdLJCBdIjP4Ri4LOb4UoAZ+FoAxaaNO/7Yjw==
X-Received: by 2002:a17:90a:5588:: with SMTP id c8mr5346902pji.224.1601209670735;
        Sun, 27 Sep 2020 05:27:50 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.106.216])
        by smtp.gmail.com with ESMTPSA id k11sm4205024pjs.18.2020.09.27.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 05:27:49 -0700 (PDT)
Date:   Sun, 27 Sep 2020 17:57:45 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20200927122745.GA6641@mail.clickyotomy.dev>
References: <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
 <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
 <20200926114626.28823-2-shrinidhi.kaushik@gmail.com>
 <xmqqwo0ggl65.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo0ggl65.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/26/2020 16:42, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > @@ -2252,11 +2263,11 @@ int is_empty_cas(const struct push_cas_option *cas)
> >  /*
> >   * Look at remote.fetch refspec and see if we have a remote
> >   * tracking branch for the refname there.  Fill its current
> > - * value in sha1[].
> > + * value in sha1[], and as a string.
> 
> I think the array being referred to was renamed to oid[] sometime
> ago.  "and as a string" makes it sound as if sha1[] gets the value
> as 40-hex object name text, but that is not what is being done.
> 
>     Fill the name of the remote-tracking branch in *dst_refname,
>     and the name of the commit object at tis tip in oid[].
> 
> perhaps?

Of course, that sounds better; will update.
 
> > + * The struct "reflog_commit_list" and related helper functions
> > + * for list manipulation are used for collecting commits into a
> > + * list during reflog traversals in "if_exists_or_grab_until()".
> 
> Has the name of that function changed since this comment was
> written?

Heh, it sure has. It should have been "check_and_collect_until()".
 
> > + */
> > +struct reflog_commit_list {
> > +	struct commit **items;
> 
> Name an array in singular when its primary use is to work on an
> element at a time---that will let you say item[4] to call the 4-th
> item, instead of items[4] that smells awkward.
> 
> An array that is used mostly to pass around a collection as a whole
> is easier to think about when given a plural name, though.

Yup.

> > +
> > +/* Get the timestamp of the latest entry. */
> > +static int peek_reflog(struct object_id *o_oid, struct object_id *n_oid,
> > +		       const char *ident, timestamp_t timestamp,
> > +		       int tz, const char *message, void *cb_data)
> > +{
> > +	timestamp_t *ts = cb_data;
> > +	*ts = timestamp;
> > +	return 1;
> > +}
> 
> The idea is to use a callback that immediately says "no more" to
> grab the data from the first item in the iteration.  It feels
> somewhat awkward but because there is no "give us the Nth entry" API
> function, it is the cleanest way we can do this.

I considered using "grab_1st_entry_timestamp()" briefy, but
"peek_reflog" is shorter compared to that.

> > +	/* Look-up the commit and append it to the list. */
> > +	if ((commit = lookup_commit_reference(the_repository, n_oid)))
> > +		add_commit(cb->local_commits, commit);
> 
> This is merely a minor naming thing, but if you rename add_commit()
> to append_commit(), you probably do not even need the comment before
> this statement.

Will do.

> >  	return 0;
> >  }
> >  
> > +#define MERGE_BASES_BATCH_SIZE 8
> 
> Hmph.  Do we still need batching?
> 
> > +/*
> > + * Iterate through the reflog of the local ref to check if there is an entry
> > + * for the given remote-tracking ref; runs until the timestamp of an entry is
> > + * older than latest timestamp of remote-tracking ref's reflog. Any commits
> > + * are that seen along the way are collected into a list to check if the
> > + * remote-tracking ref is reachable from any of them.
> > + */
> > +static int is_reachable_in_reflog(const char *local, const struct ref *remote)
> > +{
> > +	timestamp_t date;
> > +	struct commit *commit;
> > +	struct commit **chunk;
> > +	struct check_and_collect_until_cb_data cb;
> > +	struct reflog_commit_list list = { NULL, 0, 0 };
> > +	size_t count = 0, batch_size = 0;
> > +	int ret = 0;
> > +
> > +	commit = lookup_commit_reference(the_repository, &remote->old_oid);
> > +	if (!commit)
> > +		goto cleanup_return;
> > +
> > +	/*
> > +	 * Get the timestamp from the latest entry
> > +	 * of the remote-tracking ref's reflog.
> > +	 */
> > +	for_each_reflog_ent_reverse(remote->tracking_ref, peek_reflog, &date);
> > +
> > +	cb.remote_commit = commit;
> > +	cb.local_commits = &list;
> > +	cb.remote_reflog_timestamp = date;
> > +	ret = for_each_reflog_ent_reverse(local, check_and_collect_until, &cb);
> > +
> > +	/* We found an entry in the reflog. */
> > +	if (ret > 0)
> > +		goto cleanup_return;
> 
> Good.  So '1' from the callback is "we found one, no need to look
> further and no need to do merge-base", and '-1' from the callback is
> "we looked at all entries that are young enough to matter and we
> didn't find exact match".  Makes sense.
> 
> > +	/*
> > +	 * Check if the remote commit is reachable from any
> > +	 * of the commits in the collected list, in batches.
> > +	 */
> 
> I do not know if batching would help (have you measured it?), but if
> we were to batch, it is more common to arrange the loop like this:
> 
> 	for (chunk = list.items;
>              chunk < list.items + list.nr;
> 	     chunk += size) {
>              	size = list.items + list.nr - chunk;
>                 if (MERGE_BASES_BATCH_SIZE < size)
> 			size = MERGE_BASES_BATCH_SIZE;
> 		... use chunk[0..size] ...
> 		chunk += size;
> 	}
> 
> That is, assume that we can grab everything during this round, and
> if that bites off too many, clamp it to the maximum value.  If you
> are not comfortable with pointer arithmetic, it is also fine to use
> an auxiliary variable 'count', but ...

Actually, the "for" version looks much cleaner and avoids the use
of "count". However, I think ...

>               chunk += size;

... should be skipped because "for ( ... ; chunk += size)" is already
doing it for us; otherwise we would offset 16 entries instead of 8
per iteration, no?

> > +	chunk = list.items;
> > +	while (count < list.nr) {
> > +		batch_size = MERGE_BASES_BATCH_SIZE;
> > +
> > +		/* For any leftover entries. */
> > +		if ((count + MERGE_BASES_BATCH_SIZE) > list.nr)
> > +			batch_size = list.nr - count;
> > +
> > +		if ((ret = in_merge_bases_many(commit, batch_size, chunk)))
> > +			break;
> > +
> > +		chunk += batch_size;
> > +		count += MERGE_BASES_BATCH_SIZE;
> 
> ... you are risking chunk and count to go out of sync here.
> 
> It does not matter within this loop (count will point beyond the end
> of list.item[] while chunk will never go past the array), but future
> developers can be confused into thinking that they can use chunk and
> count interchangeably after this loop exits, and at that point the
> discrepancy may start to matter.

I agree, it should have been "count += batch_size;". But, I think the
"for" version looks cleaner; I will change it to that the next set.
 
> But all of the above matters if it is a good idea to batch.  Does it
> make a difference?
> 
>     ... goes and looks at in_merge_bases_many() ...
> 
> Ah, it probably would.  
> 
> I thought in_merge_bases_many() would stop early as soon as any of
> the traversal from chunk[] reaches commit, but it uses a rather more
> generic paint_down_to_common() so extra items in chunk[] that are
> topologically older than commit would result in additional traversal
> from commit down to them, which would not contribute much to the end
> result.  It may be a good #leftovebit idea for future improvement to
> teach in_merge_bases_many() to use a custom replacement for
> paint_down_to_common() that stops early as soon as we find the
> answer is true.

If we consider the amount of time it takes when "in_merge_bases_many()"
has to be run for all the entries, there isn't much of a difference in
performance between batching and non-batching -- they took about the
same. But, as you said if the remote is reachable in the first few
entries, batching would help with returning early if a descendant is
found.

Making the function stop early when a descendent is found
does sound like a good #leftoverbits idea. :)

Thanks again, for a detailed review.
-- 
Srinidhi Kaushik
