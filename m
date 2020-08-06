Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD773C433EA
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC02221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="sS8vm/BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgHFHCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgHFHCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 03:02:19 -0400
X-Greylist: delayed 116975 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Aug 2020 00:02:18 PDT
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E3C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 00:02:17 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596697333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=A4DKxsjwovtKysruGx65zcE7C/kCFL09eXMqZnnzkBQ=;
        b=sS8vm/BUXqNo1ldhFCSEYClfSeOPwDKdkSikD9JCQgv1oIynvpfg324AzdiWbBfPYXEV9T
        2GychBauebsKVot7yux0AdAFtUv7WdIZT3/+05r8GZ/H8pwBk5K//GhTFAzRtjM79RRC92
        PP4tFdU9qOy+UesNpwW7AST4vDZlymQ=
Content-Type: text/plain; charset=UTF-8
Subject: Re: Why is AuthorDate displayed on git-blame?
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?b?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= 
        <inoamsol@gmail.com>
Cc:     <git@vger.kernel.org>
Date:   Thu, 06 Aug 2020 02:57:20 -0400
Message-Id: <C4PPV24G8ZNK.3IYI2MQ3A262Y@ziyou>
In-Reply-To: <xmqq5z9yq611.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Aug 4, 2020 at 8:40 PM EDT, Junio C Hamano wrote:
> IOW, what you would want is a "git blame --first-parent".

This exists (because blame takes rev-list options) and works as expected
(because blame.c handles this case), but is not documented. We could
include rev-list-options.txt, but this wouldn't be accurate because
blame does some of its own commit walking. Perhaps the following
adaptation:

--first-parent::
	Follow only the first parent commit upon seeing a merge
	commit. This option can be used to determine when a line
	was introduced to a particular integration branch, rather
	than when it was introduced to the history overall.
