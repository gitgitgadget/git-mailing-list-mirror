Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C81DE3D2
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640392; cv=none; b=SV+Dt03RyCCokA8YcF3R2MRoOj9CwCP5/DvtgD3JMewLH9GtC1sAOxKiqhNY0MLSfUov9ee2yV8I0IC1PK0ZK8r3u8Qy/iRwaTq86J699ZbE14wt34kTjBu3Xp6XE3c1PQBfUU1t8NEk4rd096mtsJhGAA1hsCQMsjKf+oBM/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640392; c=relaxed/simple;
	bh=dNFQncdVTIr/um+TXzTAl7jibTTfQJE/S8HDs99Q1x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqoIi5RG6JhkYFxLGI/QvJi9VL5sG6wtDYjRZ4CTU9K7dwIIUuRaXCuWsuHIUpun9Fsnvw4CI7xJ6nZOGl+jSfsc3M7F8Ud4VJqEmG8XhrzT2XN2dEADdMqy1lu141pnBs88U2z4MZeRYrtiTJDuOUPZEr4s2MX09K1fSwgwvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WaGt9Ckh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WaGt9Ckh"
Received: (qmail 14690 invoked by uid 109); 19 May 2025 07:39:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=dNFQncdVTIr/um+TXzTAl7jibTTfQJE/S8HDs99Q1x4=; b=WaGt9CkhlVAHZCoHeNExeGDC7k9zHsIMDeJq92EvIIGAjKGl5XDDGWHpaE26OqSlbLrzUUXXGkgp/u+bnJpP9+byBMM/v62FvM2p3stWRJpLD6Xb9c0J25wRBhJy/iQELL0N/T2oP3m40y73tVSUQCiksRXE4GMKRFlSINtAkOr+ebvsdlxH14+d8iL7Z3rmxpIT536e7/OP5lzfAf3aHHSBqdqFBRHOtBbG7S10w6aba+gLEeXhB/dkGC/T+FSAtfgfbR4CYOC+AfQ/CGNIWAIneEGAp5uoTKzHKFWmtWnN9Hg3QeJ0utaWsov5gL5KCHW5HiG7i2mhXJxgJSOfXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 07:39:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25273 invoked by uid 111); 19 May 2025 07:39:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 03:39:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 03:39:49 -0400
From: Jeff King <peff@peff.net>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Patrick Steinhardt <ps@pks.im>,
	Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: add loading corrupt bitmap_index test
Message-ID: <20250519073949.GD102701@coredump.intra.peff.net>
References: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
 <aCrJcK6ml4r4S-mF@pks.im>
 <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>

On Mon, May 19, 2025 at 02:44:22PM +0800, lidongyan wrote:

> 2025年5月19日 14:02，Patrick Steinhardt <ps@pks.im> 写道：
> > Okay. We _can_ do that now, but the patch doesn't explain why we
> > _should_.
> 
> The main purpose of this patch is to provide a test case to check whether
>  a memory leak occurs when loading a corrupt index file as requested here
> https://lore.kernel.org/git/20250514180325.GB2196784@coredump.intra.peff.net.
> A potential memory leak is mentioned in this patch here https://lore.kernel.org/git/pull.1962.git.git.1747052530271.gitgitgadget@gmail.com/.

I think we'd need to mark it with the !SANITIZE_LEAK prereq until the
leaks are actually fixed. Or simpler, just apply this on top of the leak
fixes once they are ready. That ordering needs to be communicated to the
maintainer, and the simplest way to do that is probably to just post a
3-patch series: your initial leak fix, a polished version of the one
from Taylor, and then the test on top.

> > My proposal would be to either move the logic into "test-bitmap.c", or
> > to even better to write a unit test in "t/unit-tests/". After all, we
> > expect that the code should fail gracefully, so a unit test might be a
> > good fit after all.
> 
> I found that the header size of an index file depends only on the type of hash algorithm.
> To trigger the condition for the memory leak, I need to corrupt a few bytes right after the
> index file header size. It's more convenient to implement this functionality in pack-bitmap.c.
> However, I think I can place the test itself under t/unit-tests/.

I don't think you can do a prereq for a unit-test file (though I might
be wrong, as I have not really paid attention to that area).

If the corruption offsets are easy-ish to compute statically (and it
sounds like they mostly just depend on the hash algorithm size), then
I'd actually prefer to just do it with "dd". That avoids extra C code,
and simulates a real on-disk corruption more exactly (using real
commands).

Something like:

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 042f62f16e..16bd607654 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -498,7 +498,17 @@ test_bitmap_cases () {
 			git commit -am "add hello_world.txt" &&
 
 			git repack -adb &&
-			test-tool bitmap load-corrupt
+			bitmap=$(ls .git/objects/pack/pack-*.bitmap) &&
+			chmod +w "$bitmap" &&
+
+			# this matches the xor offset
+			offset=$((120 + $(test_oid rawsz))) &&
+			printf "\241" |
+				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$offset &&
+
+			git rev-list --count HEAD >expect &&
+			git rev-list --use-bitmap-index --count HEAD >actual &&
+			test_cmp expect actual
 		)
 	'
 }

-Peff
