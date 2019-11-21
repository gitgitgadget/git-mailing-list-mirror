Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421A0C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1781920878
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2iZQH/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKUApx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:45:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33356 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUApx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:45:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id h27so657021pgn.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1lmW8L2FvS8F96eNc7Bhmh/D/maivNejXnyb1anGiKU=;
        b=l2iZQH/ooLek5A7LidTN8DgxwZpoZqN21+ZV8m3hMbIj5S5dTKIc+t4EaV5WPBr5b/
         5yN4VDrEfvdj1GaMpDBVuldKuiM72N70V/1GxTnLXr+rPv7EUy41MFOZndUBfoctftIV
         rOFnokEZbcuts/rO75JWZcPgHvPhfHg/+RsjV8xm/gPAN2p86bopnWm2Z/PJa4dVzIs1
         VnOmHABQ79T86i1W9DdrA8cS51d8MHqX956b04bdl4H+u6aaqq0Mngl0I/lZ3R6EjIJZ
         1VFaoouB7TLXykrshIYrIHCw4nR+YPKMVQNIVoAFFrG+CldzI3+hwclnSTygLwrn+TmL
         7jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1lmW8L2FvS8F96eNc7Bhmh/D/maivNejXnyb1anGiKU=;
        b=dSFY/s7AoPSp1/BkOxcSzBdY8mp7CKzFjWfh0bCKwYRy9/PuKXURiCElJwW9Y0xwdz
         nRuVdF9tfqUJlFQ/L0rAXPgu+JbooeEq/NwTlTOAoTHcm5Y5az5kxV2/7oQP9ddBZSAw
         gEIXqADIvvD+zpntAOZXZqd6vdyqiOlVD+WhpYtW8SIOsxkzssRcRl2XqF7buawZi1L+
         +UIepttbb6MaTYwkIdy6tHAGCCjG71NHpnh/hSbiRIEoQJbsn7LDyAByDniysszgZyi0
         sAD2iLoVDg87Iw8psH25PHk3vrpBUXO+P+L5FTqw3xTu4DMxxuYjkNuad4Z30rpAraRq
         3taQ==
X-Gm-Message-State: APjAAAUlCWXbdVusRGtRbFtDWuQZ4OhQPAgOt9dH1B1YHHcJoOmX3hWK
        n/TdNFwUAbGVjEgwQw9u4f2v6SVo
X-Google-Smtp-Source: APXvYqyUsVoX9CJ1JjaGz6yL2u6Se9QetSa0gT+EIkNFIirNTahbUEGt1/CoRV/EvbTt74ZCbhINbw==
X-Received: by 2002:aa7:9d8b:: with SMTP id f11mr7421665pfq.20.1574297150749;
        Wed, 20 Nov 2019 16:45:50 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a25sm600130pff.50.2019.11.20.16.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:45:49 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:45:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 01/21] lib-bash.sh: move `then` onto its own line
Message-ID: <da6ff639186c6e1ece4e3a69576f61e03ec3bb7f.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code style for tests is to have statements on their own line if
possible. Move the `then` onto its own line so that it conforms with the
test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-bash.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 2be955fafb..b0b6060929 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -2,10 +2,12 @@
 # to run under Bash; primarily intended for tests of the completion
 # script.
 
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+then
 	# we are in full-on bash mode
 	true
-elif type bash >/dev/null 2>&1; then
+elif type bash >/dev/null 2>&1
+then
 	# execute in full-on bash mode
 	unset POSIXLY_CORRECT
 	exec bash "$0" "$@"
-- 
2.24.0.450.g7a9a4598a9

