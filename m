Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602DC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjEPRYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPRY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:24:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC50FC
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:24:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A34DE1F8053;
        Tue, 16 May 2023 13:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uu5UZaETVkp5xMuTg5XMmtX1nVdsmeLkCV03bH
        t+ByA=; b=lWohbAG7fyTndFYWYbG+iAzimA1myQ/MVSSzLXDVLMAt1vW5cibO6P
        zEHgGHpFkgZ5dgt1xDq+ILa1TIVk+sTPWvXjddRgOHz6AxbbCA2A6Yca0SxqEzA0
        bxmHn3UK+WDMVMHp5DPcJU5uTZtBBEJozOVZ2qfXIoYSGMU1fs5qg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BE9E1F8052;
        Tue, 16 May 2023 13:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA7291F8051;
        Tue, 16 May 2023 13:24:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] run-command.c: need alloc.h for our own at-exit handler
 emulation
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
        <ZGO4LesPe4A2ftdm@nand.local> <xmqqlehourbf.fsf@gitster.g>
Date:   Tue, 16 May 2023 10:24:24 -0700
In-Reply-To: <xmqqlehourbf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        16 May 2023 10:19:48 -0700")
Message-ID: <xmqqh6scur3r.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 818B3AEE-F40E-11ED-A671-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent header file shuffling missed this old user of ALLOC_GROW()
that was inside "#ifdef NO_PTHREADS' section and forgot to include
the new file, alloc.h, that defines the macro.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 run-command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git c/run-command.c w/run-command.c
index d4247d5fcc..1affea48af 100644
--- c/run-command.c
+++ w/run-command.c
@@ -1073,6 +1073,7 @@ static void NORETURN async_exit(int code)
 }
 
 #else
+#include <alloc.h>
 
 static struct {
 	void (**handlers)(void);
