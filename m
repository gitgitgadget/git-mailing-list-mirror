Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7FA1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbcHQThR convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Wed, 17 Aug 2016 15:37:17 -0400
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:44629 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753749AbcHQThL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2016 15:37:11 -0400
X-AuditID: 12074425-e03ff7000000470c-ec-57b4b3f60bc2
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by  (Symantec Messaging Gateway) with SMTP id 2E.E5.18188.6F3B4B75; Wed, 17 Aug 2016 14:59:02 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id u7HIx1DD004672;
	Wed, 17 Aug 2016 14:59:01 -0400
Received: from localhost (howe-and-ser-moving.mit.edu [18.9.64.27])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u7HIwxBD031015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 17 Aug 2016 14:59:00 -0400
Date:	Wed, 17 Aug 2016 14:58:58 -0400 (EDT)
From:	Anders Kaseorg <andersk@mit.edu>
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Bernhard Reiter <ockham@raz.or.at>,
	"Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] imap-send: Tell cURL to use imap:// or imaps://
Message-ID: <alpine.DEB.2.10.1608171449371.57685@howe-and-ser-moving.mit.edu>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixG6nrvtt85Zwg4WftSy6rnQzWTT0XmG2
	uLx3OYvF+Wl3GB1YPHbOusvucfGSsseHVYYenzfJBbBEcdmkpOZklqUW6dslcGV0n//EXLCA
	veLY4tlMDYwdbF2MnBwSAiYSq9v+sHYxcnEICbQxSezZ8YoZwtnIKNF0ZhU7hHOASaLh7V9m
	kBYWAW2JnTvfsoLYbAJqEh+OfgWzRYDsiW2HWEBsZoFMiWdTz4OtEBZwkHix9RITiM0r4Cux
	4dQxsHpRAV2JQ//+sEHEBSVOznwC1asuceDTRUYIW1vi/s02tgmMfLOQlM1CUjYLSdkCRuZV
	jLIpuVW6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYwcHporqDcc5fr0OMAhyMSjy8O6Zu
	CRdiTSwrrsw9xCjJwaQkyhs1FyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdkE1CONyWxsiq1
	KB8mJc3BoiTOu/1be7iQQHpiSWp2ampBahFMVoaDQ0mCVx4YhUKCRanpqRVpmTklCGkmDk6Q
	4TxAwy1AaniLCxJzizPTIfKnGHU5Fvy4vZZJiCUvPy9VSpx310agIgGQoozSPLg54KTC6SD9
	ilEc6C1h3rsgd/IAExLcpFdAS5iAlvDygy0pSURISTUwhhkt4pPs2O04Z+WMxZFPLn+KEbAM
	aKtxnPONtcImKn7O0upJdy4uvLBum6gj/4JehYOOn1mEKiJ2vtjutspok4r/j1ztOakb96hP
	eVy8sNL2S7vXqjtdpTJxGZrG22w7v7OIyl3iVA+80pJ8TCNLmmdx94GTeybf/HngYf/n/qa/
	BXvlJfsXK7EUZyQaajEXFScCAB5/sygFAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Right now the imap:// or imaps:// part of imap.host is not being
passed on to cURL.  Perhaps it was able to guess correctly under some
circumstances, but I was not able to find one; it was just trying to
make HTTP requests for me.  It’s better to be explicit in any case.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index 938c691..7dd5acf 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1410,6 +1410,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
 	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
 
+	strbuf_addstr(&path, server.use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, server.host);
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
-- 
2.10.0.rc0

