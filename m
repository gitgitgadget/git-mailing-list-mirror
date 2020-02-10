Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0ACC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90F52070A
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lBqSxjoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJV0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:26:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51883 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJV0F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 16:26:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B2E9B99E3;
        Mon, 10 Feb 2020 16:26:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qf/NXqorgvg/9KVVAni/MzDyVjQ=; b=lBqSxj
        oarfzhxhFxFuAlsXS+qLr6ZmtIONbUxJyfCJ9I1VuAw/vpwM4Kk32CAWBn2gPLBK
        Olb3QdMMXrOPbrFeNs4LSKxvAA3/K3gaFiLPnfQE9fUmZztn7F65vqjFjeEC7Ejn
        KshDFu0xDGaju5H3UPFYnZvf/nvkWvQGlpbuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HmO9X4+zTNJ/pgeYs6X8BFY9AnUBiDvr
        YXeT3JZ4Vg+K2JrByzIjHXsLwccaPxBbppdCJiIXur65f8SV3GYXmoD3NFT2WoC/
        70LZDJi2FRXEjqb9kQZOM6i59AHQQwqbb+wwqvDHw98H1hGfr+kM6M3OK3cHaAKJ
        a/yO/vNiS1w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4329AB99E2;
        Mon, 10 Feb 2020 16:26:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C871B99DF;
        Mon, 10 Feb 2020 16:26:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 04/10] config: make scope_name non-static and rename it
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
        <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 10 Feb 2020 13:25:58 -0800
In-Reply-To: <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 10 Feb 2020 10:02:59 -0800")
Message-ID: <xmqqzhdqxhg9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF057E7C-4C4B-11EA-942F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The change from "cmdline" to "command line" does need to happen
> before the end of the series, but I do not think it should happen
> here, especialy given that the proposed log message explains that
> this step is to expose scope_name() under a better name (which is a
> very good split point).

I'll tweak this step with the attached patch, and then adjust
06/10 as needed, while queuing.

 config.c              | 2 +-
 config.h              | 1 -
 t/t1308-config-set.sh | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 83bb98d65e..a922b136e5 100644
--- a/config.c
+++ b/config.c
@@ -3307,7 +3307,7 @@ const char *config_scope_name(enum config_scope scope)
 	case CONFIG_SCOPE_REPO:
 		return "repo";
 	case CONFIG_SCOPE_CMDLINE:
-		return "command line";
+		return "cmdline";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index dcb8c274d4..c063f33ff6 100644
--- a/config.h
+++ b/config.h
@@ -35,7 +35,6 @@ struct object_id;
 
 #define CONFIG_REGEX_NONE ((void *)1)
 
-
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 5f3e71a160..7b4e1a63eb 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-cmdline
 	origin=command line
 	name=
-	scope=command line
+	scope=cmdline
 	EOF
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
 	test_cmp expect actual
