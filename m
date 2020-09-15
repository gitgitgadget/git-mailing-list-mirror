Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C81C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2CA2078E
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+hG46/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgIOVYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:24:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55432 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgIOVYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:24:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0492DC87A;
        Tue, 15 Sep 2020 17:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UMSc2+k8qubQ2gCVouuEeIGcyw4=; b=H+hG46
        /3SAbeu7K3MnW02/g9wRjizGeuNDmTgBs5M75ZZE+o8gYeqJBFwE6N+AKe5QB85u
        yBBrRXChX6kb4B3nAUd3isZPMDlSbkEBxKRfzowtLf/2qqdJ183wlghODWL84r1w
        sPyWANgK7S3SE37FRP9I+WhxWAySdo4hLJ7bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ETwQBDRaGNOGob6Jjnl+Ha8hkVyikN38
        oOLMgfZwIQeROm3IbgjzRaJ0Sp0mLahT8XDGVcFoQ7h5G2nMBwgn8mJ18Ai9UHBR
        wvx7NyfLckT4MGBzKC3PDnTicGwudQIxO2QkqCbno5GuV+3oZ2qgHnmPIA89fMx9
        t5Fh390Axek=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8775DC879;
        Tue, 15 Sep 2020 17:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 373ACDC875;
        Tue, 15 Sep 2020 17:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Pass --ipv4 and --ipv6 options to sub-fetches when
 fetching multiple remotes and submodules
References: <20200915115407.GA31786@pflmari>
Date:   Tue, 15 Sep 2020 14:19:11 -0700
In-Reply-To: <20200915115407.GA31786@pflmari> (Alex Riesen's message of "Tue,
        15 Sep 2020 13:54:07 +0200")
Message-ID: <xmqqeen2zqk0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A5A96EA-F799-11EA-9AB2-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> The options indicate user intent for the whole fetch operation, and
> ignoring them in sub-fetches is quite unexpected when, for instance,
> it is intended to limit all of the communication to a specific transport
> protocol for some reason.
>
> Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> ---

To avoid an overlong title and conform to project convention (aka
"easier to read 'git shortlog --no-merges' output), I shortened the
title and tweaked the text a bit to compensate for the change.

Thanks.


-- >8 --
From: Alex Riesen <alexander.riesen@cetitec.com>
Date: Tue, 15 Sep 2020 13:54:07 +0200
Subject: [PATCH] fetch: pass --ipv4 and --ipv6 options to sub-fetches

The options indicate user intent for the whole fetch operation, and
ignoring them in sub-fetches (i.e. "--all" and recursive fetching of
submodules) is quite unexpected when, for instance, it is intended
to limit all of the communication to a specific transport protocol
for some reason.

Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82ac4be8a5..447d28ac29 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1531,6 +1531,10 @@ static void add_options_to_argv(struct argv_array *argv)
 		argv_array_push(argv, "-v");
 	else if (verbosity < 0)
 		argv_array_push(argv, "-q");
+	if (family == TRANSPORT_FAMILY_IPV4)
+		argv_array_push(argv, "--ipv4");
+	else if (family == TRANSPORT_FAMILY_IPV6)
+		argv_array_push(argv, "--ipv6");
 
 }
 
-- 
2.28.0-618-g53f972bf7d

