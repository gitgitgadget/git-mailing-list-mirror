Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9412CC3F2D8
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B66620857
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWN3MGbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgCCRI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42273 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbgCCRI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id z11so5299778wro.9
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUU0m7zuH+Jw1rlW+oPq9wui5b5GA21PmG6BwqbM61s=;
        b=sWN3MGbw3FNXOITAR3a+yFCFeVQo7Yyi6lzSLn3u7Ve4lbEPHhasLXENe8G/9xo4+t
         QR/qkT/fpqf3+NpHkfwA/jKCF4JkUjCf8TXhGhnQ2IOyWrC/SeenICqQSm6DcOr54JY+
         ziilnuT0dPN6ZCYMoO2LGjVCEjNNMxniXDJxUgcHwqW+RLIxRQHutfWas4kq+9ikpmka
         HF6rpbz2Rp00ms687AmCcNrV9baMG+oz0fKd3sjtOReir1W3A5TtSfSEd34hVzTdKq7v
         dCEN7hi7FADDpEhw7T2REkSoi3ZAi9BtgojUn774jDpAIPfC0NYXju/g/49AWDQaDPxN
         JZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUU0m7zuH+Jw1rlW+oPq9wui5b5GA21PmG6BwqbM61s=;
        b=MSYcMS5w9zEqKundAirihgoPwweF5b7McaXfOKDuhS+rvfIu1rqPkjspmRDflGnary
         BYpUIS+l1CBkOUyUWqQgoLkWrHf+dk5bgwdzCwA8dDTlNOkQvwQ6m9lmBNA7JuIUIvov
         t1mbt4J5RggfCdB/vODCHnGYW0A+57SzvV9hVAoJMxSQ3zsjUwcxCaUzZEwBh6UJZcEr
         n0KyBmFyIf0mJAIspiFAjx08t1KQa6DsZuBnPpnydCjBYmdTFNR0Joy9l08vT/KEHY5Y
         hu2MZpY4q0KFXhuTRLeflFX55XndWcNIgQDuq2lk1V79z4bVdm0cnqNnycGGPJ8vHJdS
         W0vw==
X-Gm-Message-State: ANhLgQ2nB+pUNe5uiXr4VcKgbR3UBRwiZu8z3F7xKakiT7Io+nBGjKBC
        cbgV26Huo4gvnkecEzQZCVjgFox+gmU=
X-Google-Smtp-Source: ADFU+vuUTsiQ5RHB4588Fy3ZoGn6jZjSmEO6OWze9UajEmm2RTaLWPywqwdNnV91AgMNHYqWwwjCuQ==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr6754297wrx.182.1583255306642;
        Tue, 03 Mar 2020 09:08:26 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 16sm4746576wmi.0.2020.03.03.09.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:08:25 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 3/5] doc: explain how to deactivate recurse.submodule completely
Date:   Tue,  3 Mar 2020 18:07:38 +0100
Message-Id: <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 5962f41ead..74e691a487 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -63,6 +63,13 @@ submodule.recurse::
 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
 	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
+	When set to true, it can be deactivated by calling
+	`--no-recurse-submodules`. Note that some Git commands without this
+	option may call some of the above commands affected by
+	`submodule.recurse`; for instance `git remote update` will call
+	`git fetch` but does not have a `--no-recurse-submodules` option.
+	since `submodule.recurse`. In this case a solution is to temporary
+	change the configuration value by using `git -c submodule.recurse=0`.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

