Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62752C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9E560C4B
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhJLXFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 19:05:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56483 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhJLXFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 19:05:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D697102228;
        Tue, 12 Oct 2021 19:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ROxumu3Uu1kKXPc7E/rbC+H36ASSfRSKwnefRH
        NLv58=; b=LBb5wRKpqQpTZ8xTBRguzIU/4/62qzKsNZCyFBYE5YnciREbE+undX
        gnrAhpVUDvlULMqzMNpYtqudyJGi2uOiEZUd6RVda1NFcbnJEAIm1Fa2PmPR1H46
        pgMGQAFVi/EAxiUYrGcg/IRKqYQvWtR1qethjhNRdx8LVxiRpEMEs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04847102227;
        Tue, 12 Oct 2021 19:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A89F102226;
        Tue, 12 Oct 2021 19:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] test-lib.sh: try to re-chmod & retry on failed trash
 removal
References: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
        <patch-v2-1.1-9cfc0621067-20211011T014059Z-avarab@gmail.com>
Date:   Tue, 12 Oct 2021 16:03:20 -0700
In-Reply-To: <patch-v2-1.1-9cfc0621067-20211011T014059Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 11 Oct
 2021 03:41:59
        +0200")
Message-ID: <xmqq5yu13kxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98826ED4-2BB0-11EC-9F61-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mostly looking good, but I applied the following on top to be
squashed in.

Thanks.

-- >8 --
Style fix plus adding more paranoia to cope with the lost 'r' bit.

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 138a26c19b..d820910154 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1386,11 +1386,11 @@ export HOME GNUPGHOME
 
 # "rm -rf" existing trash directory, even if a previous run left it
 # with bad permissions.
-remove_trash_directory() {
+remove_trash_directory () {
 	dir="$1"
 	if ! rm -rf "$dir" 2>/dev/null
 	then
-		chmod -R u+wx "$dir"
+		chmod -R u+rwx "$dir"
 		rm -rf "$dir"
 	fi
 	! test -d "$dir"
