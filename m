Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3125C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7336E21D7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMyGTSn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgLAMJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLAMJR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 07:09:17 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAA8C09424A
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 04:07:50 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id 7so3659032ejm.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76EHc0LQCbtEuyGw5XcsMjxdOrK3WomCoBJ5fhrjbso=;
        b=kMyGTSn9Oo4lhVNC+FD3HXSV04ZnmMrtELpselUgywFd2ktpPornbQUteyvT8MFk/C
         Yb6cz1qSNFPIZ3Xk+rqhLkAqjdUZl2bgykkWAP1NmqsyKLNlAjPQoSo6Isp19BiRDtNj
         Tz1mMhZe9ZpsuNbUBhIL/4nVtUWzdpZLNg8WwbUxrDOQ1Aem6UULumc2w9IeHnhXW9Lg
         dKkHuH8P+OcXB0PpoWUH9hqUSbAa0P7DTidNUb2rFg3meMAz6lSkguym3rBH7qRvD6LY
         5yNbLhYt3hQLcHXL+7ebMGwJ8JzXcribTdgovNyk+LZ7h94YWtzka67ixPJMrToRqwzP
         H3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76EHc0LQCbtEuyGw5XcsMjxdOrK3WomCoBJ5fhrjbso=;
        b=Y2stN5tmkYchFt+8YWsvub8feSGtGehXNo48XoFN9sNkKxaouqeGGcbzY4wcbGTInP
         55w/6RBc2C324RAg+T44A5EPnILsfW0uKBXH8CsvXRA56dfFhNXB/ADaqAhMZ2zUqVkF
         lolJ1r9yjKXOPjyhLYxzIMbqtk3LA0Gn24n8OrBnlqowOjG/XJ9H/k3DppLeKJ1qjRN2
         BDs/cCfhhxJLrZgoKqgfxsmnS3U/+bHU+OhLvdKUSqS0KbSCxKQ2CYDlh5eVD4kp+mkN
         eU9TfWVSTgY/gmG36qn0+zkrs2b+GS27fUPcJF/sA4+mkvayzMQHCyKeD7VTDSS30OR6
         D+UA==
X-Gm-Message-State: AOAM5310WVbDZr1ng3/pRJjG+LEW55eIgoiojwI7sxQ6Oo2Dj6XO8fw7
        /00vX2AsyeZ8Pf3O75aJoGRq44tKlZk=
X-Google-Smtp-Source: ABdhPJyVRNg8ukeExMhQkNBVYerv8E/Bh/yFgvhB4aq1BTx+SuYA7JwHaqCvlCTm7De6Cf+NgMkBCw==
X-Received: by 2002:a17:906:94ca:: with SMTP id d10mr2571452ejy.62.1606824468589;
        Tue, 01 Dec 2020 04:07:48 -0800 (PST)
Received: from localhost ([185.112.167.39])
        by smtp.gmail.com with ESMTPSA id n7sm724938edb.34.2020.12.01.04.07.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:07:47 -0800 (PST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] config.txt: fix a typo (backslash != backquote)
Date:   Tue,  1 Dec 2020 13:10:51 +0100
Message-Id: <20201201121051.186050-1-stepnem@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Štěpán Němec <stepnem@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf706b950e..9700f6ebf9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -64,7 +64,7 @@ The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
 A line that defines a value can be continued to the next line by
-ending it with a `\`; the backquote and the end-of-line are
+ending it with a `\`; the backslash and the end-of-line are
 stripped.  Leading whitespaces after 'name =', the remainder of the
 line after the first comment character '#' or ';', and trailing
 whitespaces of the line are discarded unless they are enclosed in
-- 
2.29.2

