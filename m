Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F100D1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbdEKJlV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:41:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34310 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKJlU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:41:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so5642233wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILSr1V6JCDaIZO2Pz9WxseRFZMeHidpoF/4wxhYcNC8=;
        b=QikID7uVUoFCXiTGcxVXAL4tAA/cbwvXUt29yo9pUbrzWh+y0mu5AsBsTPUerly61a
         w5EbamewyxHcXxc3bnQhRc4azWLnABKXCSy51p9BBfKEyivJE9XBlBT2xAhVjDvkvl5z
         zSlTi0k/c8VXIv91n/ir/+1ZPAXNUtSFLxQeqOMbwWvR4pePuvXU9ECtNq0j+efFcqyA
         viy/3MhavqphuC5AzaO+S7dGLSFSt4jHEzwZX5HoKCQyuvw7G9klpZ7HypfZpqL/3LAp
         2VALRPb7Gal3UoHrYhm9lPaSFFHBXdbYtthPBU50K10/GvvNiAeAURlYtsYiC6gZk3cB
         /86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILSr1V6JCDaIZO2Pz9WxseRFZMeHidpoF/4wxhYcNC8=;
        b=JPt2eNvGAAFLK2TO5hPq898UjCkdiKZG8wKIM5p6u8epCqRU0xS/MwEBoLbM2iCVOo
         5n8E+7vbQG9JovkJAWBZC6ytQN7AzvbZqcoP6Uo7eTd/AvNRxtw/VmdaVioI3LCOUn2r
         MTkoPm5Wr5uQpuI229YFFGxs0GzZMnYiKeBXThLzMYrRZXidLHm9RRxAPXLX2iogeHAf
         B1P+NitNhskURH+XvyHSuUzv8+Xj5dM28iI8wK/KhagBugTUZolwvMNikPYlFkdPFjE2
         RiU/8jZ5+ZW3gxmU1nPbVfHWa8KSFEwNIgbpUiIZ10dE/g6CowzbK+aeqoWJHK2WFnBS
         zZKQ==
X-Gm-Message-State: AODbwcAv6TWyhM6D6cSHJojMyq+T4i0KDSSoJKchuYvplWXaLjtvnnx6
        ZpYQcnYoZyqVPw==
X-Received: by 10.80.172.122 with SMTP id w55mr103454edc.120.1494495679490;
        Thu, 11 May 2017 02:41:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h46sm16386ede.56.2017.05.11.02.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:41:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/2] perf: show that wildmatch() regressed for pathological cases in v2.0
Date:   Thu, 11 May 2017 09:41:06 +0000
Message-Id: <20170511094108.8756-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511074354.11336-1-avarab@gmail.com>
References: <20170511074354.11336-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a brainfart in v3. I thought I'd fixed that subshell cd issue,
but turns out I didn't, actually fix that.

Ævar Arnfjörð Bjarmason (2):
  perf: add function to setup a fresh test repo
  perf: add test showing exponential growth in path globbing

 t/perf/README            |  1 +
 t/perf/p0100-globbing.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh       | 19 +++++++++++++++----
 3 files changed, 59 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p0100-globbing.sh

-- 
2.11.0

