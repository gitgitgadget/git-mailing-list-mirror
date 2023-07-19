Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7ADC0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGSOx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGSOxV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 10:53:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B760C7
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 07:53:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D0B71FD69;
        Wed, 19 Jul 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689778399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGlndJCvFWwe1fQ9fqasC2V56/Xq51rjnmWSZHMXP9E=;
        b=TwaNjjm8jaKBkp55FbYbcgdw8Zi7ZL9HYxwq5+FoP3DznWkE8hgrn3BIujWu0NQWTfl6n/
        w+4lX3RjflG6vs4G2cedDsfRaN5DgcSdSEe5pZjnVH4DLcn1zhsE0MlSG60472t7/Bq391
        OgpmeMqUhiuMJBhdvvTopqBrFQVq4So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689778399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGlndJCvFWwe1fQ9fqasC2V56/Xq51rjnmWSZHMXP9E=;
        b=6La2xB1UVWpOiKPaUta0dw+ymg7jxrTcfJ5wdxg6JV668Cx4Ibaqhc5rhvTmS47h2D+HtS
        bcUGfTTU6CH8voBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39D3313460;
        Wed, 19 Jul 2023 14:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4POmDN/4t2TBVQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Wed, 19 Jul 2023 14:53:19 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     git@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] configure.ac: always save NO_ICONV to config.status
Date:   Wed, 19 Jul 2023 16:29:58 +0200
Message-ID: <20230719145211.17854-8-aherrmann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719145211.17854-2-aherrmann@suse.de>
References: <20230719145211.17854-2-aherrmann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case 'configure --with-iconv=no' is used, NO_ICONV is not saved to
config.status and thus git is built with iconv support.

Always save NO_ICONV to config.status to honor what user selected
during configure step.

Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index e85e215f14..276593cd9d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -644,7 +644,6 @@ LIBS="$old_LIBS"
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
 GIT_CONF_SUBST([NEEDS_LIBICONV])
-GIT_CONF_SUBST([NO_ICONV])
 
 if test -n "$NO_ICONV"; then
     NEEDS_LIBICONV=
@@ -652,6 +651,8 @@ fi
 
 fi
 
+GIT_CONF_SUBST([NO_ICONV])
+
 #
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.
 
-- 
2.41.0

