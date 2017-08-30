Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2AF208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdH3HPR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:15:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37584 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdH3HPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:15:16 -0400
Received: by mail-pg0-f66.google.com with SMTP id t193so4494458pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Ms1kVbG+nzQuRAinv3ohLfEF4jRoaDCJqceA0kP3rk=;
        b=pKky7JikviHCKNdb6/LcC/bRqV+FlnebdZYGnntcuy2490ZAezg51aEHAng2UHsw0Y
         YvfgA24W5IilGxgQ6XJdQcm34BbRZ0GmYp4ZmD9mrraYohCuF50geEmu3gmrwbADeSFX
         daFZyvnO6QEQ/xxTuM/MfR5acJuGBOcGI529okGCIAsK+Qry2WjzRTnwJv8lT+KdhRn2
         afOUhQgprv3OSliLkfq0lzWowiKsm3m9RDwMf/OBm802mFUii5dHtPLGTLbwyvVK7Gdv
         ms5/+kS4nvKiVoCeAuUYddfj6vDYMRsIzD0mAsjfka/5phgVdcGD9O1T8VIBMO6shqw/
         0Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Ms1kVbG+nzQuRAinv3ohLfEF4jRoaDCJqceA0kP3rk=;
        b=jxotzEzVV7BsP/CC27KTiLwr/REOuyhyh1dqCrokHIEe2fhQ/VRHKXzy5yRh0GuioE
         lvMWqsDZm9nOnxpIPwYPasjg/qcEXCV3SUo0FOiTMsJGY3J+hz6s1x3BUsLSO2655H3c
         tGCPoTuJD6IQarrQ0gCgLxxqqAmXxg5sZrlTQ7nduPbXFgUxQIRhI5lnfO+Iq+jOgbtD
         KKzq7HDDhK0MOYbN/wmm/MD9Dx5YLX02eMCA/p95BWuYCE/CUng1p9iCd9bUH+XUAfIW
         tROGwt7txIj2TCPqy8lNJYm6k8dsf+c0BsDLfJW+SCLdRpAR4V26PH1ADpYrTJSYrzP+
         slJA==
X-Gm-Message-State: AHYfb5hW0q4mSPizB6PLN40LqJgRcJ2RsL2q5DC4ZRuDtxDd2reKbUuH
        4A7YExRiyvgD1jeCsGE=
X-Received: by 10.84.215.219 with SMTP id g27mr714445plj.289.1504077315773;
        Wed, 30 Aug 2017 00:15:15 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id q192sm8410887pfq.24.2017.08.30.00.15.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:15:15 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:15:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 35/39] pack: allow stat_sha1_file to handle arbitrary
 repositories
Message-ID: <20170830071513.GJ153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ac57eea0f2..282ed7bd1b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -822,19 +822,18 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 
-	*path = sha1_file_name(the_repository, sha1);
+	*path = sha1_file_name(r, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.14.1.581.gf28d330327

