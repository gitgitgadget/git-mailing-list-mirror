Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1E8207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbdEFWLT (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:11:19 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37604 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754117AbdEFWLH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4AE94280B2;
        Sat,  6 May 2017 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108666;
        bh=A1alHSyYkN5ApLa4F3ObQpBeLHYtW/uPWw3C5MCRZbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDe8HFmZ+W0+P4pk42Yo36IhQJLoL50VGOvNz60xdKclB2o6JEAB1PmvO0S5lzsUR
         9RN9AZa4ub8+q6eGvbXtjO85c27/aYCJ+9bzSYweTioV8m5VCFmO4xs+AkQeHvjpwk
         CcKCX3gFBtA5kwGI/4uQLVcSo58Kp35ZkYUP1a2NJN7UD61yNMk6PfF6NWwSFRB9RO
         tB45EX/Eo+7VfGSrDb6ybo3leqQlJjuZ5Y3LPRiLzfVB7+qDYAbEbT14gS7Rl8ruVQ
         9XZ3X8CXq011oCZEbhLvy4RCP6DzmaAc1cZOvE65Ruw7zEirUVyxQJEbZHDoPQNOo0
         qTAAa70OT55gVGRHiqJ8qVFm8agS7oa3HoSqrI+9OJnXGLjtegfUJbgW9m80l4zP7I
         Q9hu4XvDONfvKgL3RTx+DmNjTDaizqwCeJ5/Wp+sh0jJ8uHRVtp1agp+waziyJDRf7
         Tneb7WyMVcaZ9S2qvI1EOIw1YZIAWK565/w1b1lLkAz01erzl3L
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 05/53] builtin/prune: convert to struct object_id
Date:   Sat,  6 May 2017 22:09:50 +0000
Message-Id: <20170506221038.296722-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the sole instance of unsigned char [20] to struct object_id.
cmd_prune is a caller of parse_object, which we will convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/prune.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 42633e0c6..96dca7d58 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -123,11 +123,11 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!get_sha1(name, sha1)) {
-			struct object *object = parse_object_or_die(sha1, name);
+		if (!get_oid(name, &oid)) {
+			struct object *object = parse_object_or_die(oid.hash, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
