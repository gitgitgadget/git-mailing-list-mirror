Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB59201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbdEQMGm (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:57196 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753667AbdEQMGg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:36 -0400
X-AuditID: 12074414-059ff70000004f50-0a-591c3cbf996f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 89.CF.20304.FBC3C195; Wed, 17 May 2017 08:06:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg6000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/23] ref_update_reject_duplicates(): add a sanity check
Date:   Wed, 17 May 2017 14:05:38 +0200
Message-Id: <704a0263164527f09565cda207a9f31939badb60.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqHvARibSYMVeDou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG9c//mAsOs1ecaN3O2MD4lLWLkZNDQsBE
        omHFHMYuRi4OIYEdTBI7/11ihnBOMEm8ufqZDaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwGMm
        ib/LullAEsICnhL93ceYQWwWAVWJT13fwVbwCkRJrL/SyQaxTl5iV9tFsDingIXE/feP2LsY
        OYC2mUtsv145gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdC73czBK91JTSTYyQUBPZ
        wXjkpNwhRgEORiUeXgsO6Ugh1sSy4srcQ4ySHExKorz7HwCF+JLyUyozEosz4otKc1KLDzFK
        cDArifDeNJWJFOJNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuCdYg3U
        KFiUmp5akZaZU4KQZuLgBBnOAzScC6SGt7ggMbc4Mx0if4pRl2POva/vmYRY8vLzUqXEeQ+A
        FAmAFGWU5sHNgaWIV4ziQG8J8z4HqeIBphe4Sa+AljABLWkG+Y63uCQRISXVwLjEcs5WaWlG
        xjRP7jmijxiYWNKtCiYEiquuufx0Pc92HZEs6YDeTWeEz0ZFsxW8fFhzc7tMe9nNgl9Lnkk4
        Xgl+XWBu/zFK3CuO2/vLhPDHW50nxe55uFE++br4xUNKwr8mHniqsVPndY/0vjrpOVdVrVSW
        uE6LahGXX/+rPE79yxsvsZ/iFUosxRmJhlrMRcWJALZfK4XsAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's pretty cheap to make sure that the caller didn't pass us an
unsorted list by accident, so do so.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ffc9bd0be5..68a0872562 100644
--- a/refs.c
+++ b/refs.c
@@ -1696,13 +1696,19 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 
 	assert(err);
 
-	for (i = 1; i < n; i++)
-		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
+	for (i = 1; i < n; i++) {
+		int cmp = strcmp(refnames->items[i - 1].string,
+				 refnames->items[i].string);
+
+		if (!cmp) {
 			strbuf_addf(err,
 				    "multiple updates for ref '%s' not allowed.",
 				    refnames->items[i].string);
 			return 1;
+		} else if (cmp > 0) {
+			die("BUG: ref_update_reject_duplicates() received unsorted list");
 		}
+	}
 	return 0;
 }
 
-- 
2.11.0

