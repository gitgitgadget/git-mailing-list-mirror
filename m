Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF6AEB64DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 07:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjGMHqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGMHqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 03:46:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286892102
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 00:46:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6DEF1F45E;
        Thu, 13 Jul 2023 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689234407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CZvYmc+7pEyB+WVkDFEr8CAXsgIBpVVXFSDNiecdsgA=;
        b=JagvMdmzxUi51JZdlgPkdh62kNibTcpTyQ30k1ULTGJmRdkvaLd9gKne3gnCR15CDw9PM1
        +9ZvCV8498nOMv2iGr6xqaFq+m3+GYmrFIy1ILKTeZxkeLCgN26f2Z5+cglqkQygWWsBqo
        WRucgsROx0wQFwuc3tUQz9298nMK13g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689234407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CZvYmc+7pEyB+WVkDFEr8CAXsgIBpVVXFSDNiecdsgA=;
        b=B+/ZXh8V+MCWAbACwkqwD8kRHA2IRJdZE3gLcnbcG1I65Zh1y0WlDxs+yiV6IMblCniOOY
        F9mv/aIoM6usLdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6E23133D6;
        Thu, 13 Jul 2023 07:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BYJfJ+err2RRFwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 13 Jul 2023 07:46:47 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     git@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH] configure.ac: Don't overwrite NO_EXPAT option
Date:   Thu, 13 Jul 2023 09:45:41 +0200
Message-ID: <20230713074654.23957-1-aherrmann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if 'configure --with-expat=no' was run, expat support is used,
because library detection overwrites it. Avoid this overwrite.
(I think, configure should obey what the user has specified.)

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

