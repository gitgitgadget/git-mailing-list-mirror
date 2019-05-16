Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3ED1F461
	for <e@80x24.org>; Thu, 16 May 2019 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfEPS0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:26:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40327 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPS0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 14:26:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id e69so2649916pgc.7
        for <git@vger.kernel.org>; Thu, 16 May 2019 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DURh3s/Z0IJh5QaJ/hKGkT0nzdtj9GEy4E6MJvK3qSw=;
        b=FSft3VqQB7YgS+3LNQR3RHJiulyrthhyDVoKMlh+WildnaLGzKLu5D6AUGqoRrZBc7
         InajFqiUDFG/kg5mvqz6tf6/IAuuFHaMozsHoukj4rhtjmlnF7RyuryJ+9vIFQ4Jb6hj
         l5Nusse80BJqh7RQqZh2xq62tUzXQDpJHmDuf/m/Sz14Fdds5hnxRf24vlA4p3q9hrPe
         gI3tllDuKd5OekX6X6CVhYhF3PHF3djjhLqkUv8BQr2A5uUSSGLyEMKY9bT0NSvrVRTM
         FknU34ZWVi/YcrtHVK1iYzTcTeDhJYnIZ81GoPhVrjXFVfvYsyb9ZEwuZA/lZ845A2qj
         M+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DURh3s/Z0IJh5QaJ/hKGkT0nzdtj9GEy4E6MJvK3qSw=;
        b=rA+boL67jT0HA028FU6FYWg2diwTf1LF0eveKVoyQJosX/pN2IoeSHEF7fBBUkewho
         3idObDiBDTcdeoBc7zRP9Sa0yqkuw3RJAII4P6lO47S48Uql8FYnEZ0EJnV6Ij2Nsm0C
         z9ECAe4jM1pLMXRioFGHwGSfIcrthVmSkH6p3g7cFYFm5Bkdo1PbSXvcsH50cSjWqwkL
         +4yGUupK6W00Hut5i3AxO4yAl9Agy6+F0oLzKE3tawWwE2QoV2HYVqU1EyZdx/V9pjA7
         sqIliMQUCyD0278vp8qXSpo/aouiVwKauRP6nEIHUoOJwb0jAJFwuTdAUQHlCrv/WUnW
         tSMg==
X-Gm-Message-State: APjAAAXQ1yuCf03R++cqSpMc/PIMjIjVVeQpnytCWqzdPURMhXYnjL12
        hVxDxtW73jAyJxDrQEo/v0tWfOr1AehOQU9ceXqI
X-Google-Smtp-Source: APXvYqxNUBBu0we1mVcW6vcT0oJJCCnJfYrp+npC/zGjNIXPEzAWX6gH/vp/cD62vmRb8MzDcrElGpd79DxtG4yD4H8i
X-Received: by 2002:a63:1055:: with SMTP id 21mr51108107pgq.200.1558031209711;
 Thu, 16 May 2019 11:26:49 -0700 (PDT)
Date:   Thu, 16 May 2019 11:26:46 -0700
In-Reply-To: <20190515231617.GA1395@sigill.intra.peff.net>
Message-Id: <20190516182646.173332-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190515231617.GA1395@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, May 14, 2019 at 02:10:55PM -0700, Jonathan Tan wrote:
> 
> > Support for lazy fetching should still generally be turned off in
> > index-pack because it is used as part of the lazy fetching process
> > itself (if not, infinite loops may occur), but we do need to fetch the
> > REF_DELTA bases. (When fetching REF_DELTA bases, it is unlikely that
> > those are REF_DELTA themselves, because we do not send "have" when
> > making such fetches.)
> 
> I agree that the current implementation (and probably any sane
> implementation) would not send us a delta if we have not provided any
> haves. But this does mean that a malicious server could send a client
> into an infinite loop.
> 
> Pretty unlikely, but should we put some kind of circuit-breaker into the
> client to ensure this?

I thought of this - such a server could, but it seems to me that it
would be similar to a server streaming random bytes to us without
stopping (which is already possible).

> > To resolve this, prefetch all missing REF_DELTA bases before attempting
> > to resolve them. This both ensures that all bases are attempted to be
> > fetched, and ensures that we make only one request per index-pack
> > invocation, and not one request per missing object.
> 
> Ah, but now things get more tricky.
> 
> You are assuming that the server does not ever send a REF_DELTA unless
> the base object is not present in the pack (it would use OFS_DELTA
> instead). If we imagine a server which did, then there are two
> implications:
> 
>   1. We might pre-fetch a full copy of an object that we don't need.
>      It's just that it's stored as a delta in the pack which we are
>      currently indexing.
> 
>   2. If we pre-fetch multiple objects, some of them may be REF_DELTAs
>      against each other, leading to an infinite loop.
> 
> Off the top of my head, I am pretty sure your assumption holds for all
> versions of Git that support delta-base-offset[1]. But that feels a lot
> less certain to me. I could imagine an alternate server implementation,
> for example, that is gluing together packs and does not try hard to
> order the base before the delta, which would require it to use REF_DELTA
> instead of OFS_DELTA.

A cursory glance makes me think that REF_DELTA against a base object
also in the pack is already correctly handled. Right before the
invocation of conclude_pack() (which calls fix_unresolved_deltas(), the
function I modified), resolve_deltas() is invoked. The latter invokes
resolve_base() (directly or through threaded_second_pass()) which
invokes find_unresolved_deltas(), which invokes
find_unresolved_deltas_1(), which seems to handle both REF_DELTA and
OFS_DELTA.

Snipping the rest as I don't think we need to solve those if we can
handle REF_DELTA being against an object in a pack, but let me know if
you think that some of the points there still need to be addressed.
