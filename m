Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DD81F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbfKHUIe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39308 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfKHUId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so5335708pfo.6
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=91gNwSg4vQuvnon4MXWVt/9qy9hwVpOg6PXc05+/n6o=;
        b=hhx0e/ygYeIwHYFIR1mDALcIXKLdB16LfhXvF4go3WujkTB2VjY7WWrlqnQaVYcv01
         51/dD3Yn3V/Xn7YWSH4k00A1PGP+NYq7O6khPJklwZHweq44lM1uA7W8D+HL22w8DrHA
         C3d705kBB4G8XPMjDPR5HhMnNcECHyg+jVVxoOqMiJ9PezRDbc3FLh2/7OuqgitOWEwg
         qI9oALfzgidUgT8bqWm90vTthAYhOAQ1Am9IcxKZA/BtImpw9tccauDeLXJcluPjfDuf
         ITntPIbTurcsS87Xaen1KjvtIBnxqw1iVHDDCGUpUYIGDhLOrkB90EWvQhbW3eWumHTa
         mbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=91gNwSg4vQuvnon4MXWVt/9qy9hwVpOg6PXc05+/n6o=;
        b=AtiZjlPLrWpEUl7RlamIM/rDjrK8Re6q8RRXoUuxXR+Mccbdp/QofmoNQ1+/a4WI/O
         XRhHhg+YfdRb2lDAWZNNrjx+tct2j427x237eKVgjUFz1JOqxJJVn6zkPgVxaXbE9nHP
         rQRnrF4aG/+oqSTzKtMOruWC37YmvsiozXSrgwZrxAtEpSn7R7Sx1SwE5E1o2aykn1xP
         ZwWHsm/CwabFMeN/xu3Hu9qsQbS1SLCHTYj/bNtgnolKwkey/7+8Db82gUiAwUoVNGuP
         J61AORLusUi2zgxH8XJGOreJUdKiP7qEbkAd4Ady2/0AhoG5vDodI/rb1liV42adKX3w
         nA3g==
X-Gm-Message-State: APjAAAV4Grvwpcj5Degyx/QcDF4W6nUDK5MYanWEREZIHqsiryUPkYH1
        rfV1bnsa6wjC9Zfh7wNUWtqoSYZe
X-Google-Smtp-Source: APXvYqzMsgbE41JN/rn+qnVCFwYOM3Xzyh+4vdKq5mPgJtXIFENJfLe0H84hl/+MlKaniUbY3vQMRQ==
X-Received: by 2002:a63:1812:: with SMTP id y18mr12726334pgl.302.1573243712157;
        Fri, 08 Nov 2019 12:08:32 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id i13sm6565053pfo.39.2019.11.08.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:31 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/10] t4205: cover `git log --reflog -z` blindspot
Message-ID: <b5950823ce90dd2476f002ed0370b7e0099a4d85.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
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
---
 t/t4205-log-pretty-formats.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..d35650cae7 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -134,6 +134,41 @@ test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
 	test_cmp expected actual
 '
 
+emit_nul () {
+	echo | tr '\n' '\000'
+}
+
+for p in short medium full fuller email raw
+do
+	test_expect_success "NUL termination with --reflog --pretty=$p" '
+		>expect &&
+		revs="$(git rev-list --reflog)" &&
+		for r in $revs
+		do
+			git show -s "$r" --pretty='$p' >>expect || return 1
+			emit_nul >>expect
+		done &&
+		git log -z --reflog --pretty='$p' >actual &&
+		emit_nul >>actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'NUL termination with --reflog --pretty=oneline' '
+	>expect &&
+	revs="$(git rev-list --reflog)" &&
+	for r in $revs
+	do
+		# trim trailing newline
+		output="$(git show -s --pretty=oneline "$r")" || return 1
+		printf "%s" "$output" >>expect
+		emit_nul >>expect
+	done &&
+	git log -z --pretty=oneline --reflog >actual &&
+	# no trailing NUL
+	test_cmp expect actual
+'
+
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
 	test_commit "message two" two two message-two &&
-- 
2.24.0.298.g3e88fbd976

