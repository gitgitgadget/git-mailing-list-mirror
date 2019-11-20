Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D830C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037AB2245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UieqIeW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKTAvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:22 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35044 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:22 -0500
Received: by mail-pj1-f65.google.com with SMTP id s8so3402412pji.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ABxWWyvohAslzq6J5HDDQ3MDaiMrpY8anuSFIFS94I=;
        b=UieqIeW2vAClgjJRtHMGiw/zKCnhmC8YOoVtYlc3SlTvKK6QJofB6e+hkjhsBj46Aq
         qxUGgxe3NzY7iTn3zVw5KB4i8nBJETlcfXFf89alwewsMgo2I5f11k9fuKa6Pkb2/9Un
         7pVQ/EXnnGGZJ/540i/rQfs6RGOdXb9/gFMqRB0VyK4+H0YN+RUp9pTNEQsBdR3seJvU
         XE3vKLnMWVKrJo4I829Ba8S7DkYLNcKD8eKBWYjnzEL0jECbuBWzb4N1FwK+htab9LXd
         2YKxY+l6gJVInalOpuTuDpEJBG7EeOt1LXs5F1KbKhsi1ZZyd6BsPSluKgZ1VZbBE0mw
         23lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ABxWWyvohAslzq6J5HDDQ3MDaiMrpY8anuSFIFS94I=;
        b=OhW+O879HcG/7GAID+hewIdYlwAVQusQrMofEM/qIWiQOor1SsJC54ielGnJGGnTgM
         Tpid2Id7/rNS41kDKhGYJI0736yV6MP57Wqq3IXvw2xlRvpmReJRgrRj7grMXJPlBV1q
         zOoIMksjN0MUnU6jbqnY3Ab+5MQNAEoO6q9Yxo6VGuF583W1dFXNUEibIfu8oBuNu5Cm
         EWcuNNPKlb4ipRWpWMI+qjUYz5ZNGt3pb4KEI7D6lwTUx8iLyowADLyNkOuWQD9U25Bs
         wlzGnUvVbVjIko9LX0jl9BVe0pjZmjoHk/80Qp+URiAe2kYk9IlhDLpsqSZjAwyri3Mm
         ANbA==
X-Gm-Message-State: APjAAAU/2A9CCEbiOrbVjBL/YKpEPDxfffKtv4gOgyxxpdrD0AR3I8bQ
        DL0rEuascyT9s+nkAa17lajlWAeb
X-Google-Smtp-Source: APXvYqxKPSi4FTihF6WJxXXRCqyach64v7ay/g6m/x/BSSZXPLZUg9GmWIRNq9wLBp9qDqC0CZSumQ==
X-Received: by 2002:a17:90a:fb57:: with SMTP id iq23mr486506pjb.79.1574211080862;
        Tue, 19 Nov 2019 16:51:20 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id p9sm27245780pfq.40.2019.11.19.16.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:20 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 07/11] t4205: cover `git log --reflog -z` blindspot
Message-ID: <1519677b30f7a543141c7a0c313c6a965c616a58.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite does not include any tests where `--reflog` and `-z` are
used together in `git log`. Cover this blindspot. Note that the
`--pretty=oneline` case is written separately because it follows a
slightly different codepath.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4205-log-pretty-formats.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..0335b428b1 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -134,6 +134,36 @@ test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
 	test_cmp expected actual
 '
 
+for p in short medium full fuller email raw
+do
+	test_expect_success "NUL termination with --reflog --pretty=$p" '
+		revs="$(git rev-list --reflog)" &&
+		for r in $revs
+		do
+			git show -s "$r" --pretty="$p" &&
+			printf "\0" || return 1
+		done >expect &&
+		{
+			git log -z --reflog --pretty="$p" &&
+			printf "\0"
+		} >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'NUL termination with --reflog --pretty=oneline' '
+	revs="$(git rev-list --reflog)" &&
+	for r in $revs
+	do
+		git show -s --pretty=oneline "$r" >raw &&
+		cat raw | lf_to_nul || exit 1
+	done >expect &&
+	# the trailing NUL is already produced so we do not need to
+	# output another one
+	git log -z --pretty=oneline --reflog >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
 	test_commit "message two" two two message-two &&
-- 
2.24.0.420.g9ac4901264

