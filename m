Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E262C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBE2082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4pEZQsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfK0TxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39815 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0TxH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id v93so7284060pjb.6
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8oQyuhlgHZAJtCYHSIRwkFMjgd735KXwMjjOYt4/fU=;
        b=W4pEZQsJnKN47HATTruI/xTUbxecFPcUdcsT9UruhO0XXTS8Vmy6kOzujfs30c96Sm
         NxCQaC6vjktcU3gNEaDy1+62Ewl9QkPz55woJNC7MnpHfCSGutqY0yKgh465p+P2AIoP
         z9GnkfwXQvZ9mf5/KDUvpvfYE3xTZFUQc61iaHaCqQovXHojPifWoAvY9LQiA24ashX4
         TQqZfxUbXc+a39rbKldRGDoh3GBJbYHoirSaU/36LXAFBzCWAQ+NvvYhsE7t5TzSuQNM
         ivnu2Xbj3XaGxqpldVkBAzEJOMiH3K4bCoQdYxTFoOInwBDZ2ExsKzBlcGWRh1meIGTL
         rw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8oQyuhlgHZAJtCYHSIRwkFMjgd735KXwMjjOYt4/fU=;
        b=TJbuD+z+1en7uHmG0Dfi7k4iXmsaDbgdY0rUO7mW5khSGf3E370Pyf2NxyYJOxRwv7
         2u4svKOxWQK8Ri3VhWfVkqvzFT0b7Rb8zUilhy0ZGqUzI34dGtODg5lsVohTNHgoB86r
         UiRhr4vMK/eXSPanLIFcz6j5EZ8tuoM2zZsBqnH+jYH87jsDrwITW+X/yJzq2GlPU865
         lMjND3Se337fowuucc7rYbZ8ozXC21rUug+ZaD4M9bElWdI1OGEJzaH5d/fZUd0h8Vht
         f3H3yDPtMTfa70VLBZwdZM0vRlgjeAhaeROvPScqL9fsXUE4eczPaVPWnEpgwv+GX18k
         Jllw==
X-Gm-Message-State: APjAAAXvfQqy7GCM6BnmlK3sRw9gai9BunPdQIbCM2fQBatJVTvnFV7Q
        qa3egG3ZSjGEI+tItYlD1h61UNfA
X-Google-Smtp-Source: APXvYqyUSooxvdq/2XFY6WCSIZtjmMTlPjpM8FewHWTLL2QT2RYWT1N7PSPAQBGg5jiKRo+2ZyfqqA==
X-Received: by 2002:a17:902:860a:: with SMTP id f10mr3845825plo.326.1574884386056;
        Wed, 27 Nov 2019 11:53:06 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id j126sm18339934pfg.4.2019.11.27.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:05 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 01/26] lib-bash.sh: move `then` onto its own line
Message-ID: <9085cc00af10408d9425cfdff5a8b2c49008ae7b.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

