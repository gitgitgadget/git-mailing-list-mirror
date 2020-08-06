Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55406C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C86A221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jLSQi6L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHFUAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:00:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63724 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgHFUAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:00:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A2DB618F6;
        Thu,  6 Aug 2020 16:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=92PdugISCTmoLrZC8/1aZKeTcsE=; b=jLSQi6
        L8xmYvcwKz7C/PUNpgRutH4sgYQ7IzQGk4QRkFlAjbIDK8AY9xplqC4sW5oqhCVY
        X2etRQ+x/c5U4AON+DM0/oNZ/5WTzpVwnG0oKzotdILKKyc/gVH8dIBH4m6lv1G5
        RWYsYUjk8M64ac+aVzx2ZVcRan/cpHcz7um3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I/DORH0H8hGKMXSPy3jt82PSANO2AuAI
        QT8Fc21Le5eea6gW8q0YYL5JYQZ9I/U7N6dQVP/Hw5opPumu3usjtfGdcvpwZMIv
        4Q6md+NXPdjU1uTRukAToPJkLCNue09j0h1AbWKJOp806P1Kyd7IXhMSPCtceUFo
        HxxYUA9tD6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8326B618F5;
        Thu,  6 Aug 2020 16:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01764618F3;
        Thu,  6 Aug 2020 16:00:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] No-lazy-fetch has_object() and some fixes
References: <20200728010403.95142-1-jonathantanmy@google.com>
        <cover.1596668156.git.jonathantanmy@google.com>
Date:   Thu, 06 Aug 2020 13:00:44 -0700
In-Reply-To: <cover.1596668156.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 5 Aug 2020 16:06:48 -0700")
Message-ID: <xmqqwo2bk0ib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8383912E-D81F-11EA-B712-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Since v1, I've took a look at 3 other cases that use has_object_file():
> 2 don't need lazy-fetching (patches 3 and 4 in this set) and 1 does -
> "cat-file -e" - although I think this is a special case. So I still
> think that not lazy-fetching when checking object existence is more
> likely, and should be privileged with the shorter function name
> (has_object() instead of has_object_locally()).

Thanks.  has_object then.

>
> Changes from v1:
>  - Patch split into 2 (patch 1 and patch 2)
>  - 2 additional patches that fix bugs by making use of the new function
>
> Jonathan Tan (4):
>   sha1-file: introduce no-lazy-fetch has_object()
>   apply: do not lazy fetch when applying binary
>   pack-objects: no fetch when allow-{any,promisor}
>   fsck: do not lazy fetch known non-promisor object
>
>  Documentation/git-pack-objects.txt | 11 +++++++----
>  apply.c                            |  2 +-
>  builtin/fsck.c                     |  2 +-
>  builtin/pack-objects.c             |  4 ++--
>  object-store.h                     | 25 +++++++++++++++++++++++--
>  sha1-file.c                        | 12 ++++++++++++
>  t/t4150-am.sh                      | 16 ++++++++++++++++
>  7 files changed, 62 insertions(+), 10 deletions(-)
