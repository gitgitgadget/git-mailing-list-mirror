Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F195C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 00:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356394AbiD0A2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbiD0A2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 20:28:36 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A33389B
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 17:25:24 -0700 (PDT)
Received: (Authenticated sender: mitchr@mitchr.dev)
        by mail.gandi.net (Postfix) with ESMTPSA id A415920002;
        Wed, 27 Apr 2022 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mitchr.dev; s=gm1;
        t=1651019123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qRhVj2wsjeta/+ebFQ1Yq18P4Gi3VnDn/iB77pAS+Eg=;
        b=hZQ0Ci9Yxe2aD8nDnM2Pq20z/ItMAXAkjyjYthqZle+eIqEZXbpDRcy3F+uA0oZ1f4Hb7f
        lPjGIVxvRXPIVqdNdPYtF2gzaa84mWRh/XXXkrroqwj0is04FlzoIOUVLDqnsgBrqyJizU
        CRs1Br0l/tCXdx1yiSNVtBler5NW+cRBx//oQuuO399g9i42wASA3kFKwiapBq7nFAG0At
        Neb+YqaaTi7jqOu93DBXFVhzHIm/P5wCOaKr/9pvS1OdfgrKL8+0GRksUgTJ6Dm4ocngVv
        e3BZkdV14BR6+j79JK3gJVcn7zfb23+tgo/ERAQc/MFMYbXdjZZGHUNVv6Us1Q==
From:   mitchr <mitchr@mitchr.dev>
To:     git@vger.kernel.org
Cc:     Mitchell Riley <mitchr@mitchr.dev>
Subject: [PATCH] git-gui: Indicate cursor position in commit buffer
Date:   Tue, 26 Apr 2022 20:25:20 -0400
Message-Id: <20220427002520.99115-1-mitchr@mitchr.dev>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mitchell Riley <mitchr@mitchr.dev>

Add a visual indicator for both the line and column position of the 
cursor to the bottom right of the commit buffer.

Signed-off-by: Mitchell Riley <mitchr@mitchr.dev>

---
 git-gui.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 201524c..a0cdf5c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3411,8 +3411,10 @@ if {![is_enabled nocommit]} {
 #
 ${NS}::frame .vpane.lower.commarea.buffer
 ${NS}::frame .vpane.lower.commarea.buffer.header
+${NS}::frame .vpane.lower.commarea.buffer.footer
 set ui_comm .vpane.lower.commarea.buffer.frame.t
 set ui_coml .vpane.lower.commarea.buffer.header.l
+set ui_comm_pos .vpane.lower.commarea.buffer.footer
 
 if {![is_enabled nocommit]} {
 	${NS}::checkbutton .vpane.lower.commarea.buffer.header.amend \
@@ -3465,10 +3467,23 @@ ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
 	-orient vertical \
 	-command [list $ui_comm yview]
 
+set line 0
+set col 0
+${NS}::label $ui_comm_pos.ll -text "Ln "
+${NS}::label $ui_comm_pos.lb -textvariable line
+${NS}::label $ui_comm_pos.cl -text ", Col "
+${NS}::label $ui_comm_pos.cb -textvariable col
+bind $ui_comm <KeyRelease> {lassign [split [$ui_comm index insert] "."] line col}
+pack $ui_comm_pos.cb -side right
+pack $ui_comm_pos.cl -side right
+pack $ui_comm_pos.lb -side right
+pack $ui_comm_pos.ll -side right
+
 pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
 pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
 pack $ui_comm -side left -fill y
 pack .vpane.lower.commarea.buffer.header -side top -fill x
+pack .vpane.lower.commarea.buffer.footer -side bottom -fill x
 pack .vpane.lower.commarea.buffer.frame -side left -fill y
 pack .vpane.lower.commarea.buffer -side left -fill y
 
-- 
2.32.0

