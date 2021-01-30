Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E087C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 20:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B7D64DDD
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 20:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhA3UVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 15:21:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54572 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhA3UVk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 15:21:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDC3FA2644;
        Sat, 30 Jan 2021 15:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W8hfaj47A8ELQbFGTcnUZmUzuAo=; b=tNyAR4
        B5iKjaAFH4FSUPpQRf/BDTuDlDee+I6G674WLFWUhcC5Mj8wC7eaNAP/YMTX7V8a
        eLvZe4l1b9jF4aVen8pWuhzg6w9Moq9hp4YTuwVwD67X+qfUl1AaEDE+z9qMIIFN
        3VAfqGSJt6yY/q43xWP9kxHMbyz2ttYdku9M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WO9LV/McSFucpuhtjpicMA+TeEqJZOqf
        6a1IiaxxVdY07jRWCmsWercR0CU34IiIz8hjXjvQTEiMAtJjFvfYLlSH63YWB+Jv
        O/0ublQms2SDoicKaN3MowvpIHKpn8bgEvDpUhpv/J7KZkmwXRiexLzc+ippm23Z
        NoJ2xaqbMqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5697A2643;
        Sat, 30 Jan 2021 15:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FD28A2641;
        Sat, 30 Jan 2021 15:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 0/3] Unify trailers formatting logic for pretty.c and
 ref-filter.c
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <xmqqft2jqkli.fsf@gitster.c.googlers.com>
Date:   Sat, 30 Jan 2021 12:20:56 -0800
In-Reply-To: <xmqqft2jqkli.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 29 Jan 2021 17:28:25 -0800")
Message-ID: <xmqq35yip45z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A93AC85C-6338-11EB-97EC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> With this queued directly on top of master, I am getting these
> failures.
>
> t6300-for-each-ref.sh                            (Wstat: 256 Tests: 301 Failed: 6)
>   Failed tests:  277-280, 285, 287
>   Non-zero exit status: 1

Judging from the way the first failure happens, it appears that
some code depends on a kind of shell portability issues?

The failure is under GNU bash, version 5.1.4(1)-release (x86_64-pc-linux-gnu)

Ah, I think I know what is going on.

test_trailer_option() {
	title="$1"
	option="$2"
	expect="$3"
	test_expect_success "$title" '
		echo $expect >expect &&
		git for-each-ref --format="%($option)" refs/heads/main >actual &&
		test_cmp expect actual &&
		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
		test_cmp expect actual
	'
}

Not quoting "$expect" given to 'echo' inside double-quote is
criminal, but I do not think that contributes to this particular
failure.  The problem is in the callers.

test_trailer_option '%(trailers:key=foo) shows that trailer' \
	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'


Doing

	expect='foo\n'
	echo $expect

and expecting that somebody would magically turn \n to a true
newline is the bug.  Not everybody's builtin "echo" works that way.

Here is a quick fix-up.  I didn't check which parts are to be blamed
on which patch of yours, if any, so you might need to split them up
into multiple pieces (i.e. a preliminary clean-up patch, and a patch
each to be applied to part N/3 (1 <= N <= 3) of your patch).


 t/t6300-for-each-ref.sh | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git c/t/t6300-for-each-ref.sh w/t/t6300-for-each-ref.sh
index a8835b1391..0278cb9924 100755
--- c/t/t6300-for-each-ref.sh
+++ w/t/t6300-for-each-ref.sh
@@ -874,7 +874,7 @@ test_trailer_option() {
 	option="$2"
 	expect="$3"
 	test_expect_success "$title" '
-		echo $expect >expect &&
+		echo "$expect" >expect &&
 		git for-each-ref --format="%($option)" refs/heads/main >actual &&
 		test_cmp expect actual &&
 		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
@@ -883,13 +883,18 @@ test_trailer_option() {
 }
 
 test_trailer_option '%(trailers:key=foo) shows that trailer' \
-	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'
+	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>
+'
 test_trailer_option '%(trailers:key=foo) is case insensitive' \
-	'trailers:key=SiGned-oFf-bY' 'Signed-off-by: A U Thor <author@example.com>\n'
+	'trailers:key=SiGned-oFf-bY' 'Signed-off-by: A U Thor <author@example.com>
+'
 test_trailer_option '%(trailers:key=foo:) trailing colon also works' \
-	'trailers:key=Signed-off-by:' 'Signed-off-by: A U Thor <author@example.com>\n'
+	'trailers:key=Signed-off-by:' 'Signed-off-by: A U Thor <author@example.com>
+'
 test_trailer_option '%(trailers:key=foo) multiple keys' \
-	'trailers:key=Reviewed-by:,key=Signed-off-by' 'Reviewed-by: A U Thor <author@example.com>\nSigned-off-by: A U Thor <author@example.com>\n'
+	'trailers:key=Reviewed-by:,key=Signed-off-by' 'Reviewed-by: A U Thor <author@example.com>
+Signed-off-by: A U Thor <author@example.com>
+'
 test_trailer_option '%(trailers:key=nonexistent) becomes empty' \
 	'trailers:key=Shined-off-by:' ''
 
@@ -928,11 +933,14 @@ test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes non
 '
 
 test_trailer_option '%(trailers:key=foo,valueonly) shows only value' \
-	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>\n'
+	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>
+'
 test_trailer_option '%(trailers:separator) changes separator' \
 	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>'
 test_trailer_option '%(trailers:key_value_separator) changes key-value separator' \
-	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>\nSigned-off-by,A U Thor <author@example.com>\n'
+	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>
+Signed-off-by,A U Thor <author@example.com>
+'
 test_trailer_option '%(trailers:separator,key_value_separator) changes both separators' \
 	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>'
 



