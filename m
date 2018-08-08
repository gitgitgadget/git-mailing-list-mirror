Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947C6208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 17:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeHHUH0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:07:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeHHUHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 16:07:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so2732752wrt.11
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Qu4XskFlIY9pLTyto6WENC5PEctb4FAutBc0bxiwtzo=;
        b=LCosUbeVb7XpmzkRnE6qEYlZ/yO4VGL05NQv3Zfn6ieLMxvobrGNlvSu2LSTrE40Z9
         LC6vpUMo+w0pw68eurunXihwuxTU7ch8nguvoBNqGbXBnTAzRtUORmcAEILBb66daMpL
         oZjthK/KFpPTbZ/HFT/TN9JyEW2zqP+dbk9zHwecrDORHECkHjBqbkgWEgfcaR2AEjP6
         QuPQCIW1NEzijuFVG9xCDGZqO1MxvaaY9xKE3DVmfaee4TY20hJALeumKVBRUgFy4bh6
         qgLLgMlCNljnUygsdXKxGQ1g/3QlzpiNtSugj5S36BsF/h8M6cJ3+ErhRolDUeZl1pXm
         tBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Qu4XskFlIY9pLTyto6WENC5PEctb4FAutBc0bxiwtzo=;
        b=jiP98vUYiES+IgLJ6cfcoB7zM6YAfyR2sjjPnkD6vv0/OR3MEK+PRPwaZm/DfonhvA
         7DLO/9F5bFnbPXdO/xoQ1hgHO8+HnqBP1ivOWMck7XaUPwv4ZULm/w+LFLV9zD43Kja2
         J3VmQ6hcXivK7rQ3WH3dDlfYPi4Z9Z2sUllQPfU2IwJC6uQJvyUxe6u4PQgisFIcOukW
         x7Xe3PhSPsRRXdlZMMGVmMM02uUcgbAUD+F6E+aie1PQfCaiFzpCAr5LBXNLTE4JOb8v
         mzwgzDA35uzlPEpt8vKeuX7EV76OVrtJ8uedEqy5RtNpSs/KFDECzivfyWFBMn0924kY
         9y2g==
X-Gm-Message-State: AOUpUlGzq4mrKQfV7vbMS4Q27NEgziyiXC8/NGxH9f893FWYc337MhLx
        eAWsorUVxD63oEIg80p1jWY=
X-Google-Smtp-Source: AA+uWPy2nF84g5sreTZbo24tjEtKEbLwY66bYq3tIqc0djLOhspuhKyK+k9aoydZ7Kth24BAyAgCzQ==
X-Received: by 2002:adf:aa09:: with SMTP id p9-v6mr2646869wrd.92.1533750400043;
        Wed, 08 Aug 2018 10:46:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x82-v6sm14291481wmd.11.2018.08.08.10.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 10:46:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
References: <20180729103306.16403-1-pclouds@gmail.com>
        <20180804053723.4695-1-pclouds@gmail.com>
        <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
Date:   Wed, 08 Aug 2018 10:46:38 -0700
In-Reply-To: <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 6 Aug 2018 17:59:28 +0200")
Message-ID: <xmqqpnyshhtt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 6, 2018 at 5:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > I've also checked about the lookahead thing in unpack_trees() to see
>> > if we accidentally break something there, which is my biggest worry.
>> > See [1] and [2] for context, but I believe since we can't have D/F
>> > conflicts, the situation where lookahead is needed will not occur. So
>> > we should be safe.

I think you would want the same "switch cache-bottom before
descending into a subdirectory, and then restore cache-bottom after
traversal comes back" dance that is done for the normal tree
traversal case to happen.

	bottom = switch_cache_bottom(&newinfo);
	ret = traverse_trees(n, t, &newinfo);
	restore_cache_bottom(&newinfo, bottom);

During your walk of the index and the trees that are known to be in
sync, there is little reason to worry about the cache_bottom, which
is advanced by calling mark_ce_used() in traverse_by_cache_tree().
Where it matters is what happens after the traversal comes back out
of the subtree.  find_cache_pos() uses the bottom pointer so that it
does not have to go back to far to find an index entry that has not
been used to match with the entries from the trees (which are not
sorted exactly the same way as the index, unfortunately), so
forgetting to advance the bottom pointer while correctly marking a
ce as "used" is OK (i.e. hurts performance but not correctness), but
advancing the bottom pointer too much and leaving entries that are
not used behind is *not* OK.  And lack of restoring the bottom in
the new codepath makes me suspect exactly such a bug _after_ the
traversal exits the subtree we are using this new optimization in
and moves on.

Imagine we are iterating over the top-level of the trees, and found
a subtree in them.  There may be some index entries before the first
path in this subtree that are not yet marked as "used", the earliest
of which is pointed at by the cache_bottom pointer.

Before descending into the subtree (and start consuming the entry
with the first in this subtree from the index), we stash away the
current cache_bottom, and then start walking the subtree.  While we
are in that subtree, the cache_bottom starts from the first name in
the subtree and increments, as we _know_ the entry at the old
cache_bottom is outside this subtree and will not match any entry
form the subtree.  Then when the traversal returns, all index
entries within the "subtree/" path will be marked "used".  At that
point, when we continue to scan the top-level of the trees, we need
to restore the cache_bottom, so that we do not forget entries that
we knew we needed to scan eventually, if there was any.
