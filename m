Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4932C433E9
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF62376F
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 12:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhAVJ07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:26:59 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34328 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbhAVJKF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 04:10:05 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l2sRA-00C9l1-U0; Fri, 22 Jan 2021 02:09:00 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1l2sR9-00021r-Vd; Fri, 22 Jan 2021 02:09:00 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id A80E6500B4F;
        Fri, 22 Jan 2021 02:08:59 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sJbgR6o3e84Y; Fri, 22 Jan 2021 02:08:59 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 604735005FF;
        Fri, 22 Jan 2021 02:08:59 -0700 (MST)
Date:   Fri, 22 Jan 2021 02:08:56 -0700
From:   Seth House <seth@eseth.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git <git@vger.kernel.org>
Message-ID: <719978262.66088809.1611306387062.JavaMail.zimbra@eseth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-XM-SPF: eid=1l2sR9-00021r-Vd;;;mid=<719978262.66088809.1611306387062.JavaMail.zimbra@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 02:50:17AM +0000, brian m. carlson wrote:
> Can you report this as a bug?  This behavior isn't compliant with POSIX
> and it makes it really hard for folks to write portable code

I finally tracked down what upstream project these packages come from.
I don't use Windows very often and the MSYS2, MinGW, msysgit, & Cygwin
project history and overlap is *complicated* to say the least.

It seems the Git-for-Windows userland comes from both MSYS2 and MinGW
[1]. sed and awk come from MSYS2 and the carriage return conversion is
indeed documented [2].

[1] https://github.com/git-for-windows/build-extra#msys2
[2] https://www.msys2.org/wiki/How-does-MSYS2-differ-from-Cygwin/#runtime

It looks like the auto-CR conversion is well-tread, and well-flamed,
territory. I'd prefer not to reignite that but I filed an issue to start
a discussion. That issue also details the history behind this behavior
for anyone interested:

https://github.com/msys2/MSYS2-packages/issues/2315

