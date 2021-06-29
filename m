Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D630C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D869C61DC8
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhF2OAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhF2OAV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 10:00:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9AC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:57:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so1990034pjb.0
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTTo6Ac1ofsYIUlKphkC7ZTXj9O416HphY0fqN6rvPw=;
        b=vHpF+DjpJLjuVPjDzt4+3/cxtDyRkOpYoySF/UoSmYK6bQWsiVY0pdvwp5XV6mDux8
         C0nOP5A33LShYMsiCcnqFaUreIpLnnweqhT8SjPBUe8IQk5rwNR1wSjdqAkAPSl4Rtyo
         Q4o/VlR8E8TIIIvlHSuRjO28meuNm+IlHwyoYHUtxHjivP2AvkE9C9+FyHDDx2Yt7biE
         sVwg3JaSjI2kqSEYXJ8M9/B2hHhJFksJDSq7wlyHTana3TQvqw8BG82w6qst0JfM2MBD
         qnY5armnomFHmwFbXFMsaq8YY6Mvj2NHobQikYCC7hhmFxQUPbUvozypixrkYCUKURwB
         Ud0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTTo6Ac1ofsYIUlKphkC7ZTXj9O416HphY0fqN6rvPw=;
        b=gltmxQL80YJYcSzHXNaHqYbfl63DixktHiP8hGEFW4SSrlSmwFPYgTEglesWuAhkhD
         vwZ3yJ3FZ42o45YkH8nWwbSWzRkjLEL/QFZQorc5xbwld2eur2RfPYDlLhXtDDPOi/M0
         tiUDzk9AKBAsoxAX71vIxsk0zeDwo56YCA3Kau02fpBXtSRYGnTaJu4TxBYk7Ch6voYJ
         PUt0oIjrNFJV6s7SadkLdw4qaeuxZ0+KUrtWqee0qyM9uN6ZEzEu3D0NjRCfY5tqNuk2
         hUZurLW5EKV7JnHsZh9X67z4K/haYEvXFpnEw6V9ZYOHUS887YmQxcb72H97bhLEj9te
         Ocug==
X-Gm-Message-State: AOAM531sTCAbziuHj7Iav6rJVYM937eQiqE9vsoBTVotI3aY/SZam07R
        1QSozIQd8Ef1Mbgx/tQu0UXnhyHP0ko=
X-Google-Smtp-Source: ABdhPJxF2wahSci1hEMtMhXcM14ZdbHFyzJXemhe2J36DGBzxBQvKg9+MioJf8g6Y2ibpmINvV1AMg==
X-Received: by 2002:a17:903:1ce:b029:128:e252:4480 with SMTP id e14-20020a17090301ceb0290128e2524480mr8984754plh.74.1624975073303;
        Tue, 29 Jun 2021 06:57:53 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:8e5c:5bd7:f8a:333f:cf5])
        by smtp.gmail.com with ESMTPSA id c62sm18376572pfa.12.2021.06.29.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:57:52 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/2] t640{0,2}: preserve ls-files exit status code
Date:   Tue, 29 Jun 2021 20:57:42 +0700
Message-Id: <cover.1624974969.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series to clear false positive when applying Junio's suggestion to
to a series written by Ævar [1].

Not that we have any conclusion on that suggestion, just to clear the way out.

In v4, I dropped the test_line_count_cmd completely.
A local to t640{0,2} helper was written instead.

Hence, the changelog and range-diff for v2 and v3 is dropped.

1: https://lore.kernel.org/git/87r1j42ffz.fsf@evledraar.gmail.com/

Đoàn Trần Công Danh (2):
  t6400: preserve git ls-files exit status code
  t6402: preserve git exit status code

 t/t6400-merge-df.sh     |  30 ++++++---
 t/t6402-merge-rename.sh | 146 +++++++++++++++++++++-------------------
 2 files changed, 100 insertions(+), 76 deletions(-)

-- 
2.32.0.278.gd42b80f139

