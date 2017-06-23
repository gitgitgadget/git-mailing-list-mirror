Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B652620401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbdFWHC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:56 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58780 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754131AbdFWHCy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:54 -0400
X-AuditID: 12074413-b45ff700000069ec-cc-594cbd1c360c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B6.53.27116.D1DBC495; Fri, 23 Jun 2017 03:02:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o6B001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 26/29] clear_packed_ref_cache(): don't protest if the lock is held
Date:   Fri, 23 Jun 2017 09:01:44 +0200
Message-Id: <585946fc1191c540768206cdf59c0c6101583691.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqCu71yfSYG4Tp8XaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBlLzp9iKtjOVvHxZGQD4yrWLkZO
        DgkBE4m/u7+ydDFycQgJ7GCSuLqoixXCOcUksX7lOnaQKjYBXYlFPc1MILaIgJrExLZDYB3M
        ApOYJd5eWwiWEBYIlfh3cRmYzSKgKtHQMYERxOYViJI4sXAyM8Q6eYldbRfBVnMKWEj0TFwO
        tkBIwFxi1e/VrBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAk6
        4R2Mu07KHWIU4GBU4uFNOOsdKcSaWFZcmXuIUZKDSUmUVzPSJ1KILyk/pTIjsTgjvqg0J7X4
        EKMEB7OSCK/OKqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCV3QP
        UKNgUWp6akVaZk4JQpqJgxNkOA/QcI/NIMOLCxJzizPTIfKnGHU5mj5s+cIkxJKXn5cqJc67
        YTdQkQBIUUZpHtwcWLJ4xSgO9JYwbyJIFQ8w0cBNegW0hAloyYw1YEtKEhFSUg2MNZ1r5ous
        nxe36O7CD3+KDroJ33aRPPu3+EKxVJV1O9O31IM313v3Nu7aeDD8i2/aPZWlj73EXhvHPLF8
        FJ92J2i28oSGUIFHPg4ijum13zd/Y74odfZkUuphBwGb2AllxyZOiEgr4u5mL9IVNczefHx5
        edr/D7INl2WrDN4s0p/yZ/Idj4csSizFGYmGWsxFxYkA30fQPPECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing callers already check that the lock isn't held just
before calling `clear_packed_ref_cache()`, and in the near future we
want to be able to call this function when the lock is held.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f27943f9a1..96d92a5eea 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -133,8 +133,6 @@ static void clear_packed_ref_cache(struct packed_ref_store *refs)
 	if (refs->cache) {
 		struct packed_ref_cache *cache = refs->cache;
 
-		if (is_lock_file_locked(&refs->lock))
-			die("BUG: packed-ref cache cleared while locked");
 		refs->cache = NULL;
 		release_packed_ref_cache(cache);
 	}
-- 
2.11.0

