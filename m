Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59109C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 23:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB0XXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB0XXs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 18:23:48 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E03E166F6
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 15:23:47 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31RNNFbm1085664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 23:23:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
References: <003d01d94b00$16abc7a0$440356e0$@nexbridge.com> <xmqqv8jmr98f.fsf@gitster.g>
In-Reply-To: <xmqqv8jmr98f.fsf@gitster.g>
Subject: RE: Problems with CSPRNG in wrapper.c
Date:   Mon, 27 Feb 2023 18:23:36 -0500
Organization: Nexbridge Inc.
Message-ID: <003e01d94b02$877c2c20$96748460$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGBLd+J4rsGAdm8C27f2wNf7SMANAMTgfZsr3sLt8A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, February 27, 2023 6:15 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> First, I was not aware that csprng was a git dependency ...
>
>You can choose from implementations that depend on common external
libraries
>and system functions, but we have a fallback internal implementation that
only
>requires /dev/urandom.
>
>See description for CSPRNG_METHOD in Makefile and 05cd988d (wrapper:
>add a helper to generate numbers from a CSPRNG, 2022-01-17) for additional
>background.

I have already been down that path, but not successfully. /dev/urandom is
not available on the platform - never has, never will to my knowledge. This
does appear to work if PRNGD is correctly running, but I can't seem to get
that to work on this site. The config.mak.uname for NonStop does specify:

CSPRNG_METHOD = openssl

which should use OPENSSL_random(), shouldn't it? OpenSSL 3.0 uses the
_rdrand() builtin so should ever go to PRNGD, but it seems like this is
anyway. Debugging isn't possible as this is not on my own systems - and
things work here. Is there any kind of tracing I can do?

