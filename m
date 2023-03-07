Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BBC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 06:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCGG7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 01:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjCGG7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 01:59:11 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0788DA2
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 22:58:30 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id bo10so8310179qvb.12
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678172305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVVuJ3c6arR4O2pLFGB6rMzPk+273dee8DeFNd18X44=;
        b=Y+h+CG+lIlS83qCk0FL8AvqFhRwaLTZ9iPcVhsLnvacqiCnJRlU5V6jJ0L8u6mqEoL
         nWHMhvlJ7VsFEbpoWMTnSc2lDtKmVemTNwmhdn4IcM1t+i3bgjC6oLyBGnaRsZNwykfj
         E5eaiDy8AjKuhQHmUnVMALqNKIeAuKlJiuR7sQbCcLe8/8DgoFUMp/UJbOzruZHlpV+7
         AROqpSyhjRfkjIzP11GN6u2Djr80j+JRzeLH97p2H2htmpcBkMkvtpuzzJtpUJ+X6yUU
         Z/hx0VBs0c5TQfaf/BqRPDjK3aZuiOQheCNkd2NO25nuZzK1Yc7J4flmvckMX/7macCX
         pt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVVuJ3c6arR4O2pLFGB6rMzPk+273dee8DeFNd18X44=;
        b=F5rvDH3/hdAODeui5P1IIB6hPXAx9u0Cn6jlYQeLnMD9kGixR6kDolQalmNz8K9y8o
         pwy0AkSBohv3vzsOaDXjooDlcWk6KZuMxmV8OWtkvxlcCrdp4pacfAxRAl2kG58Ca3y4
         fTK9q+q/pGq6D6OMxL1/mY3PxuQXHCTOhw1zWUH8xwLe2Dbrcd2Tv4w6uXQhwMcpNH54
         SRPLdvIOGHCRyOr40x5TF1tF5Yi/SjhbaYcblJawu6rwVrtjf9Q6X2vf3/tsVaBDL3fu
         O8tCBbBvjbicAE+NyNcpw2mBIT58DFVDsFKlqJntcn307qSyXSJ24uCrnq1iT4Xfyd6u
         R7fw==
X-Gm-Message-State: AO0yUKVGNmNdZnkSSXFMcm62TEfuY5/YRiXadGy748/b+Kjyfg228CDV
        kJLyibl5lFVmx48519LgnyzWAOyybQ0=
X-Google-Smtp-Source: AK7set8+yNjIdDyjPXudmu6z3ThqoTIH+S4H1bWjQw7jTAKeS/qfkV1Xf0RF7jugywTW/bS7v/MLyw==
X-Received: by 2002:a05:6214:248e:b0:56e:a6f1:8cf with SMTP id gi14-20020a056214248e00b0056ea6f108cfmr24826835qvb.6.1678172304722;
        Mon, 06 Mar 2023 22:58:24 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id l5-20020ac87245000000b003b9a426d626sm9013958qtp.22.2023.03.06.22.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:58:24 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [PATCH v2 0/2] diff-files: integrate with sparse index
Date:   Tue,  7 Mar 2023 01:58:11 -0500
Message-Id: <20230307065813.77059-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230304025740.107830-1-cheskaqiqi@gmail.com>
References: <20230304025740.107830-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse-index feature within `git diff-files` command.
Add necessary modifications and test them.

Changes since v1:

1.Add an empty line between the previous test's closing quote
and the start of new test.

2.Use "git add --sparse newdirectory/testfile" instead of 
'git sparse-checkout set' to have staged changes outside 
of the sparse-checkout cone

3.Edit commit message to be more informative

(sorry to send this patch twice ,I forgot to --inreply-to the origin one)

Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 52 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0

