Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09356C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1FE61037
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhHDRYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:24:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51563 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbhHDRYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:24:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F475130451;
        Wed,  4 Aug 2021 13:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JPaKwxr+tTGK
        Ctx6dlPJjX5mCmiSf7tYBVe0Wk1bQ3s=; b=AeIA29wCvHYaot5Y7bKeFAiOogUs
        mjuctklHpIEQoQ0Vk7rjzbUBXaHi0ZdrUT47KWu7xYklr5KIjJmLChs70Wze86IU
        D7di8dBRCifWtqxJn5RKZoKftF7nE+8q7Vtg6QQabz/cKwSibJVOuzNYRr7zbWSg
        NX4XKq+qFCNb/i4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27D1E130450;
        Wed,  4 Aug 2021 13:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6834213044F;
        Wed,  4 Aug 2021 13:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 4/3] fixup! reftable: add dump utility
References: <20210802190054.58282-1-carenas@gmail.com>
        <20210804064434.42236-1-carenas@gmail.com>
Date:   Wed, 04 Aug 2021 10:24:00 -0700
In-Reply-To: <20210804064434.42236-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 3 Aug 2021 23:44:34 -0700")
Message-ID: <xmqq35rpqg27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C316A730-F548-11EB-A805-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> avoid _XOPEN_SOURCE in alpine by making sure git-compat-util.h is inclu=
ded
> first (through hash.h) as recommended and therefore avoid:

The headers cache.h and builtin.h are the only ones whose inclusion
allows the source to omit an explicit inclusion of git-compat-util.h
and we'd prefer the inclusion of git-compat-util.h to be explicit
here, not through hash.h.  Just including git-compat-util.h directly
without moving inclusion of hash.h should be sufficient.


diff --git a/reftable/dump.c b/reftable/dump.c
index 668cfa8996..eb7b2b4161 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -6,6 +6,7 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
=20
+#include "git-compat-util.h"
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 #include "reftable-merged.h"
