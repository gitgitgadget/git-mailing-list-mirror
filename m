Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97C31F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeCQWGG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:06:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53017 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeCQWGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:06:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id t3so9070849wmc.2
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yC/NxDBfcOAhWIc05WDe961U6+vQfzmjlh8ic/JAsaA=;
        b=KBFPNvknoGmIIAHHKN0MKe8OBN9/sZBlKoDudcSG86dJbaT15Ljl8YhMUoGVBsgqqq
         k15ag3VtaId3Du4GGNkjfiFZKE1suBXaLZgI17hmU1sEG3NqcHyAlLM7H/7JcdODjE9Z
         Nd7mKsABFMlF2Pi7jGJE8/tiiPIXWSflPwKDW6VWF3dodpaigsh8b9LVJ60CMg7v/uRw
         JcOTiWehNKJ8HQZH3fNPTcFc3u4sEyNE0KvnsKVnUZK890SyIcEfZg2bBplbD3Wtq3hp
         wk1aZxajnA695OkXSBYuQsDBg84tu4Oxp2GuvW7gYVUEo9cNuTKnXU2vqpD0r04VoIDw
         6wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yC/NxDBfcOAhWIc05WDe961U6+vQfzmjlh8ic/JAsaA=;
        b=Mn7Fqs7QY/gFz6bQ0ydmYUll7G45YkVF2ibi4un3eyRgzvxlGNwM62AN815P9It/Dz
         G49JIt0qQ1IoXuDGxY7S9jo+eEvQHfs8YaW8xEn08h8WOPenkXibWQ5n6oLaQEhI+V+U
         FvU2xyMR6YF48F26F9mcQFv4DgpprW0F2ZzKmEMAPOWL5c7WYSFM+9shzdqLrW8ol67q
         l0JTPKGKRBnPOnOzh8P38G05cmJi/mPKY4y7pnQhoIPvCLrGHv7fNKVwqpGeWioN+WXA
         Zz9ijoKRJhEjBlBpU/erPobMIHI8V+hbDw1zuPj1RBC6ATWMF2nK9NvKVQS6lrj9BIge
         9m0A==
X-Gm-Message-State: AElRT7HRSQ5HY6ioj5PiZrcuvyw37xtaVGMNvo3GBzDJicuHcr2f1ldW
        HMl17qLGQI0qf0XEcYE0Vhc=
X-Google-Smtp-Source: AG47ELvROw+suw77gZ8JG7iuru4L8IUK1BsUgo+k4RFI9fO/jv3lbpJOQAyAZXg4nfXYLnVdiMWWSA==
X-Received: by 10.28.55.4 with SMTP id e4mr374087wma.7.1521324361695;
        Sat, 17 Mar 2018 15:06:01 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l22sm9622794wmi.39.2018.03.17.15.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:06:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Why does pack-objects use so much memory on incremental packing?
References: <20180228092722.GA25627@ash>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180228092722.GA25627@ash>
Date:   Sat, 17 Mar 2018 23:05:59 +0100
Message-ID: <87fu4ycq7s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 28 2018, Duy Nguyen jotted:

> linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
> consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
> all apps nearly unusuable (granted the problem is partly Linux I/O
> scheduler too). So I wonder if we can reduce pack-objects memory
> footprint a bit.
>
> This demonstration patch (probably breaks some tests) would reduce the
> size of struct object_entry from from 136 down to 112 bytes on
> x86-64. There are 6483999 of these objects, so the saving is 17% or
> 148 MB.

Splitting this off into its own thread. Aside from the improvements in
your repack memory reduction (20180317141033.21545-1-pclouds@gmail.com)
and gc config (20180316192745.19557-1-pclouds@gmail.com) series's I'm
wondering why repack takes so much memory to incrementally repack new
stuff when you leave out the base pack.

Repacking git.git takes around 290MB of memory on my system, but I'd
think that this would make it take a mere few megabytes, since all I'm
asking it to do is pack up the few loose objects that got added and keep
the base pack:

    (
        rm -rf /tmp/git &&
        git clone git@github.com:git/git.git /tmp/git &&
        cd /tmp/git &&
        touch $(ls .git/objects/pack/*pack | sed 's/\.pack$/.keep/') &&
        for i in {1..10}
        do
            touch $i &&
            git add $i &&
            git commit -m$i
        done &&
        /usr/bin/time -f %M git repack -A -d
    )

But no, it takes around 230MB. But thinking about it a bit further:

 * This builds on top of existing history, so that needs to be
   read/consulted

 * We might be reusing (if not directly, skipping re-comuting) deltas
   from the existing pack.

But I get the same result if after cloning I make an orphan branch, and
pass all the "do this as cheaply as possible" branches I can find down
to git-repack:

    (
        rm -rf /tmp/git &&
        git clone git@github.com:git/git.git /tmp/git &&
        cd /tmp/git &&
        touch $(ls .git/objects/pack/*pack | sed 's/\.pack$/.keep/') &&
        git checkout --orphan new &&
        git reset --hard &&
        for i in {1..10}
        do
            touch $i &&
            git add $i &&
            git commit -m$i
        done &&
        git tag -d $(git tag -l) &&
        /usr/bin/time -f %M git repack -A -d -f -F --window=1 --depth=1
    )

But the memory use barely changes, my first example used 227924 kb, but
this one uses 226788.

Of course nobody's going to clone a huge repo and then right away create
an --orphan branch, but is there an inherent reason for why this
couldn't be taking as much memory as if the repo was cloned with
--depth=1?

I.e. when I have a *.keep on an existing pack we would have some
low-memory mode to copy the trees/blobs needed for the current commit
over to the new pack, and use that as the basis for packing everything
going forward.

Jeff: Is this something ref islands[1] could be (ab)used to do, or have
I misunderstood that concept?

1. https://public-inbox.org/git/20130626051117.GB26755@sigill.intra.peff.net/
   https://public-inbox.org/git/20160304153359.GA16300@sigill.intra.peff.net/
   https://public-inbox.org/git/20160809174528.2ydgkhd7ayclat3t@sigill.intra.peff.net/
