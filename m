Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11923909F
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250834; cv=none; b=XOhL5AyNOPI+80uw2N6LN+sc6eEnIKspF0LKJxhnJp05uuVA+UxIVOvsX9dj17U94tNRA27K4WfApBK2YGJ054Cu19yd0TwVX+vcgpBHm0WGFvoE7c9ld5I2JhCH5i7jv2meFb/zDJE9sPb1fdrUatSnfPnW0/fKfVXZPUI5IUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250834; c=relaxed/simple;
	bh=K3Ozx+iZizBTKJO/Qx7aK3gNRG7TZzkMbzHcQYIEEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjujGnU7pf5KDzXWK1dUGUp4XFu3H9cc+btT8t8I1fqaJEXXePkuUlpMJ0VXLfFLXSYaIpiursG+53aJze5jfWYJwASllAeqK8Mz4QDZg7X5B2iT9loNj6Bi67NRHxBWx9VU6OzxNV0fnFQ26mhG25ivIXzGM8T1kA7I2SIWi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EhL5kegn; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EhL5kegn"
Received: (qmail 80946 invoked by uid 106); 28 Jul 2026 15:00:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=K3Ozx+iZizBTKJO/Qx7aK3gNRG7TZzkMbzHcQYIEEdU=; b=EhL5kegns46GqzWMTTCvW09oyDduy3bMASMHxd9xCkjSi+3zUyfDKFUZlLeobn9DNjKmEHGzFVAUC1sB8el+BN74Fd29/RjpnjXMAn0z8lr0EwoRSRNXvI5XktngqfxmGGLZZJ7ohwV9vI2R8AQD5FVDwuQHwtZ3G1zDEN1p7sTw/oDIMWKjVORVWb+SElJL0IZkxY/58JNBpccXLQAKKSsawKEzsk8yPHqF7SLspY14SU89MCHOXE1ROAyStKK5992sEm5kbPZtUqJoNqk0dcGlbMPpKbs1MoPeuo9VRI5m52lGUQm2BXowPlErVs+pd6t5XuQ8JcgKVfWL5X+X/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 15:00:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 100023 invoked by uid 111); 28 Jul 2026 15:00:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 11:00:32 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 11:00:31 -0400
From: Jeff King <peff@peff.net>
To: Alan Stokes <alan@source.dev>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Subject: [PATCH] cat-file: handle content request for --batch-command without
 type
Message-ID: <20260728150031.GA41931@coredump.intra.peff.net>
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
 <20260727095735.GA1153453@coredump.intra.peff.net>
 <DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
 <CAFZW3h3xyeJJwHfVK2mB2k1=e-0he9_gbTetJ1RdB2uUM1rp4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFZW3h3xyeJJwHfVK2mB2k1=e-0he9_gbTetJ1RdB2uUM1rp4A@mail.gmail.com>

On Tue, Jul 28, 2026 at 10:08:46AM +0100, Alan Stokes wrote:

> > > Do you want to try your hand at a patch? It would need to do the
> > > save/restore, and most importantly add a new test to t1006.
> 
> I would be willing to have a go at it. But realistically I probably won't have
> time for a month or two. I'm also a complete noob at the whole posting
> patches via email process, so it may be slightly chaotic. If anybody else
> wanted to deal with it I obviously wouldn't object.

That's long enough that I'm worried we'll forget about it. So here's a
patch. Thanks very much for a clear bug report!

-- >8 --
Subject: cat-file: handle content request for --batch-command without type

The batch mode of cat-file needs to know the object's type in order to
print the contents (because it decides whether to stream or not based on
object type). The default batch output contains %(objecttype), so we get
the type info automatically. But when it doesn't, we have to ask for it
explicitly.

In the --batch code path, we check while setting up the object_info
struct whether we will print the contents, and if so set "typep" to get
the value. This comes from 6554dfa97a (cat-file: handle --batch format
with missing type/size, 2013-12-12).

But later we added a --batch-command mode, which does not do the same
trick. The decision about whether to retrieve the contents is made
per-command (a "contents" vs "info" command), so we can't decide when
building the object_info originally. As a result, asking for:

  echo "contents HEAD" | git cat-file --batch-command="%(objectname)"

will fail the assertion in print_object_or_die() that the type was
actually filled in.

We can fix it by tweaking the object_info on the fly as we receive each
command. But we should be careful to restore it afterwards; otherwise a
sequence of commands like:

  contents $one
  info $two
  info $three

will pay the type-lookup price for $two and $three when it does not need
to. This wouldn't be incorrect, but just slightly inefficient (and hence
there are no tests for that part, because the externally-visible
behavior is the same).

Reported-by: Alan Stokes <alan@source.dev>
Helped-by: Pablo Sabater <pabloosabaterr@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c  | 3 +++
 t/t1006-cat-file.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1458dd76d6..ac458c9737 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -689,8 +689,11 @@ static void parse_cmd_contents(struct batch_options *opt,
 			     struct strbuf *output,
 			     struct expand_data *data)
 {
+	enum object_type *saved_typep = data->info.typep;
+	data->info.typep = &data->type;
 	opt->batch_mode = BATCH_MODE_CONTENTS;
 	batch_one_object(line, output, opt, data);
+	data->info.typep = saved_typep;
 }
 
 static void parse_cmd_info(struct batch_options *opt,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 762c77c351..f085738082 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1351,6 +1351,14 @@ test_expect_success 'batch-command flush without --buffer' '
 	test_grep "^fatal:.*flush is only for --buffer mode.*" err
 '
 
+test_expect_success 'batch-command contents auto-handles type' '
+	echo "HEAD" |
+		git cat-file --batch="%(objectname)" >expect &&
+	echo "contents HEAD" |
+		git cat-file --batch-command="%(objectname)" >actual &&
+	test_cmp expect actual
+'
+
 perl_script='
 use warnings;
 use strict;
-- 
2.55.0.749.g30c495c7a6

