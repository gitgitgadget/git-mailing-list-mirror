Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81AC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B640020658
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lQje1OUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0VIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:08:21 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:35835 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbgC0VIU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Mar 2020 17:08:20 -0400
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 3C2B84AC0685
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 00:08:18 +0300 (MSK)
Received: from mxback3q.mail.yandex.net (mxback3q.mail.yandex.net [IPv6:2a02:6b8:c0e:39:0:640:4545:437c])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 35E53CF4000C
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 00:08:18 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback3q.mail.yandex.net (mxback/Yandex) with ESMTP id OexoVLsZo7-8Ha0YNBi;
        Sat, 28 Mar 2020 00:08:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1585343297;
        bh=jp4kp7KEWAr4uCsceLVylRyml2j/nQmkqXfc9odmJIc=;
        h=Message-Id:Date:Subject:To:From;
        b=lQje1OUPqHaPjNZKnwh7l50zIAf1+JsFDbGxMG5taRqB1ZhWtiPiNunQW/vvLPNFQ
         PxGlvjJnkszEleDupPi1F36Z4MI+hGyw7+UqS4GCt2/F2UyNeZamjOKu8ZbBUDuoku
         DrikTTv1aUpzJ57Cx3iQuN6MthPHmnbXiYT0o/EY=
Authentication-Results: mxback3q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-a1bfe7298e26.qloud-c.yandex.net with HTTP;
        Sat, 28 Mar 2020 00:08:17 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     git@vger.kernel.org
Subject: Inefficiency of partial shallow clone vs shallow clone + "old-style" sparse checkout
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 28 Mar 2020 00:08:17 +0300
Message-Id: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Is it a known thing that addition of --filter=blob:none to workflow with shalow clone (e.g. --depth=1)
and following sparse checkout may significantly slow down process and result in much larger
.git repository?

In case anyone is interested, I've posted my measurements at [1].

I understand this may have something to do with GitHub's server side implementation, but AFAIK
there are some GitHub folks here as well.

[1] https://gist.github.com/annulen/835ac561e22bedd7138d13392a7a53be

-- 
Regards,
Konstantin

