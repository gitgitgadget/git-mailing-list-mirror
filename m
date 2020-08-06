Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE530C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76E2221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="h8mrtd5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHFVv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHFVv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 17:51:27 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2D0C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 14:51:26 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596750684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=qTjdz8TATfkeyewLAan4MbkXzZ1ktKBZpqJfBzd4zdU=;
        b=h8mrtd5a9F+iPfo10Em8wIaDGoC+POaP9HUlVk58oi2XHuNDAUlHqVTZ+vC1dbB4E6lyo6
        8hc8RFGH7/19u6DTEurGZ1VaT8VQ2h8ECxA9VNlLcPibjP6VzcwbR5SAf97sjBXPC/8bDf
        whYPRxMp3B3G5neGNXwk8kC3qtFUrG0=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] apply: make i-t-a entries never match worktree
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Thu, 06 Aug 2020 17:47:04 -0400
Message-Id: <C4Q8SABARPKO.3TGSLMINT377S@ziyou.local>
In-Reply-To: <xmqqimdvjxq1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 6, 2020 at 5:00 PM EDT, Junio C Hamano wrote:
> At first glance, it feels somewhat sad that this check is not done
> in check_preimage(); after all, the caller of check_preimage() feeds
> it to all kind of patches, without excluding path creation, so the
> helper should be allowed to say "heh, you are trying to create path
> F with this patch, but there already is F in the index", "you are
> renaming into F but there is F already", etc.

I spent some time trying to put it in there before deciding it was
better off in check_to_create().

> It is somewhat unsatisfactory that we need to do the same
> index_name_pos probing twice. I wonder if we somehow can
> consolidate them?
>
> Perhaps something along this line, instead of this patch?

I think this logic can be consolidated and still readable, yeah. I'll
send a patch.
