Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACD62047F
	for <e@80x24.org>; Wed,  2 Aug 2017 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdHBATw (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 20:19:52 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35818 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdHBATv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 20:19:51 -0400
Received: by mail-pg0-f44.google.com with SMTP id v189so14171081pgd.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKL851Qqj+GFwoo5vGmo7FlsswDpgK+m5E1WS4W8yck=;
        b=uNXf7G6x7vvL5kgEemDggdGEdJQCRSjhucQQQK1qNwMKSMEFYbFk2uc7Kq7rGQlc3j
         d2ZJsO35raTLG8l4RIa072eyRgutgZ9RpXB07dzfpVb/RfBIJbThT6kcWIjtzJorXjdb
         4CPIBIuFC8lCNqNgyC+/MEnv8UrzJ9+PDMKZJF32yvO/c9qGQt5YrQsBp4cj+1CqpZ3I
         t5VB961Zkv3rie52mz/Isj94gEuu5IczhtvwWTFNVYnSgBTcaERDDeu0CK+IaAOg3HaD
         MZa1Qf7Urq8KhSb//6NSg8p7qVeWfxpFRTMafGZt4kp1Om5MHgx9xlg7oWyAMAcYC/Tz
         HrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKL851Qqj+GFwoo5vGmo7FlsswDpgK+m5E1WS4W8yck=;
        b=eFFuvJdES9aCBRa37KkZpkYCd1hvVIEn34mzcZcSU85hhhBGQGns01Abzhz+W3Pkiu
         NWy0DC0UKGpQHc4SatbEaGy3h3FxuXmeL3EgNp43FQUfojKJiHjMN1qVB4DZEvRDYFgN
         JJMp9L5XYMRozb45z7S2KIXl/NKfwFUnr2nmPwKJdrIdvVTTIG5WE5dWRrAFWi5McsJw
         p9Y0iVXNcQO+f1aO2etQ7MXvGc9q2cDHwbKgRMiWanDap1EBjMb0vqvXOaEg/6Zq6mUJ
         wIoUN0Qm8M7tdf+VMY3m99kAcWZWPZd3JD7lkJNkFB03hePmG51pyBlsbbFC20HCexHz
         +x1g==
X-Gm-Message-State: AIVw110bJc3dIbbEjt5bFCKNVgiiwbw2AKN20LJGTC+RhnDz4e4Q/2FV
        FNLEMuLRBR6gK+GD
X-Received: by 10.98.38.68 with SMTP id m65mr20644055pfm.47.1501633190725;
        Tue, 01 Aug 2017 17:19:50 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:89e8:42fb:7e1e:307a])
        by smtp.gmail.com with ESMTPSA id n129sm50005789pfn.27.2017.08.01.17.19.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2017 17:19:50 -0700 (PDT)
Date:   Tue, 1 Aug 2017 17:19:44 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual
 invocation of loader
Message-ID: <20170801171944.7690a63f@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
        <20170731160533.0a446244@twelve2.svl.corp.google.com>
        <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 01 Aug 2017 10:11:38 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Let's step back a bit and think what already happens in the pre-
> lazy-object world.  We record cut-off commits when a depth limited
> clone is created in "shallow".  These essentially are promises,
> saying something like:
> 
>     Rest assured that everything in the history behind these commits
>     are on the other side and you can retrieve them by unshallowing.
> 
>     If you traverse from your local tips and find no missing objects
>     before reaching one of these commits, then you do not have any
>     local corruption you need to worry about.
> 
> the other end made to us, when the shallow clone was made.  And we
> take this promise and build more commits on top, and then we adjust
> these cut-off commits incrementally as we deepen our clone or make
> it even shallower.  For this assurance to work, we of course need to
> assume a bit more than what we assume for a complete clone, namely,
> the "other side" will hold onto the history behind these, i.e. does
> not remind the tips it already has shown to us, or even if it does,
> the objects that are reachable from these cut-off points will
> somehow always be available to us on demand.
> 
> Can we do something similar, i.e. maintain minimum set of cut-off
> points and adjust that set incrementally, just sufficient to ensure
> the integrity of objects locally created and not yet safely stored
> away by pushing them the "other side"?

This suggestion (the "frontier" of what we have) does seem to incur less
overhead than the original promise suggestion (the "frontier" of what we
don't have), but after some in-office discussion, I'm convinced that it
might not be the case - for example, one tree (that we have) might
reference many blobs (that we don't have), but at the same time, many
trees (that we have) might have the same blob (that we don't have). And
the promise overhead was already decided to be too much - which is why
we moved away from it.

One possibility to conceptually have the same thing without the overhead
of the list is to put the obtained-from-elsewhere objects into its own
alternate object store, so that we can distinguish the two. I mentioned
this in my e-mail but rejected it, but after some more thought, this
might be sufficient - we might still need to iterate through every
object to know exactly what we can assume the remote to have, but the
"frontier" solution also needs this iteration, so we are no worse off.

Going back to the original use cases that motivated this (the monorepo
like Microsoft's repo and the large-blob repo like Android's repo), it
might be better just to disable the connectivity check when
extensions.lazyObject is set (as you mentioned). This does change the
meaning of fsck, but it may be fine since the "meaning" of the repo (a
view of another repo, and no longer a full repo) has changed too. Then
this patch set will be more about ensuring that the lazy object loader
is not inadvertently run. As future work, we could add diagnostics that,
for example, attempt a walk anyway and print a list of missing SHA-1s.

(I suspect that we will also need to disable the connectivity check for
things like "git fetch", which means that we won't be able to tell
locally if the server sent us all the objects that we requested for.
This might not be a problem, though, since the local repo already has
some measure of trust for the server.)
