Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BEFC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE0822227
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="t1DR7Bpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgJNRSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:18:37 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:33436 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgJNRSh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Oct 2020 13:18:37 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 13:18:36 EDT
Received: from mxback26j.mail.yandex.net (mxback26j.mail.yandex.net [IPv6:2a02:6b8:0:1619::226])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id B05871D40B79
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 20:11:08 +0300 (MSK)
Received: from myt2-accb38a5c431.qloud-c.yandex.net (myt2-accb38a5c431.qloud-c.yandex.net [2a02:6b8:c00:2e9b:0:640:accb:38a5])
        by mxback26j.mail.yandex.net (mxback/Yandex) with ESMTP id 3CfUZ5vGTj-B8qSmS6r;
        Wed, 14 Oct 2020 20:11:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602695468;
        bh=CrUzjWf0cIbsFVs6JKLMoy0EwLxTq2tMFTM64mhf3iM=;
        h=Subject:To:From:Date:Message-ID;
        b=t1DR7BpkeK/W2MbVawR0er6Lyc9nQdrgE0tHauSP+V7XEIaAQC9ixTwdU/9c3p8dt
         xTEbqNxTCixkxVEcPUL3CQ76/wng03It6iI2mAu0AZXNf6zHv6dO9//I0oypZmkSMj
         p6OIPslTqMy7uqXz3BJo4Qpj04VidvVPn/3Z/sHM=
Authentication-Results: mxback26j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt2-accb38a5c431.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id mY7huTgdbe-B7mS2cFo;
        Wed, 14 Oct 2020 20:11:07 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 14 Oct 2020 20:11:06 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <703071109.20201014201106@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: BUG: git rebase shows different commit message
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

How to reproduce: do commit message with leading space:

$git log --graph --decorate --pretty=oneline --abbrev-commit
* 093010ea (local/dev) Change column 'Label' => 'OPFG' and added column 'comment'
* 86221a47  Updated OpenAPI schema according to SCHEMA 193
* 6202eb08 Added opfg.html

$git rebase -i --autostash --rebase-merges 86221a47^
label onto

reset onto
pick 86221a47 Updated OpenAPI schema according to SCHEMA 193
pick 093010ea Change column 'Label' => 'OPFG' and added column 'comment'

Here commit message is shown without leading space.
I  think  that this is wrong. Because if space was shown then I reword
commit message

r 86221a47 Updated OpenAPI schema according to SCHEMA 193
pick 093010ea Change column 'Label' => 'OPFG' and added column 'comment'

but now I just do not see that I shold reword it =(

TODO: Display commit message as is

-- 
Best regards,
Eugen Konkov

