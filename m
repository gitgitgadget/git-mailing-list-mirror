Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8326C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiHUOCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiHUOBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906E24BC5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b5so6019921wrr.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3qac5u0oZzH0/Yrl75Odyu4+0g2slhhrqutEVAFJeQY=;
        b=iuxJpIiBRe6iauB9hDmOnxblbNf2ksDrOa+a6p0jNe03tUrNjiccOXSDjknnSUT3vP
         Mn8aihEuoEE6LWE+AFTfSWftBQ/Rc31mwJJXvArfa2kcdhHmVrZU1NUqrqgDVOspaFmu
         tLgLPrSxFm5g3EpJjBq4VCqD5FiL1o61WlU+xJBsw+uvLn34NPR2PlurPS+Gywbl64LD
         uJxP68Wu6UIGnyESqDiDwfnvsvYYlVJAMOcIpDr/t7jydumXbbxDfZ4Ttv+2/I+DHJvo
         cfKiFWEJ/NC2JJsdZU6vMX32B3XegtMRuAczCsBVN+r3KvUXy4ja66ZXc6Wu/WfR7azg
         /Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3qac5u0oZzH0/Yrl75Odyu4+0g2slhhrqutEVAFJeQY=;
        b=TkHuGYyWAcjA2GwpBIbz9CqnZmJKGntmOKtsq8SDoKvl3yfityxRBi7Z3EuFm5DqPW
         obdCrGQPwz80Rv9ojWuu5EkQUzSau3sssoRx0AykFjO8IPFxEapn1Wc5UqG0bfzq747P
         9qqS15qMGg7m8gDIrSlkOo+k+DvTw+9Wk5ceITqUDw0OSee5nuKiovRnMgHjMeTLp3KT
         eaUibekuMvdUFmdq08YIcNUScf8OYBihKed56p6Kbpk6NbsVTR1IaoI5BBl34UinDsln
         bRtW5mIFdcOSez00+r+iqTnhgIRwWuuLryIIAQB+6uvLC/3dhLKVvOXj0ua3Q9bmS1+3
         3W/w==
X-Gm-Message-State: ACgBeo0MRpnzWLJWXhAns45cbiQNigbb7jiJeTFmJ9A7dWhdL1EI64Q3
        MPkLIfVrFAunr78eeDs+P2TcVZ3Nvg+WhzZ3
X-Google-Smtp-Source: AA6agR6aJZJdWiSMRQGvvi3GSvhp9If9TvUEr4nRsc6PCeTJLWOb2gPZPN8WZ/eRiQsL6ZsJPOhMxw==
X-Received: by 2002:a05:6000:1ac7:b0:225:1cb4:d443 with SMTP id i7-20020a0560001ac700b002251cb4d443mr8316908wry.501.1661090471860;
        Sun, 21 Aug 2022 07:01:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 09/17] submodule--helper: fix a leak with repo_clear()
Date:   Sun, 21 Aug 2022 15:59:33 +0200
Message-Id: <patch-v6-09.17-a0d1a03166f-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ea925178946..b029e109b47 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2399,6 +2399,7 @@ static int ensure_core_worktree(const char *path)
 		strbuf_release(&sb);
 	}
 
+	repo_clear(&subrepo);
 	return 0;
 }
 
-- 
2.37.2.1279.g64dec4e13cf

