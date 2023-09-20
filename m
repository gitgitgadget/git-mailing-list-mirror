Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13BC04FE8
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 18:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjITSrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITSrH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 14:47:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32769A1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 11:47:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CAEE835EFA;
        Wed, 20 Sep 2023 14:47:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4jJGmxXB9OTtydbSpZ9qk28Ib3oO9G32iogKY9
        pTDBw=; b=sIbF/kEn6bcB5969inOmAx9g39MGlzUkwch7/GdobvdzD6itxahgwO
        tkdYUjZ5wmrPZOiT+ahLbmt4w8O9UmGpYViB7ghkUz7leV0I9oCu7TXvxEpONlfk
        fn/0mqGW1792m2iijrcUZwh1Mi3rwzbeTuMr1EqiN3Xoh68WFPI4Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C406535EF9;
        Wed, 20 Sep 2023 14:47:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C60635EF8;
        Wed, 20 Sep 2023 14:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: loosen and document the requirement around
 completing alias
In-Reply-To: <xmqqy1h08zsp.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Wed, 20 Sep 2023 11:28:22 -0700")
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
        <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
        <xmqqy1h08zsp.fsf_-_@gitster.g>
Date:   Wed, 20 Sep 2023 11:46:55 -0700
Message-ID: <xmqqr0ms8yxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1365BCF6-57E6-11EE-AE7D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * We've discussed this when we reviewed the topic that just hit
>    'master'.  Before we forget...
>
>  contrib/completion/git-completion.bash | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

And here is an obligatory "test" update I will squash into the main
patch.  The new ones copy a canonical ": git <cmd> ; ..."  test and
remove 'git' and also the space before the semicolon.

diff --git c/t/t9902-completion.sh w/t/t9902-completion.sh
index 47e20fb8b1..a7c3b4eb63 100755
--- c/t/t9902-completion.sh
+++ w/t/t9902-completion.sh
@@ -2464,6 +2464,24 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
 	EOF
 '
 
+test_expect_success 'completion used <cmd> completion for alias: !f() { : <cmd> ; ... }' '
+	test_config alias.co "!f() { : checkout ; if ... } f" &&
+	test_completion "git co m" <<-\EOF
+	main Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
+test_expect_success 'completion used <cmd> completion for alias: !f() { : <cmd>; ... }' '
+	test_config alias.co "!f() { : checkout; if ... } f" &&
+	test_completion "git co m" <<-\EOF
+	main Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
 test_expect_success 'completion without explicit _git_xxx function' '
 	test_completion "git version --" <<-\EOF
 	--build-options Z
