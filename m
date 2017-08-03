Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD58D1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdHCTI5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 15:08:57 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38788 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbdHCTIz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 15:08:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id l64so9673084pge.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ydeN1yjSOxfINHrLc67oldP7PfxhQmRWjjzsFkZbVc=;
        b=TCETgm2LgCkShtMmGaWUc8AuaeaPExb1txpgrspVxICiU0CV2aylmFE3pr7cUI6pYk
         Q4/qRqVpJiILywwDabidWgnYdfh6R8USB46w+ybgB/xxkre8sulVYAqaELaIYBKGBaf9
         fEYhMnbtF0opKrSmAl60oxvs+Vu10AEcTV+HTbP/0waJbsjgA9M3wgYzO5UdUU9kbTcl
         eBUZnG4c1IzsQh1GfepW4z/2ttFskw4FCizWj66NJk7l+q42wiLxFy41Di9eQ4tNQjXN
         nezxdPTBGbUGWR9ZWjYvUvYXCPDzIbwecXpDR5O7ujzxQq88o72qcoBh9BUiHmwC22/H
         P7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ydeN1yjSOxfINHrLc67oldP7PfxhQmRWjjzsFkZbVc=;
        b=cLCl6arDKWRDsWiT4JmyHKVm/puXwrPa0dPGjG7ZN7OK9AU4DWcqcsmcmDRqRSNbTA
         FuCLMPPs4SH7MbYNExsNNsJee2TxwiSRgwQMvDGKY0BL/h9H8FD2l2yv0pbVpw0vv/Ii
         WT7vnihes3gQQrngUZB5E+THp9onxun8inJjwB6FCv+DG1sRZ3KnUk97BfXiG4zrAZRi
         NghM4uEfd7DsvOfpX0tv2CLid/wGCQdCdv3a6JnawLhL97qic0TQo64Z4p1DzOq4+1IY
         gMiLvv71Nzu93juWZMOZdk2hjVr8Dgt/iP/0rnpl1yRBIfYNEPbu2Fyg7nnYql6KUWgV
         2iFw==
X-Gm-Message-State: AIVw113vnxi8tA1HO0eQGoDZcP9VFgJRUUVg/MxCr+DUyRQwhlvVeumA
        7yL8Mt33n6v3JVtb
X-Received: by 10.98.153.72 with SMTP id d69mr2634183pfe.42.1501787334312;
        Thu, 03 Aug 2017 12:08:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:54d8:d3fd:b9f1:6dda])
        by smtp.gmail.com with ESMTPSA id r86sm32982593pfi.138.2017.08.03.12.08.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 12:08:53 -0700 (PDT)
Date:   Thu, 3 Aug 2017 12:08:49 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual
 invocation of loader
Message-ID: <20170803120849.5f7382d3@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq8tj1snfq.fsf@gitster.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
        <20170731160533.0a446244@twelve2.svl.corp.google.com>
        <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
        <20170801171944.7690a63f@twelve2.svl.corp.google.com>
        <xmqqefsudjqk.fsf@gitster.mtv.corp.google.com>
        <20170802173857.GU13924@aiede.mtv.corp.google.com>
        <xmqq8tj1snfq.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 02 Aug 2017 13:51:37 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> > The complication is in the "git gc" operation for the case (*).
> > Today, "git gc" uses a reachability walk to decide which objects to
> > remove --- an object referenced by no other object is fair game to
> > remove.  With (*), there is another kind of object that must not be
> > removed: if an object that I made, M, points to a missing/promised
> > object, O, pointed to by a an object I fetched, F, then I cannot prune
> > F unless there is another fetched object present to anchor O.
> 
> Absolutely.  Lazy-objects support comes with certain cost and this
> is one of them.  
> 
> But I do not think it is realistic to expect that you can prune
> anything you fetched from the "other place" (i.e. the source
> 'lazy-objects' hook reads from).  After all, once they give out
> objects to their clients (like us in this case), they cannot prune
> it, if we take the "implicit promise" approach to avoid the cost to
> transmit and maintain a separate "object list".

By this, do you mean that the client cannot prune anything lazily loaded
from the server? If yes, I understand that the server cannot prune
anything (for the reasons that you describe), but I don't see how that
applies to the client.

> > For example: suppose I have a sparse checkout and run
> >
> > 	git fetch origin refs/pulls/x
> > 	git checkout -b topic FETCH_HEAD
> > 	echo "Some great modification" >> README
> > 	git add README
> > 	git commit --amend
> >
> > When I run "git gc", there is nothing pointing to the commit that was
> > pointed to by the remote ref refs/pulls/x, so it can be pruned.  I
> > would naively also expect that the tree pointed to by that commit
> > could be pruned.  But pruning it means pruning the promise that made
> > it permissible to lack various blobs that my topic branch refers to
> > that are outside the sparse checkout area.  So "git gc" must notice
> > that it is not safe to prune that tree.
> >
> > This feels hacky.  I prefer the promised object list over this
> > approach.
> 
> I think they are moral equivalents implemented differently with
> different assumptions.  The example we are discussing makes an extra
> assumption: In order to reduce the cost of transferring and
> maintaining the list, we assume that all objects that came during
> that transfer are implicitly "promised", i.e. everything behind each
> of these objects will later be available on demand.  How these
> objects are marked is up to the exact mechanism (my preference is to
> mark the resulting packfile as special; Jon Tan's message to which
> my message was a resopnse alluded to using an alternate object
> store).  If you choose to maintain a separate "object list" and have
> the "other side" explicitly give it, perhaps you can lift that
> assumption and replace it with some other assumption that assumes
> less.

Marking might be an issue if we expect the lazy loader to emit an object
after every hash, like in the current design. There would thus be one
mark per object, with overhead similar to the promise list. (Having said
that, batching is possible - I plan to optimize common cases like
checkout, and have such a patch online for an older "promised blob"
design [1].)

Overhead could be reduced by embedding the mark in both the packed and
loose objects, requiring a different format (instead of having a
separate "catalog" of marked files). This seems more complicated than
using an alternate object store, hence my suggestion.

[1] https://github.com/jonathantanmy/git/commit/14f07d3f06bc3a1a2c9bca85adc8c42b230b9143
