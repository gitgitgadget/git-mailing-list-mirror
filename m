Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D690C20286
	for <e@80x24.org>; Thu,  7 Sep 2017 19:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755934AbdIGTXu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 15:23:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34207 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbdIGTXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 15:23:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id k20so288837wre.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DZYbbX9Cm4leHisQ1/UHy6X2PtGpbRr7Gf19N/EtfOo=;
        b=Zca8X+RMasZ2uk/+ca1OE6axsxG41UHo/lDy2K7/mR66Rm0bzKFbvKqYBiyTLCHLuX
         /XBtMnQHjVXWxh/Ho+iAHqpJd/HztrTd8VuGQmrKkJaQ4DpZLg6ASCpQfqlhIBGHSNXP
         s++rqfKght4h7DxL5NavdKhR0nqjzuVSpNNnzf4gHaZsi3R1OMGoQA8GZcU9/VGCSZJO
         A6SQMQdvGrp9BDCpte7hE9dj3tfzECfkChP8ehAczAO7lawY81gNRzo9J8OGNWMReNRa
         tiMEta9jiu01HNH0mDQLpP2Vali5O/BL5jWg+nB9Hjgaa4ccJuhBegET7A108R8CTjXJ
         4T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DZYbbX9Cm4leHisQ1/UHy6X2PtGpbRr7Gf19N/EtfOo=;
        b=e26rEEIrEqF90dWHfmylXzepmI9UVEbM9WLFdfcJmtB3b5Y1PPynXkq6Gk0EO3bFi6
         qj4NMyx82ub91eTy6WEe8+kCJNce9fEItCgrEG4+LVNY56V4FI0qsy3YhCeew2s9wnaN
         GKunJWdApG2C0fIkirFXhaCrFsaPlMvC2zRZMQmOwGHWwhZAhXjWJYfg67eIZGjhvyXF
         Gp/WQGHm3sVWRfeZYXv1f3ljd6pOlxIcVzjVLB/XeLcMbDgmOWI2rJUoVv+WhzTRJOIb
         SJdNnEbhlNZCmE0zlPdkkuzAg3lsNSZ/z/19oBdwEx/D5EW0Ti8l8wQ5jdp8H+vg+R+G
         Dasw==
X-Gm-Message-State: AHPjjUi/2ECiobKbnADtrZtonhp0rA5bWlX3MhnHLf12Raq4aZRY6YtY
        VSkaRWZM9LN1n9fsCrk=
X-Google-Smtp-Source: ADKCNb6BPPe4uXz1oirIDjL0P06Ot+/DqKO2/8dpnrzbxJ/u0G/i014UapPQXm1UdgQsU3kzazU1Sg==
X-Received: by 10.223.195.87 with SMTP id e23mr286269wrg.77.1504812225565;
        Thu, 07 Sep 2017 12:23:45 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id m4sm16868wmf.0.2017.09.07.12.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Sep 2017 12:23:44 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] read-cache: fix index corruption with index v4
Date:   Thu,  7 Sep 2017 20:24:12 +0100
Message-Id: <20170907192412.8085-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-qg@mail.gmail.com>
References: <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ce012deb98 ("read-cache: avoid allocating every ondisk entry when
writing", 2017-08-21) changed the way cache entries are written to the
index file.  While previously it wrote the name to an struct that was
allocated using xcalloc(), it now uses ce_write() directly.  Previously
ce_namelen - common bytes were written to the cache entry, which would
automatically make it nul terminated, as it was allocated using calloc.

Now we are writing ce_namelen - common + 1 bytes directly from the
ce->name to the index.  If CE_STRIP_NAME however gets set in the split
index case ce->ce_namelen is set to 0 without changing the actual
ce->name buffer.  When index-v4, this results in the first character of
ce->name being written out instead of just a terminating nul charcter.

As index-v4 requires the terminating nul character as terminator of
the name when reading it back, this results in a corrupted index.

Fix that by only writing ce_namelen - common bytes directly from
ce->name to the index, and adding the nul terminator in an extra call to
ce_write.

This bug was turned up by setting TEST_GIT_INDEX_VERSION = 4 in
config.mak and running the test suite (t1700 specifically broke).

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

> Will send an updated patch in a bit.

In a bit was a lie, I didn't get to it anymore yesterday, but here it is :)

 read-cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 40da87ea71..c6c69cf027 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2103,7 +2103,9 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 		if (!result)
 			result = ce_write(c, fd, to_remove_vi, prefix_size);
 		if (!result)
-			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common + 1);
+			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common);
+		if (!result)
+			result = ce_write(c, fd, padding, 1);
 
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
-- 
2.14.1.480.gb18f417b89

