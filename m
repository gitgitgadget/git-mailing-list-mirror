Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE18354EA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="InQ/O81/"
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CE112
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:54 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d4453ba38so32946166d6.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736533; x=1698341333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PO2d8JRzHU7FtTh9JiLtJgEt0DrafOcFO2g07IErPkA=;
        b=InQ/O81/BEsvdXQiBs9qz2X8m7iVS7xjXbqLwNfyriXYf1n1oObDXYKuMp528Gt0Xx
         cg8OHHyu6J//XToOtDfqpXPoe/InHFJ1yqImzpTWT5YSj81UzjvlBkudFGo6WNJyNFNU
         kKpiaQEfQztlRbqGoUvP1nU9vr3iTH7/KA9pt2uYA9sGxbROMQykIqPMk4ECs8p32MK6
         h7UUuC2ceHSrIN5vaM4gixEVhFduC/qtZfNdOnw5fIuADgcHABK2xluu7KQrORxukgbv
         ml58BBx6L1Dk3bxtbPG+ft1mrr5fveKe+2cEvjaXsswB6jxNvkmtvSZc8/B3uSeycMj8
         XV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736533; x=1698341333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO2d8JRzHU7FtTh9JiLtJgEt0DrafOcFO2g07IErPkA=;
        b=vzlrNPBGQll9gUhZX7t8Jc8U7sJDQ9+K06FCg86FBgUWHovfICFz0IO68RFTqhgVC7
         ywLBD8g4QtD8EwhAW4CHveJZThuPlElJa+7wwaRRPclJY0mCi2vMsvHADX7np6rkP4lW
         u/HGY0ZWaNsLOBEyKBpJxWhiERDt/MvICaL8Om9Oen3NOH6v9XhU4iX7U2GkKB43xRvt
         eEtl5mVxpdlOs6uao5HcqbWV4nIjnmVybQ3x482QGOrVlerJySi1A0rjtK10kTP9sMMb
         N53RuQ6PcG+yqYsrF2YUXYnvZX+kdLwTrP59edz419iTgVaDYNysvXqiRnR5HpbtX/Hv
         XMnw==
X-Gm-Message-State: AOJu0Yx/bcO9kwPs9oMCm2O93FK8OiLQJB5ALlZlRwuIKChdDwcoaOlF
	0FuGksue67P9lEDYJhB0L7YJnznAhMBqmi5B48T+ug==
X-Google-Smtp-Source: AGHT+IHK6i4P9Z8hhcA2D+HWm+kBaGiQhY0q+x8P21v7I8An7hZ0k1H5HJ0sY1EM2P/N0oHJHa/5oQ==
X-Received: by 2002:a05:6214:21ed:b0:651:6349:fa7 with SMTP id p13-20020a05621421ed00b0065163490fa7mr3290192qvj.25.1697736533076;
        Thu, 19 Oct 2023 10:28:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e20-20020ad442b4000000b0065d1380dd17sm15736qvr.61.2023.10.19.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:52 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 4/7] bulk-checkin: implement `SOURCE_INCORE` mode for
 `bulk_checkin_source`
Message-ID: <e427fe6ad383cc238c13f313dc9f11eab37a3840.1697736516.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>

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
index 28bc8d5ab4..60361b3e2e 100644
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
2.42.0.405.g86fe3250c2

