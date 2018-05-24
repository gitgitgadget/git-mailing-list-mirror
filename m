Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CB81F42D
	for <e@80x24.org>; Thu, 24 May 2018 04:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEXEbG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 00:31:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39409 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeEXEbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 00:31:05 -0400
Received: by mail-wr0-f193.google.com with SMTP id w18-v6so462109wrn.6
        for <git@vger.kernel.org>; Wed, 23 May 2018 21:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NBjTGA+xSCy61jsgU97KwAz0nOmFWwfonAE6evoQ1Fo=;
        b=tLuAY+Vb0bzzYQE4PHvqz1Fx3tRLeTbaDmTHRBDBOEv88EVUr7o+pkoNqnfYs26hf0
         9VSoUVTGk8N7mLHXfpRSeNKCzLanC5mjoi8/KCrm+TGnzg7EhBny00nHKQcSf88Y0VTi
         rm5S0TbWYeSg1GUh6doL4GwkLC6ING3s9a50vHP3M0arr9WD5qDh1h7jL2uQxM2qfmWX
         VMnvd/t6ZFTPTcHSKLQK4CYmRkAlbq2noVOJFm7cvqj2INib1ovpsut7Q/VYyl+KQkrm
         n+zKS9g2/yk8cYNHEvXrlZE047LmRnIFl/iUrzYGNyt0GVGIIhdmY/K5uknW9PA0eQDN
         lfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NBjTGA+xSCy61jsgU97KwAz0nOmFWwfonAE6evoQ1Fo=;
        b=IcJePcpad/jhJZgLjQuwdFLT5kSU6GGCU2D0qDfkAwu5rNsd/cu/LqOEs+43ES+ojN
         IstdsQPX+vIbpoH+EEaLEWHXIvVXE3Px5Kj3tbyUOjLoBU7vAJadKChHP9Blm1yqO84y
         UbzegY9gCRSrVIpaXosHm4edarptg+5ExETWtz9NPUWHxjN8fWebrceSzEYQUiqhNoKe
         inPDw2F6mCRwrr6kKI3GFdObsSnwBFKUtOGlnH3y0iURlIUwrkNijsZYpisUjVVbW0uJ
         tuAxYHZ/FQd5Q8GUiTu9iLbZTXwbIhlEujNUSsjZZt3RnTO2y8tjXpOcAX8nrJczf9vo
         BqaQ==
X-Gm-Message-State: ALKqPwdmFiVPM4tKGkNVNviwOMSY2/urhvfMv3Zx0rFFOW9FKyayzqaU
        Ant5dVMklmTVhmOlRKk9d4I=
X-Google-Smtp-Source: AB8JxZppnhgPpKyGdFrFRsgYi47cELqrN8HCxaToDIn643Tf0MVQZfsZn0JQh84korKkmv/Hrf76Jw==
X-Received: by 2002:adf:f6c1:: with SMTP id y1-v6mr4597804wrp.197.1527136263606;
        Wed, 23 May 2018 21:31:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g105-v6sm32254584wrd.45.2018.05.23.21.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 21:31:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v3 1/2] Implement --first-parent for git rev-list --bisect
References: <20180523120028.36427-1-tiagonbotelho@hotmail.com>
Date:   Thu, 24 May 2018 13:31:01 +0900
In-Reply-To: <20180523120028.36427-1-tiagonbotelho@hotmail.com> (Tiago
        Botelho's message of "Wed, 23 May 2018 13:00:28 +0100")
Message-ID: <xmqqtvqxsmii.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> -static int count_interesting_parents(struct commit *commit)
> +static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
>  {
>  	struct commit_list *p;
>  	int count;
>  
>  	for (count = 0, p = commit->parents; p; p = p->next) {
> -		if (p->item->object.flags & UNINTERESTING)
> -			continue;
> -		count++;
> +		if (!(p->item->object.flags & UNINTERESTING))
> +		    count++;
> +		if (bisect_flags & BISECT_FIRST_PARENT)
> +			break;
>  	}
>  	return count;
>  }

Since this change makes the function never return anything more than 1,...

> @@ -310,7 +315,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			continue;
>  		if (weight(p) != -2)
>  			continue;
> -		weight_set(p, count_distance(p));
> +		weight_set(p, count_distance(p, bisect_flags));
>  		clear_distance(list);

... this code will not be reached when in the first-parent mode,
where we count the weight for merge commits the hard way.

Am I reading the code correctly?  Not pointing out a problem; just
double checking how the code works.

> @@ -329,9 +334,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			if (0 <= weight(p))
>  				continue;
>  			for (q = p->item->parents; q; q = q->next) {
> -				if (q->item->object.flags & UNINTERESTING)
> -					continue;
> -				if (0 <= weight(q))
> +				if (!(q->item->object.flags & UNINTERESTING))
> +					if (0 <= weight(q))
> +						break;
> +				if (bisect_flags & BISECT_FIRST_PARENT)
>  					break;
>  			}
>  			if (!q)
>  				continue;

This loop propagates the known weight of an ancestor through a
single strand of pearls.

When this loop is entered, any commit that has non-negative weight
has only one parent of interest, as we counted weight for all merges
the hard way and also weight for root and boundary commits, in the
previous loop.  The original goes through p's parents and see if an
interesting parent has non-negative weight (i.e. weight is known for
that parent), at which point break out of the loop, with q that is
non-NULL.  Immediately after the loop, q != NULL means we can now
compute weight for p based on q's weight.

I think this patch breaks the logic.  When we are looking at a
commit 'p' whose weight is not known yet, we grab its first parent
in 'q'.  Imagine that it is not an UNINTERESTING commit (i.e. a
commit whose weight matters when deciding the bisection) whose
weight is not yet known.  With the updated code under the
first-parent mode, we break out of the loop, 'q' pointing at the
commit whose weight is not yet known.  The computation done by the
code that immediately follows the above part is now broken, as it
will call weight(q) to get -1 and propagate it to p (or add 1 and
set 0 to p), no?

Perhaps something along this line may be closer to what we want:

	if (0 <= weight(p))
		continue; /* already known */
	for (q = p->item->parents; q; q = q->next) {
        	if ((bisect_flags & BISECT_FIRST_PARENT)) {
			if (weight(q) < 0)
				q = NULL;
			break;
		}
		if (q->item->object.flags & UNINTERESTING)
			continue;
		if (0 <= weight(q))
			break;
	}
	if (!q)
		continue; /* parent's weight not yet usable */

That is, under the first-parent mode, we would pay attention only to
the first parent of 'p' and break out of this loop without even
looking at q->next.  If the weight of that parent is not known yet,
we mark that fact by clearing q to NULL and break out of the loop.
If the weight is known, we do not clear q, so we compute weight of p
based on weight(q).

I am not offhand certain what should happen when p's first parent is
uninteresting.  The updated count_interesting_parents() would have
returned 0 for p in such a case, so at this point of the code where
p's weight is unknown, its first parent can never be UNINTERESTING,
I would think.
