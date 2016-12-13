Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16F720451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbcLMXn7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:43:59 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:56377 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbcLMXn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:43:56 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 6AEC4C344A;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 463F3C3419;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 0FA78216E2; Wed, 14 Dec 2016 00:31:52 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 4/6] update-unicode.sh: automatically download newer definition files
Date:   Wed, 14 Dec 2016 00:31:42 +0100
Message-Id: <1481671904-1143-5-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking just for the unicode data files' existence is not sufficient;
we should also download them if a newer version exists on the Unicode
consortium's servers. Option -N of wget does this nicely for us.

Reviewed-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/update-unicode/update_unicode.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
index 9f1bf31..56871a1 100755
--- a/contrib/update-unicode/update_unicode.sh
+++ b/contrib/update-unicode/update_unicode.sh
@@ -8,12 +8,8 @@
 cd "$(dirname "$0")"
 UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode_width.h
 
-if ! test -f UnicodeData.txt; then
-	wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
-fi &&
-if ! test -f EastAsianWidth.txt; then
-	wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
-fi &&
+wget -N http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
+	http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
 if ! test -d uniset; then
 	git clone https://github.com/depp/uniset.git &&
 	( cd uniset && git checkout 4b186196dd )
-- 
2.7.2
