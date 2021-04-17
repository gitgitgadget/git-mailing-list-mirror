Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D133C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0E361210
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhDQVqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 17:46:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55577 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhDQVqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 17:46:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F124B86FA;
        Sat, 17 Apr 2021 17:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=seqZ44L8EftTjmYyD0mVQJer44w=; b=oE1DUS
        tM6+IsXletH+HUvUTTpabUqu7T+vBPOVFoD5FeyM+bR8zHYFkLZjqAx6WHGOaqv6
        WHbfgCAhKBGO/KOjALi9FQXIBVnaASsxUBLoX5v0wrUnsTDM8OWfD4IiDJ7uoARZ
        FSrtGlW4sp4Gi2KCN6hDiE47lMAJViNqiRFdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UrEm/uBitTw9+WZ8Mg8OWH3nttUzprG2
        1iiiZJvmJ0FWWSAFtxkVCJyk4q3kFChsynPScNABKpZeqR+EOqOd+lYJWapAcOvt
        SlAcX8Aszgp2xDWB5qzMtZDAXUKFs1DzIbcWgbKkkEK57/MBo9o17ntGrwNn+m3a
        9QvazbmSJKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3409AB86F9;
        Sat, 17 Apr 2021 17:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98D8AB86F2;
        Sat, 17 Apr 2021 17:45:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net> <YHVQ9RPLk8/r+8mS@ncase>
        <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net>
        <xmqqlf9hkhpp.fsf@gitster.g> <xmqq4kg5kehw.fsf@gitster.g>
        <YHo3LO2RKfe0W/z7@satellite>
        <YHqkBFp+CGzWW4Xs@coredump.intra.peff.net>
Date:   Sat, 17 Apr 2021 14:45:34 -0700
In-Reply-To: <YHqkBFp+CGzWW4Xs@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 17 Apr 2021 05:01:56 -0400")
Message-ID: <xmqq35vod1q9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D582F4C-9FC6-11EB-A42E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that would probably be nice, but let's not hold up the topic. It
> can include "cache.h" like a bunch of other headers in the meantime.
>
> (Too bad we can't just forward-declare the enum like we do for some
> other types, but it's impossible in C).

For now...

From f08346ce05e5512e5914e760aba769d0ef8035bc Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 17 Apr 2021 14:44:37 -0700
Subject: [PATCH] fixup! list-objects: implement object type filter

---
 list-objects-filter-options.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 4d0d0588cc..da5b6737e2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,6 +1,7 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
+#include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
 
-- 
2.31.1-450-gca40e2789b

