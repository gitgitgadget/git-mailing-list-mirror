Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1FC7EE22
	for <git@archiver.kernel.org>; Tue, 16 May 2023 02:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjEPC24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 22:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPC2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 22:28:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC085B89
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:28:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D98871F95FB;
        Mon, 15 May 2023 22:26:49 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=Xxz1bYHuHuMTH+ZmwocRTxXN2b6AJ1An8De27xfphKs=; b=KN+0
        cuSjg3yedRtGiMwQot64PFS8FD029gOXKRucjqbJ72aW11eCposHvnVAzqMx5d6q
        Jf8AxBsQT2bG0XExiTJG+9H551Uj9wYVxNRvN6JW5t7g/r4TLy+qOFKTqTFX9+7L
        67NRpW7ul3mkNnyp87j336t0rCwGa7YpZ5UD23c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D41791F95FA;
        Mon, 15 May 2023 22:26:49 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0CBF91F95F7;
        Mon, 15 May 2023 22:26:47 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] fix use of "! test_path_is_foo" in tests
Date:   Mon, 15 May 2023 19:26:43 -0700
Message-ID: <20230516022646.648123-1-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-rc0
MIME-Version: 1.0
X-Pobox-Relay-ID: 1B35E9B0-F391-11ED-8C35-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During recent review of a topic, I noticed that there are a handful
of places where we misuse test_path_is_{file,directory} test helper
functions.  They are designed to be silent when the given path is
of the expected type, so

	! test_path_is_file foo

when you do not want 'foo' to be a file, while making the test pass,
does not help debugging when things go wrong.

These small patches touch the places where

	$ git grep -e '! test_path_' t/

shows hits, except for test_path_is_hidden that shares the same name
pattern but is not designed to help debugging like others.

Junio C Hamano (3):
  tests: do not negate test_path_exists
  t2021: do not negate test_path_is_dir
  test: do not negate test_path_is_* to assert absense

 t/lib-submodule-update.sh     | 2 +-
 t/t2021-checkout-overwrite.sh | 2 +-
 t/t4067-diff-partial-clone.sh | 4 ++--
 t/t4115-apply-symlink.sh      | 2 +-
 t/t5572-pull-submodule.sh     | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

--=20
2.41.0-rc0

