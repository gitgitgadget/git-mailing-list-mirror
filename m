Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B986F20248
	for <e@80x24.org>; Mon,  8 Apr 2019 11:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfDHL0j (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 07:26:39 -0400
Received: from srv1.79p.de ([213.239.234.118]:51106 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDHL0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 07:26:38 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 07:26:38 EDT
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id C48C6220063;
        Mon,  8 Apr 2019 13:20:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
        id 2C7E822006E; Mon,  8 Apr 2019 13:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2019; t=1554722418;
        bh=a8ma+TgZDqga74MJu39R7RrLG32NcaHcdOlHvZFnoRU=;
        h=From:To:Subject:Cc:Date:From;
        b=AgMJ47gGWRt0YSeNqS+xHxBVpSmpOXc/7PyxiwQ/wuzihoX2jJ7KEX2GPc7WYUiSM
         HIzNXiprq45VAMEWw2d+q6OM/2LrTwP9r6oEVJp3E18L9NClqDo6PzL1B1uUq4LL82
         ZVvpkVKNIPJcYX91G+8Z1jLdV/rrdh0LBVSw6mTKBBrSIUUCumyssedZq4FUKWFVJe
         amQb+BU7it1d6cO5pxdj2sl/IvyqPSnxZf22AIfHgiN+hdtU3SPOrRvzaxGn9IVN/W
         Um+U+UZAGQsGmFVtkjtD4SFi2UMBDFrJKlzUwBKxgIE+2/8nsjEIUYcBGipGU9R21q
         +zZHsDb4yjh5w==
From:   Sven Strickroth <email@cs-ware.de>
To:     git@vger.kernel.org
Subject: [PATCH] Unbreak real_path on Windows for already absolute paths (with
 Visual Studio)
Cc:     gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de
Message-Id: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
Date:   Mon, 8 Apr 2019 13:16:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A path such as 'c:/somepath/submodule/../.git/modules/submodule' wasn't
resolved correctly any more, because the *nix variant of
offset_1st_component is used instead of the Win32 specific version.

Regression was introduced in commit
25d90d1cb72ce51407324259516843406142fe89.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-compat-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e0275da7e0..9be177e588 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -210,6 +210,7 @@
 #include "compat/mingw.h"
 #include "compat/win32/fscache.h"
 #elif defined(_MSC_VER)
+#include "compat/win32/path-utils.h"
 #include "compat/msvc.h"
 #include "compat/win32/fscache.h"
 #else
-- 
2.21.0.windows.1

