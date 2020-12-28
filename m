Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC7BC43381
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F423208BA
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 13:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgL1NKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 08:10:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54646 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgL1NKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 08:10:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A619FAD66D;
        Mon, 28 Dec 2020 08:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dHBWzoHB+yMX5ky1uGQBiPjZ4S4=; b=xwOhLh2PHdN7D0j2aMcn
        9m94UExEsza9Dk7zBi5pdCgZ5Xy24x1Ov2AdZMIczkgoGM95vSkxtTB+laDQPulv
        xuoEpBaZibZmrnfXF4zvWdX3ESw7a8HLdpJqGIfSwC5Nue/Ufqv6DhzAw3hfaqDM
        J29+N9wyRNCYI0a5EJ21ytE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=IJtcjrvle2HdQePTOCMRdQkyk6NctViMKGJpi9d/eLW3Zj
        5e1tHIZqii6cSns/FI4TkHDgkxUF/qiaBl2+wXWGcOh068zJUcyVb2T7buAW9Vgx
        Kz6AHIx5eeAGw5DIDTSYuiIahZvKeWRyZrW5Bn+CucYvXywdhnBX7/1UMO8pA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CF3AAD66C;
        Mon, 28 Dec 2020 08:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2866CAD66B;
        Mon, 28 Dec 2020 08:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 2/4] mergetool: Add per-tool support for the
 autoMerge flag
References: <20201228004152.522421-1-seth@eseth.com>
        <20201228045427.1166911-1-seth@eseth.com>
        <20201228045427.1166911-3-seth@eseth.com>
Date:   Mon, 28 Dec 2020 05:09:53 -0800
Message-ID: <xmqqzh1yhyam.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9F4177A-490D-11EB-8504-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Subject: Re: [PATCH v8 2/4] mergetool: Add per-tool support for the autoMerge flag

"git shortlog --no-merges --since=2.months" may tell you this but our
convention is not to capitalize the word after "<area>:" on the
title.

> Keep the global mergetool flag and add a per-tool override flag so that
> users may enable the flag for one tool and disable it for another.
>
> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  Documentation/config/mergetool.txt | 3 +++
>  git-mergetool.sh                   | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 7ce6d0d3ac..ef147fc118 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -21,6 +21,9 @@ mergetool.<tool>.trustExitCode::
>  	if the file has been updated, otherwise the user is prompted to
>  	indicate the success of the merge.
>  
> +mergetool.<tool>.autoMerge::
> +	Remove lines without conflicts from all the files. Defaults to `true`.
> +

This entry needs to mention how it relates to the big red button
mergetool.autoMerge and vice versa.  E.g.

 mergetool.autoMerge::
-	Remove lines without conflicts from all the files. Defaults to `true`.
+	Remove lines without conflicts from all the files. Can be
+	overriden per-tool via `mergetool.<tool>.autoMerge` configuration
+	variable. Defaults to `true`.

would be a good update to the documentation introduced by the
previous step.  It is somewhat misleading for the per-tool entry
added in this patch to say "Defaults to `true`", as the value of the
big red button configuration would be the real default.

	Remove ... the files when the mergetool '<tool>' is in use.
	See also `mergetool.autoMerge`.

or something like that, perhaps.
