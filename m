Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC3820373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbdCMUKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:10:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:59158 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbdCMUKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:10:30 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfVU3-1cc9dT2uAV-00P62E; Mon, 13
 Mar 2017 21:10:01 +0100
Date:   Mon, 13 Mar 2017 21:09:44 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 03/12] Prepare setup_discovered_git_directory() the root
 directory
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <8d8be2b095afb215f5bf0e0bb7989c9c9ab3f471.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LQ8Y5syPLqp8XiXpZYawrgDArRtNRfHZJlm4yEI7FmUarnl0j9W
 FNn4SN/w14gui71xuGKYJLHajPSpRtUFsSSgY4ZWmvtKQfsLEWIvti64JnfEu2AhXegBBGu
 UTFePWcl15CJbqfgE9xyshPehNabfCoMcy0auhoBshnffXQV2QYqTDfJ8RTaCrAvp9TOQmI
 ruRpO4Qjd3u2hjb9ax9/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1rWDxvYUozM=:BLp0MMaqviXEUzJ/XmsBGR
 2FhhdDSrOoXoDXfdAcT52fH7LjUdm3iUCgVmV9KUKpWXex3dFGe8JYDNQlgjMbj3JD4zzWrJj
 AWpUCeiOepd/L9MZxsgQfdQ9nfHeK1mecmwcsDcYfECuoen3iHEYHa8SnwrcImSqW4zrd9t7G
 TfDy3YM8UBO7MxfKBAiVIrYhRillF5ARK5GhHP/9xRA822CMSZumiNZRSDG60vzYJUdVHTMMz
 8v8f24+HMSUnPcPSyKIyuwlI9IIIAS1s3fXZwV3Uu74F2jYcgbauqiimnyuafNhVbWRvsRjsm
 fnnOjUi1TyJ8Cwr6blCzMBXlGJVw+GnIhxKX2LvGW/C8lES0AtSca/n2B4mzVuejxQEE8BPXs
 0e7T20mus86pvx/+AuvtxwOAL80L2qGDdTgqq1Xn2+mAFN4dKELenr4IjVi9PASZMQU4ot3zL
 +iH0PsQpf8H7JQlmBKhguOaJm1kBD1Y/OZG3YVzWSrV19kOWcg9cfSxmQtjPlKZjblqV638Wh
 65aeJg0SWZycMf487jo2EUuVFQM1H1RCyR6EY71JbjHJDNduHHzJYUSUVrn04X8+XxV7KnPkq
 wp0zk9sejR7qJpQj0kkpy8lmFK31KWqFQQv1oi6PZ4qlg2aKL/6S+IGeFtnFlmOQCWhO7gz1W
 jcwGeO45Ki5OF61JTTfM/pDw3FFUqbYtjkHgLVmgB9kWor5p+dR0L6Ge4am/iNA0ZdAqwIG0V
 yD6etq/CdgAM+a40xAmMMLb3xnsEXkf0GJNE+90cYc47z94hOMAsxNaNkBu8y2kSZeYN509nx
 1aPclKC
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
index 2ac891d4b9a..23114cb7aa3 100644
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


