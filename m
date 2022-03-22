Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD4CC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiCVU1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCVU1w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 16:27:52 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21DF73
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1647980772;
        bh=NQcPAN/j/dJUNpGXyvQ4TcgQhj0SgsKuxLSQSjWph0Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J2FtL9IPjL7MbWwSRJMqK/P587cDH9mfLb/KjLqQxSF8n6tytU/BX9DlTFmIB66ix
         pIqTutXKp4IhQGyW1IeTDUMCm82hKB7eAMtNy9SBfLTDM5wG6ZAnpjjAxSH3orcRNo
         6qItPr9ZfP9nrwOpWTo1mmlkYXy/DbC8K1gH3Y4w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.26.225]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1o1P8a3h8F-00eYut; Tue, 22
 Mar 2022 21:26:11 +0100
Message-ID: <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
Date:   Tue, 22 Mar 2022 21:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: improve performance of PCRE2 bug 2642 bug workaround
Content-Language: en-US
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pFlTMOZJyfKMvH3EBOU00UKKw3OeX4uZP7acYiDGazGAHInfwMK
 vs7IxqI43jlYqia1+2e4dYCxI9H0doQs0nC4Jc/0/6+YMbmusfN7V1v5TnPEt9wUIsQeb+G
 SCizdbzKeZGR4qMQQVQV8ZL+Y7ObjUm43B62dbR3FiLS+UXIIzv4EiQo4gHp9zJVTITFgMk
 aQMcvSYqgbr/FTHDob4yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6GA9G5ofsgs=:slQEn8MU/diHANXaiBqNta
 HqO9vuaQeSImu8pEP8meSFYVdTTdxV5PvKR6Zl8g20jhUG1hCYYRkhffRoW7Oi7jRUyLNIqSV
 RYz+c29EsErVQGQ6WkutEPyFUYJB2OozwYMtIQmSrPVfcHHKI5D3ipudR3MBz+hjdvXEg7Bd8
 xpcg6SFhA5tKdPJcFI1x4cNmb6/kDjM0OcwV0Mbms5h4HpbdJTx9uU36k7L6GUHRzPpFy4UQ8
 nhMteK4ug64x12HnEPZiK9gYuC25ysVuK9AxvUt3Rz/YZ63XK2SK3mytpH+qianBzxbfGd5/T
 rysljXX6sBjqQMggR039mQxPFCfnTq4cUaFWjxwaafXej4hXxnROc2lT2bGoETkpA2CxLHV0d
 5tivahk3ho8qy/zTef6ajZJpFBREQDNX+IMgsOvqobWPfTiUnHM85uTI+OOaFTLicCC9Lsuvl
 ljyzUI56XoBi/yn7nvRs5bsGOgOqcQce+QYo97xBsw1Mg9bwdDK2DELg01Yvv3/Z+K5hAtkwu
 EPFG7Tch9fFvFCVT9CMqhc7LtsLTbaBe4oNNXvuS/P97NrSQkLe8/odPrqQ3M8+rtqL5lvD9L
 fUWb0AHjX34tQUDTjCDlCEiQfR/oxX/xj9OUPsfrhr/z0UCGQPKmdFlN9QTp6VrlHH+z4XGTl
 MN8PoZIKQLq+f9Vg+qR5kuWYk0h5JRFhyKIMRIwtmFkBZgey5tNj/P8nQWp/yBH9WbjCWiGEr
 oI5xEL2QcQFRPDYGKb6GTWnsyFqB6uUMq5WEvCGya2jIQSXHVFJArXOyUnMuhq9cXmvaVCOXN
 GqABKTlfycSpo5ba7GaF0PFuIzozBKVH5Jr7FzhUJ707Jj7dn/or/pCe3ywEyavGI0JSTumfH
 Pgh7Wq0wcWYHrZF9Yz5rwmR1/LnEmYw92kb/Rjnh2IR8Ycf4tQRKB5/ao8fuBD1n+Cw5+l8Yg
 GdmvmYA9PWX25XTBIPsiV54SH9xNax1DBYGZTKtLBnYL1DmrbA5BZM4mmAB7h7GoflbF3VZk/
 LtryQ8ciwYi0hJ3UvN+BEzOQW0tVbvb+/f7DWz9K7Zq4L54WDKQ1Bz9glssVYIrM8g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.03.22 um 17:38 schrieb Paul Eggert:
> Today, Carlo Arenas pointed out[1] that GNU grep didn't work around
> PCRE2 bug 2642, which Git grep has a workaround for. While installing
> a GNU grep patch to fix this[2] I noticed that Git's workaround
> appears to be too pessimistic: on older PCRE2 libraries Git grep sets
> PCRE2_NO_START_OPTIMIZE even when PCRE2_CASELESS is not set.
>
> Attached is a patch to Git that I just now cobbled up and have not
> even compiled, much less tested. Please feel free to ignore it, as it
> would merely improve performance on older, buggy PCRE2 libraries and
> that might not be worth your trouble. I'm sending this email as more
> of a thank-you for letting us know indirectly of the PCRE2 bug.
>
> [1]: https://lists.gnu.org/r/grep-devel/2022-03/msg00004.html
> [2]: https://lists.gnu.org/r/grep-devel/2022-03/msg00005.html

Interesting.  So you say bug 2642 [3] requires the flag PCRE2_CASELESS
(i.e. --ignore-case) to be triggered.  (That's probably documented in
Bugzilla, but I'm not authorized to access it.)

However, the looser check works around another bug, if only by accident.
I believe it was fixed upstream by [4].  That other bug was discussed in
the thread Carlo linked to, which started at [5].  You should be able to
reproduce it with something like this (search for leading white-space in
a Unicode haystack):

  $ echo ' Hall=C3=B3' | grep -P '^\s'

An affected version of PCRE2 would loop forever.

However, I can only test any of that with CI jobs, not locally, so
please take my findings with a heap of salt.

Ren=C3=A9


[3] https://bugs.exim.org/show_bug.cgi?id=3D2642
[4] https://github.com/PhilipHazel/pcre2/commit/e0c6029
[5] https://lore.kernel.org/git/20220129172542.GB2581@szeder.dev/
