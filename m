Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6243BC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC466134F
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhECFYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:24:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51107 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECFYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:24:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85CBB13B737;
        Mon,  3 May 2021 01:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aEvZgXC+3sbHM6dpneJM2H7fmkBVvrCEF8BxNV
        5OQD0=; b=Hbm7fbh8ccOqLO9kgujxI7stRGILVhG8G5M493fkkVdDcx9cmC0J1G
        Wpn0emanXjPemdWNgicQa4MftRbVNmiwGWvqHpxeivCD5Zdl94UKP6hpr6yx7Rxz
        eS6bnJEWOSbU9Le7uDvRnJX4Eh85CCwr6ogEGOXU4rzUCXB+MLZSI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E24313B736;
        Mon,  3 May 2021 01:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9927413B735;
        Mon,  3 May 2021 01:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] CodingGuidelines: explicitly allow "local" for test scripts
References: <xmqqfsz4a23x.fsf@gitster.g>
        <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
        <xmqqsg348k9j.fsf@gitster.g>
Date:   Mon, 03 May 2021 14:23:24 +0900
In-Reply-To: <xmqqsg348k9j.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        03 May 2021 14:21:44 +0900")
Message-ID: <xmqqo8ds8k6r.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF87A2C2-ABCF-11EB-8A17-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

01d3a526 (t0000: check whether the shell supports the "local"
keyword, 2017-10-26) raised a test balloon to see if those who build
and test Git use a platform with a shell that lacks support for the
"local" keyword.  After two years, 7f0b5908 (t0000: reword comments
for "local" test, 2019-08-08) documented that "local" keyword, even
though is outside POSIX, is allowed in our test scripts.

Let's write it in the CodingGuidelines, too.  It might be tempting
to allow it in scripted Porcelains (we have avoided getting them
contaminiated by "local" so far), but they are on their way out and
getting rewritten in C.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c9..ea70676a30 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -175,6 +175,11 @@ For shell scripts specifically (not exhaustive):
 
    does not have such a problem.
 
+ - Even though "local" is not part of POSIX, we make heavy use of it
+   in our test suite.  We do not use it in scripted Porcelains, and
+   hopefully nobody starts using "local" before they are reimplemented
+   in C ;-)
+
 
 For C programs:
 
-- 
2.31.1-579-ge1192275af

