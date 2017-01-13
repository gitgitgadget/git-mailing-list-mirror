Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675CB20756
	for <e@80x24.org>; Fri, 13 Jan 2017 19:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdAMTzi (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 14:55:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58096 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750789AbdAMTzi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 14:55:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3AB95EFBB;
        Fri, 13 Jan 2017 14:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z1gAu+VrF7pNE4i0x6i2gcNx2Wk=; b=ubqyAu
        BdGUjgoTB8HMCUCzbtWsHch0e1o0XXsv4qZEFgLsg4ToULve1bCzk7KuqBPQwBUi
        5LQqHgXF6klHxJwj9V73TVh/kY29Vd9zJxhm+RqOIx+jgA12/vck2IblHyW6wN+f
        T3v7sL28DUvdEnC/KA/RqudcCcCHqk4LbpvSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nv9vkOuPNm7ycq0uyVqhskRbeRyBeZ7V
        kjbR6aUC6y4x8U0a6F2yZrK4e7p1N8rnxh4uebh1ayouLwsUg+Hqmm4AuI+jHdIN
        tXJeLcxk+bAv28Ko1i0c6uY+A1gS7wWk58MvJX4rJ1Mzp06695WJVRazOLpe3pUt
        aQwWyYoQLFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAFD75EFBA;
        Fri, 13 Jan 2017 14:55:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 039545EFB9;
        Fri, 13 Jan 2017 14:55:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] lib-submodule-update.sh: drop unneeded shell
References: <20170111184732.26416-1-sbeller@google.com>
        <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 13 Jan 2017 11:55:34 -0800
In-Reply-To: <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 13 Jan 2017 10:40:51 -0800")
Message-ID: <xmqqa8auhgzt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FEA7650-D9CA-11E6-9F54-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> In modern Git we prefer "git -C <cmd" over "(cd <somewhere && git <cmd>)"
>> as it doesn't need an extra shell.
>
> There is a matching '>' missing.  The description is correct (I am
> not sure if there actually is "preference", though), but I found the
> title a bit misleading....

It turns out that there were two missing '>' ;-)  It tentatively has
become like this in my tree.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Wed, 11 Jan 2017 10:47:32 -0800
Subject: [PATCH] lib-submodule-update.sh: reduce use of subshell by using "git -C"

We write

    (cd <dir> && git <cmd>)

to avoid

    cd <dir> && git <cmd> && cd ..

that allows a breakage in one part of the test script to leave the
entire test process in an unexpected place.  We can do this more
concisely with "git -C <dir> <cmd>" with modern Git.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34a54..915eb4a7c6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -69,10 +69,7 @@ create_lib_submodule_repo () {
 
 		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
 		git submodule update &&
-		(
-			cd sub1 &&
-			git checkout modifications
-		) &&
+		git -C sub1 checkout modifications &&
 		git rm --cached sub1 &&
 		rm sub1/.git* &&
 		git config -f .gitmodules --remove-section "submodule.sub1" &&
