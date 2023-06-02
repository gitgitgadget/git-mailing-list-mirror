Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ADFC7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 07:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjFBH1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjFBH1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 03:27:08 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D8128
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 00:27:07 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a28817f70bso1210274fac.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685690826; x=1688282826;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zdr/eHCQ37tXUwQXR29N2a6FEcEUjXcwqTXEhBvuEXg=;
        b=sTaCde+fMNeaU0pGeCY6Ymu9DWylUPcIWltYqdlgj1lM2o+I/sbqa+fADrskOLw8N3
         OoGNP71nOYvDARS0xHIut6cpbW477kGEIYvinucsv9tRHKTts5xy8WjJvM4MZFlB+R7n
         4rMcO5Yw2h3kPpVx/+BRzCuBsQxEvIK6pSU1LJAMxeFVeRw8gCMBzyVXFE3+BcPtcnxR
         vonl3S/bgxGD/VsPFsu0hM6e0DrNA0QTsp2YKgdzU+ZgKd8dhqmT95xqY2djqPfUCUEp
         PdpdU5KQRNEWa3Q/PnqoLz/LOHf8eZvTt+eamFftusipqP3wbxCtNfVFg3zSNYoHFNiS
         V1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685690826; x=1688282826;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zdr/eHCQ37tXUwQXR29N2a6FEcEUjXcwqTXEhBvuEXg=;
        b=IoSafl7sww67/+JLfebyYbnvU28F81X6CsY8xIeI2tKD3HTYBcxDQFikH3KPH7ux4P
         QyDuLyykUpXmA8e/jJJcN68ojzJ5pj1UFwlIuOFP9wxC9gc/u8yfV/2DjWdnhrfkhE5o
         8dfOc3ZE23xg7FKUfaWFQ/zCCfnPo0vXOQJOvnYeDRT7XDUG4aNLG9s7DUWznLef8ufe
         Gc7Sgbvhx5DDk1vNlmR+IGRwtqksxdpfSI9nKUDLliuhXWjOsXYdQYaYMTGZ4WUTV1Gx
         Pm1r1nI+yGKEYsL8XzjZkrqYdwHybkG6I/JZhBvjm0cQPYyfN7Stn343k6kGKMjeWCXj
         DYXQ==
X-Gm-Message-State: AC+VfDwZGfZd/yI/N+vgJ3daJ4GAB2uPaUqB+96/DKXk6W3oKQ8Tnirt
        25aOUeELwq1JmY2fqoi2M3I=
X-Google-Smtp-Source: ACHHUZ53oY5kc3qOEB2N3Ry4jly12tegtk884CrS74k+TFerroTn2ZPOYT6MZA8ddz8dyNeqWj58Qw==
X-Received: by 2002:a05:6870:d304:b0:19f:afde:1c62 with SMTP id f4-20020a056870d30400b0019fafde1c62mr1354147oag.38.1685690826121;
        Fri, 02 Jun 2023 00:27:06 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id q25-20020a63f959000000b00534514bc08bsm579225pgk.64.2023.06.02.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 00:27:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jim Pryor <dubiousjim@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: detect pathspec magic not supported by --follow
References: <20230601173724.GA4158369@coredump.intra.peff.net>
        <20230601174351.GC4165297@coredump.intra.peff.net>
Date:   Fri, 02 Jun 2023 16:27:05 +0900
In-Reply-To: <20230601174351.GC4165297@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 1 Jun 2023 13:43:51 -0400")
Message-ID: <xmqq4jnq9vee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The --follow code doesn't handle most forms of pathspec magic. We check
> that no unexpected ones have made it to try_to_follow_renames() with a
> runtime GUARD_PATHSPEC() check, which gives behavior like this:
>
>   $ git log --follow ':(icase)makefile' >/dev/null
>   BUG: tree-diff.c:596: unsupported magic 10
>   Aborted

Stepping back a bit, isn't the real reason why follow mode is
incompatible with the pathspec magic because it does not want to
deal with anything but a single literal pathname?

In other words, in "git log --follow ':(icase)makefile'", if the
given pathspec matches a single path in the starting commit, we
should be able to start from the commit inspecting that uniquely
found path, compare the commit with its parent(s) at the path, and
when the parent does not have the path, detect rename and continue
following that the name before the rename as the single path
starting from that parent.  Perhaps the commit we start at, HEAD,
has "Makefile" and not "makefile" (if we have two, that is an
error), so we start traversal, following the pathname "Makefile".
At some point, we may discover that the parent did not have
"Makefile", but has "GNUMakefile" with a similar contents, at which
point we swap the path we follow from "Makefile" to "GNUMakefile".

At each step, tree-diff does not need to and does not want to do
anything fancy with pathspec---the operation is always "this path in
the parent, does it exist in the parent? If not, did it come from a
different path?", and use of "literal pathspec" mode makes sense
there.

So why does try_to_follow_renames() even *need* to say anything
other than "We are in follow mode; what we have is a single path;
use it as a literal pathspec that matches the path literally without
any funky magic"?  GUARD_PATHSPEC() is "please inspect the pathspec
and see what kind of special pattern matching it requests---we
cannot allow it to ask for certain things but do allow it to ask for
other things", that sounds terribly misguided here.  The string is
literal, so we do not even want to look at it to see what it
asks---it is taken as nothing but a literal string and we do not let
it ask for anything special.

For example, if we started at HEAD to follow Makefile and in an
ancestor commit we find that the Makefile came from a funny path
":(icase)foo", instead of allowing the pathspec match code to
interprete it as a magic pathspec that matches any case permutations
of 'f/o/o', we want to force the pathspec match code to match
nothing but the funny path "colon parens icase close parens foo" by
using literal pathspec magic.

So perhaps having GUARD_PATHSPEC() there is the mistake, no?

For the above idea to work, I think we need to resolve the pathspec
early; "log --follow" should find its starting point, apply the
given pathspec to its treeish to grab the literal pathname, and use
that single literal pathname as the literal pathspec and continue,
which I do not think it does right now.  But with it done upfront,
the pathspec limiting done during the history traversal, including
try_to_follow_renames() bit, should be able to limit itself to "is
the path literally the string given as the pathspec"?

I dunno.
