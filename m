Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F00E1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfHRS2N (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:28:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRS2N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 14:28:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so6384407wra.6
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahcbSRj/v9mEepZ2JG2IjEq24r+5A4zJGoDXz3QkxTM=;
        b=gcUZIyBN41reC9yFH9RYnE5rIH2Urxfp5gQ5zaMZ2v5yb+bWMmOcjzGh0o9ZWf9Pja
         A72WcGeX9k7HMUGhVEbcfpPaBB8tSMLxhtte0pKEoBDofLYBQ5Bbi55YuKVMMnkXtAGU
         1vKgElpNVTSsmkykNbMXvRg/hsoUlWS1sAq5Y511drt5gmiwNe292i0F+9M1Fz6pOZ9d
         Web9qOA+ibXhLLkgE/QSXFAD854iulZq0o9CkHwKAj7g0vmoeb2XgYbmYTTHkGQoVJrE
         Z00VujU32p2EYUpJCLbljfeQsS85EaT6Ho2xo3IRUD7BPs9FWva8UQktG5uH6lTo/MPn
         q4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahcbSRj/v9mEepZ2JG2IjEq24r+5A4zJGoDXz3QkxTM=;
        b=AObAuwm/ltvEgzrT3i1VVDc16ylUOh84tHXInGeML50pQH24I11G3uYWe2FQ70jgO6
         j4Ys79Ij4F0u1NHM2igJHZhCiqRuTWoG3tU9D/Fy26wkU3EiqhGOxU6K5m3AuuBqRAU2
         ghk31FbsenL5TgT0biapRt6fU/7Thwcy+KDMToKHlPUFsLWWOh1LWBEm6c+DwS8usgmh
         WuogbhBzJEQdvoiToYCLbC3ojSKa6XDUx50/cA+2eciztSCPrQrzA4hy2WoRcu48f3T/
         uCxIAOo10sMcWkeZJg6CQGClrwp8wFQF5FBzkLN1yytJgc39amp6F2IKE7Fqsj/pN56b
         IAiQ==
X-Gm-Message-State: APjAAAVw4tenCPpFx/fqQqTutaGR5iFdxK+eGubmS6yeqbmdcLce12Ll
        hQst9ZEqDYsUs7tOVdNnPXBJrT6v
X-Google-Smtp-Source: APXvYqxKpYobt3/D/qFLDd7QMdZLK3yOyYuTbOFVfjqeZTcZdKrDqgbSHeF/+ecCxhdl7lJ8Yjc3FQ==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr19772117wrx.328.1566152891316;
        Sun, 18 Aug 2019 11:28:11 -0700 (PDT)
Received: from localhost.localdomain (x4db53457.dyn.telefonica.de. [77.181.52.87])
        by smtp.gmail.com with ESMTPSA id c201sm24112584wmd.33.2019.08.18.11.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:28:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 1/5] completion: offer '--(no-)patch' among 'git log' options
Date:   Sun, 18 Aug 2019 20:27:57 +0200
Message-Id: <20190818182801.7580-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.349.g73f10e387d
In-Reply-To: <20190818182801.7580-1-szeder.dev@gmail.com>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e087c4bf00..57f984340e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1804,6 +1804,7 @@ _git_log ()
 			$merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
+			--patch --no-patch
 			"
 		return
 		;;
-- 
2.23.0.349.g73f10e387d

