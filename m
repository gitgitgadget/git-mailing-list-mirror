Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8451C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 22:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7E2078A
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 22:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H7WbZf1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFLWwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:52:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59835 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgFLWwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 18:52:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF484C4438;
        Fri, 12 Jun 2020 18:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=grk3NbP4Scfyt59WsDC4tabNbLg=; b=H7WbZf
        1qBxNW2gjGzobiHfFyXGEQK1ecEDJHOF1rVhdS4FcDcgLcBkNTP1HmiodV0wwaHg
        FlZg8o4h0rjJD9ahvufiq5uYX8B9+5FgXPGRjqjcdMdJz8EzVaCIVVMUS2TTohov
        14qYE6dZHpDTxomry1SB9lJgkr5/ezdtfLAdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CQV0IWYIEFHh9ktepTlNT8zzO4XLVPSA
        LoALadu43XHhgDKJaxRvkBrYf3ee64oUXYLc4g6P5ggc0HnxtLmAf3/KS4fVyXhg
        G73J0DHLUR4N2XZZ4MVtngW8jjNv7mQ/0CYNbbsVME0PqZGq9Om2nzgt7CPr5pnI
        iiy51K2V0TE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7312C4437;
        Fri, 12 Jun 2020 18:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39CC2C4436;
        Fri, 12 Jun 2020 18:52:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
        <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
Date:   Fri, 12 Jun 2020 15:52:26 -0700
In-Reply-To: <20200612184014.1226972-2-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sat, 13 Jun 2020 00:10:11 +0530")
Message-ID: <xmqq8sgr28yd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63FF0B6C-ACFF-11EA-800C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

>  static unsigned int alloc_commit_index(struct repository *r)
>  {
> -	return r->parsed_objects->commit_count++;
> +	static unsigned int parsed_commits_count = 0;
> +	r->parsed_objects->commit_count++;
> +	return parsed_commits_count++;
>  }

I'll queue this as-is, together with the rest of the series, but
with the following SQUASH??? to document why we are counting
globally.

I do not think r->parsed_objects->*_count is used by anybody, and we
probably can eventually get rid of these stats fields, and when that
happens, we may want to lose the "struct repository *" pointer from
the functions in the callchain, but not right now.

Thanks.

 alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/alloc.c b/alloc.c
index 29f0e3aa80..ee92661b71 100644
--- a/alloc.c
+++ b/alloc.c
@@ -99,6 +99,11 @@ void *alloc_object_node(struct repository *r)
 	return obj;
 }
 
+/*
+ * The returned count is to be used as an index into commit slabs,
+ * that are *NOT* maintained per repository, and that is why a single
+ * global counter is used.
+ */
 static unsigned int alloc_commit_index(struct repository *r)
 {
 	static unsigned int parsed_commits_count = 0;
-- 
2.27.0-90-geebb51ba8c

