Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2411F463
	for <e@80x24.org>; Sun, 15 Sep 2019 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfIOQMY (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 12:12:24 -0400
Received: from mout.web.de ([212.227.15.3]:59993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfIOQMY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 12:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568563934;
        bh=CHTjIIadRFyxV5a3ougaA7faaWMFbITfGsnZAP4FIaE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M7zhRegIBxW+eJpP7TQqqBA75twf5eYrRkx/iH3iepGAAPoZA7THB2RXtTDkE0kNq
         hJ/ZEL0P+83TZLvi3aZWtKGYlb/sy5MFP7GNAA7mxpVCvuBLicdz16tTpxZ3HjSjqr
         VDoAjnhz159SFv08T9bPjWcXFvrB7GWOfLxIFSiI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLlCd-1i9G173DrH-000vZ2; Sun, 15
 Sep 2019 18:12:14 +0200
Subject: Re: [PATCH 2/2] sha1-name: check for overflow of N in "foo^N" and
 "foo~N"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c43610f2-a51f-7333-a200-a76930a0b705@web.de>
 <2be6e3ee-209e-9cd1-eb43-284f9a8462b3@web.de>
 <20190915151513.GU11334@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <651e7bdb-c2e8-e607-d78d-5292b3509a8d@web.de>
Date:   Sun, 15 Sep 2019 18:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915151513.GU11334@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cuXvEb1AG26CVjIld6mxzVN3I+BUWbUXMKDzRQFTeu+7g/yriM/
 D8mwAf+EhR6PrJhzsodvTrssRk3ZgUJfcMV1DewNdaB4IA5yfdkiMPA3Fm7INbT3TWmt5RG
 DCUKkAzNA0Xqhmfe9s+8xCint0xMfjaRt/pV16S/SkFG93e2SS6twjB2PWqU66Ti+uBicch
 e4KlxNrl71qr+J51IVqvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1UrBQcF2q0w=:YJOWZjKEMUoDN/kDT9yVHm
 PClFETRZLze8GGeBQZQ3rxkgJ/R0JIDUZ1yXdDsN+tqMRWlNYY8ABPVoRKoF8M0CrKcqnOwbk
 wRYzSMo/ojWav7Cu97TSETB3nejbvHMtHsj9oXlqWLubPp0f+CYekRsQInFGmXprHSQrzJW6m
 fh6pAuMCFpLazMNijfJ8Wxd/bbTqKx0pkOY4ghcch7tDMOm7L9d0vtrYZIslGxru0OqrpWxF3
 Nx5tQuGRRUj5iKkY+h/Hp9dItmQvtJwvv3tZ2jGvXqDt8D+t0mVgo5FCKI/F17pQSp6qSk2hW
 0Ft/mouRvJz4mKJLQMxSaD/Bh7oHNCu3Rppv+JyITJ2hsbEJXTDg1GZLXk2eQx5OOw6Ffx0wr
 vJayJVv+WeBWjceTJF91YwriRH+WKploD+NjIXS3GH5fREcNlLsDqDZfWUEK1AbvI4EiRiH4q
 rpXFPZyBaRGw2SU1S7fPLGhXzhnkGdflgHDsTkKGIjhvHPjdfJd0BCLBZTqOD4Zrl3yMt/GUC
 3281w3hnxQiS9Tg/eQdgSPM1hI8h9OmAm+ArdzCH5XgQe9h4fGBZJ1ctf4pRyRvoOt9iJuX4R
 wjDXLg8gjhLC5Bf/AqN+3hDzyd3LHQoUpxYECrFPB+aMUSfKTLAPUM+2JDu5R/gwxTax4KzCE
 Dwo/fNSEuK5m1tl8wzu+QiTGxPuF2WUPHe4v99b1U5q+drZbV82zNbvipJzfn8ySgFwwQUUhG
 /Zpquk5lNYEGhHNEfoB/0vW5CJ2AQwaO9fi061vXKhKpPENkXkZxnPvfuXXSuoTxp9R/u1Zp0
 fgKrFmaJhz9GedT0PnDtYt3JMVM7p+knWIoPleC1QcJLtED8XX5teIG5u/4ebrL3Ihx+F4n//
 LvovcTLtP30ZajZMB5tRSDyaKd/0S9VmVEAQrJJ794qpr5cBl/L3XiJB7GeVEzC1kZjEtP5RV
 2kXpSUi7aQ54IUkzBNdsqrbx2+xh7ktPazOH2o7xwVw714gdWQcEbMS7kPFAXXYZp8UfdvBzC
 SW5xjUVBgGgFv19DdoqfKhLx9GcmLYcJl2fsC2jj/RyXc53DrvIGW61py8EizIJWoAYGQQzXG
 7XZcfU1hCkJY6zVDb5Ca40POGjDc3LEHxR1f6E1uW6ObMEelHjWpIG3TOgrDSK9pzgMlnscEK
 uTPI5mo4CBDioINOPqN4Gdg4DoS92s/jjARoKfBSDQmRhywcxtNbpnw4PJ01IMnwoFXw5X11M
 nJaZP6nOE6JyhaoKidOFuqlaxmrcqxvCAGX8fNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.19 um 17:15 schrieb brian m. carlson:
> This approach seems reasonable.  I must admit some curiosity as to how
> you discovered this issue, though.  Did you have a cat assisting you in
> typing revisions?

Found it by reading the code, but I'm not sure anymore what I was
actually looking for.

Would a fuzzer (or a cat) be able to catch that?  The function is
happily eating extra digits -- it's not crashing for me.

Ren=C3=A9
