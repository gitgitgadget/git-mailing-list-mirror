Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADAEC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 22:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0082077B
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 22:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIxB/71a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAIWqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:46:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36695 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgAIWqr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 17:46:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so122525pfb.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 14:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGt2YcMIIlh1TIqyM+gh/+qV6UlMB+snD3W3xWebEo8=;
        b=KIxB/71aB8PF15OaRTFsK7RHLq3iYvyE1BxWF90ITFV4rGwRydvZhDN4lx4gWiv+Ok
         egOw5jZQ+D35dK6+JfrY/WCMOXTe5/b2NB5DJOQx1V3wH9y3L6dPZCiKXx1JifByZkrW
         X8JoYCVcrhcOP9XPSon2BP3NZUT4x90sorYJMXRdVoXBoQiuYtw+fBCIQIK09U/UBEES
         ppAAd9vPsYOgMwM4aDRl7EEl2gFji7Qj1p9gkmQSurOqnrVGsJDI5lR4qgzVsbK+6cqM
         SiGuhhhoPx1Cw3Cbt+T2PLCVaMconAlKA3uGnGQ8P6odF43rUVHvwLqO6xzUZ9lV2qiI
         /qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGt2YcMIIlh1TIqyM+gh/+qV6UlMB+snD3W3xWebEo8=;
        b=AtaZJhK+i7rdi/l7qE0xC4mZvYKRNCF6MLASrF659nLr4K73ttX35trvkB8ygR3GG3
         0qO9RSawKegxmWJ8F6LO4BDNJtUIHuNh2j6wRgAH95CYuxjQh2SN1pcU+O2g2MSVrO+y
         MOim4OoCrvHn8Zm2AhEoz9V1ILGZ6FDFQzXPzG9nauZZePcuYsgx86JZP2SSSfxlLgTI
         5A8nHqB6gqNkySPwHV0j8+13X6BBcKKbdYxTXj2RLskYFqHR6lnIgBMLSQrp7AfzJuy5
         +5It3jDostxHbllhaSUasMseRBQJVhE8dKtqe1JfZB+XxFesywJyF+yfif9EuouIQWaQ
         ATNQ==
X-Gm-Message-State: APjAAAX9LOKHGPYhdZw+Y0JNGdpzPVjS1eWU/LX3C9yVanYbytPng9KA
        APNodr2KDSYEr960hINu2PVLvifGLLo=
X-Google-Smtp-Source: APXvYqyzNrMYJnc1885cp6uYQSgymCsuAfmbgVA0yHa5mVfS5BLlTIbU5su365J8BvWXgYu3HSwImA==
X-Received: by 2002:a63:3750:: with SMTP id g16mr332349pgn.413.1578610006573;
        Thu, 09 Jan 2020 14:46:46 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c34sm8613616pgc.61.2020.01.09.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 14:46:46 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:46:41 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] unpack-trees: watch for out-of-range index position
Message-ID: <20200109224641.GF181522@google.com>
References: <20200108023127.219429-1-emilyshaffer@google.com>
 <20200108071525.GB1675456@coredump.intra.peff.net>
 <xmqqeew93lfn.fsf@gitster-ct.c.googlers.com>
 <20200108193833.GD181522@google.com>
 <xmqqo8vd1yb2.fsf@gitster-ct.c.googlers.com>
 <20200109075250.GA3978837@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109075250.GA3978837@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 09, 2020 at 02:52:50AM -0500, Jeff King wrote:
> On Wed, Jan 08, 2020 at 12:35:29PM -0800, Junio C Hamano wrote:
> 
> > >> It does not sound like a BUG to me, either, but the new condition
> > >> does look correct to me, too.  We can turn it into die() later if
> > >> somebody truly cares ;-)
> > >> 
> > >> Thanks, both.  Will queue.
> > >
> > > Thanks much for the quick turnaround. If I hear more noise I'll give it
> > > a try with die() or error code instead, but for now I'll move on to the
> > > next bug on my list. :)
> > 
> > By the way, it is somewhat sad that we proceeded that far in the
> > first place---such a corrupt on-disk index would have caused an
> > early die() if we did not get rid of the trailing-hash integrity
> > check.
> 
> Perhaps. The integrity check only protects against an index that was
> modified after the fact, not one that was generated by a buggy Git. I'm
> not sure we know how the index that led to this patch got into this
> state (though it sounds like Emily has a copy and could check the hash
> on it), but other cache-tree segfault I found recently was with an index
> with an intact integrity hash.

Yeah, I can do that, although I'm not sure how. The index itself is very
small - it only contains one file and one tree extension - so I'll go
ahead and paste some poking and prodding, and if it's not what you
wanted then please let me know what else to run.

  $ g fsck --cache
  Checking object directories: 100% (256/256), done.
  Checking objects: 100% (20/20), done.
  broken link from  commit 153a9a100eae7fdba5989ce39a5dd1782075517f
                to  commit cca7ecaa5d8c398f41bfec7938cc6a526803579b
  broken link from  commit 7d6bb91e31d18eadfaf855a9fb7ad6ba81b8b6d9
                to  commit 03087a617bfe55f862cb1ef43273a2bd08e8b6d6
  missing commit 03087a617bfe55f862cb1ef43273a2bd08e8b6d6
  missing commit cca7ecaa5d8c398f41bfec7938cc6a526803579b
  dangling commit 5e2c635433bc46b13061b276e481f63b1f6642c8

  $ hexdump -C .git/index
  00000000  44 49 52 43 00 00 00 02  00 00 00 01 5d 89 5e 22  |DIRC........].^"|
  00000010  23 bf a3 c4 5d 89 5e 22  23 bf a3 c4 00 00 fe 02  |#...].^"#.......|
  00000020  02 c8 f5 83 00 00 81 a4  00 06 c1 dc 00 01 5f 53  |.............._S|
  00000030  00 00 06 b3 78 88 a4 f4  22 34 7d ad b0 c4 73 0f  |....x..."4}...s.|
  00000040  c5 bc f6 ea 1d 2d f0 3a  00 09 52 45 41 44 4d 45  |.....-.:..README|
  00000050  2e 6d 64 00 54 52 45 45  00 00 00 3a 00 31 37 20  |.md.TREE...:.17 |
  00000060  31 0a da 7f 67 25 40 7d  4e ce 9f d3 72 ce 4c e8  |1...g%@}N...r.L.|
  00000070  40 6d 5d ad e9 79 67 69  74 6c 69 6e 74 00 34 20  |@m]..ygitlint.4 |
  00000080  30 0a 93 63 25 17 69 e6  d6 92 78 97 55 4b 0f 8b  |0..c%.i...x.UK..|
  00000090  ff a0 e8 2d 6d 71 32 d1  69 fc f2 38 42 f8 5a 6e  |...-mq2.i..8B.Zn|
  000000a0  05 35 d6 94 41 c0 9f c7  ba 43                    |.5..A....C|
  000000aa

  $ find .git/objects -type f
  .git/objects/pack/pack-5e5d5e7c3cbd60a99b4c0295a2935885fbb235a1.idx
  .git/objects/pack/pack-5e5d5e7c3cbd60a99b4c0295a2935885fbb235a1.pack
  .git/objects/15/3a9a100eae7fdba5989ce39a5dd1782075517f
  .git/objects/5e/2c635433bc46b13061b276e481f63b1f6642c8

(By the way, cat-file barfs on both those loose objects, for the reason fsck
reveals.)

I hope that's helpful.

 - Emily
