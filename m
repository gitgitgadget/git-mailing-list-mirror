Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1359D20248
	for <e@80x24.org>; Tue,  9 Apr 2019 07:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDIHmW (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 03:42:22 -0400
Received: from srv1.79p.de ([213.239.234.118]:57260 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfDIHmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 03:42:22 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 03:42:21 EDT
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [141.89.53.191] (dhcp191.soft.cs.uni-potsdam.de [141.89.53.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 832B1220060;
        Tue,  9 Apr 2019 09:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2019; t=1554795248;
        bh=DveXrXzwc5yCP49Ez9VxjA8eH03FFwJVkfeQOnjWmpU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=6CZNPtOUioFHjE1ho1FkLXFcAROjdZ8XE+ApyJQsAppL2X+Sp7k1qVLmIAxnrQCj4
         lejuKV3cHsc+inwjCJ2IC2PilvLVKFALvunriaQ6t4AyP5WDLRWefeR9CViZigLtXm
         DOoRAw/4Ox0hBmfj5gmqC1tSBgk+AjJ3O3fU6jvzOFn29u+AP0IdNfkcvpNHIfHSUI
         0u7umLbp67mI8VNjvWiF9oFZw91/Ane/kEECw5VTdx56lY/ei3m2yAtFZXCuJP79Yr
         sPAwoNJi3JmTHm6uxJIlwFO1nhnM0ZXdTAC7aUu85AiCP+9n8Bno0kC77M2zNPwO1y
         CMV2TamQLuOVQ==
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths
 (with Visual Studio)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
 <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
From:   Sven Strickroth <sven@cs-ware.de>
Openpgp: preference=signencrypt
Message-ID: <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
Date:   Tue, 9 Apr 2019 09:34:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.2019 um 07:53 schrieb Torsten Bögershausen:
>> Regression was introduced in commit
>> 25d90d1cb72ce51407324259516843406142fe89.
> 
> Was it ?
> 25d90d1cb merged this commit:
> 1cadad6f6 (junio/tb/use-common-win32-pathfuncs-on-cygwin)

Yes, I copied the revision of the merge commit.

> And, if I read that correctly,  1cadad6f6 does not change anything for MSVC.
> And the problem with the missing/wrong path resolution was there before
> 1cadad6f6 and after 1cadad6f6.

That's not correct, it was correct before:
1cadad6f6 removes mingw_offset_1st_component from mingw.c which is
included by msvc.c. Then the in git-compat.h the new file
"compat/win32/path-utils.h" is only included for __CYGWIN__ and
__MINGW32__, here _MSC_VER is missing -> that's the regression.

> In config.mak.uname  we need to add a line
> compat/win32/path-utils.o
> for the Windows build.
> In the git-for windows codebase I see
>   COMPAT_OBJS +=compat/win32/path-utils

I don't use config.mak.uname and never did, so I can't tell you about that.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
