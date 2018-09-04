Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890181F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeIED3k (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:40 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:54521 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeIED3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:40 -0400
Received: by mail-yw1-f74.google.com with SMTP id c67-v6so3919280ywc.21
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KMxpJaFeDvA+JYWDSIqw1e9nTvx03OpdM6Z5DG0u5dA=;
        b=c8eakJO16/2d5rdi5m1TfviViP+HeFkRbdhrDF8uu52fIhn3olWLotInzgpsV94WOG
         coRGIIITH3ym5LhFTFBpExjUKafNuZbvfeYQtL/RzcZ2eV5t3AdaiitAYSIprngSLTxD
         MYX8MdP4bT0UelTxAD6fR+CaWeyRcFvqPjcuAb+QzdvNOx9LALAG9W4YHV3jW2q5oNY9
         cDxYnJLpAon1M+XwPjSxQ4VCessbmz9X4nx7ZhMeuknGOrcKFLvnVgoi2Jiwt/oGC8gD
         5viW+YG2nFZ/dWA3tini4mDKESJ/W0dqlby8br/HKXoU2DjqfL5vXS/CxnoX7x0bIOAE
         u8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KMxpJaFeDvA+JYWDSIqw1e9nTvx03OpdM6Z5DG0u5dA=;
        b=GS2jDtzmXlhYeA2glpnfOfAKVs9fhgGoNXmKaPwaJYFh2T55RKtMHEKzTTVPvoYXYG
         6CGGlV6ErDzOUKZ8R7tcbBoYgsrvYAX8ZryQ4gXbDITHOiHhanV2bY7QzJA0GUWEKSkY
         5KiVSFImcrsuYDOlgstne9aql0BlDF0yBOkiDFX2ZFCJQsPxQdbN8N2R1CrRLRTVPFfd
         Oo3ups4knOtL2zNypyrOGCXAX22LyWelC91SJzsxox8GohdCu1yb5z0V3T/dDfembgkM
         jP2J050R8RfaTn7nGIRmvhTmkRqitLwrpQVp9ylpYWbsiGyPz5QnRVB5kII7oC7n8e10
         7Y1Q==
X-Gm-Message-State: APzg51DBEgxBKXW1oVDKdxlay2FeT1+ldIroA68TUbAon9JV6Vbs5eNa
        BV7Vw+Bc48C03x7nri8lIsrn3G/rn8R+VguQ7e5H6JBRMT/ztQxIlc8o6/VbDliMmSasNuW/IOd
        Jm6VL5KXhfnlCyVu4r7cReQmCWx1CgJrvVka1qUlp21MdIxYiTNQ/UE5CzgVw
X-Google-Smtp-Source: ANB0VdYUPNuGXTCOpreDgw6bgcfQrvTfyDsvAl48lT4AMAtI0HeFWAYrw5o4kDK8fkLupIgu5LDNtJEeT8/5
X-Received: by 2002:a0d:f8c2:: with SMTP id i185-v6mr8861945ywf.211.1536102143366;
 Tue, 04 Sep 2018 16:02:23 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:49 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-12-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 11/11] builtin/fetch: check for submodule updates for non
 branch fetches
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For Gerrit users that use submodules the invocation of fetch without a
branch is their main use case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             | 5 ++++-
 t/t5526-fetch-submodules.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95c44bf6ffa..ea6ecd123e7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -887,11 +887,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else {
+				check_for_new_submodule_commits(&rm->old_oid);
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
+
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index af12c50e7dd..a509eabb044 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -615,7 +615,7 @@ test_expect_success "fetch new commits on-demand when they are not reachable" '
 	git update-ref refs/changes/2 $D &&
 	(
 		cd downstream &&
-		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
+		git fetch --recurse-submodules origin refs/changes/2 &&
 		git -C submodule cat-file -t $C &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

