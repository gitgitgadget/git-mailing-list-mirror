Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE19202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbdCIWYO (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:24:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:49981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752734AbdCIWYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:24:13 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3j17-1bupMn1CVN-00rKsz; Thu, 09
 Mar 2017 23:24:00 +0100
Date:   Thu, 9 Mar 2017 23:23:59 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 03/11] Prepare setup_discovered_git_directory() the root
 directory
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <69394fd8d91a3723fed34ad1a9051300df3cc7b3.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WX8hqP3yrwpPwKCQy0MNKGK4iffGlyFaL4LCYriUqCpNw9Xba5Y
 iZQ+1ZEkZTduZ6lQX1C9CD+F5/As9VYvUWohYR6TJY0TdJacHKKxr7sScrfCUPgz6cYz02B
 S84tHhmsAWmk28jKDrI5Ag+XxHVGyc/44I945sAPsX47H4Pk9g524y6McnPXRdoX3NpB1HT
 3KVWwvpaR27xAEnWRRWvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NDYCG0XEaLg=:zdo2q/nxxPPuiIAIaMyqUt
 UP9bp+yrPXpHqbXjWF/b2IC+s2UIb029q2fsxQgkBJ35t1KE0MR/wBdJLZ+ZRkaOXmUh9ceWt
 lUljv/vkEEmNFlrV5xv70Soe4nTMSB6jXjFiIU+kyCNFbJHZfvkcXmdMvJq1rXcdk2+SIV1ow
 +uedsYVFqTnsfpdlVKjUfw9rPgHGKJEUKRdI8KZBbKKcAdLnMpojkJNpxLIamIUN8sJYyMt+y
 UFhLGq0F/sVGbzUAa2FjjIqef9rk6ecMTBmln45CPluWxIjw1QrBM6eGMemj63cpIZTdczFN/
 73LiRw08Xnd6AS0YeI4lE1x442swplC/IEbu5oY4EUaGfA9qgbxsS1j+1Kqliqh6lnyPBLFpt
 1ualkmYJcB3LzOUDV19TFdNTk4JhVs4Jzz+1SXhK/lnD1nOEZFYs9D0CLJap8HMqR6i5Zaeip
 Tcv2WQbTWCcxIHm7jPnvaoysS5OAA7j6Is4y1Chiz2FCNGVTd1N4GQHHrgBnX7MPbiVHUS57R
 VmP5A1GfZN3RoTSEcT6fXUoQjj0VspRN5INi89BOvJJSJb5aE/czDNL1cAms22MV7IYftceAf
 eGtk3Cn4SuO1u50+gvBRaMBCg0hCqOSW0P8sHIyg5yCCUwR1LMKMER5CIWXaGQeyodvuX+Dhu
 blNCs/kdyfkN8JUasRoMgbY0cYYWGMqFO+7xSmmgoQelRFIElUoQNFEHCz7fSItovBRfilnNz
 ZOxkmeaLXwWxJAPzRwPxZQD4r4OsNXKB3RJ07HYUsaIFtvcZtlZ0cPCv0lNK/Na4o01e87yCo
 Gb9STh/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the offset parameter (indicating what part of the cwd
parameter corresponds to the current directory after discovering the
.git/ directory) is set to 0 when we are running in the root directory.

However, in the next patches we will avoid changing the current working
directory while searching for the .git/ directory, meaning that the
offset corresponding to the root directory will have to be 1 to reflect
that this directory is characterized by the path "/" (and not "").

So let's make sure that setup_discovered_git_directory() only tries to
append the trailing slash to non-root directories.

Note: the setup_bare_git_directory() does not need a corresponding
change, as it does not want to return a prefix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 4a15b105676..20a1f0f870e 100644
--- a/setup.c
+++ b/setup.c
@@ -721,8 +721,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (offset == cwd->len)
 		return NULL;
 
-	/* Make "offset" point to past the '/', and add a '/' at the end */
-	offset++;
+	/* Make "offset" point past the '/' (already the case for root dirs) */
+	if (offset != offset_1st_component(cwd->buf))
+		offset++;
+	/* Add a '/' at the end */
 	strbuf_addch(cwd, '/');
 	return cwd->buf + offset;
 }
-- 
2.12.0.windows.1.7.g94dafc3b124


