Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 15:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiFGPvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiFGPvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 11:51:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8FDF33A5
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 08:51:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso3977450wms.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yp+pxPsPCKspCvMR+GHXTKwM7XJ17BbdiKbig5kf474=;
        b=IgoQAHl1iAD98FKHx4duNhpVNocrtdZ3jOzQxwInh9gNuEckZXzb2Pl94UPn4drxOz
         2jBDTPuExTYz00N82QRBP64UeX1D23L1yIWaL/GeazBukUrT8vhoa8ZGACSL/uJo7ESQ
         x8p3oMUVuGpQa2YNiEitNjCYbfNuryadqnjqCzJG4r9282GLJIJOwXGjefeQ80PwkfL4
         aTOSHHNRbbGrSD2bkGHeI/4RUQXuTCbzXZ9ouNuruPlXMtnT3oNKJSeoXBXhv5SL+n3l
         DNEgaWCMF6zByGRthpA0O4QVShq65cUjIrdKGIRuYkvv0I5+q9qBlhKUq2aRoWI+wA1J
         NR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yp+pxPsPCKspCvMR+GHXTKwM7XJ17BbdiKbig5kf474=;
        b=yLjtaXYXfEaXxlynlhGWHWGBAsdAL3IBdWA53cr8WU0icOnyW7k5ZdSwPu5YtD3dbp
         yRWtojiHU64EpH9nJhEeLEeCmBmQWMK/1ceJOVhyFdNZY7lLYEzwMihjHnY3Hr6M4HUT
         lzUiVtD8Y3n7N//KDLFo5eldhvTSoFky2yG5cvp9TGM7XNpjoSq0Mf0cp67XWLqH/byr
         4BbGF5wsYZTksHpx1UhAXE9sqhTBqLdgia06RNDbR3ivnjahRdZincvaCf72X88RJefg
         HPA1abtk0rlqRUZ0gCppAMSUlc9krPYYP41Dqwemj9sPz6+y1Ch6/FqydvseXQCf95kD
         8XHg==
X-Gm-Message-State: AOAM531HZjfb0JX5anzZN26fuuilrRQ+veMsHXlUzX1fkI3mSQqLLfaX
        ocIaeEvwmggdttt5/Ann+cQGtbY5m77ovw==
X-Google-Smtp-Source: ABdhPJxyFi8w/ru3xkBE2SMFYLRtbFypcsrCVUTZSUkA5uUgCUY6Fl4U1xQ+wX6C7xCPLjQlZg2hWw==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id f18-20020a7bcc12000000b0037c01ae100amr57683658wmh.54.1654617064936;
        Tue, 07 Jun 2022 08:51:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6-20020adfbc06000000b0020fe4c5e94csm18790056wrg.19.2022.06.07.08.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:51:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] remote.c: remove braces from one-statement "for"-loops
Date:   Tue,  7 Jun 2022 17:50:03 +0200
Message-Id: <patch-1.3-1879ed2826e-20220607T154520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.g0c3594a0ba5
In-Reply-To: <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com> <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove braces that don't follow the CodingGuidelines from code added
in fd3cb0501e1 (remote: move static variables into per-repository
struct, 2021-11-17). A subsequent commit will edit code adjacent to
this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index e98148ac227..3e75db7bb4f 100644
--- a/remote.c
+++ b/remote.c
@@ -145,14 +145,12 @@ static void remote_clear(struct remote *remote)
 	free((char *)remote->name);
 	free((char *)remote->foreign_vcs);
 
-	for (i = 0; i < remote->url_nr; i++) {
+	for (i = 0; i < remote->url_nr; i++)
 		free((char *)remote->url[i]);
-	}
 	FREE_AND_NULL(remote->pushurl);
 
-	for (i = 0; i < remote->pushurl_nr; i++) {
+	for (i = 0; i < remote->pushurl_nr; i++)
 		free((char *)remote->pushurl[i]);
-	}
 	FREE_AND_NULL(remote->pushurl);
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -2720,9 +2718,8 @@ void remote_state_clear(struct remote_state *remote_state)
 {
 	int i;
 
-	for (i = 0; i < remote_state->remotes_nr; i++) {
+	for (i = 0; i < remote_state->remotes_nr; i++)
 		remote_clear(remote_state->remotes[i]);
-	}
 	FREE_AND_NULL(remote_state->remotes);
 	remote_state->remotes_alloc = 0;
 	remote_state->remotes_nr = 0;
-- 
2.36.1.1178.g0c3594a0ba5

