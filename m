Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FE91F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeAGSPO (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:14 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39594 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeAGSPH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:07 -0500
Received: by mail-qk0-f194.google.com with SMTP id r8so7422955qke.6
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LXQyH2yDUpB6AovzMJo/Ppg3r02EFFdxI6wB0Y33W7c=;
        b=VfC1fWAIqmqrPLQhlR2EMoKoxcVae0NJ0l17Gt0Z1Z2bua0kJb85x1oXStfVMlBldB
         3RNbr/dhE5sPWnUHEIeNT4kPXAktEJTngy/w/R0dAH6f7uNHWx361PFQaRGy1pmCU1um
         ag7amkgou0ZArPYuq03UeLxd5gWYnuU3ZF5T7ckDhVmh/QB3n2WT49x9RauIsFzEe0Ut
         y2Kj0Uxyk/xdbwEr5vwCsCdsnIn5AagWP3NQw9qrG7dq/iHe3YsSIV6dCs/y8U/SXRPk
         /tsFJ5piuwr1T1W33Jm/h31ZjPvwFt3LuRLzz/DV44nuaG6tgLP9JFYocqnds4DiILtd
         e2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LXQyH2yDUpB6AovzMJo/Ppg3r02EFFdxI6wB0Y33W7c=;
        b=NilKoQPjH6E/jDV5/2QePFUnL5s5sbGTScSLLsHzT8gOmhpdmo1BATMGrAZaYfEsE4
         4WywpkM0BYc9Ms9E8IGbko/ow7s0UiSnMd04huAm0Z218CZxq5ohubftsyAFZBEeoRgQ
         NT4XkPEQ0HzLmNsLVV15zCvUgbWqwgXsPHWyIyNEXMPyPsggz45rM8kiWICTz8w9FsI2
         h9XS8+47ATbIDRt8f9qItCWyoIaILlxdjUuS+P7ZuRNWiK2PXFH4jtWQDDKixoLpE3b/
         uK1kIrX6KZ7e+/yUwrL76Dov5ImD4Jr75zuyffK3PG4gMSeBkfWUgMa0K77zkHDdJ+dl
         KK3g==
X-Gm-Message-State: AKGB3mIh7HiOiBxNaT4e+wLFgpOHcugKKT+irul71mqlK0+BSMP9VFTW
        bZDxr3YSTaxQrXTyz6iTO3DTXmtfvgI=
X-Google-Smtp-Source: ACJfBott+o/ao2e7yyMKguJ6kr/mgrV67x4NYLT4wkSR8GlGV21zkioRZ3TvWdHsPP32pRtCl6NvAQ==
X-Received: by 10.55.192.2 with SMTP id o2mr12063212qki.232.1515348906513;
        Sun, 07 Jan 2018 10:15:06 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:05 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 02/18] midx: specify midx file format
Date:   Sun,  7 Jan 2018 13:14:43 -0500
Message-Id: <20180107181459.222909-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A multi-pack-index (MIDX) file indexes the objects in multiple
packfiles in a single pack directory. After a simple fixed-size
header, the version 1 file format uses chunks to specify
different regions of the data that correspond to different types
of data, including:

- List of OIDs in lex-order
- A fanout table into the OID list
- List of packfile names (relative to pack directory)
- List of object metadata
- Large offsets (if needed)

By adding extra optional chunks, we can easily extend this format
without invalidating written v1 files.

One value in the header corresponds to a number of "base MIDX files"
and will always be zero until the value is used in a later patch.

We considered using a hashtable format instead of an ordered list
of objects to reduce the O(log N) lookups to O(1) lookups, but two
main issues arose that lead us to abandon the idea:

- Extra space required to ensure collision counts were low.
- We need to identify the two lexicographically closest OIDs for
  fast abbreviations. Binary search allows this.

The current solution presents multiple packfiles as if they were
packed into a single packfile with one pack-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8e5bf60be3..ab459ef142 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -160,3 +160,88 @@ Pack file entry: <+
     corresponding packfile.
 
     20-byte SHA-1-checksum of all of the above.
+
+== midx-*.midx files have the following format:
+
+The multi-pack-index (MIDX) files refer to multiple pack-files.
+
+In order to allow extensions that add extra data to the MIDX format, we
+organize the body into "chunks" and provide a lookup table at the beginning
+of the body. The header includes certain length values, such as the number
+of packs, the number of base MIDX files, hash lengths and types.
+
+All 4-byte numbers are in network order.
+
+HEADER:
+
+	4-byte signature:
+	    The signature is: {'M', 'I', 'D', 'X'}
+
+	4-byte version number:
+	    Git currently only supports version 1.
+
+	1-byte Object Id Version (1 = SHA-1)
+
+	1-byte Object Id Length (H)
+
+	1-byte number (I) of base multi-pack-index files:
+	    This value is currently always zero.
+
+	1-byte number (C) of "chunks"
+
+	4-byte number (P) of pack files
+
+CHUNK LOOKUP:
+
+	(C + 1) * 12 bytes providing the chunk offsets:
+	    First 4 bytes describe chunk id. Value 0 is a terminating label.
+	    Other 8 bytes provide offset in current file for chunk to start.
+	    (Chunks are provided in file-order, so you can infer the length
+	    using the next chunk position if necessary.)
+
+	The remaining data in the body is described one chunk at a time, and
+	these chunks may be given in any order. Chunks are required unless
+	otherwise specified.
+
+CHUNK DATA:
+
+	OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
+	    The ith entry, F[i], stores the number of OIDs with first
+	    byte at most i. Thus F[255] stores the total
+	    number of objects (N). The number of objects with first byte
+	    value i is (F[i] - F[i-1]) for i > 0.
+
+	OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
+	    The OIDs for all objects in the MIDX are stored in lexicographic
+	    order in this chunk.
+
+	Object Offsets (ID: {'O', 'O', 'F', 'F'}) (N * 8 bytes)
+	    Stores two 4-byte values for every object.
+	    1: The pack-int-id for the pack storing this object.
+	    2: The offset within the pack.
+		If all offsets are less than 2^31, then the large offset chunk
+		will not exist and offsets are stored as in IDX v1.
+		If there is at least one offset value larger than 2^32-1, then
+		the large offset chunk must exist. If the large offset chunk
+		exists and the 31st bit is on, then removing that bit reveals
+		the row in the large offsets containing the 8-byte offset of
+		this object.
+
+	[Optional] Object Large Offsets (ID: {'L', 'O', 'F', 'F'})
+	    8-byte offsets into large packfiles.
+
+	Packfile Name Lookup (ID: {'P', 'L', 'O', 'O'}) (P * 4 bytes)
+	    P * 4 bytes storing the offset in the packfile name chunk for
+	    the null-terminated string containing the filename for the
+	    ith packfile. The filename is relative to the MIDX file's parent
+	    directory.
+
+	Packfile Names (ID: {'P', 'N', 'A', 'M'})
+	    Stores the packfile names as concatenated, null-terminated strings.
+	    Packfiles must be listed in lexicographic order for fast lookups by
+	    name. This is the only chunk not guaranteed to be a multiple of four
+	    bytes in length, so it should be the last chunk for alignment reasons.
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
-- 
2.15.0

