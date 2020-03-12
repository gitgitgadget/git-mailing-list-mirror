Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A8DC2BB1D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 16:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6D5206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 16:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="M2x1jgH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCLQVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:21:52 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:54657 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgCLQVw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 12:21:52 -0400
Received: from mxback6o.mail.yandex.net (mxback6o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::20])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 9842E9401B4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 19:21:49 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback6o.mail.yandex.net (mxback/Yandex) with ESMTP id sLarCmDcLw-LnPC0vki;
        Thu, 12 Mar 2020 19:21:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1584030109;
        bh=8y8eSIJrD/NoGr+TbEzBcI6PgwuZN09CdO/R2s6a5ao=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=M2x1jgH6g583l74WKk0lTcRZZBWzHpHZY/OJ9oFlXEFdvfs8WrX4YXyaHvZ6WMcUq
         TYRBvX1wf7mKHwH1rPFyC56eSGVTwICjWLCAJ/4UVTDqAWL6lsMeBCxlmhwiJcYxdH
         tyCzwismJoUye+6JXQbFrvZzqdw9ulCVQpEIkBg4=
Authentication-Results: mxback6o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-c38703ca5585.qloud-c.yandex.net with HTTP;
        Thu, 12 Mar 2020 19:21:49 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net>
References: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net>
Subject: Re: [Feature request] "Hooks" for git log
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 12 Mar 2020 19:21:49 +0300
Message-Id: <628991584029077@iva6-9bda19f40fc4.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



12.03.2020, 18:06, "Konstantin Tokarev" <annulen@yandex.ru>:
> Hello,
>
> While it's possible to filter commits in `git log` by their contents with
> --grep and -S options, it's not always possible for formulate desirable
> filter in their terms.
>
> I think it would be very useful if git log provided new option named e.g.
> --hook or --script, which would take script path as an argument.
> git log would follow it's normal way of operation, applying other filtering
> options it was given, however intstead of printing info on commit that
> matches filters, it invokes script with commit hash as an argument.
> Script can do whatever it needs with hash, including any git operations,
> can print commit info to log if needed, or print something else, or keep
> silence. If script returns non-zero, parent git log command terminates,
> otherwise it continues.

On the second thought, its user interface should probably be more like
`git submodule foreach` to allow use of one-liners. For example, there is a
bug which I've recently reported that prevents use of 

git log --follow --full-diff <path>

It could have been worked around easily as

git log --follow <path> foreach git show $1

(syntax may be different)

-- 
Regards,
Konstantin

