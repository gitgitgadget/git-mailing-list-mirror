Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjDFIhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjDFIhD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:37:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025FF12F
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:37:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn12so147495999edb.4
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770221;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T0hvV+Lho5g2DlzFJWmGn/ACJ+8nJO4w9czLK7Q69s=;
        b=F03dzwFXFmG5up+oBq75ajnEVN78SySUqJn4IdToV1PcVeqjubyKdGOlNXvibkBnuG
         Kk7xNeSvBBRljDhyNNObhbI/CI+fC2HMCvLwniXhOHb4EtT6CSA/5EerLBKAqzg2Z0re
         2GXyGqC5ficTGensWuk/fs0Sq0e+QHCcocnThom/TipbI3klg0VRmZTRGi7ldUkSOpEg
         u4eheXHgwXBu7KdEhyhaTIOLOHYBPyFaQ1m3/ulqd2+vWNKUhFBCr9yaIhaSden1NgSY
         FIpp2Lguq5aqIZflmhZ3r+IbZKWYxAFTTPE++d/yc5jf/C5JCHZUHaowx7vf9nvXjmHu
         iKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770221;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T0hvV+Lho5g2DlzFJWmGn/ACJ+8nJO4w9czLK7Q69s=;
        b=cXBJ4bPdANYLxTNE630FKnvPiHdgdigtwp2mtsd6/0xOZ3DnW9cNIBiwRjEyWYjFIM
         mFUHIMMYEviB/0DaiAngFaibHKw2mUVgiVnuGnSnLQS7U4TubIVKFy/9fnH9+PE34zG6
         WDkvLHyBAPRrPXI9361XrFochFkdql2C3jKJZ18g2UZgY/cBZSdrR+ogXco6x4gDqJdO
         YDeOeQ475kXxemOVxBJC+U136vKNX3O61TduTDcfvVOg+4SF28gbI6bMq3SlpDB61dFL
         XPGqq7grrmtOZxoYn5FuUkHfm8UpKvjlqegIUOupuH6+53lRY7KeofaSXlzI7GJCrB8y
         hJPw==
X-Gm-Message-State: AAQBX9dLfMw6DjJf29Z8mUPUJYYC15Z/ZaN1MxrB3Yr+5js/RYdyEMgT
        mulDlxbSAitpUFQejwfFmYRsriVcD8E=
X-Google-Smtp-Source: AKy350YEl/7bZxKwsRAesOHZr6+zWadDy4+6dIZ1DLelil9mKEGQojOvo8EhxiHNHSHcwFLLvCg6ew==
X-Received: by 2002:a17:906:b317:b0:93a:6e9c:262e with SMTP id n23-20020a170906b31700b0093a6e9c262emr5938677ejz.23.1680770221161;
        Thu, 06 Apr 2023 01:37:01 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hd10-20020a170907968a00b008d606b1bbb1sm517766ejc.9.2023.04.06.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:37:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkL76-005Otm-0x;
        Thu, 06 Apr 2023 10:37:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] t0300: don't create unused file
Date:   Thu, 06 Apr 2023 10:34:00 +0200
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-2-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230403223338.468025-2-rybak.a.v@gmail.com>
Message-ID: <230406.86ttxttnir.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Andrei Rybak wrote:

> Test 'credential config with partial URLs' in t0300-credentials.sh
> contains three "git credential fill" invocations.  For two of the
> invocations, the test asserts presence or absence of string "yep" in the
> standard output.  For the third test it checks for an error message in
> standard error.
>
> Don't redirect standard output of "git credential" to file "stdout" in
> t0300-credentials.sh to avoid creating an unnecessary file when only
> standard error is checked.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t0300-credentials.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index c66d91e82d..b8612ede95 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -808,7 +808,7 @@ test_expect_success 'credential config with partial URLs' '
>  
>  	git -c credential.$partial.helper=yep \
>  		-c credential.with%0anewline.username=uh-oh \
> -		credential fill <stdin >stdout 2>stderr &&
> +		credential fill <stdin 2>stderr &&
>  	test_i18ngrep "skipping credential lookup for key" stderr
>  '

This goes for these changes in this series general: You're correct that
this is useless now, but I don't think it follows that we should be
removing the "redundant" code in all cases, rather than fixing the test
to actually check these.

E.g. this will also make this test pass:
	
	diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
	index c66d91e82d8..62c2a0fd50e 100755
	--- a/t/t0300-credentials.sh
	+++ b/t/t0300-credentials.sh
	@@ -806,9 +806,11 @@ test_expect_success 'credential config with partial URLs' '
	 		return 1
	 	done &&
	 
	+	cp stdout stdout.last &&
	 	git -c credential.$partial.helper=yep \
	 		-c credential.with%0anewline.username=uh-oh \
	 		credential fill <stdin >stdout 2>stderr &&
	+	test_cmp stdout.last stdout &&
	 	test_i18ngrep "skipping credential lookup for key" stderr
	 '
	 

Does that make sense? No idea, I don't know the credential system well.

But isn't it worth testing that when we ask for this that we're getting
some known output along with the warning?
