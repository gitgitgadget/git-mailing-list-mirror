Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39356C433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC162074A
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HJ0ZO3N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEaQ7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 12:59:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51156 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 12:59:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C876ED24BA;
        Sun, 31 May 2020 12:59:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tD4RAy4SsG8UzEdPEFGdtzJDeHQ=; b=HJ0ZO3
        N80h05qvY6K9p3R/WPymLKvmLrZjmvv/kzvDdMZUlfiO2QdH2NFbix/BX6jINfth
        fKuFlTvKVrg1dqmlV+RujU6TFAa+SMlFQIxgYwPBYRpRc0qKM0OMitGJD9+sr3AP
        74ozH3ZStwLL0sM1SkhUfVDKvZKe8D61UFlT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hq0k5/CjAESm8vmmk/rmZpLOhqO4DY20
        bAuqpQcq372QjsZ1QiwFytUhK9SlIuch3NmxodQfdxW+6LqzfiptQHo2kieLykI3
        HJaUzlqXPBVs70R2ahU7/wNd+guB8uoxT1g4LWohZgOPch272sXqvn6BnoHByHh9
        I4lQ0w0WAg8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C10D0D24B9;
        Sun, 31 May 2020 12:59:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4F87D24B8;
        Sun, 31 May 2020 12:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] upload-pack: send part of packfile response as uri
References: <cover.1590789428.git.jonathantanmy@google.com>
        <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
Date:   Sun, 31 May 2020 09:59:23 -0700
In-Reply-To: <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 May 2020 15:30:20 -0700")
Message-ID: <xmqqa71ovy50.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14CF3C90-A360-11EA-8347-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 8da65e60de..3ea9345e6f 100755
> + ...
> +	GIT_TEST_SIDEBAND_ALL=1 \
> +	test_must_fail git -c protocol.version=2 \
> +		-c fetch.uriprotocols=http,https \
> +		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
> +	test_i18ngrep "pack downloaded from.*does not match expected hash" err

I haven't really read the later parts of this series, but I noticed
that this triggers a test-lint check.  I'll be adding the following
fixup in the meantime before continuing today's integration run.

Thanks.

-- >8 --
Subject: [PATCH] fixup! upload-pack: send part of packfile response as uri

---
 t/t5702-protocol-v2.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 041e78a88f..53bda39fb7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -829,8 +829,8 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 		"uploadpack.blobpackfileuri" \
 		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
 
-	GIT_TEST_SIDEBAND_ALL=1 \
-	test_must_fail git -c protocol.version=2 \
+	test_must_fail env GIT_TEST_SIDEBAND_ALL=1 \
+		git -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
 	test_i18ngrep "pack downloaded from.*does not match expected hash" err
-- 
2.27.0-rc2-6-g1aa69c7357

