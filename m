Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6204DC4332F
	for <git@archiver.kernel.org>; Sat, 10 Dec 2022 13:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLJNGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Dec 2022 08:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJNGr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2022 08:06:47 -0500
Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862518B1C
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 05:06:44 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bd7:7400:6c37:c1df:83ce:abbb] (unknown [IPv6:2001:9e8:2bd7:7400:6c37:c1df:83ce:abbb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 7FDDE60009A;
        Sat, 10 Dec 2022 14:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2022; t=1670677601;
        bh=lID50p9M79g449TnW+apTxyIepGS+NWf+1fgMIho6eE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VAIIaVv4B0u3OQWgvcOrRlUWXOQ5JrfrKnW9z23M8Ti82DRm9tkkIQHdt4MELw02D
         mckYDx8A2o94+ViuTs1iY7g7dZTFr7/hw0BuhXfpTsPQsITyFyeYYJWAUYWtgZG8b/
         0UqsS3FvjnbUDBu8jODiPKZ3Q5hKWq1Em/rjoEWXNLxdgJgdlkS+Q5mcj8wN15SPa1
         2FmcTX+yahSh1MGqFUkMo2Hyso438yjBlVSzPmvJlhQ8JAY8rTGxb5z5rrWrMrxve3
         QNm9SQGq8aivTGf/i64pz2oPD2GjqLoJrC6zwB4JiP6ga52yRgqPjlfG0cXmBEuFq5
         V3nlm5yF53RiA==
Message-ID: <f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de>
Date:   Sat, 10 Dec 2022 14:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: [PATCH] submodule: Accept -v for update command
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, "Robin H. Johnson" <robbat2@gentoo.org>
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
 <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
 <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
 <221130.868rjsi6bn.gmgdl@evledraar.gmail.com> <xmqqiliur6t9.fsf@gitster.g>
From:   Sven Strickroth <email@cs-ware.de>
In-Reply-To: <xmqqiliur6t9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git pull -v --recurse-submodules" propagates the "-v" to the submodule 
command which did not support "-v" yet.

Commit a56771a668d introduced this regression.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
  git-submodule.sh | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9a50f2e912..7f9582d923 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -244,6 +244,9 @@ cmd_update()
  		-q|--quiet)
  			quiet=1
  			;;
+		-v|--verbose)
+			quiet=0
+			;;
  		--progress)
  			progress=1
  			;;
-- 
2.38.1.windows.1

