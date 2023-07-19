Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B035C0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 14:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGSOw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjGSOwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 10:52:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC29F10FE
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 07:52:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7A61FD69;
        Wed, 19 Jul 2023 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689778367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NoKd1L9pNKcqOGxuMYzoPZJQBa6tCAFp1XFnP4/6dw=;
        b=gk68rBCWlPCXKgvN03dlwWVbUWc65cPbiCkZyQiBUmOts4OVCTo6hJYZCztJ3c5mTHPqAJ
        e44EBoNQE7xt2wt5qV67/6QoL7zoutvfwqz4D1vrOihcTzLeY3kwSC2EuGVr9vdS8zxlhm
        QNfL/ZQZuiD6+/hSd8rFaQ4udtVb+EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689778367;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NoKd1L9pNKcqOGxuMYzoPZJQBa6tCAFp1XFnP4/6dw=;
        b=feGP0+1Ke//CuLId9TZ76gnNNWSEUeZvbQrdSPgk+riTwwyvqLNM04y7nh5acHi/45/7AV
        txx8HYc3D75olIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68FA413460;
        Wed, 19 Jul 2023 14:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OHElGL/4t2TBVQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Wed, 19 Jul 2023 14:52:47 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     git@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] configure.ac: don't overwrite NO_EXPAT option
Date:   Wed, 19 Jul 2023 16:29:54 +0200
Message-ID: <20230719145211.17854-4-aherrmann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719145211.17854-2-aherrmann@suse.de>
References: <20230719145211.17854-2-aherrmann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if 'configure --with-expat=no' was run, expat support is used,
because library detection overwrites it. Avoid this overwrite.
Configure should obey what the user has specified.

Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index 38ff86678a..62cc8197f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -581,6 +581,8 @@ fi
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 
+if test -z "$NO_EXPAT"; then
+
 GIT_STASH_FLAGS($EXPATDIR)
 
 AC_CHECK_LIB([expat], [XML_ParserCreate],
@@ -589,6 +591,8 @@ AC_CHECK_LIB([expat], [XML_ParserCreate],
 
 GIT_UNSTASH_FLAGS($EXPATDIR)
 
+fi
+
 GIT_CONF_SUBST([NO_EXPAT])
 
 #
-- 
2.41.0

