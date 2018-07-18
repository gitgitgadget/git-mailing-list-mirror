Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FE21F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeGRXgg (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:36:36 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36348 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeGRXgg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:36:36 -0400
Received: by mail-wr1-f45.google.com with SMTP id h9-v6so6196038wro.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=haMbcMKkxnTdNr6YV+pDvdHb8i+DYtVXJIIgBY4RJTI=;
        b=A02lLvVN3Uy9/PESdI4HcMQfb4xPGxbAu6ZgwE6OmKwgKhX2wHeEIUqIF4M5VNy1Nn
         lCRioWoRmwu3Ov/8BCnjMw9mjHSDd62VzBV5gta6hZt/cIMJCNmFGE4WD0G0aEDF15Ym
         4YauobtV/KckI2794zDi2n5hFZlJPjWszz36Z2izouZ9Ujnq2hrckc0jU/9ufQ4yi1Nd
         M1wRcug1pbXyHGyiSBjglKe8kxI/e21NRXPDLPcN+rCVBA1tdntXzDh4jBzqUFacSj8q
         G5TsmVRhT7nI2v1xO6fE+AdtSlZaOyOAmVNOd7ePdOTo65kOtDaYwtQSfRUFPoDtzhnM
         mYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=haMbcMKkxnTdNr6YV+pDvdHb8i+DYtVXJIIgBY4RJTI=;
        b=Tsyb6S5qzvFJ8McltEhsbizM+Rr7NauyD6zvVUAxDLLR9x+2w9PXJd1egm1VzCww6g
         UFiiHEKmjWijdaRYhB1s7+gv8xad4UQuQzg+PEq7Gx9qilbypuLxx99TkGNIzVdo7Z8t
         DBxbbpHfCYXG9zJLI0eYJ78/Ss0euIKKwLNo3mkm+upx3/E5B4cPGplBOVQYH3k1oQaK
         JsZyuo/V0oSUC5OIwjU904vszigMKCeDru6QULb7saUyLU1sTXy63VgK3TFT9HatFMHi
         +98vsZXnkXxkGyk2+IdinlfJF81sMnllMRiMT3E3x3v2/crufDZDYT1SXyewp6AbME6I
         3KcQ==
X-Gm-Message-State: AOUpUlEB2szOo02dJkbYsnHLkDMd5LFMpZLOZ7IFPfr8vuJ5jYt8kV1p
        gx6+JRDnNV9EQnW6yeX4NBg1O5I1
X-Google-Smtp-Source: AAOMgpe5i44wEmwBm3QzcONTWL+09Jd3+vbLiQLZvzvrsCxRHOi+Gxv9l1eRpAzun7+oUjiz9JbjOw==
X-Received: by 2002:adf:8b01:: with SMTP id n1-v6mr5898716wra.282.1531954588837;
        Wed, 18 Jul 2018 15:56:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y102-v6sm6026677wmh.9.2018.07.18.15.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:56:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] Add initial parallel version of unpack_trees()
References: <20180718204458.20936-1-benpeart@microsoft.com>
        <20180718204458.20936-4-benpeart@microsoft.com>
Date:   Wed, 18 Jul 2018 15:56:27 -0700
In-Reply-To: <20180718204458.20936-4-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 18 Jul 2018 20:45:17 +0000")
Message-ID: <xmqqbmb4i25g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> +	 * Fetch the tree from the ODB for each peer directory in the
> +	 * n commits.
> +	 *
> +	 * For 2- and 3-way traversals, we try to avoid hitting the
> +	 * ODB twice for the same OID.  This should yield a nice speed
> +	 * up in checkouts and merges when the commits are similar.
> +	 *
> +	 * We don't bother doing the full O(n^2) search for larger n,
> +	 * because wider traversals don't happen that often and we
> +	 * avoid the search setup.

It is sensible to optimize for common cases while leaving out the
complexity that is only needed to support rare cases.

> +	 * When 2 peer OIDs are the same, we just copy the tree
> +	 * descriptor data.  This implicitly borrows the buffer
> +	 * data from the earlier cell.

cell meaning...?


> +	for (i = 0; i < n; i++, dirmask >>= 1) {
> +		if (i > 0 && are_same_oid(&names[i], &names[i - 1]))
> +			newinfo->t[i] = newinfo->t[i - 1];
> +		else if (i > 1 && are_same_oid(&names[i], &names[i - 2]))
> +			newinfo->t[i] = newinfo->t[i - 2];
> +		else {
> +			const struct object_id *oid = NULL;
> +			if (dirmask & 1)
> +				oid = names[i].oid;
> +
> +			/*
> +			 * fill_tree_descriptor() will load the tree from the
> +			 * ODB. Accessing the ODB is not thread safe so
> +			 * serialize access using the odb_mutex.
> +			 */
> +			pthread_mutex_lock(&o->odb_mutex);
> +			newinfo->buf[newinfo->nr_buf++] =
> +				fill_tree_descriptor(newinfo->t + i, oid);
> +			pthread_mutex_unlock(&o->odb_mutex);
> +		}
> +	}
> +
> +	/*
> +	 * We can't play games with the cache bottom as we are processing
> +	 * the tree objects in parallel.
> +	 * newinfo->bottom = switch_cache_bottom(&newinfo->info);
> +	 */

Would the resulting code match corresponding entries from two/three
trees correctly with a tree with entries "foo." (blob), "foo/" (has
subtree), and "foo0" (blob) at the same time, without adjusting the
bottom?  I am worried because cache_bottom stuff is not about
optimization but is about correctness.

> +	/* All I really need here is fetch_and_add() */
> +	pthread_mutex_lock(&o->work_mutex);
> +	o->remaining_work++;
> +	pthread_mutex_unlock(&o->work_mutex);
> +	mpmcq_push(&o->queue, &newinfo->entry);

Nice.  I like the general idea.

