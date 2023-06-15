Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E729EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFOTAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 15:00:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A07196
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:00:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b01d3bb571so47907795ad.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686855602; x=1689447602;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4N9azPRuhcw5T1b/dnXErsKVYp9Y0wuCdXSyNeuwcs=;
        b=nvQRGsWGKAEQmhgLbSyCYIutkL1wfJI6YtOdatoY/WuY268PAmzV42/WaiRVZa6oJb
         XjU7oMO0RLlT/KiQBHokJUw2SA9bMY77UQQ88tuqp73YL4muenU+PCc+5y8uiFmBvib8
         wX8kh6oq/ej5S3NoVyxG5Vcab23bUlJp9uF538oahqrmSL1OzCp/f988hcxgUmZw0sc0
         OTvXUZkl48aZ2k2/LaFNqcCqOzWKGqW80IE1CdHNg0KV4jQan3rYnQjpeHwTLIpFF7C1
         IMu4FIUCiBbgDl7vTpUGBGTcC/t1BMav5rFv32IN5TpbUsM1y+gtM7QwUt+GunkQEsI1
         /FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686855602; x=1689447602;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L4N9azPRuhcw5T1b/dnXErsKVYp9Y0wuCdXSyNeuwcs=;
        b=OugeEt9UnJmHuFwJ/sy8gOEDWi2X0c1lP/B9KXm+xpt++QX/oO0cce3TTrL8sF/s1W
         QhxMHpunGfnyQBw6lrJ1mCXwn4Uwi4vIGZ59bEu1V7Mg4pp4PiQxt9czYPxQ5HCgVMqj
         rDKN73cv2ps/66Iuvjn8lFb6u9OmUceR7fRwPbTciq6MU9Ak+sArANrmITyVeZaO5r/A
         qiUmdIgdTTTktj2Lu+mTreLMQda/ueQYFcWmTmfARqpnwUabVOfiBEEOpzDNpXRib9EL
         AafMEEw/9hyU986Yzw5Y61lrYGf55+tVlz6cSSdWl4msG+6R0cRVej38Y867EQNxe6+i
         pyiQ==
X-Gm-Message-State: AC+VfDwFdmPJCn4ABQ3Y9fvDnuu2NtbO4EZskqnXihoidv+y8oET+QMN
        1nTxlh0nEB46iYpl1BSJjoc=
X-Google-Smtp-Source: ACHHUZ6dviQCQzlvP8eRvXBJnbCR27HU4jqirlYZnAFg/6cFr9wHrFW4iy2+HVwJICBVizbgtLUPMA==
X-Received: by 2002:a17:902:ab1b:b0:1b5:26d4:517d with SMTP id ik27-20020a170902ab1b00b001b526d4517dmr944665plb.29.1686855602446;
        Thu, 15 Jun 2023 12:00:02 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001b3d27a7820sm1859287plb.234.2023.06.15.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:00:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jim Pryor <dubiousjim@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: detect pathspec magic not supported by --follow
References: <20230601173724.GA4158369@coredump.intra.peff.net>
        <20230601174351.GC4165297@coredump.intra.peff.net>
        <xmqq4jnq9vee.fsf@gitster.g>
        <20230615072625.GD1460739@coredump.intra.peff.net>
Date:   Thu, 15 Jun 2023 12:00:01 -0700
In-Reply-To: <20230615072625.GD1460739@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Jun 2023 03:26:25 -0400")
Message-ID: <xmqqr0qcv9e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... except that the notion of "starting point"
> is ambiguous. If I do:
>
>   git log --follow branch1 branch2 -- foo*
>
> then we have two treeishes. Do we look at one? Both? What happens if the
> pathspec resolves differently?

If we consider a middle-ground where we do not keep a separate
pathname that each history traversal is following but only keep a
single pathname, then the answer is one of "ignore others and pick
one" (which is essentially what needs to happen in the current
implementation when a path gets renamed between a child commit and
its parent while the other parents do not have renames), "ignore
others and pick one, but give a warning that the result may be
incomplete", or "barf".  The latter two would need us to look at all
treeishes.

A false-positive-ridden "solution" that would slightly be better
than that would be to still keep a global, single, pathspec that has
more than one elements (all of which are literal pathspec elements).
Every time we discover a rename, we add the newly discovered old
name as an additional element, instead of replacing the single
element.  If we were to go that route, then starting from multiple
points, each following a pathname, would be a simple matter of
looking at all trees and finding which pathname each history
traversal wants to follow and creating a pathspec with all these
(literal) pathnames.

But once we fix the underlying problem, and start tracking which
path each history traversal trajectory is currently following, then
it is not a problem for each starting point to have a pathname that
is being followed.  Each commit would _know_ which pathname it is
interested in, and when a traversal from a commit to its parent sees
a rename, the pathname being followed for the parent commit will be
different from the child.

When this happens, the parent may have a pathname it is already
interested in, set by traversing from another child (i.e. one side
of a fork renamed the path one way, while the other side of a fork
kept the same name or renamed it to another way, and we traversed
both forks down and are now at the fork point).  It most likely
should be the same name we discovered from the other child, but in
weird cases it may be different (e.g. a child thinks its path A came
from parent's path X while another child thinks its path A came from
parent's path Y), in which case we may have to follow two pathnames
in the parent commit, as if the pathname we have been following in
the child had combined contents from multiple paths.

> So I'd suggest to let my series continue graduating, and then if anybody
> wants to work on more sensible pathspec handling, to do so on top.

I think we are in agreement on this---otherwise I wouldn't have
merged the patch as-is down to 'next' ;-)

As I said multiple times in the past, the current "log --follow" is
more of a checkbox item than a feature, and in that context, I think
your "fix", which may be papering over just one obvious breakage, is
what the codepath should be happy with, before it gets reworked more
seriously.

Thanks.
