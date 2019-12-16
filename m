Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D3AC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E039206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQThc0sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLPSzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:55:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56438 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfLPSzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 13:55:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00A4990C08;
        Mon, 16 Dec 2019 13:55:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FigoefTMCtzKT3gSomzymvKU8WM=; b=WQThc0
        svfGDjFTTLxy21IuNBgkQlMpPFl+Jw3H1zLp4I5T6Rhd/GwXSex2TnlyxcZyuCeY
        XGR6spLS0X/iIZcwqRUf5Z6zIpkbGNLQ+YumYf39DS/WLeo6m5vwOT2LvgL5Mesw
        BXkS2+OFizccowv+TJKjXkHVe6X03YYEfbF4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tv9g3c2UhKS2gkXTRKGLrM3d1nNA1Ky3
        SSWtaRtZ4wPgrD8CkOHjNYHGPIUGMZM5ftAnmirf0hdRH/hz6UJMWvRHCJL4NbX/
        YuJyF+k2mPctNyU2hVSAPM/pry9ev3OiHA47R1cPeft/hp4OWAnx0Eq01B/IuTmu
        VU+vLGAmw9c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC59E90C07;
        Mon, 16 Dec 2019 13:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08CA890C05;
        Mon, 16 Dec 2019 13:55:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
        <20191214003820.GA927924@coredump.intra.peff.net>
        <20191214010002.GA945704@coredump.intra.peff.net>
Date:   Mon, 16 Dec 2019 10:55:40 -0800
In-Reply-To: <20191214010002.GA945704@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 13 Dec 2019 20:00:02 -0500")
Message-ID: <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9B109BE-2035-11EA-B359-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 13, 2019 at 07:38:21PM -0500, Jeff King wrote:
>
>> That's because LIB_H is created by running find in the local filesystem.
>> So until it's generated, we don't realize it's there to check. I kind of
>> wonder if it should be part of LIB_H. I suspect that on some systems,
>> we'd fail to notice a rebuild when command-list.txt is updated (but
>> nobody noticed, because it is only systems that do not have
>> compiler-supported dependency tracking, and most developers are no
>> modern platforms that do).
>
> Actually, this probably isn't true. We have an explicit dependency for
> help.o on command-list.h, so it would get built properly then.
>
> Its inclusion in LIB_H is still wonky, though. It sometimes is included
> and sometimes not, depending on whether ls-files or find is used.

As long as GENERATED_H is maintained properly to list headers that
are actually used (e.g. if we ever start creating and using a header
only when some Makefile macro tells us to, we make sure to place the
header in GENERATED_H only when we create and use it), I think we
should just add it to LIB_H, regardless of what is tracked.

LIB_H could contain command-list.h (and other GENERATED_H files) if
we did this, but dups in dependency does not hurt in general, and I
did not find anything potentially problematic in the existing use of
$(LIB_H) in our Makefile.

How about doing this as a further clean-up?  I am reasonably sure
the status-quo description is correct, but I find the justification
a bit weak (in other words, I do not have a good answer to "who
cares if those that depend on $(LIB_H) are not rebuilt when
command-list.h gets rebuilt?")

--- >8 ---
Makefile: include GENERATED_H in LIB_H

$(LIB_H), which is meant to be the list of header files that can
affect (hence trigger recompilation) the objects that go in
libgit.a, in a directory extracted from a tarball is computed by
running "find \*.h" but instead computed with "ls-files \*.h" in a
working tree managed by a git repository.  The former can include
generated header files after a build, and omit them in a clean
state.  The latter would not, as generated header files are by
definition not tracked.

Explicitly add $(GENERATED_H) to $(LIB_H) to make things consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9a9d35637d..552c43c3d8 100644
--- a/Makefile
+++ b/Makefile
@@ -822,6 +822,7 @@ LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentat
 	-name t -prune -o \
 	-name Documentation -prune -o \
 	-name '*.h' -print)))
+LIB_H += $(GENERATED_H)
 
 LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
@@ -2399,7 +2400,7 @@ else
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
-$(OBJECTS): $(LIB_H) $(GENERATED_H)
+$(OBJECTS): $(LIB_H)
 endif
 
 exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
@@ -2521,7 +2522,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
+LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
 LOCALIZED_SH += git-rebase--preserve-merges.sh


