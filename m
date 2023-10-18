Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB747366
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PbMZSGTq"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89E118
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77897c4ac1fso45574685a.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653961; x=1698258761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZMUe/8alzUbB7b+lpZKgiTlzrBoUML86Vq+SVEl2Wg=;
        b=PbMZSGTqZLxGkhIJnJeDUojespU242p4PuaTWpMUJshgWHBJXGno3ZbW7CqqZhT5FC
         jYuTWsjaWUxsFH9y1nMoks32o4k/v3KMLMHPXzwxmzR3ka7WnMtvTqNSbhVlPe/BU3NU
         cP+QA5U/och5CNiTixM0vvy7zBLjmWPXcTozwa17WJSrx5E+uP3cnvrSBGSuZLNmQp3n
         zJZsdlKcxsG6qJwBz4EFtC0tJtZgKqabToJ/jj2QnxJWY5NqFvOoPGx6Q4u15TGw7Ey2
         D48hw+GouM6SzhDyzK35vx9VYp7yZEULpSnMDMcSeCkToaooCBQT860hi4FhXb11OFxP
         LUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653961; x=1698258761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZMUe/8alzUbB7b+lpZKgiTlzrBoUML86Vq+SVEl2Wg=;
        b=fOrqbFDMAXvvA/MkTEoCyYDzjFtuUXhv6FwcGUpJZODReR5zhyZyxef208w5UGfi+L
         OP7QEGtgaxvZjRutV+pmJf8xZNgOJA8zJjVSDUINRzhC9Euoe6hNkQ6xK5PHTrxqj8uy
         DjYflqO229WbAI2tjoOvO6U375kudKZa12o0jB19phARwfmwEY1h5sxlm5OipK40UO0a
         OYjR4QUddzVNTKaBQbNeo2//p+hpx7y5IBjMlzG7tkzh3yfVCbb6prRQcHMrwDzm7YV3
         e033QO1IgZ2MONLGWXsP9aKIIvEYiULAwVg5YUB4xWNQxPzFYTdrVOu4S6rhT5wxP2ty
         QvJQ==
X-Gm-Message-State: AOJu0YwDsjZac4Gx9P5ZLFNFhwwhCE42totpD4H3TSyR8H2DGF9Hx0G0
	YdK4Ll6cnnq43+Cm7FqcWGgl7V7qbEV1yNyt5Hx8QQ==
X-Google-Smtp-Source: AGHT+IE7tzosb/m9rNoMkUF/k67+f0UGvg8yW1nG9J2RvSF8jqzijpKXGpYEIFl4/HePEOaaq1MQ+w==
X-Received: by 2002:a05:620a:44d0:b0:777:784:3458 with SMTP id y16-20020a05620a44d000b0077707843458mr7821937qkp.64.1697653961338;
        Wed, 18 Oct 2023 11:32:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o14-20020ae9f50e000000b0076d6a08ac98sm149832qkg.76.2023.10.18.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:41 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 04/17] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <4d0190a9926bddc691cfa5b856d02b7bcc3a1d81.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jonathan Tan <jonathantanmy@google.com>

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.42.0.415.g8942f205c8

