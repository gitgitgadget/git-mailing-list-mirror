Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7FC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4727420736
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uiKk6uGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHQ3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:29:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54080 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHQ3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:29:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF655B763;
        Fri,  8 May 2020 12:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i3mDjWWlme2V7ldwXHUb+AYaFt8=; b=uiKk6u
        GvAWnDwtLoMlQ6/5AmPs/8VIUhKJSrHlWOhrG8QbMYffZGEm+r1p2Yt+BBQ6Iue0
        TMvx5U63NXjwQEFuEeRkwWwfQW0Og4mYF4/NJQudcCICYjvkf8Ena2n1Rpgdby6T
        Ecdz/swNU+bMYN1bPcyWuc5q5LzKL+bhTPMok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D65lHWZxBHDcIVmoUdyBbPKdSdRcmJAI
        u4/f4VwHbhjP4HwwZvVu+9TfUwDfCI6NAWWW2i5vjuPw9WgHST474THn16//H/bJ
        rR1jRTimeJQmw6PfD19QxFIoxs9RHPj9YsbBtjarxOJFv8OuxmjQD6K4zNVdGJBp
        m2IZymo7gNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BFAD5B762;
        Fri,  8 May 2020 12:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BC8E5B761;
        Fri,  8 May 2020 12:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
        <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
        <20200508130831.GB631018@coredump.intra.peff.net>
        <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
Date:   Fri, 08 May 2020 09:28:56 -0700
In-Reply-To: <xmqqh7wq1n52.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 08 May 2020 08:07:05 -0700")
Message-ID: <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03CD39CA-9149-11EA-847C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if we can add a CR to IFS so that the parsing logic of each
> line would not even see it?

So I got curious and tried this; it seems to pass Christopher's test
(corrected with Eric's suggestion).

As the implementation changed, I ended up rewriting some parts of
the log message originally proposed and here is what I tentatively
queued.

-- >8 --
From: Christopher Warrington <chwarr@microsoft.com>
Subject: [PATCH] bisect: allow CRLF line endings in "git bisect replay" input

We advertise that the bisect log can be corrected in your editor
before being fed to "git bisect replay", but some editors may
turn the line endings to CRLF.

Update the parser of the input lines so that the CR at the end of
the line gets ignored.

Were anyone to intentionally be using terms/revs with embedded CRs,
replaying such bisects will no longer work with this change. I suspect
that this is incredibly rare.

Signed-off-by: Christopher Warrington <chwarr@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh               | 2 ++
 t/t6030-bisect-porcelain.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..56548d4be7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -209,6 +209,7 @@ bisect_replay () {
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
 	git bisect--helper --bisect-reset || exit
+	oIFS="$IFS" IFS="$IFS:$(printf '\015')"
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
@@ -232,6 +233,7 @@ bisect_replay () {
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$file"
+	IFS="$oIFS"
 	bisect_auto_next
 }
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 821a0c88cf..bb84c8a411 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -792,6 +792,13 @@ test_expect_success 'bisect replay with old and new' '
 	git bisect reset
 '
 
+test_expect_success 'bisect replay with CRLF log' '
+	append_cr <log_to_replay.txt >log_to_replay_crlf.txt &&
+	git bisect replay log_to_replay_crlf.txt >bisect_result_crlf &&
+	grep "$HASH2 is the first new commit" bisect_result_crlf &&
+	git bisect reset
+'
+
 test_expect_success 'bisect cannot mix old/new and good/bad' '
 	git bisect start &&
 	git bisect bad $HASH4 &&
-- 
2.26.2-561-g07d8ea56f2

