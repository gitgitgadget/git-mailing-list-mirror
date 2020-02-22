Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBEC35673
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1766208C3
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbryXrw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBVWfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:35:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35893 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVWfM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 17:35:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so6033336wru.3
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jnmhxW1Y3p4Z8GCr3INi92MATkecvv9LWbRXgPg/Hss=;
        b=DbryXrw7Tw44/xtoK5sH9ZnDCt71QuDsC80ciT8v3I3BLihVjQD11HqYivd8Lv/33k
         tXR3YGzbCLNjwSpw98kVFiITM8+QMHTvtjL4ZJkcuTFooSqGeWo5RZUjuRThUN89xB1N
         Cqy1vxYW42idJu4yNHHdQlfsTx1mfsSOqknIlEcTbO+AXB7xMZW5pI/l6TcPvoaVwOTz
         oZNwT/OOayoJihW9HWt8SJhctONCiZKwp0ara/Iyl3gmMKnapN96AGwZCCEl+xBhEq6r
         raydPDc+sxPeBIbCFCrAue09IU0lMlf9jb7ZUtJIau/hw+90n6pgx566xjkojZqbMDSx
         D7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jnmhxW1Y3p4Z8GCr3INi92MATkecvv9LWbRXgPg/Hss=;
        b=d9kiTFJPYTau3u7JI9fXg/4lTpOHDhnHRepmdUdPatn8ejZNKDCA1LvOhh+IFc0wlS
         gWhDkJsJlvErV1E4qNcoCcJSjmc/th6YJUbkEy7RUwIPrti0iv7o33/nBxTbSiOdGlDK
         MKhP6VCYzv20wlmtFa0qZ0WA7Sr7bgAaAhqdU48zg8D0hkc3I2GEk1Rwb0Q37eV+SZnn
         +7zGz+nB++28kTru8GAyEWZUF+zQRO9QKQkfOeD2+CaFUzDIR7t2KOEPZ4qBgHuP2Cw3
         pch/2kG/fk+SprYS9zlMORKbyVfBeb/pGmZpwPcPbmM2V/tD29nVLf7FmHl+EcZN8QV5
         83Hg==
X-Gm-Message-State: APjAAAVReUERcqWjgm7kU8ntX703uU6ojbIOfxIiLQ7xo/snpkuNnSiH
        eNdqfSTxCOo//+KYCNxrQH/oLklB
X-Google-Smtp-Source: APXvYqwiFewWZ9lhCy+dn2fWB6EC15UEqYUrS0bMvIFUobCZ8bTkFoefLEkS/DVOasd+mzE2XTDNrQ==
X-Received: by 2002:a05:6000:10c:: with SMTP id o12mr57514614wrx.106.1582410911006;
        Sat, 22 Feb 2020 14:35:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm10336395wmj.6.2020.02.22.14.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:35:10 -0800 (PST)
Message-Id: <5c749e044a3846d7757b198f29d984d181636556.1582410908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:35:05 +0000
Subject: [PATCH v2 2/4] t5509: initialized `pushee` as bare repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

`receive.denyCurrentBranch` currently has a bug where it allows pushing
into non-bare repository using namespaces as long as it does not have any
commits. This would cause t5509 to fail once that bug is fixed because it
pushes into an unborn current branch.

In t5509, no operations are performed inside `pushee`, as it is only a
target for `git push` and `git ls-remote` calls. Therefore it does not
need to have a worktree. So, it is safe to change `pushee` to a bare
repository.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t5509-fetch-push-namespaces.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 75cbfcc392c..e3975bd21de 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	) &&
 	commit0=$(cd original && git rev-parse HEAD^) &&
 	commit1=$(cd original && git rev-parse HEAD) &&
-	git init pushee &&
+	git init --bare pushee &&
 	git init puller
 '
 
-- 
gitgitgadget

