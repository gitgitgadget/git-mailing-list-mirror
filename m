Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA4420248
	for <e@80x24.org>; Fri, 22 Feb 2019 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfBVTXi (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 14:23:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46547 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 14:23:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so3521144wrs.13
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b0cLoJKtccS95z+/nWN5omJxNzlj7V7zFkf/a7xun9g=;
        b=pkwpxvFRNiKpnTCbYZsOmoFQKAfLVF8aaHdE+WppdxfmBuRh+GcVhfbJn5Y5juLJn2
         uYxxxbCgd7juqzerNYeNxbehYUYHjTvneNQU9OE8Cl8+ayby7J941z2egMBO5nWMbOwE
         DJ5jvgwAP+5LclU9/17ElXBEjwC+XjiK1UCnJbK5oT/0AksJbGy7oj0dLxVID+0Q8Edk
         pbqpAR+hmjE7lgB50QWen+XsU/niK6qfIz2+91olXTNQ/Ng/87xy4Vzeg37g8tmCJ8AD
         b/JNBvDatQ99Gn+V8uC56xCQjCXj3Mfp2V6WUSw1OTvbsJdzAHT4LRLvkgVWQfaiPwzu
         9lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b0cLoJKtccS95z+/nWN5omJxNzlj7V7zFkf/a7xun9g=;
        b=R7XJsYX+1GiUufUehnYZO12CwdgWHi/z5lS9tuv2m1ka6T40jSM+wtN94iJhPSZzQr
         GBUtJK5dl6zyh9GjigSHOp37WqViALtFPB1bDw3UrnzNpgnQWPtUHxfOKvcVJbLJJNjZ
         VQ0X7weP40KYRfUS1MDrqqCkTLoNcUO73Xt41y4J1Gh8i+pTcKHDXYIs8i1UDgHxLyMV
         LfUpbbWoMOaEJAPdvZlpBxtX8sr/gpaBtAY4gkJiCvYXq5O0yC6Nc35M7Y6PcoZuUxww
         AQqXbVbnNBsPyv+9lqWEBBfSkch6kX9HKKnQWfrHzIsRHTEAKqYJ533AUU9o/qgyMKo5
         BkVw==
X-Gm-Message-State: AHQUAuaeeElCAX9t1bc9vN5cxrvqniqy28TIPZX/1Ti70Oc8Ne823OH3
        o+oCEhXAOtXnpCHFxxWvC6s=
X-Google-Smtp-Source: AHgI3IaCrLGJHAeJAjVfsNPe07cnx9kQt6pcauBIymJr+3Fe4j9D4x2tNA/zNyANxYqldv3B/EJb+g==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr3916275wrn.157.1550863415574;
        Fri, 22 Feb 2019 11:23:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p9sm2056416wmc.14.2019.02.22.11.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:23:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] commit-graph tests: fix unportable "dd" invocation
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
        <20190221192849.6581-3-avarab@gmail.com>
        <20190221204310.GS1622@szeder.dev>
        <878sy86anh.fsf@evledraar.gmail.com>
        <20190222105053.GU1622@szeder.dev>
        <8736of6gej.fsf@evledraar.gmail.com>
        <xmqqbm33r7zl.fsf@gitster-ct.c.googlers.com>
        <20190222183553.GA16125@zaya.teonanacatl.net>
Date:   Fri, 22 Feb 2019 11:23:34 -0800
In-Reply-To: <20190222183553.GA16125@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Fri, 22 Feb 2019 13:35:53 -0500")
Message-ID: <xmqq36ofr5jd.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> s/ as/ has/ ?

Oops and thanks.  Here is my second attempt (which makes it v3).

-- >8 --
From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Date: Thu, 21 Feb 2019 20:28:49 +0100

Change an unportable invocation of "dd" with count=0, that wanted to
truncate the commit-graph file.  In POSIX it is unspecified what
happens when count=0 is provided[1]. The NetBSD "dd" behavior
differs from GNU (and seemingly other BSDs), which has left this test
broken since d2b86fbaa1 ("commit-graph: fix buffer read-overflow",
2019-01-15).

Copying from /dev/null would seek/truncate to seek=$zero_pos and
stop immediately after that (without being able to copy anything),
which is the right way to truncate the file.

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d4bd1522fe..561796f280 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -382,7 +382,7 @@ corrupt_graph_and_verify() {
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
-	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
+	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
 	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
-- 
2.21.0-rc2

