Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5144A1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 17:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938455AbcLTRI0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 12:08:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S937351AbcLTRHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 12:07:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92F6D576F2;
        Tue, 20 Dec 2016 12:07:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O+0OiZgLHiXJF1AOrs8U5m8GJ7Y=; b=OfOS/f
        ZjIiabFRzkVugnibdj4ARgS2txXJW07z3jhy4kkB8ksqH4ghV39khvllRKJzFA8V
        IbBDOw2PgjF0c328X53gQmtFEVcalQO22RW4oIfTls8M9j3Pq78KZI+ivJUWNeVT
        c+oR/SklyZlQOSZF5cguETEk0uBv1B9Qz6ug8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NBypSDFlVHfmMNsvNqVX47AvPw5BEFGp
        951iKIOFc3K4RW6v2aib+snqWcqkM4VTH6f8TCchCK09AKSJWCAllyH0HlG5xTzJ
        im5EmH5d/PO0PGLNj/CVjQ7LXEHL35Nw7zABi/ky0jENX88z4M3ujCDAH32+Ea7X
        w1HqryWhSpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B902576F0;
        Tue, 20 Dec 2016 12:07:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 116D8576EF;
        Tue, 20 Dec 2016 12:07:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Max Kirillov <max@max630.net>, Karsten Blees <blees@dcon.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: consider that UNICODE_STRING::Length counts bytes
References: <1482183120-21592-1-git-send-email-max@max630.net>
        <alpine.DEB.2.20.1612201610270.54750@virtualbox>
Date:   Tue, 20 Dec 2016 09:07:19 -0800
In-Reply-To: <alpine.DEB.2.20.1612201610270.54750@virtualbox> (Johannes
        Schindelin's message of "Tue, 20 Dec 2016 16:16:02 +0100 (CET)")
Message-ID: <xmqqpokmlebc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4F27FF2-C6D6-11E6-9BAB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Max,
>
> On Mon, 19 Dec 2016, Max Kirillov wrote:
>
>> UNICODE_STRING::Length field means size of buffer in bytes[1], despite
>> of buffer itself being array of wchar_t. Because of that terminating
>> zero is placed twice as far. Fix it.
>
> This commit message needs to be wrapped at <= 76 columns per row.
> ...
> Very good, thank you for fixing my mistake! I verified locally that it
> does exactly the right thing with your patch.

Thanks, both.  I'll queue this like so.

-- >8 --
From: Max Kirillov <max@max630.net>
Date: Mon, 19 Dec 2016 23:32:00 +0200
Subject: [PATCH] mingw: consider that UNICODE_STRING::Length counts bytes

UNICODE_STRING::Length field means size of buffer in bytes[1],
despite of buffer itself being array of wchar_t. Because of that
terminating zero is placed twice as far. Fix it.

[1] https://msdn.microsoft.com/en-us/library/windows/desktop/aa380518.aspx

Signed-off-by: Max Kirillov <max@max630.net>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3be60ce1c6..6b4f736fdc 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -553,7 +553,7 @@ static void detect_msys_tty(int fd)
 			buffer, sizeof(buffer) - 2, &result)))
 		return;
 	name = nameinfo->Name.Buffer;
-	name[nameinfo->Name.Length] = 0;
+	name[nameinfo->Name.Length / sizeof(*name)] = 0;
 
 	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
 	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))

base-commit: f7f90e0f4f58d493242078d17c0eba41dd3f1f79
-- 
2.11.0-416-g1351c11cce

