Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711363FE22
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BEqFhjS/"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF53359D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:14 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so47665276d6.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648887; x=1698253687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3xJACvcTogI6rqUYPzB/a+ZJMPHbJJ1R0f7E7mJydU=;
        b=BEqFhjS/16bkMm7ctYmXEeMCbpEEKkOfPt0BsY53DFByQxpih6AzZnGtfuPuyVlR0J
         GOrcUVdtCsOOgSL9vIIyl5lleBUH1DaxHog2wp5TkVMytSe7zlGva/0AMRII2moXNwf3
         CjOusJ4MCWSrwxlM/PBXb+0euZS8PYYdaIqUo6dN8vBxa/7ec4BR29PtuEBTWNhi44Y4
         1l8jnZkQGCfwjzldRSc/R5FS7jwJSGjG/w8Kb8TCTZ0Rv1ZilnsL5nJagAWo54Xg2j8m
         GGh0N9md1w8Z4dZoJ8oncp+brxEns9+C0cNpbt68ENJIzqDIA1urGc5r/wq/DZtTa9GO
         DYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648887; x=1698253687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3xJACvcTogI6rqUYPzB/a+ZJMPHbJJ1R0f7E7mJydU=;
        b=bC5fpP8JeRKuxvTr+LhKzWOscXMIpil+IpSbDp1aPQTyWVjtczl9/aeGcD5PUSzZFR
         ngzdKvmgL/0vK20K7DUMmsMSWQLhrV2Q+XmyQp0yMl6kohqZmF04yErcWKOEv1MP8b8O
         ctdwarvcZvyjvbclIqcjn+2N29tm00ZtYwJu0bfV2AGa5pCp3PVST5o+Ya/E01kjE0Ne
         /gVIQeXLFWsbfGUSp6QyJYpxu6Wl5EMhAriMbDbYXYwKAb0LyVINU7BMUZHhaQlMGmND
         7wzYutjwLrNIBeGd0hD8WCMG2F5SZfRN/ZcaeB6V7UJIApHRSlt+jX6EiEnUBAXHoVOv
         B6Uw==
X-Gm-Message-State: AOJu0YyZB/uYrm0yU90KEgVRfo3YchZ5w0XPg7ak4H2HZhvHhtl+Du0o
	OBC3aoWQV9xAhD9WbrTxAOK3H7eiIfeEytkudOcbBg==
X-Google-Smtp-Source: AGHT+IHooKkC/yeCbuyOIe5EcDoJ/QznGk/BzFVssYEijkD+WrQi9tdEpdrI6Bv/vd3erh1e+qqumQ==
X-Received: by 2002:ad4:4f29:0:b0:63d:580:9c68 with SMTP id fc9-20020ad44f29000000b0063d05809c68mr6273174qvb.32.1697648887025;
        Wed, 18 Oct 2023 10:08:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8518e000000b0041b83654af9sm97330qtn.30.2023.10.18.10.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:08:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:08:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 06/10] bulk-checkin: implement `SOURCE_INCORE` mode for
 `bulk_checkin_source`
Message-ID: <4e9bac5bc1a49ca7a96aaee84a46b389c6bfe99b.1697648864.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697648864.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697648864.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Continue to prepare for streaming an object's contents directly from
memory by teaching `bulk_checkin_source` how to perform reads and seeks
based on an address in memory.

Unlike file descriptors, which manage their own offset internally, we
have to keep track of how many bytes we've read out of the buffer, and
make sure we don't read past the end of the buffer.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index fc1d902018..133e02ce36 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -141,11 +141,15 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
 }
 
 struct bulk_checkin_source {
-	enum { SOURCE_FILE } type;
+	enum { SOURCE_FILE, SOURCE_INCORE } type;
 
 	/* SOURCE_FILE fields */
 	int fd;
 
+	/* SOURCE_INCORE fields */
+	const void *buf;
+	size_t read;
+
 	/* common fields */
 	size_t size;
 	const char *path;
@@ -157,6 +161,11 @@ static off_t bulk_checkin_source_seek_to(struct bulk_checkin_source *source,
 	switch (source->type) {
 	case SOURCE_FILE:
 		return lseek(source->fd, offset, SEEK_SET);
+	case SOURCE_INCORE:
+		if (!(0 <= offset && offset < source->size))
+			return (off_t)-1;
+		source->read = offset;
+		return source->read;
 	default:
 		BUG("unknown bulk-checkin source: %d", source->type);
 	}
@@ -168,6 +177,13 @@ static ssize_t bulk_checkin_source_read(struct bulk_checkin_source *source,
 	switch (source->type) {
 	case SOURCE_FILE:
 		return read_in_full(source->fd, buf, nr);
+	case SOURCE_INCORE:
+		assert(source->read <= source->size);
+		if (nr > source->size - source->read)
+			nr = source->size - source->read;
+		memcpy(buf, (unsigned char *)source->buf + source->read, nr);
+		source->read += nr;
+		return nr;
 	default:
 		BUG("unknown bulk-checkin source: %d", source->type);
 	}
-- 
2.42.0.408.g97fac66ae4

