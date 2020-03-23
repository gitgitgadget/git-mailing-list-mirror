Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8EEC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B0120409
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rLYOMROA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCWXLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:11:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63786 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWXLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 19:11:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89252484FD;
        Mon, 23 Mar 2020 19:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TUDNdwhInc9KE+nx56rR8onHWnQ=; b=rLYOMR
        OApEoKYkLpwso/QPbnFGeYCcDmkCwFPiIxs9cjoB5QAjMRzAJwCGx/wC7r6JweIC
        cj/S8wfQ7ZQfBE8i0j+cTB8e1Q2V+HPXjNH3/wfh1Yv014VZCCnINcwH7kRZ6QzI
        w35gUkl872m2UWjTD0O4jtu5qGkyWm0GyXJsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EU/F81CAvGmeIpS7H4LW3HwXkyaw0kEs
        O+v394YMh4i4/8udwOSi0kkcn1WIvxg+U4HX4nj/a7J8eMHIDPGoeWGJ/TzWY+tI
        MzEpNykenSgQcwlqdhb3DgbAxIcG/VAGY+Hu4y5rBnoc126VbyVJqPNFmXzzYZQa
        x1S/nn7mx2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DD02484FC;
        Mon, 23 Mar 2020 19:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D39CB484FA;
        Mon, 23 Mar 2020 19:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v10 5/5] bugreport: add compiler info
References: <20200323214340.182724-1-emilyshaffer@google.com>
        <20200323214340.182724-6-emilyshaffer@google.com>
Date:   Mon, 23 Mar 2020 16:10:59 -0700
In-Reply-To: <20200323214340.182724-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 23 Mar 2020 14:43:40 -0700")
Message-ID: <xmqqlfnq3bwc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F1E79CE-6D5B-11EA-996D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +#ifdef _MSC_VER
> +	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
> +#endif

This part is a bit different from what Dscho suggested to be
squashed (and I have had on top of v9 series).

Below is a diff between (v9 + SQUASH???) and v10.  I think the
change in the strftime format is a strict improvement.

Thanks.

 bugreport.c       | 2 +-
 compat/compiler.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/bugreport.c b/bugreport.c
index 5073c901cd..089b939a87 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -73,7 +73,7 @@ int cmd_main(int argc, const char **argv)
 	int report = -1;
 	time_t now = time(NULL);
 	char *option_output = NULL;
-	char *option_suffix = "%F-%H%M";
+	char *option_suffix = "%Y-%m-%d-%H%M";
 	int nongit_ok = 0;
 	const char *prefix = NULL;
 	const char *user_relative_path = NULL;
diff --git a/compat/compiler.h b/compat/compiler.h
index ac90fa051d..ce6a7f6de9 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -16,8 +16,7 @@ static inline void get_compiler_info(struct strbuf *info)
 #endif
 
 #ifdef _MSC_VER
-	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
-		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
+	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
 #endif
 
 	if (len == info->len)
