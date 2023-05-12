Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ABC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbjELIrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELIrH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:47:07 -0400
X-Greylist: delayed 1881 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 01:47:05 PDT
Received: from cisrsmtp.univ-lyon1.fr (cisrsmtp.univ-lyon1.fr [IPv6:2001:660:5001:a188::146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6930F4
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:47:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 5A6AC6022D
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fvK5WtX-DVxp for <git@vger.kernel.org>;
        Fri, 12 May 2023 10:15:39 +0200 (CEST)
Received: from MailInBlack.univ-lyon1.fr (mailinblack.univ-lyon1.fr [134.214.128.85])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 8B1406005B
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:39 +0200 (CEST)
Received: from bvsortant.univ-lyon1.fr (bvsortant.univ-lyon1.fr [134.214.128.70])
        by MailInBlack.univ-lyon1.fr (Postfix) with ESMTPS id 3099C8460F;
        Fri, 12 May 2023 08:15:39 +0000 (UTC)
Received: from SAMBXP02.univ-lyon1.fr (sambxp02.univ-lyon1.fr [134.214.128.92])
        by bvsortant.univ-lyon1.fr (Postfix) with ESMTPS id 70FDC260E4E;
        Fri, 12 May 2023 10:15:31 +0200 (CEST)
Received: from [10.56.9.62] (134.214.126.37) by SAMBXP02.univ-lyon1.fr
 (134.214.128.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 10:15:38 +0200
Message-ID: <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
Date:   Fri, 12 May 2023 10:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Can we clarify the purpose of `git diff -s`?
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
CC:     Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Content-Language: en-GB, en-US
In-Reply-To: <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [134.214.126.37]
X-ClientProxiedBy: SAMBXE02.univ-lyon1.fr (134.214.128.94) To
 SAMBXP02.univ-lyon1.fr (134.214.128.92)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ I apologize for not being more reactive the last few years. I still 
love Git and this ml, but I'm struggling to find time to contribute. ]

On 5/11/23 19:37, Junio C Hamano wrote:
> The behaviour came in the v1.8.4 days with a series that was merged
> by e2ecd252 (Merge branch 'mm/diff-no-patch-synonym-to-s',
> 2013-07-22), which
> 
>   * made "--no-patch" a synonym for "-s";
> 
>   * fixed "-s --patch", in which the effect of "-s" got stuck and did
>     not allow the patch output to be re-enabled again with "--patch";
> 
>   * updated documentation to explain "--no-patch" as a synonym for
>     "-s".
> 
> While it is very clear that the intent of the author was to make it
> a synonym for "-s" and not a "feature-wise enable/disable" option,
> that is what we've run with for the past 10 years.

That's too old for me to remember exactly my state of mind, but if you 
want to do a bit of archeology, the origin is there:

https://public-inbox.org/git/51E3DC47.70107@googlemail.com/

Essentially, Stefan Beller was using 'git show --format="%ad"' and 
expecting it to show only the author date, and for merge commits it also 
showed the patch (--cc). I suggested -s and noticed that the option 
wasn't easily discoverable, hence the patch series to better document it 
and add --no-patch as a synonym.

Probably I did not get all the subtleties of the different kinds of 
outputs. I guess I considered the output of diff to be the one specified 
by --format plus the patch (not considering --raw, --stat & friends), 
hence "get only the output specified by --format" and "disable the 
patch" were synonym to me. Looking more closely, it's rather clear to me 
they are not, and that

   git show --raw --patch --no-patch

should be equivalent to

   git show --raw

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/

