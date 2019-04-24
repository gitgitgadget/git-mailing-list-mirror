Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31C11F453
	for <e@80x24.org>; Wed, 24 Apr 2019 18:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbfDXSDj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 24 Apr 2019 14:03:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53554 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbfDXRTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so5605805wmj.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 10:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zmj8KRCYvIfIxLY9x2MMyo7Xfo4Iw7Lt3d2ngHgMO28=;
        b=HvSQRxqEerf9XF9GTkYPrmf6s5sClv5IC7Kxism24XgkcC5L2d+XqSpBTG7I1YyHk8
         JwKJnTLJss6J94ZX11CX+0LSbq7Sl1Vi+fn8WvzIqBIS8gI3unXhy9cqq4t8hagC49ou
         IWOmAU4aq0PMiW0KRRgDZ95/8+wlQKW7boUo5wH2UIgC8w1rWlZZQe7bSfZX2s3kKbww
         nxG1R0TpB8aw10CTpyliw3S1tKL/+L127u/085Zx8CQXablxVeJLIfI51wGrHYcpwV4A
         qxjH+9Opn25RqHGyHlx9rslZdg1eUncL2YTnNu38D+aHkEx9gySSq9uSTw4YQWJdqdPX
         K25g==
X-Gm-Message-State: APjAAAVW790nO/2KL2M2GPvkQKNCF1O5s4OgTHChGfD2QDZqP5+jiW2J
        vIloukZJN6Kk23NZijML+B7GeLy48yEkpn3v3Kk=
X-Google-Smtp-Source: APXvYqxDGwpkYJnvysIkgrTWm5lzZBqpUfa7pmXaumLjQCw/YmbNlc3Shd2dExXYXbXukzTKac+DZqYgZOy+uf9GtzQ=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr97254wme.71.1556126391421;
 Wed, 24 Apr 2019 10:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com> <20190422144927.GA6519@sigill.intra.peff.net>
 <20190423202109.GA8695@szeder.dev> <xmqqlg0043km.fsf@gitster-ct.c.googlers.com>
 <20190424112550.GC8695@szeder.dev>
In-Reply-To: <20190424112550.GC8695@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Apr 2019 13:19:40 -0400
Message-ID: <CAPig+cSU5L2NDgMPJ4PG2nd8j9=Pe_LXxukDsFmZTiV2wf-4EA@mail.gmail.com>
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 7:26 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On second thought, however, I'm not sure that such a '--dedup' option
> would be all that useful in the above cases.  If the users have to
> adjust their 'git ls-files' invocation by specifying '--dedup' to
> avoid the same paths listed multiple times, then they might just as
> well remove the redundant options.  After all, a deleted file is
> inherently modified, and a modified file is inherently cached...

As a person who rarely, if ever, uses git-ls-files, I'm having trouble
understanding why de-duping isn't the default behavior when the
listing is otherwise not annotated (that is, when -t/-v/-f/--debug are
not used). Are consumers of an unannotated list able to derive any
additional useful information from the duplicate entries? If consumers
can't derive anything useful, then the duplication seems more an
accident of implementation (for the unannotated case) than a planned
feature, thus could be considered a bug worth fixing. And, the fix
would be to de-dup by default when unannotated, thus no need for a
--dedup option. (As for backward-compatibility concerns, I imagine
that existing consumers either don't care about the duplication or
already manually de-dup, but perhaps I'm not seeing the larger
picture.)
