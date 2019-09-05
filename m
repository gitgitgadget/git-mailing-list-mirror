Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E59F1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfIESSD (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:18:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64362 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfIESSD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:18:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81354845DB;
        Thu,  5 Sep 2019 14:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d0r3Z/8+pLK8LFsowzVAZuKJqD4=; b=oZ5Cn9
        MY/FBItF9paly/EFWeV+R5xk+2Xq/ng72VbKFKLNpUBxU8PGp+2LO6OJVuQz/+wN
        IHfQU5Oz5kikhOT6BGFz25G/3KTkaVfU5G5t5IDgjuABYdAvK1RypBkevq8pIiwa
        9cZW3FNIFy/GTYb0j3CjgdhrhkWoXkSEHn5mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vn6tdABWWrkCTKiCB671idKUAU+tDR0u
        VuUn+VATqo3qZf8EDVU5Fopt/VFpVDiVMSZkPtYFe16lMIIZc2DHWUyj7hyMjmzX
        sdgpWoTqDdaHljrS6AssL5Y/NuvUWPI/LamlJLe/u5kbBSo+2WKffQFutG6WuT05
        JPi03lbUyYk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7920B845DA;
        Thu,  5 Sep 2019 14:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 974CF845D4;
        Thu,  5 Sep 2019 14:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: use LF variable defined in the test harness
References: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
        <20190904002930.GA76383@syl.lan>
Date:   Thu, 05 Sep 2019 11:17:57 -0700
In-Reply-To: <20190904002930.GA76383@syl.lan> (Taylor Blau's message of "Tue,
        3 Sep 2019 20:29:30 -0400")
Message-ID: <xmqq7e6mr4iy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DDB49FC-D009-11E9-A6B7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   - t/t3005: this script calls the variable '$new_line', but could be
>     renamed to LF and then removed in a second patch

It is worse than that, isn't it?

If it used $new_line, then it would probably have been a good idea
to somehow make a separate patch related to this one and make a
series about "use $LF from test-lib", but ever since its beginning
at 0f64bfa9 ("ls-files: fix pathspec display on error", 2011-08-01),
$new_line is assigned once but never used in the script.

Somebody may want to go clean-up the use of various $sq and $SQ
locally defined by giving a unified $SQ in test-lib.sh, by the way.

-- >8 --
Subject: t3005: remove unused variable

Since the beginning of the script, $new_line variable was never used.
Remove it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3005-ls-files-relative.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 209b4c7cd8..583e467683 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -7,8 +7,6 @@ This test runs git ls-files with various relative path arguments.
 
 . ./test-lib.sh
 
-new_line='
-'
 sq=\'
 
 test_expect_success 'prepare' '
