Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E9C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB53206EB
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tlTBAO4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCLTY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:24:26 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:43305 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgCLTY0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 15:24:26 -0400
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 1DA9B6054A;
        Thu, 12 Mar 2020 22:24:23 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id rVdGZxkwTK-OMuKdggw;
        Thu, 12 Mar 2020 22:24:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1584041062;
        bh=QsDYD5fEJM20OO1jNj3SUtaiVFybSwQPcCRbi00B3mk=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=tlTBAO4BkRBMLISyXZvMcm4RQh2bvF7GZ9E5ggExokY7wrghbKvbTkps/ZUq9afez
         2zdDwOBG5XIYePVtV4QLms0e40i8wXW1ua5rg86czIUU4BTxPMEvKw2R7x5ShXtG1e
         g6QP1NOD7k/qBcmK5aFEZd6vyf5M79qmnJSsryNQ=
Authentication-Results: mxback11q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla3-bebe75876e15.qloud-c.yandex.net with HTTP;
        Thu, 12 Mar 2020 22:24:22 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <79741584039971@myt6-4d759d962265.qloud-c.yandex.net>
References: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net> <xmqqo8t1flin.fsf@gitster.c.googlers.com> <79741584039971@myt6-4d759d962265.qloud-c.yandex.net>
Subject: Re: [Feature request] "Hooks" for git log
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 12 Mar 2020 22:24:22 +0300
Message-Id: <87951584041001@myt5-5e0e3f348369.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



12.03.2020, 22:08, "Konstantin Tokarev" <annulen@yandex.ru>:
> 12.03.2020, 21:58, "Junio C Hamano" <gitster@pobox.com>:
>>  Konstantin Tokarev <annulen@yandex.ru> writes:
>>
>>>   I think it would be very useful if git log provided new option named e.g.
>>>   --hook or --script, which would take script path as an argument.
>>>   git log would follow it's normal way of operation, applying other filtering
>>>   options it was given, however intstead of printing info on commit that
>>>   matches filters, it invokes script with commit hash as an argument.
>>>   Script can do whatever it needs with hash, including any git operations,
>>>   can print commit info to log if needed, or print something else, or keep
>>>   silence. If script returns non-zero, parent git log command terminates,
>>>   otherwise it continues.
>>
>>  You do not need a hook for that, no?
>>
>>   $ git log --format='%H' ...your other options here... |
>>     while read commit
>>     do
>>          ... your "hook" that checks the $commit to see if
>>          ... it is "interesting" and shows or discard or whatever
>>          ... it does comes here
>>     done
>
> When pager is in use, git log loads commits lazily when you scroll down.
> I find this feature rather crucial for working with any long history, and
> I don't see how to achieve this with pipe.

Nvm, passing to less -R makes it pause when needed. I've never realized it
was that simple.

-- 
Regards,
Konstantin

