Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FBC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8417C206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="fWbvGpVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFOXA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:00:28 -0400
Received: from avasout07.plus.net ([84.93.230.235]:57492 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 19:00:27 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id ky5VjREEu0wwMky5WjEVNo; Tue, 16 Jun 2020 00:00:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1592262025; bh=XQX2pEwnuFpXV457nPBhISZ22y4PgZlrqEwX4Z9XEuo=;
        h=To:Cc:From:Subject:Date;
        b=fWbvGpVT7bu6LgQ6QKwLrnpw/5xctbmHcHUq1RZuB3hSjs7k6J0wHvz8Ylyf2wq38
         /DJWBeWA4Y+ggr8WGNBLyd9otNY9BItGzyptw5vj2XWViFf7+RGOS3yZfkwl5qGuxG
         84j9d/HuVYiRplHs0aKOwXcxQnozQS/OJTxLbnPLvSS3Gzmrz/0revtAqHM4hfREPi
         Gs0xaj4NNtgZOB4O+UncH6Opcxbycp6xZ8518LOcfVdGLaKZ0zof4HQ7ueYP2ifbXU
         fPueSYZe+HcB1lX7Jx3ng1XWK369BfSMqNNj+tqXDPfSgJ+Mc/hjFg+S2sRQWaMqUY
         obpKX48Sr6qzg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=b/4pHuOx c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=QMTOO-xQpH9P0Wc2a6AA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] upload-pack: fix a sparse '0 as NULL pointer' warning
Message-ID: <494e000a-17a5-b730-b032-1fc0e8690c07@ramsayjones.plus.com>
Date:   Tue, 16 Jun 2020 00:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC24aNLEFyrFPTJaUKgMxc2Xsj7uwmKE0zlo4IoKuB7JBZafJZPQUh5gjcDdGQFOK0mYmYe3yJNFYUhiSMZsxijIoC6GHQdO+T4v06uMqRaGtr4fWfKG
 8/SuokxbTBdFQgCgEbpsYwmDNnZDPG2jZOpDZhJyzd2gJzUyzsXXVGQK0kqy9u0M3jsYFsFyEgh5uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jonathan,

If you need to re-roll your 'jt/cdn-offload' branch, could you please
squash this into the relevant patch (commit dd4b732df7 (upload-pack: send
part of packfile response as uri, 2020-06-10)).

Thanks!

ATB,
Ramsay Jones

 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index b4fd85fb9a..951a2b23aa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1246,7 +1246,7 @@ void upload_pack(struct upload_pack_options *options)
 		receive_needs(&data, &reader);
 		if (data.want_obj.nr) {
 			get_common_commits(&data, &reader);
-			create_pack_file(&data, 0);
+			create_pack_file(&data, NULL);
 		}
 	}
 
-- 
2.27.0
