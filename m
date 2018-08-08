Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29173208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 18:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeHHUdp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:33:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54963 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHUdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 16:33:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so3676060wmb.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=srrwrMuSQDrTvTAkCz4TmA4dLoQbT/TVsCI8TM98rvk=;
        b=L8DoSghRl00vI7nq1bR8pKpXoOKdN//uopsOogd3wp9N/2TzudQzMz14RgFWKCEQOJ
         g7TyXEpD7QaQEfz6eeorV9JmVOkJw+eqJX5s0QPVhJyRdQ8cFJEs15LtIRafongr1t9J
         es6Qd/6OHpaCzA4lFcS5Gi1xguhqXtH4OxMftHGHWC7KArozU01ys5+J7N1k+Dr9plTm
         PX9Eg1JL5Z0zU5pmY8QVYg9oop1Xc73ugEGM9V1PPRpJD3z02pSqP/EWZj2RHMOwk9jP
         eayffvGAHcp1WCezvewVec1V8vRlzDmDYejPmNU2xFkHNNG3cPpNuQN56CSN3bOBbqI0
         lZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=srrwrMuSQDrTvTAkCz4TmA4dLoQbT/TVsCI8TM98rvk=;
        b=s/zsWUoBum/ju0+RtUoYc9czeHNXSnJyZOjBLglTeQMsFHdd+mDEt8g+FRcZ962C2E
         PF9FSbfhYBwuaNmmcPMzO6fly4Wju1ju7PKETkqs5IPyA6z01Xi46xcZhm67pcElXUDs
         0gXVxeIRUUVp1bG7/BW2xaU6Ie6Jd7tKJf8+bNDSx/KgylkUWoVO/ytqM/AG0tX7G7AJ
         K0xq+B1orEYugpB4a2z7VvvAGQYSJpjm/eKidKccUk26hmlMbClJeqyz63lEba6uXTFa
         gbaKEaiGzij1pz3X6qzct3NKJzvvyi1r1J6j+qt05qsjevKbZziqQz0vM91nEPpNHN/Z
         lMIQ==
X-Gm-Message-State: AOUpUlFg96DxRku73igFQHcRJgexlhGwt1a7AdxA8etYJsLhCNZlFHQc
        gjlJHN1Pgv5wI5SEUdiujOc=
X-Google-Smtp-Source: AA+uWPym3rQxSs3f5gRjXHKaioeQGynILf182I6uKb594mTSQZ76BQ2JNZ67anhYKgwbO9XE55bb6A==
X-Received: by 2002:a1c:8d0a:: with SMTP id p10-v6mr2612158wmd.121.1533751971461;
        Wed, 08 Aug 2018 11:12:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q2-v6sm3568761wmc.44.2018.08.08.11.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 11:12:50 -0700 (PDT)
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
        <xmqqpnyshhtt.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 Aug 2018 11:12:50 -0700
In-Reply-To: <xmqqpnyshhtt.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 Aug 2018 10:46:38 -0700")
Message-ID: <xmqqin4khgm5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> not used behind is *not* OK.  And lack of restoring the bottom in
> the new codepath makes me suspect exactly such a bug _after_ the
> traversal exits the subtree we are using this new optimization in
> and moves on.

Hmph, thinking about this further, I cannot convince myself that
lack of bottom adjustment can lead to a triggerable bug.  The only
case that a subtree traversal need to skip some unpacked entries in
the index and then revisit them by rewinding, e.g. entries "t-i" and
"t-j" that are left unprocessed while entries "t/1", "t/2", etc. are
processed, in the illustration of da165f47 ("unpack-trees.c: prepare
for looking ahead in the index", 2010-01-07), is when one of the
trees have a non-tree with the same name as the subtree we are
trying to descend into, and as long as we know all trees have the
thing as a tree, I do not think of a case where such ordering
inversion would get in the way.

That was the only thing I found questionable in 2/4, which is the
most important piece in the series, so we probably are OK.

Thanks for working on this one.
