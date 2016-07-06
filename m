Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1C42070C
	for <e@80x24.org>; Wed,  6 Jul 2016 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbcGFStE (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:49:04 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34949 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbcGFStD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:49:03 -0400
Received: by mail-lf0-f51.google.com with SMTP id l188so160417193lfe.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 11:49:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEgsPM9laCBnZsZLaNFyLgNJewLBsEY08zv4fEUhx/I=;
        b=xFclbz6fjhuArz4MlHT+pa8uSNYcIS4+jQE/mK+JGTP4GADQHlm/Hw5antEUWTvKi8
         8HUNU2eoYytPuqlCk52+lgekJ5C713hbz+e1wFkW+wGm9VUYMiggi94nypvf0p8KDMMx
         muU8iSuQtdFLAn1/1PEGa5nzm8per0h3HQ194CAXTPxHIMwJ8YSQ6hPPrE4eTpnJAF0b
         0NJMenHCBnmnaiVvCKDdJrkEYvwsi85dKV4mr2qD9aTe4QH3myLvVTbsLh9SBrDbz8OC
         dqPDigwLyem3c5ikQdK6aa7adgpNajEaxH48laPS+4XGBhrhbGUKuCFguSql0gz5Gsy3
         6NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEgsPM9laCBnZsZLaNFyLgNJewLBsEY08zv4fEUhx/I=;
        b=PSCJT8R4iDBUvzUXH7zAscSud+Mf27lvv3lJZ33b2tMDy3tzaSXvxwzyAzqjPrc42Z
         cA/59kiWGV1QWlT4rG9YkUn6FnpL+fAjEiP71LCdKut4BtsiKUAisvTIqyb99poB3wEy
         hqNNaTbcS4zNzCBZkfJA9jSSeGWlUOn3U4l9O2ZoycgPKK4fYhT5Z69LHaGBwiHG9S16
         x1QFbXs1zA5xl52SmA4CRW/GN8/ME8JphGt/4xC8MsqeH9gdSnj/749e9eMn+2pGUErP
         JDfJskNz5vuk+hwyeVYB02RYYTH+611V/BEGktn5rIG2oeknW++c9CvK+HPkQUK9rHhl
         jmkQ==
X-Gm-Message-State: ALyK8tJvhwHE/Rn6J+hZswfs2nlLPlQKhSP+xNhCadVDothcxlQFMuUwznX7SIsCiiRKpQ==
X-Received: by 10.25.44.85 with SMTP id s82mr7783777lfs.197.1467830940703;
        Wed, 06 Jul 2016 11:49:00 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm6686199ljj.3.2016.07.06.11.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 11:48:59 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] cache-tree building fix in the presence of ita entries
Date:	Wed,  6 Jul 2016 20:48:27 +0200
Message-Id: <20160706184829.31825-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160704174807.6578-1-pclouds@gmail.com>
References: <20160704174807.6578-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

1/2 is the same as before with some test fixups from Junio.

2/2 fixes the empty tree generation found by Junio. I split it out
because the commit message in 1/2 is already long. And because it can
happen even without 1/2 (i.e. yet another bug :( though really hard to
happen).

Suppose a/b/c contains all i-t-a entries. Without 1/2, we skip adding
'c' to the tree object 'a/b' (by luck). But if 'a/b' has _nothing_
else but 'a/b/c' then again we will have an empty tree object, which
should not be added in 'a'. It's a cascading effect all the way up.

Nguyễn Thái Ngọc Duy (2):
  cache-tree.c: fix i-t-a entry skipping directory updates sometimes
  cache-tree: do not generate empty trees as a result of all i-t-a subentries

 cache-tree.c          | 20 ++++++++++++++++++--
 t/t2203-add-intent.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.8.2.537.g0965dd9

