Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A411C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGFBDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFBDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 21:03:38 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 18:03:37 PDT
Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA065CE
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 18:03:37 -0700 (PDT)
Received: from satellite ([147.147.167.40])
        by smtp with ESMTPA
        id 8tP4oJCEmO2ri8tP6otKVk; Wed, 06 Jul 2022 02:00:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657069234; bh=e68spoOPwpNXm/qzKGRAf/MLzG/yGB5TF/dm6l6ZBeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cpvwuNyphiAY+qRc/jCqLogcWVs5maKwhz6eZIU9ebQBmlVMC3WUalwpdDL8ue8x1
         +POfpo3qLsK6snvPYvwkmwuFLi8/ldbiKJ9Q1oNJSdo/24Q/gdK1UWJ3ps5SgZ2CWJ
         V8ygz+E3xp8rxRcCopgYgHmvE5SuRpMgfrQCJ2XZ2+r+PR8l9O7SbpLK4e5zELM9Yt
         YklI0GUbvSM1jsVgjrurRD9JN/g7Lbb3qnoUIYyYVXUirZCiEzPbLiss5QMKvCM5Ny
         ORb6vt3Da3sjyNNGvU5Kfabo1IBZ6NB05F+J8i3OFGAZ+U8AKGRwO1GVSSVbnueqca
         I5v/IMwYEDBOw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Zs/+lv3G c=1 sm=1 tr=0 ts=62c4deb2
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=kj9zAlcOel0A:10 a=OPE9x6HFIsRec6tRUh0A:9 a=CjuIK1q_8ugA:10
X-AUTH: ramsayjones@:2500
Date:   Wed, 6 Jul 2022 02:00:29 +0100
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
Message-ID: <YsTerevSOG9Q76qt@satellite>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705230518.713218-1-sandals@crustytoothpaste.net>
X-CMAE-Envelope: MS4xfGo5fqt8STkwl5h4U7boZuzCo/5KeAlZqR/rAr/t/HvF8y3kFLAev5/QEZ9DmXoq+wXr54K6OD6jGrYcsbqCaeN//sJTtPi1Gek9lyhpAuZPZF2KGUDg
 /itfL1vAkg2c7fysQeaPs3KIFgo48KNL2lO0fNhFjeil5PtlzZVonXZpvMggLU0qrnXI2x2TPAUEZA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 11:05:18PM +0000, brian m. carlson wrote:

[snip]

> diff --git a/sha256/nettle.h b/sha256/nettle.h
> new file mode 100644
> index 0000000000..9b2845babc
> --- /dev/null
> +++ b/sha256/nettle.h
> @@ -0,0 +1,28 @@
> +#ifndef SHA256_GCRYPT_H
> +#define SHA256_GCRYPT_H

I'm guessing you had intended: s/GCRYPT/NETTLE/ here. :)

ATB,
Ramsay Jones

> +
> +#include <nettle/sha2.h>
> +
> +typedef struct sha256_ctx nettle_SHA256_CTX;
> +
> +inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
> +{
> +	sha256_init(ctx);
> +}
> +
> +inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
> +{
> +	sha256_update(ctx, len, data);
> +}
> +
> +inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
> +{
> +	sha256_digest(ctx, SHA256_DIGEST_SIZE, digest);
> +}
> +
> +#define platform_SHA256_CTX nettle_SHA256_CTX
> +#define platform_SHA256_Init nettle_SHA256_Init
> +#define platform_SHA256_Update nettle_SHA256_Update
> +#define platform_SHA256_Final nettle_SHA256_Final
> +
> +#endif
