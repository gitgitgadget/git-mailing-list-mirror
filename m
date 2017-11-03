Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CC320281
	for <e@80x24.org>; Fri,  3 Nov 2017 01:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbdKCBGv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 21:06:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:48759 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbdKCBGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 21:06:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id 15so1176486wrb.5
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpJdE5ho1PbhrucqWOnLbc2XFPnEJC3jQ9cuta02sGE=;
        b=U04bX3gJDeD/HdBRWKzjIU+tZ4qAZcJJd+n2XPHeN4D3TcSiUq25ynCLlCCiCsY04e
         uIAfyuMCceBT5ylJ1SRseyoQMXo/uHWcci3td4GgTk2awz++8K9OZUIVIgQlXL2T5WDO
         EOHzFgOD/tyvvFTwlSPZ+OnAWE87d4lV7NRQzBhtQJC7Oo84g0fvvOWRQQjps5MhPfXz
         19pWxqZhnsnbvAeJv1Q5vrfNNzBLSH4TE3rtSC/1vx1jhdJstD4bLALM6FGv5KGtP6C3
         BX/E5JVkzFTeJ1m8C2/5PSdgtpUWPo89Q05zlAZDnq79r/FSLZuy1Ae+FK4ppXK56nQX
         gNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpJdE5ho1PbhrucqWOnLbc2XFPnEJC3jQ9cuta02sGE=;
        b=aq45lvel4G4rawYVdtjHhLh6hf7TMT5AUM9CqYT+/DPTkPP70bDFYLxA75w/68nyFN
         +KS5LHs9VNld2dwDeXYPVjNWwe/m5Bc2cnZ/g9vN3fla982+C7FqSsy9LzraHJ5manCq
         77mXFMf05CAAkXD9Zzj021Za+FHhsrdklotHYhx16EdDB1zuQg0KgWOtrv+VnJQPNmCS
         eDgnlKgnd3WAoP7HvfgqljcVu/Ye5o+DjzSV+eZhwWD3LDoTApGhyEwvdqd3fN0Dv+IG
         qIoWk3U8NWzFneQDozt/5QJEBmvFDiD7dp6lcNggSEmqdsz1g/43L2u3rYCQrM72V5aL
         bPLg==
X-Gm-Message-State: AMCzsaUhM8t2mf/ee+fThR+riK2fLKXb8C3RAGG5LY9mAygXiOnT97Cn
        YHhK19o3Ls/Ekc79jSi9xFE=
X-Google-Smtp-Source: ABhQp+T55Zgqu5YTXBl6GyNQ0fDQwl5bto+vANOLajlfCimDat+Jc6DIjtbc+r7qitIf5srqk3SBWQ==
X-Received: by 10.223.196.3 with SMTP id v3mr4734437wrf.255.1509671209166;
        Thu, 02 Nov 2017 18:06:49 -0700 (PDT)
Received: from localhost.localdomain (x4db1c389.dyn.telefonica.de. [77.177.195.137])
        by smtp.gmail.com with ESMTPSA id j13sm3121588wrb.18.2017.11.02.18.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 18:06:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] setup.c: don't try to access '//HEAD' during repo discovery
Date:   Fri,  3 Nov 2017 02:06:45 +0100
Message-Id: <20171103010645.25499-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.67.gb67a46776
In-Reply-To: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit ce9b8aab5 (setup_git_directory_1(): avoid changing global state,
2017-03-13) changed how the git directory is discovered, and as a side
effect when the discovery reaches the root directory Git tries to
access paths like '//HEAD' and '//objects'.  This interacts badly with
Cygwin, which interprets it as a UNC file share, and so demand-loads a
bunch of extra DLLs and attempts to resolve/contact the server named
HEAD.  This obviously doesn't work too well, especially over a slow
network link.

Special case the root directory in is_git_directory() to prevent
accessing paths with leading double slashes.

Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I'm not quite sure whether this is the right or complete fix.  I can't
test it on Cygwin, and I don't know whether Git for Windows is
affected with it's drive prefixes in paths.  Anyway, at least strace
output on Linux looks good to me.

 setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup.c b/setup.c
index 03f51e056..0cfc5e676 100644
--- a/setup.c
+++ b/setup.c
@@ -311,6 +311,10 @@ int is_git_directory(const char *suspect)
 	int ret = 0;
 	size_t len;
 
+	/* To avoid accessing '//HEAD' & co when checking the root directory */
+	if (!strcmp(suspect, "/"))
+		suspect = "";
+
 	/* Check worktree-related signatures */
 	strbuf_addf(&path, "%s/HEAD", suspect);
 	if (validate_headref(path.buf))
-- 
2.15.0.67.gb67a46776

