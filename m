Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB02C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFBD208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PNkFgccE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgBUCFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:05:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58598 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 21:05:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CB0049001;
        Thu, 20 Feb 2020 21:05:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KqdgH7LbBwhQb4LtjdlyBc0EbyY=; b=PNkFgc
        cEbBIG32jL++awALLLSrdb7xi5iIK4+Kj7mO1HZJXI2VFaXFdUmqRZcR6Hz7lSsX
        BuZqsdo2gNtgOufEdPyudqujxSVSSGV6tARBtq7feqWPDpBwHbFU0nFZTOiCwRho
        F8PbEQlQ7pB1TgKACn2T/Anwe2noeynm/7dh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jYf+g+T519Ov5AGcB/sGDu7w8YqE2Yvt
        x5zFjmkyCXD6p8ye+mvjhJIN3gWplm3gZTCKsCFO/zTc2+lR8ASRICzAqtmf8Xds
        BSsmddTqmxjwuexs+7ZpclKxnUbuSvxIbZXvfT0EBWin4jx1JFB9cNSeCuQtuP5u
        89cfzWfmkNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E63E348FFF;
        Thu, 20 Feb 2020 21:05:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39AC548FFE;
        Thu, 20 Feb 2020 21:05:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, peff@peff.net, rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <xmqqftf49862.fsf@gitster-ct.c.googlers.com>
        <20200221013357.26795-1-matheus.bernardino@usp.br>
Date:   Thu, 20 Feb 2020 18:05:15 -0800
In-Reply-To: <20200221013357.26795-1-matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 20 Feb 2020 22:33:57 -0300")
Message-ID: <xmqqsgj47l0k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AFAED7A-544E-11EA-975B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

>> > Another case that came to my mind is when the user runs `git describe
>> > --abrev=0 HEAD` and v1.0-bob points to HEAD~. In this case, v1.0 will
>> > be displayed without suffix,...
>>
>> In this case, v1.0-1- is followed by the full object name, I think.
>
> I might be doing something wrong, but this is how I tried to test this:...

I only tried the commit exactly at the tag "describe --abbrev=0 v1.0-bob^0";
you're right---the "abbrev" option strips the suffix in a separate codepath.

> Then we cannot directly use the output. I think we can fix this forcing the long
> output for this case as well, which can be done with:

Thanks for a quick fix on top.

 builtin/describe.c  |  2 +-
 t/t6120-describe.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 5e8484f654..f71bddff4a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -452,7 +452,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	}
 
 	append_name(all_matches[0].name, dst);
-	if (abbrev)
+	if (all_matches[0].name->misnamed || abbrev)
 		append_suffix(all_matches[0].depth, &cmit->object.oid, dst);
 	if (suffix)
 		strbuf_addstr(dst, suffix);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 16a261c45d..8f35f18c3f 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -144,6 +144,18 @@ test_expect_success 'misnamed annotated tag forces long output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'abbrev=0 will not break misplaced tag (1)' '
+	description=$(git describe --abbrev=0 Q^0) &&
+	expr "$description" : "A-0-g[0-9a-f]*$"
+'
+
+test_expect_success 'abbrev=0 will not break misplaced tag (2)' '
+	description=$(git describe --abbrev=0 c^0) &&
+	expr "$description" : "A-1-g[0-9a-f]*$"
+'
+
+exit
+
 test_expect_success 'rename tag Q back to A' '
 	mv .git/refs/tags/Q .git/refs/tags/A
 '
