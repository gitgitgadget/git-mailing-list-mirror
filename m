Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5941F453
	for <e@80x24.org>; Tue,  6 Nov 2018 10:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeKFUMv (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 15:12:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47020 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFUMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 15:12:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so12893982wrb.13
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUCsUHSBKQ7UzGKb4JIjYYEBOfAUAlaK3Z0CEXQ1ovc=;
        b=cdMjkyd+ZYyXOrulnTbwNfUgCw1PDkcthMH/KoEPy7os5LqAgYcODhBcp5MEvW3e4R
         sr0WIkOaf6NN+wcEYkgQbHJeN+4x/wBy37ud28RVmNnwcDhEavR3cjnFEVTNb6Mks3Bg
         j/SwjNdDAeKyjo4HtyXQY8lyLWnkmKmxWr8RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUCsUHSBKQ7UzGKb4JIjYYEBOfAUAlaK3Z0CEXQ1ovc=;
        b=KhDsvMO8ZEQZx7PmmmRsgZdgCK+dh9fytR7+yREFlBNgVSMzEGvOeEnl/OGH6SqD2I
         jGT+Mrw12vwL2j18bsyLl+YmwTNxzSoN+9DKuV+d3DtumC0cE4xZN6aL2sPrrvgMjHnZ
         RRFG4AnqjxrVWGxVS0h+69jYgkCyHnH7+Q0A2u/t/13ZfXtUvjoAfEnA72nBDopFdQCr
         +EZVibV906Zk1v31IhWF8LjUBNgYi6JWnzgCV0ukTlGXGp3yu+uyFmw70fZFoh7z4Llo
         WQW1R9R1kxpj6PnpsMBg3JsKCagsQqQm/QgKXyTxQQQ8L5JWr/QV+mhION1pb8IHJRjM
         ZmtA==
X-Gm-Message-State: AGRZ1gJQnfrP6zBFyocik8C1/b+Ipyi28Q0eCCrubdwexYJ/dm1zBB94
        uRPhJ5B5zEE+dG1kO1KHICoEJ9rD2RI=
X-Google-Smtp-Source: AJdET5ekxVmY4s1o/uNl/eoEldKjeP8/pLS9oTesyL6QogZvShxZtluFcG0zZ9ctm/J9j/9ZMN4MBg==
X-Received: by 2002:adf:fdc8:: with SMTP id i8-v6mr2349046wrs.276.1541501293454;
        Tue, 06 Nov 2018 02:48:13 -0800 (PST)
Received: from vanye.hemma.eciton.net (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
        by smtp.gmail.com with ESMTPSA id t129-v6sm1550446wmd.14.2018.11.06.02.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 02:48:12 -0800 (PST)
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     git@vger.kernel.org
Cc:     Laszlo Ersek <lersek@redhat.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] format-patch: respect --stat when explicitly specified
Date:   Tue,  6 Nov 2018 10:48:11 +0000
Message-Id: <20181106104811.14625-1-leif.lindholm@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 43662b23abbd
("format-patch: keep cover-letter diffstat wrapped in 72 columns") made
format-patch keep the diffstat to within 72 characters. However, it does
this even when --stat is explicitly set on the command line.

Make it possible to explicitly override the new mechanism, using --stat,
matching the functionality before this change. This also matches the
output in the case of non-cover-letter files.

Cc: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---

Note:
In TianoCore we have LotsOfGloriousFilesNamedInReallyLongCamelCase, so
our official submission guidelines specify the use of --stat.

 builtin/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd86..07e6ae2c1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1009,7 +1009,8 @@ static void show_diffstat(struct rev_info *rev,
 
 	memcpy(&opts, &rev->diffopt, sizeof(opts));
 	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
-	opts.stat_width = MAIL_DEFAULT_WRAP;
+	if (rev->diffopt.stat_width == -1)
+		opts.stat_width = MAIL_DEFAULT_WRAP;
 
 	diff_setup_done(&opts);
 
-- 
2.11.0

