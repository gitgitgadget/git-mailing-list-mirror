Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6A020C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdFLTxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 15:53:01 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33406 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdFLTxA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 15:53:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id f185so49366659pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaG9bCSGaH8VH+KfAya1YL6QCpxSITQu/LNSkBob+cA=;
        b=BXMUZFv6fWHI6gP+F0Qr/zQs72/Y5L+5O0SNGfOynq+RcRDqiIT1HpKv53QeZ2+vwS
         8KOjUR6iknv7py8UrBCQrKSA/3YBcRKinZY3prd5UuJFJI4ou5P+5Q0PgBwg8ZIa2OX5
         gjUovPCKr1EfSpCK9MvG0gMcblZFSpZq7h2OeEQ0E55jUNJ92LbzuWRtA7Aucuo0lUsS
         hILhWGNPO4YcyW71m1zsO15zkKh8zlOaQOI2FHhSKjLRdzuo4NRP4G1gnGwhUkE+Lq/v
         PBY74H3oFu5nUgGG24DZXzH47NeHwmel1oEXEwtlVVBGkjdzdXmVVD7RZXMds9R1uvop
         in6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaG9bCSGaH8VH+KfAya1YL6QCpxSITQu/LNSkBob+cA=;
        b=cT5Ch4h0uCvP4IiTrD78oCM1cWuQy97XCbuqHNPdacWXL3JKoOrddEE4FR41egy/Yz
         b24c0ZBw+DZwI7Vegy1c9f00vbY6opkYATGQDkmVvHlQz4hNfj0y/ncrc/t8h5Msik/G
         ve7cMeTa7v13Y/o2drGVksGUu1iwLyaeXXtfspjVo+MMruvkX0fA5kbmyZHIece/htZG
         RAkh+GiQRCOSoKqPiwer2j2YuLTfq/mJBDTpAGvvxGnMbNe8qcQ2aMVyxUKzzNMsrRyo
         KzWDz9VZ2lFq+omWDpQYIW57ZqfERQX+hFpunxnHht14d+EPc7M0bmo4mNVe2lGYc/xp
         oy+w==
X-Gm-Message-State: AODbwcCOSU96NSRRcjiLr2Uv49CGmz/jPVRj5a8G0g+sNQ97grwRXhS1
        HvhWkLb21QJ+u1if6q0+vQ==
X-Received: by 10.98.220.193 with SMTP id c62mr52984279pfl.140.1497297179342;
        Mon, 12 Jun 2017 12:52:59 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a1c6:b49e:dc41:58c])
        by smtp.gmail.com with ESMTPSA id q76sm20214579pfg.117.2017.06.12.12.52.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 12:52:59 -0700 (PDT)
Date:   Mon, 12 Jun 2017 12:52:54 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] sha1_file: extract type and size from
 object_info
Message-ID: <20170612125254.33ba633a@twelve2.svl.corp.google.com>
In-Reply-To: <20170610070133.boicdvkudifz7b4c@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
        <b090fef9ff8593a6d77c3d3363b4af7e73ac12dc.1497035376.git.jonathantanmy@google.com>
        <20170610070133.boicdvkudifz7b4c@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 10 Jun 2017 03:01:33 -0400
Jeff King <peff@peff.net> wrote:

> On Fri, Jun 09, 2017 at 12:23:24PM -0700, Jonathan Tan wrote:
> 
> > Looking at the 3 primary functions (sha1_object_info_extended,
> > read_object, has_sha1_file_with_flags), they independently implement
> > mechanisms such as object replacement, retrying the packed store after
> > failing to find the object in the packed store then the loose store, and
> > being able to mark a packed object as bad and then retrying the whole
> > process. Consolidating these mechanisms would be a great help to
> > maintainability.
> > 
> > Such a consolidated function would need to handle the read_object() case
> > (which returns the object data, type, and size) and the
> > sha1_object_info_extended() case (which returns the object type, size,
> > and some additional information, not all of which can be "turned off" by
> > passing NULL in "struct object_info").
> 
> I like the idea of consolidating the logic. But I can't help but feel
> that pulling these fields out of object_info is a step backwards. The
> point of that struct is to let the caller specify which aspects of the
> object they're interested in

My issue was that there are some parts that cannot be turned off (in
particular, the object_info.u.packed part). Having said that, reading
the packed object itself should give us enough information to populate
that, so I'll take a look and see if this is possible.

> Another approach to this whole mess is to have a single function for
> acquiring a "handle" to an object, along with functions to query aspects
> of a handle. That would let callers iteratively ask for the parts they
> care about, and we could lazily fill the handle info (so information we
> pick up while servicing one property of the object gets cached and
> returned for free if the caller asks for it later).
> 
> That's a much bigger change, though it may have other benefits (e.g., we
> could be passing around handles instead of object buffers, which would
> make it more natural to stream object content in many cases).

There are a few safeguards that, I think, only work with the current
get-everything-then-forget-about-it approach (the packed-loose-packed
retry mechanism, and the desperate retry-if-corrupt-packed-object one).
If we have a handle with a cache, then, for example, we would lose the
ability to retry packed after loose if the handle has already declared
that the object is loose.
