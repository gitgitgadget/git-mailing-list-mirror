Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F08EC43219
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 00:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D0A60F6B
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 00:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhIJAsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 20:48:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56052 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhIJAqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 20:46:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A4B3E10BD;
        Thu,  9 Sep 2021 20:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mk2mgPFCuTXp
        6fhFn8GLFJ6WSex8kalNz7av6BnI6Io=; b=OTJaBYoH7SN5Xdy8gfyGa/Gj6YHJ
        dCTY6HFH3ZrI6AlxXKNkR37gjPu8DKwPWYFMy8xKV/lGiiQ5ZEEAKUnX4oZX5M2p
        ovcZMCadCaMqSzxLmfLoAKZNt/vAt3iv08UhfRArhWC6grgEfN5+J2fi+iz2peAD
        bKYZkqTK67bfzgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A90B6E10BA;
        Thu,  9 Sep 2021 20:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02CF1E10B9;
        Thu,  9 Sep 2021 20:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] refs/files-backend: remove unused open mode parameter
References: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de>
Date:   Thu, 09 Sep 2021 17:45:00 -0700
In-Reply-To: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 9 Sep 2021 23:45:51 +0200")
Message-ID: <xmqqee9xw96b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 551EDC58-11D0-11EC-8AFB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> We only need to provide a mode if we are willing to let open(2) create
> the file, which is not the case here, so drop the unnecessary parameter=
.

Obviously correct.

$ git grep -e 'open.*0[0-7][0-7][0-7]' seen \*.c | grep -v CREAT

gives this one and another from reftable.

-- >8 --
Subject: [PATCH] fixup! reftable: implement stack, a mutable database of =
reftable files.

To be squashed into the said commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 48e22a6c18..df5021ebf0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -107,7 +107,7 @@ static int fd_read_lines(int fd, char ***namesp)
=20
 int read_lines(const char *filename, char ***namesp)
 {
-	int fd =3D open(filename, O_RDONLY, 0644);
+	int fd =3D open(filename, O_RDONLY);
 	int err =3D 0;
 	if (fd < 0) {
 		if (errno =3D=3D ENOENT) {
--=20
2.33.0-484-g4fa4683b52



