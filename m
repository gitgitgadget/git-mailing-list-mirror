Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B6C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357905AbiFNTAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357276AbiFNTAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:00:37 -0400
X-Greylist: delayed 198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 11:56:03 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891210FE4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 11:56:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DA8519EFCA;
        Tue, 14 Jun 2022 14:52:43 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=tVR0IO5db8bliTnN3jhZPGAFo
        NDAIwSi04xknQ2eaPc=; b=ovmfWSu5+5ydN35wzT9YK9talOmmgCWU12LBDhIUT
        42SxgBQYYdwz7yMYRxOIAnajmszLdmB2GaCqVEsNzU3djRoSxMVrZt4C/Y1w5yW+
        7ItH8S6RCMWyN4XEGiLEzJUCqdevGx39grBAUmBd+wOpVXzdITZ7i0vA3+2GAn6l
        xg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25D8319EFC9;
        Tue, 14 Jun 2022 14:52:43 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.teonanacatl.net (unknown [47.204.117.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 339E019EFC8;
        Tue, 14 Jun 2022 14:52:38 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Subject: [PATCH] t3701: update tests fixed with builtin add -p
Date:   Tue, 14 Jun 2022 14:52:18 -0400
Message-Id: <20220614185218.1091413-1-tmz@pobox.com>
X-Mailer: git-send-email 2.37.0.rc0
In-Reply-To: <xmqqwndk10gg.fsf@gitster.g>
References: <xmqqwndk10gg.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 297A55E6-EC13-11EC-B421-C85A9F429DF0-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running the test suite with 2.37.0-rc0, two tests expected to fail now
pass, thanks to the builtin add -p:

    ok 45 - split hunk "add -p (no, yes, edit)" # TODO known breakage van=
ished
    ok 47 - edit, adding lines to the first hunk # TODO known breakage va=
nished
    ...
    # 2 known breakage(s) vanished; please update test(s)

These tests were added in 1bf01040f0 (add -p: demonstrate failure when
running 'edit' after a split, 2015-04-16) and 0f0fba2cc8 (t3701: add a
test for advanced split-hunk editing, 2019-12-06).  In the latter
commit, Johannes said:

    Note that just like the preceding test case, the new test case is *no=
t*
    handled gracefully by the current `git add -p`. It will be handled
    correctly by the upcoming built-in `git add -p`, though.

And it is. :)

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/t3701-add-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 94537a6b40..9a06638704 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -538,7 +538,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
=20
-test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
@@ -562,7 +562,7 @@ test_expect_success 'split hunk with incomplete line =
at end' '
 	test_must_fail git grep --cached before
 '
=20
-test_expect_failure 'edit, adding lines to the first hunk' '
+test_expect_success 'edit, adding lines to the first hunk' '
 	test_write_lines 10 11 20 30 40 50 51 60 >test &&
 	git reset &&
 	tr _ " " >patch <<-EOF &&
