Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE60C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2AB2073C
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="prIB/wWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLSGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:06:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53926 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 13:06:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DC844B61F;
        Wed, 12 Feb 2020 13:06:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y+4/lq+2HDxag6Bl3XYxTP/P7v0=; b=prIB/w
        WEJuLLfGPGHGcy3YU3eL8chWJH/nSlKp8H3pqA7y3CnXUhvaS5nI8nbwOgKQ7XCs
        MjSWd8qVqeCWQwzDm1w2QHJDltPylTYGBMSryjYFL2pjvwn58aM07yus211lgxjr
        crE0lk5OZtTNzTJFA4grEUxptrPHOvGG0MJS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sejMlOJ8Bx1oMquarpnnjUZjw4/yiPe0
        M+MolH5qE9HmfjbrUeH7yaH6+aYegHiR3xyBBbvgPilWKyqCWLZLkI1GoHQT2s+f
        oLcaEzqysctMD+C06j3uVd9+yfQx66MhnMzHaUrvK+eSfwq5VqDGT971VJmTp5kH
        ESTKliWADSs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5394B4B61D;
        Wed, 12 Feb 2020 13:06:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC3E84B61A;
        Wed, 12 Feb 2020 13:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 03/15] bugreport: add tool to generate debugging info
References: <20200206004108.261317-1-emilyshaffer@google.com>
        <20200206004108.261317-4-emilyshaffer@google.com>
Date:   Wed, 12 Feb 2020 10:06:44 -0800
In-Reply-To: <20200206004108.261317-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 5 Feb 2020 16:40:56 -0800")
Message-ID: <xmqq36bfvfwr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E450BCC-4DC2-11EA-A8E3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As this topic seems to break under GIT_TEST_GETTEXT_POISON=yes, I'll
apply the following band-aid on top before merging it to 'pu'.  

Most of them are style fixes, but quoting $REPORT, not just makes
the redirection honor the coding guidelines, will ensure that an
error is caught if git-bugreport-* glob matches no paths or more
than on paths.




 t/t0091-bugreport.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 451badff0c..f2186941ce 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -8,9 +8,12 @@ test_description='git bugreport'
 # information there; we can make sure all our headers were followed by some
 # information to check if the command was successful.
 HEADER_PATTERN="^\[.*\]$"
-check_all_headers_populated() {
-	while read -r line; do
-		if test "$(grep "$HEADER_PATTERN" "$line")"; then
+
+check_all_headers_populated () {
+	while read -r line
+	do
+		if test "$(grep "$HEADER_PATTERN" "$line")"
+		then
 			echo "$line"
 			read -r nextline
 			if test -z "$nextline"; then
@@ -23,12 +26,12 @@ check_all_headers_populated() {
 test_expect_success 'creates a report with content in the right places' '
 	git bugreport &&
 	REPORT="$(ls git-bugreport-*)" &&
-	check_all_headers_populated <$REPORT &&
-	rm $REPORT
+	check_all_headers_populated <"$REPORT" &&
+	rm "$REPORT"
 '
 
 test_expect_success 'dies if file with same name as report already exists' '
-	touch git-bugreport-duplicate.txt &&
+	>>git-bugreport-duplicate.txt &&
 	test_must_fail git bugreport --suffix duplicate &&
 	rm git-bugreport-duplicate.txt
 '
@@ -42,7 +45,7 @@ test_expect_success '--output-directory puts the report in the provided dir' '
 
 test_expect_success 'incorrect arguments abort with usage' '
 	test_must_fail git bugreport --false 2>output &&
-	grep usage output &&
+	test_i18ngrep usage output &&
 	test_path_is_missing git-bugreport-*
 '
 
-- 
2.25.0-455-gcf3c3a5ab4

