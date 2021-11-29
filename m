Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54155C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhK2WQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:16:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64709 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhK2WOI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:14:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7780DF0EFB;
        Mon, 29 Nov 2021 17:10:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=OAnYpki9vxCHNiK+jS86T+7XbLLUDU3b4SrfN8ZiszE=; b=qDYJlhcpK9U8
        hxFjh7plkSbQagFJboF1qnnUEtdSLJpznS2T7LWP73fe++CW0Sgox3/U8A1bbsfT
        bHih3K1rEItAhj8oILHgMED4fyYBQDp8kcWa+Bp2UyIMkD8+5iJyMCkQxZCFiIt5
        /GqFJ6qYuZZnBrFr78u2NLargCsfNd4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E52BF0EFA;
        Mon, 29 Nov 2021 17:10:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2B1BF0EF9;
        Mon, 29 Nov 2021 17:10:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] grep: clarify what `grep.patternType=default` means
cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Date:   Mon, 29 Nov 2021 14:10:48 -0800
Message-ID: <xmqq7dcq62af.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35D9A4F6-5161-11EC-BE99-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in the days when the "return to the default matching behavior"
part was written in 84befcd0 (grep: add a grep.patternType
configuration setting, 2012-08-03), grep.extendedRegexp was the only
way to configure the behaviour since b22520a3 (grep: allow -E and -n
to be turned on by default via configuration, 2011-03-30).

It was understandable that we referred to the behaviour that honors
the older configuration variable as "the default matching"
behaviour.  It is fairly clear in its log message:

    When grep.patternType is set to a value other than "default", the
    grep.extendedRegexp setting is ignored. The value of "default" restores
    the current default behavior, including the grep.extendedRegexp
    behavior.

But when the paragraph is read in isolation by a new person who is
not aware of that backstory (which is the synonym for "most users"),
the "default matching behaviour" can be read as "how 'git grep'
behaves without any configuration variables or options", which is
"match the pattern as BRE".

Clarify what the passage means by elaborating what the phrase
"default matching behaviour" wanted to mean.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Whether the eventual deprecation of grep.extendedRegexp is a good
   idea, we'd need something like this to clarify what these two
   variables are meant to interact with each other first.

 Documentation/config/grep.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7c..72f5e03614 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -8,7 +8,8 @@ grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
+	value 'default' will use the settings of `grep.extendedRegexp` option
+	to choose between `basic` and `extended`.
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
-- 
2.34.1-251-g6783e24198

