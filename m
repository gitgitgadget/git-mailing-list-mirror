Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC2E1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfENSsL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:11 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41321 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfENSsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:10 -0400
Received: by mail-yb1-f196.google.com with SMTP id a13so48059ybl.8
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfk1TRfxOcZlsxokNPrgCse88p6CBjQ+EJwegADPK5w=;
        b=MDIfteL4dYNcZEDOpimPyafl571sjcGgVbYq6qQjV+bm5fwbGGBNfTpzGHmwJX570I
         e2gNXy5UdcCW0cVaSBLt2ufMT6KlcpPaSVzg7FJrduc1SWPVpDj5Aoevw1GavFea8vTP
         k+beKF6ztJPgiu1041iwC/rwFXc0lEHyYR+12tV+YduPK+CzzMf0UNvzFRS2hapC8NQ+
         FB42euzXuDHfA2iICLxiSvhqR+KaZvS+lDuD7zPrP3m/CVTMUIbLmjl47SOLf+jwWFuc
         2Xnmb/Prq/K2JMOvzdoajfK02rFSi0ya0oPl4V8unP7t1lUqD6Z8w4FCSdPyUNhUw3qX
         oshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfk1TRfxOcZlsxokNPrgCse88p6CBjQ+EJwegADPK5w=;
        b=YCpzWtVbdPxeqrmgvfYTYBCLgrIWR3wkYTtG1p4bG2JbMCAoW0awyg0FRlC0sWN8S9
         OVybz0qGgRrdmVPGrWigvwmGotrVWFK8hZkVOO4Sr0EMCnDZiggnEnORBA8dB4KOPjKZ
         9lrn1I/pzIjTmJ/g+B6ua5ez+54txk8I1zvlXF6cLlKHAjnhBaT2gFqXEYUXUruoADn4
         THd/ItN7K0QV5ZlZqJqYzXMNlD753jF+wjXdPDPaIUyB8KZGk6/+LHqWuA48CBQzqlDW
         vk4uE/CRTNLsHH4MidK4ji3u2YzThJ49BuwK9znZqadRft335Re4UNx2Vp/B0UfTEzYy
         r+jg==
X-Gm-Message-State: APjAAAXgNoovJ7cfa2aGiXXmlgl/ocUI6R4YjdgMshUWZt5N4uw6vTRI
        Z7hDsSupreVqVIG3ium9CTj1UMFAfB0=
X-Google-Smtp-Source: APXvYqyxN+0Lh705SCTt1WnnevvPhWcU19C5uutbKNWRdOiWs0LOq1pbDaZmP9yLfZyAxMrw0BZuiQ==
X-Received: by 2002:a25:ec4:: with SMTP id 187mr16706408ybo.280.1557859689354;
        Tue, 14 May 2019 11:48:09 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:08 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 10/11] midx: add test that 'expire' respects .keep files
Date:   Tue, 14 May 2019 18:47:53 +0000
Message-Id: <20190514184754.3196-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git multi-pack-index expire' subcommand may delete packs that
are not needed from the perspective of the multi-pack-index. If
a pack has a .keep file, then we should not delete that pack. Add
a test that ensures we preserve a pack that would otherwise be
expired. First, create a new pack that contains every object in
the repo, then add it to the multi-pack-index. Then create a .keep
file for a pack starting with "a-pack" that was added in the
previous test. Finally, expire and verify that the pack remains
and the other packs were expired.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 8e04ce2821..c288901401 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -510,4 +510,22 @@ test_expect_success 'expire works when adding new packs' '
 	)
 '
 
+test_expect_success 'expire respects .keep files' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-all <<-EOF &&
+		refs/heads/A
+		EOF
+		git multi-pack-index write &&
+		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
+		touch $PACKA.keep &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
+		test_line_count = 3 a-pack-files &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 2 midx-list
+	)
+'
+
+
 test_done
-- 
2.22.0.rc0

