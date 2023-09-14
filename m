Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F37EEAA55
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjINQS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjINQSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 12:18:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22291FC4
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 09:18:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 130471AFA09;
        Thu, 14 Sep 2023 12:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=bGFEXAZ6w7FC8jXluZUfeS7r5vfWxeGqPMtEjf
        3t6OQ=; b=utABAmcwkq8ReUMsfgJqT+3Wq3/QC4UVOlxCvEdyrse2moUx92cU4f
        uJK9gp5CFjgwckU88xfJnCYopptJo/Af4U4lCe841iRbuOGEatJ5RTtO5F4HUlvz
        QtoBBDQ8+fBbMwbFEzgHEbUYsRIt0lzAbX0cfqG6QQsE+ew/ZR0bg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B3CE1AFA08;
        Thu, 14 Sep 2023 12:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66C451AFA05;
        Thu, 14 Sep 2023 12:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/1] range-diff: treat notes like `log`
In-Reply-To: <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de> (Johannes
        Schindelin's message of "Thu, 14 Sep 2023 10:29:31 +0200 (CEST)")
References: <cover.1693584310.git.code@khaugsbakk.name>
        <cover.1694383247.git.code@khaugsbakk.name>
        <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
        <xmqqzg1strgx.fsf@gitster.g>
        <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de>
Date:   Thu, 14 Sep 2023 09:18:49 -0700
Message-ID: <xmqqpm2kk9sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63D79284-531A-11EE-A4FA-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A much more surgical way to address the issue at hand might be this
> (Kristoffer, what do you think? It's missing documentation for the
> newly-introduced `--show-notes-by-default` option, but you get the idea):

Clever.  I was wondering if the option parsing done by the revision
machinery was readily available for us to use from range-diff code,
but because we are forking out to "log" anyway, giving it the new
"--show-notes-by-default" option does sound like a much easier way
out.  It would help something like

	[alias] ln = !"git log --show-notes-by-default"

as well.  Nicely designed.

