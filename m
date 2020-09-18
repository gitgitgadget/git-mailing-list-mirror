Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE3FC43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 19:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A17321707
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LmWLMt/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRTOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:14:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64683 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 15:14:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02AC472BEF;
        Fri, 18 Sep 2020 15:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=egS/yF2bGqOyFs5mIPdwFc7RdFk=; b=LmWLMt
        /A781IEZF8HW5T5ctqT3A3gKgi1969LwA/YuQkeU3DZnLe1KCr9kSKgrO86Do2t8
        yS1LpJXPGRzYhg8zd6uWRz2JO672aXx5qPysKpolDjmH+XkPtx9MNtY2IKNeSmq1
        RNoKaeBgrWBDVuJPeUddvmH82/Peps7+nNRgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DoxVCV1sR4ycZbquVyctpbIafJehP0Lh
        lZy7cXkST1TMZfh0YlERoEV8t1DMMOIcWcC+g+xZka0rEHybHJqAm0itlQ3DJppF
        s6ORCl8JNGkMPyO9S8OicOX9EiUWMRmv/6ffsY8CwXFV61P41FdtzHzgCfcQcM7Q
        DoYWHMAIvhc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC0CC72BEE;
        Fri, 18 Sep 2020 15:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4361E72BED;
        Fri, 18 Sep 2020 15:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrew Klotz <agc.klotz@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config: improve error message for boolean config
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
        <689d84672422dd96d1eb89ea6137e79ce4030248.1600395427.git.gitgitgadget@gmail.com>
        <15b794ad-6eae-6de1-3328-9b814e8e2605@gmail.com>
Date:   Fri, 18 Sep 2020 12:14:38 -0700
In-Reply-To: <15b794ad-6eae-6de1-3328-9b814e8e2605@gmail.com> (Phillip Wood's
        message of "Fri, 18 Sep 2020 19:30:59 +0100")
Message-ID: <xmqqpn6ilwwx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32C5B240-F9E3-11EA-8BB8-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This patch improves things for boolean config keys  but
> git_config_bool_or_int() is used by status.submoduleSummary, merge.log 
> and commit.verbose which can be either a number or a boolean (where a
> boolean generally means use a default number).

Excellent point.  The rephrasing done by the patch as-is will be a
regression.

> It would be a more 
> invasive change but I wonder if it would be better for
> git_config_bool() to have it's own error message rather sharing it
> with git_config_bool_or_int().

You'd probably need a variant of die_bad_numer(), with an untested
patch like below.


 config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 8db9c77098..801d944d2b 100644
--- a/config.c
+++ b/config.c
@@ -1097,7 +1097,10 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return v;
 	}
 	*is_bool = 0;
-	return git_config_int(name, value);
+
+	if (!git_parse_int(value, &v))
+		die_bad_number_or_bool(name, value);
+	return v;
 }
 
 int git_config_bool(const char *name, const char *value)
