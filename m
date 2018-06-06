Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7224B1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeFFUrZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:25 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35928 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeFFUrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:23 -0400
Received: by mail-pf0-f171.google.com with SMTP id a12-v6so3717219pfi.3
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWNmHfb8I5l/1zFqA1OJWEZHOFl7vQEeBshIhBMadPM=;
        b=PcnyhPVe8vpsrI+yko+pjfMSqZYOvlHII9WBkmOG+TyP7Im3Bd4GlGxH12z/L73S4y
         a0k2bP1o34JImTW+jrwuqbC1wtHEW/hzOsuIw76O0Y4GHRXBJxBUV5zbnoQ6+OHoV8wO
         X+I4dXT96Uy4MuKIvArOAp2Bo2/rnA1e7A8NX93huupQ3fa1ZEOc4ihCYYS0pE77Vr0L
         unevS4VQbsTQFCuJXgahpO+Fh31sFjNI3jAi0z6GF8EK6YSsJPyCnfU2/4J04ZAO1pUg
         axwykQ0ujfCE7MNUW3ZGJOJ1h3Um5c2C6BoPs7aXLRPTBEjE7LsvFiYccVu2drgXL7j9
         hbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWNmHfb8I5l/1zFqA1OJWEZHOFl7vQEeBshIhBMadPM=;
        b=FheyPDiHgBxeh1EBcxtnHzHosv3duK7NJIImgJ+/QVISr/y5PzOrAaShXcNV5iiqk5
         UPb/7lG/7qeJtXK+iISrHQOVNPOWm+yPmLydvirp9q7PDJoVqDtFJlBdcRcG9g+9B4l3
         QsNIvpeOsEGgvUVKWsk/+7TMy0qYXQaNrzwSndoUseSqzxagg9ro1h3PEKpCdcIiO7YU
         Rsnnvoc7RnVIPQtyvwWVYd0r69zC10NUZVJEOSR8rM+Mdw/c2gexXrUlmuNp8BFTmQV2
         AgW22j9TI/F8XyB3d0YFu6VHMV9appbvPf1sDqidtVNsfdf7/zpeTqzJrUYbEgVXgwZT
         I6Aw==
X-Gm-Message-State: APt69E2xH14Ow4uBPk0TwKPBchvUPwmClnOUPOt2pBqX5IOrFTuokclU
        jm4Lt5WDz13bATPi4B17wiU6TLGZE+4=
X-Google-Smtp-Source: ADUXVKJuJX+9cJowDHTNIqnvFWZF+/99+GJSNH5OEfZMA8cp3/MtPQ1tJBXI0G5oMyckhvS4r0ppXQ==
X-Received: by 2002:a65:50cb:: with SMTP id s11-v6mr1779089pgp.384.1528318040276;
        Wed, 06 Jun 2018 13:47:20 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 0/8] Refactor fetch negotiation into its own API
Date:   Wed,  6 Jun 2018 13:47:06 -0700
Message-Id: <cover.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Jonathan Nieder, for your comments.

This patch set now includes a patch at the beginning to split up
everything_local(), making it clear which functions have side effects
and which don't, and a patch at the end to reformat some comments.

While I was implementing the suggestions, there were some that I were
unsure about. Here they are:

> > nit: this adds the new test as last in the script.  Is there some
> > logical earlier place in the file it can go instead?  That way, the
> > file stays organized and concurrent patches that modify the same test
> > script are less likely to conflict.
> 
> Good point. I'll find a place.

I couldn't find a logical place (I didn't see any existing tests that
test negotiation). I did move it up a bit earlier in the file, before
filtering by blob size, because that seemed more distinct from the rest
of the tests.

> >> -static struct prio_queue rev_list = { compare_commits_by_commit_date };
> >> -static int non_common_revs, multi_ack, use_sideband;
> >> +struct data {
> >> +     struct prio_queue rev_list;
> >> +     int non_common_revs;
> >> +};
> >
> > How does this struct get used?  What does it represent?  A comment
> > might help.
> 
> I'll add a comment.

I thought of adding a comment, but felt that I would end up removing it
anyway upon its move to negotiator/default.c, so I didn't end up adding
it.

> >> +/*
> >> +   This function marks a rev and its ancestors as common.
> >> +   In some cases, it is desirable to mark only the ancestors (for example
> >> +   when only the server does not yet know that they are common).
> >> +*/
> >
> > Not about this change: comments should have ' *' at the start of each
> > line (could do in a preparatory patch or a followup).
> 
> I'll add a followup.

I'm now not sure of the value of making a change just to update
formatting, but I added the followup commit anyway - it can be easily
dropped if we decide to do so.

Jonathan Tan (8):
  fetch-pack: split up everything_local()
  fetch-pack: clear marks before re-marking
  fetch-pack: directly end negotiation if ACK ready
  fetch-pack: use ref adv. to prune "have" sent
  fetch-pack: make negotiation-related vars local
  fetch-pack: move common check and marking together
  fetch-pack: introduce negotiator API
  negotiator/default: use better style in comments

 Makefile              |   2 +
 fetch-negotiator.c    |   8 ++
 fetch-negotiator.h    |  57 ++++++++++
 fetch-pack.c          | 254 ++++++++++++++----------------------------
 negotiator/default.c  | 174 +++++++++++++++++++++++++++++
 negotiator/default.h  |   8 ++
 object.h              |   3 +-
 t/t5500-fetch-pack.sh |  39 +++++++
 8 files changed, 376 insertions(+), 169 deletions(-)
 create mode 100644 fetch-negotiator.c
 create mode 100644 fetch-negotiator.h
 create mode 100644 negotiator/default.c
 create mode 100644 negotiator/default.h

-- 
2.17.0.768.g1526ddbba1.dirty

