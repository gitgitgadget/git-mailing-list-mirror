Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38B2F3639
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108234; cv=none; b=ksc3LCaAIknL2s16TsiiUeFlqGZ/maCEpiGi9D55mr354rBsu8BSxqICW0oQw2HfFXIdAIh7P3xqJB3+teP2YBxPzwBUjUbTjCUqu3pDm3pghb7yiBREPoZlpHbwJWIAYleSp8SGZJfZXo8QAHGQDeBBzto7TLh1t1qxF5d+9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108234; c=relaxed/simple;
	bh=3yAtwqu1eGrookfsZFYUhT+c7Po+wOKJH8oU5R42xik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8wLSurrmYOo3jBZv/CfGl4r+HsbgvOIAt2p2mKGu1BHs+hKgGhCxfkwSqB9IijozOKyD0Mdf0W+9jIsUKNx8IRFNHvI9gmhDz/5KeUbgoXw2bXRdZ4DLf9cmKHlvu+AU6Oc6ae3S3pUJaQxVl3JdzAvbcN92y1k/H+mL3SlWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZCMatHKC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZCMatHKC"
Received: (qmail 221343 invoked by uid 109); 5 Sep 2025 21:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3yAtwqu1eGrookfsZFYUhT+c7Po+wOKJH8oU5R42xik=; b=ZCMatHKCLtiYLB/7cTTKaYJEK0fL0DPc4CUUiP0fjJuhLRszAhoJFH7qpktkYw65+la0UkCbf53AoW19G6T2cAaOBJuA0da6Mx0KzHTpPi1sA+JLkZd9Sdk1rfTE870gnJ/4zNTQR3QEe3Bs0aHbi9+0HssmbXReCZOdpc1dxC9ZXmGdJRuk6qc7YG0zcIfwdzdXrX2zWtPlDLkBSvmuUXsl8MAVosHPaJKu/roNAp2sCmuMzag94SaNvE4i26y3WbaqKxVxFGeL0LrwLWFvLe2joyOASYvhrmag5Q+nIUUP1tpSrlyvNnm2R3ZbzOdVti265vzDPpWguGtVGKq5HA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Sep 2025 21:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 380653 invoked by uid 111); 5 Sep 2025 21:37:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Sep 2025 17:37:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Sep 2025 17:37:08 -0400
From: Jeff King <peff@peff.net>
To: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [Bug] Compat objects not added to CLAR_TEST_PROG
Message-ID: <20250905213708.GB612697@coredump.intra.peff.net>
References: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>

[+cc pks for clar portability]

On Fri, Sep 05, 2025 at 03:19:50PM +0200, Osipov, Michael (IN IT IN) wrote:

> I am building Git 2.51.0 on HP-UX 11.31, previous releases went smoothly.

Neat, today I learned HP-UX is still alive and kicking. :)

Half of your patch makes sense to me, but I'm puzzled by the other half.
This:

> diff -u -ur t/unit-tests/clar/clar/sandbox.h git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
> --- t/unit-tests/clar/clar/sandbox.h	2025-08-18 02:35:38 +0200
> +++ t/unit-tests/clar/clar/sandbox.h	2025-09-05 14:10:52 +0200
> @@ -2,6 +2,8 @@
>  #include <sys/syslimits.h>
>  #endif
>  
> +#include "../../../../compat/posix.h"
> +
>  static char _clar_path[4096 + 1];
>  
>  static int

...seems like an obvious improvement. If we are compiling any C code,
we'd want our compatibility macros, etc. Although it does get a little
funny, as the contents of clar/ are imported from elsewhere, and now
we're modifying that.

It looks like clar tries to handle portability on its own, so I guess
another route is for it to add its own mkdtemp wrapper, and we'd import
that fixed version. But it really feels like we're duplicating effort.

The other half of your patch is the linking side:

> diff -u -ur Makefile Makefile
> --- Makefile	2025-08-18 02:35:38 +0200
> +++ Makefile	2025-09-05 14:34:43 +0200
> @@ -3933,7 +3933,7 @@
>  $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
>  $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
>  $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
> -$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
> +$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(COMPAT_OBJS) $(GITLIBS) GIT-LDFLAGS
>  	$(call mkdir_p_parent_template)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  

but I'm not sure that should be necessary. The compat objects are
included in libgit.a, and we should be linking against that when we
build the unit-test executable. At any rate, building with NO_MKDTEMP=1
for me on Linux does successfully find gitmkdtemp().  Are you sure this
half of the patch was needed?

-Peff
