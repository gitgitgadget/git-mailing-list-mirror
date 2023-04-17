Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62639C77B7C
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDQJfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDQJfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:35:33 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFCE4205
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:34:50 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:33:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724030; x=1681983230;
        bh=c6CW5zlosP9UlTEEz1g9iqvpzkXVpHPsYU4nYoTaiZM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aLIWi5uxXcS3Ooq5Tgs1ElWAEBXVqK+v7DlYe2Fl7eFgb08I2FECsillqA1sQ7kQy
         zp09UWEK+0KswXoNZafMNEqig+/4EFqKtEXGwAjEbvEfn5K6qVftU1WCvbzpkIBOFu
         QG8FfEDh84K7i6L4bNoywBaZq84Ioa/0JSHY9DtP0wAt1yqp4FayKQaE+GxQ5c4OQB
         b5lcApqOnHFrXDoIcHo8AeaoqDI7z/DpS0X98Y9oJqljpiJTWvvJc5+8vIuTJ/Ea2I
         qKh9nDHashe64UocKXhY0srtJRoXq4pGrUQrh6RJ4OGXisp7v9wZzBdrHyjx27vSyT
         zy+H9XBU19FJQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 2/8] t2400: print captured git output when finished
Message-ID: <20230417093255.31079-3-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update tests that capture stderr so that at the end of the test they
print the captured text back out to stderr. This simplifies debugging
when inspecting test logs after executing with `-x`.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..9bc3db20e4 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -326,6 +326,8 @@ test_expect_success 'add -B' '
 '

 test_expect_success 'add --quiet' '
+=09test_when_finished "git worktree remove -f -f another-worktree" &&
+=09test_when_finished cat actual >&2 &&
 =09git worktree add --quiet another-worktree main 2>actual &&
 =09test_must_be_empty actual
 '
--
2.39.2


