Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E77520248
	for <e@80x24.org>; Sat, 13 Apr 2019 22:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDMWBs (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 18:01:48 -0400
Received: from mout.web.de ([212.227.17.11]:33741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfDMWBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 18:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555192893;
        bh=Mym7fdYUAfz0dJm2aeDR7VdczTsZ473gOYFsHnI01ko=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O4biOLi+ckFZnK+2AAn/SI07fBTnoaxfuUSXDM1g/Vz7mxU1wcX3lSVt5O9+nwdFv
         54KY8fESKj+JD5TTlBBr46KgposrnFx95YdG/Rk3nmjSuwUaroadYM14meLp5DkcYi
         JBNJXb9oc06ibb49GfXW/yhH7rAjVohKHV6gl60U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([79.203.21.163]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMVpy-1hDkgN0Ees-008NMR; Sun, 14
 Apr 2019 00:01:33 +0200
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
To:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
Date:   Sun, 14 Apr 2019 00:01:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413015102.GC2040@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSAtkOtzcfMlwzURwUCXeIDv2UqZL/nziHatmfRDBOxr2hcdk1M
 //Xb/mbFimjX/42MfRlEptl0uzaQj3H1/0uAb17rkr/XZw2gv/2Hy4onVPS8VHBzTQUw+hW
 1zg0k6SmnTOA+HpA8qsHRZcMemLaTHxBBsteazFcpK2hKHoFRJxEzrArNcFxIAi+UPFWED6
 +B+Nz3lR6IYh1aaVlBeSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xZpdfRi9JNM=:E1zkUZoggpc+dl2NBzQ5eT
 MWxf3DfcmwPBr3dJfulTdu9SoDiZ4Vc0X4sph0kfBDHwwbMxnqQJj8gj2urYsv7ycOaYZODfo
 9fiKYoj6EjLnoDmlu6nV+Dbeo1PCxiuvV+2MfzkT/T6k16DIWr1ukrasEq7X+DWks+YBnK5z1
 XXZrmAgy1ZgZZRCXWFviwOe6X13ej0xipGn97Yle84chwm6JmO2SrXiGdNFBpkBEMbuXDah9f
 oHjSp54BoQxFWmzJGS+wINkIXL3KYidIy8SF80v9lEu6dh0g7j66EJ2Pk7X3GMYYnzd2SlG33
 Qt0y6v5/glS3XTT5OZ/UxxZEhphg5iWvu6fgA4zjXg+wG6Ug/cEaB7Mixk9uYXYDfZDiloWfS
 KGW0A+e05d03TNHSjNhAkAL1xkU/oxC8FlHnnKPizFYE1UBChZcll8hZUAZBkYYRplbqw2q+7
 D+LjtY5DN432DCqtjDDQ0Wjf3woY8ha+nFqZugOu70w8Kosv4vHdu655LQZtU/dEisI9DRe/S
 lzvtpfwhbj+nLV73NdyXdGOkm1jPkU71xldc42yIGSnTrdpmbq+G4gpUdk1E+6n8xKTXHJDzm
 G5T9zkc+3W8A9e1F3/xGmdZjF8GF/QQj4UOXv8ECkfnok7JX83IZGOD9/ea6yG0Y3aZCs+95A
 eXJgIxYNuhQzPGz8P5sGPdHw4kBPUTsXd/znzEO2Gv9rSBCCMVeOh/HjYGCwq3YXcjP65QK+x
 RR6+YYGImPckMdEj6v1A40phvAKyz++pMNOKxgXd7A4n061ykdZwXiom3jHlgWoDzz+O5YHfA
 8KPJaU+PDM6LXRX7sq+Vg/IDajXkFTsQ8RgSKGHEZf3YlJDt0WFhv6KnnVgsEq55v5eTv6CU3
 Eo4N7zxoX5l/5mK/A2aLYj25jO6G8+Rjid5hhsP+qou2ZOtayLN8Xcek+dGJsO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.04.2019 um 03:51 schrieb Jeff King:
> On Fri, Apr 12, 2019 at 04:04:40PM -0700, Rohit Ashiwal via GitGitGadget=
 wrote:
>
>> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>>
>> As we already link to the zlib library, we can perform the compression
>> without even requiring gzip on the host machine.
>
> Very cool. It's nice to drop a dependency, and this should be a bit more
> efficient, too.

Getting rid of dependencies is good, and using zlib is the obvious way to
generate .tgz files. Last time I tried something like that, a separate gzi=
p
process was faster, though -- at least on Linux [1].  How does this one
fare?

Doing compression in its own thread may be a good idea.

Ren=C3=A9


[1] http://public-inbox.org/git/4AAAC8CE.8020302@lsrfire.ath.cx/
