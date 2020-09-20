Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4962CC433DB
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 00:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B041F207C3
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 00:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgITAaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 20:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgITAaS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 20:30:18 -0400
X-Greylist: delayed 721 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Sep 2020 17:30:17 PDT
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB9C061755
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=To:Subject:Date:From;
        bh=JTlEr9TIeoZH28AcmkuBuVLllkokwTa0S+YdltD/NWI=; b=uDI6hn1xLyPk86tbDhgYTYz1AQ
        Ipy6+fG3AA2Zjcoen5ZLlGuWObRqbbpwp9zrhK36WVVNpEMewKGiyEszoPdXimngLzvRLLt0EG0xZ
        St9DpK6E4FExvCXkEiL3JZxkvJvjmQH4m2sFwc0oGrBqVU7De5hEEUjHRY1406qTDoA9W8sgBG138
        efuLUP9hg4or0rsV3mzxd0o7ajkQFl6yotS/h6o2dRqfRAWH3nhq/DGmerQrvoaX5wCYGKI0PkM7v
        v1RLsaaHLYFiitypOysfDcnxZYv4axDXvyZH85UbaccLUXO5dwo5/E020svutlxqp5HV7W+wKwDhF
        pN5FwbhQ==;
Received: from [209.85.208.52] (port=38394 helo=mail-ed1-f52.google.com)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1kJn3T-0004Rv-0d
        for git@vger.kernel.org; Sun, 20 Sep 2020 01:18:15 +0100
Received: by mail-ed1-f52.google.com with SMTP id c8so9519742edv.5
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 17:18:09 -0700 (PDT)
X-Gm-Message-State: AOAM531rHHOJ+qJPJCyDP8fjmQxIEevSpK7bLDLH1CcMm6vgDe8ilP9K
        ZZhK85gNadV2PFIeNSK5djx2MckBWTdNCoNuVY4=
X-Google-Smtp-Source: ABdhPJxdUjZ+6Ay6M0kIy9ZasimrJdybnK1CQfyhiu+ruYNSxi2W8Nt2k9JLicc3+uJoylO2KW5/9kfEsGBfHBGBKoI=
X-Received: by 2002:a50:da84:: with SMTP id q4mr44466127edj.238.1600561088850;
 Sat, 19 Sep 2020 17:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
 <xmqqh7s8z0qw.fsf@gitster.c.googlers.com> <20200908231652.GC1014@pug.qqx.org> <xmqqo8m1k542.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8m1k542.fsf@gitster.c.googlers.com>
From:   Ash Holland <ash@sorrel.sh>
Date:   Sun, 20 Sep 2020 01:17:32 +0100
X-Gmail-Original-Message-ID: <CAHJUbDjSS-fWjeJkD49yEPmRKZQLYSW0R9-PhzFem1QsEuJUOQ@mail.gmail.com>
Message-ID: <CAHJUbDjSS-fWjeJkD49yEPmRKZQLYSW0R9-PhzFem1QsEuJUOQ@mail.gmail.com>
Subject: Re: `git describe --dirty` doesn't consider untracked files to be dirty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BlackCat-Spam-Score: 0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 19 Sep 2020 at 19:12, Junio C Hamano <gitster@pobox.com> wrote:
> This is worth fixing.  I am leaning towards saying that `diff` is
> wrong in this case, but I am OK to consider unifying the behaviour
> the other way and making `describe --dirty` more strict.

fwiw, my preference would be for the second behaviour; I have a release
script which complains at me if I've forgotten to commit something, and
to avoid making a release with new uncommitted files I currently have to
use both `git describe --dirty` (to check for modifications to tracked
files) and also `git ls-files --others --exclude-standard` (to check for
untracked files).

maybe there's a better plumbing command I should be using in a script,
but your example of the wildcard build rule also would suggest that
`describe` should be changed, not `diff`:

> Having said all that, a source that was forgotten to be added, yet
> affects the built product by a build rule with wildcard e.g.
> "compile all *.c files and link them into a single binary", would
> happen in real life, so from that point of view, appending "-dirty"
> only when there is a local modification may not be all that useful,
> and tweaking the "--dirty" option to also pay attention to untracked
> (but not ignored) might have merit.

lastly, by appeal to `git clean`'s documentation: "Remove untracked
files from the working tree"

if you clean a repository by removing untracked files, then untracked
files surely make the working tree dirty :)
