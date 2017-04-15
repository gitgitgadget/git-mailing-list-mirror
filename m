Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6AD20D09
	for <e@80x24.org>; Sat, 15 Apr 2017 08:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbdDOIHT (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 04:07:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61981 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751839AbdDOIHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 04:07:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D2F479521;
        Sat, 15 Apr 2017 04:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JOq5uc1ejy82
        J4J+Ubq5AOe/Yjg=; b=BLus8L0+/RXL4cFJ7F8VlZxei8vjf4AhUCLPmYWnDBjL
        zFMaE1Smh0bdYg1xLlWXDQQQCax4Kl3wS/ogYj5FIWpvYKVAZZi+XCPFivoQ4Lhu
        Vtt1evJV1eF1ON3OJl4ixwrJVWw+n+scHDnUT4TBsal2iTsfzEvefjU/iCnOAZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JM4Cv2
        ZnXuhWW6NlYDrzquay8lJgQZc6ZwRvdfbtsdwa/GRXJ40vnEwDMGbNb4EFn6eaFi
        Ho2+sATyxZ0eqsLSKXztlSQw3t69xMFJvSJWnVy7e96eg7fibjG0EEs3FDrr3kVO
        ++4GJV1EOClHcpdTKj+gPpRHBcc56lM7N9MoY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9583779520;
        Sat, 15 Apr 2017 04:07:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 075F57951F;
        Sat, 15 Apr 2017 04:07:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, David.Taylor@dell.com
Subject: Re: [PATCH] worktree add: add --lock option
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
        <20170412135805.29837-1-pclouds@gmail.com>
        <xmqqzifim8co.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 15 Apr 2017 01:07:13 -0700
In-Reply-To: <xmqqzifim8co.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 15 Apr 2017 00:35:19 -0700")
Message-ID: <xmqqmvbim6vi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88C29512-21B2-11E7-AAC6-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> -	unlink_or_warn(sb.buf);
>> +	if (!ret && opts->keep_locked) {
>> +		/*
>> +		 * Don't keep the confusing "initializing" message
>> +		 * after it's already over.
>> +		 */
>> +		truncate(sb.buf, 0);
>> +	} else {
>> +		unlink_or_warn(sb.buf);
>> +	}
>
> builtin/worktree.c: In function 'add_worktree':
> builtin/worktree.c:314:11: error: ignoring return value of 'truncate', =
declared with attribute warn_unused_result [-Werror=3Dunused-result]
>    truncate(sb.buf, 0);
>            ^
> cc1: all warnings being treated as errors
> make: *** [builtin/worktree.o] Error 1

I wonder why we need to have "initializing" and then remove the
string.  Wouldn't it be simpler to do something like this instead?
Does an empty lockfile have some special meaning?

 builtin/worktree.c      | 16 +++++++---------
 t/t2025-worktree-add.sh |  3 +--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3dab07c829..5ebdcce793 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -243,7 +243,10 @@ static int add_worktree(const char *path, const char=
 *refname,
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	write_file(sb.buf, "initializing");
+	if (!opts->keep_locked)
+		write_file(sb.buf, "initializing");
+	else
+		write_file(sb.buf, "added with --lock");
=20
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -306,15 +309,10 @@ static int add_worktree(const char *path, const cha=
r *refname,
 done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	if (!ret && opts->keep_locked) {
-		/*
-		 * Don't keep the confusing "initializing" message
-		 * after it's already over.
-		 */
-		truncate(sb.buf, 0);
-	} else {
+	if (!ret && opts->keep_locked)
+		;
+	else
 		unlink_or_warn(sb.buf);
-	}
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 6dce920c03..304f25fcd1 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -65,8 +65,7 @@ test_expect_success '"add" worktree' '
=20
 test_expect_success '"add" worktree with lock' '
 	git rev-parse HEAD >expect &&
-	git worktree add --detach --lock here-with-lock master &&
-	test_must_be_empty .git/worktrees/here-with-lock/locked
+	git worktree add --detach --lock here-with-lock master
 '
=20
 test_expect_success '"add" worktree from a subdir' '
