Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47820C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD4E61359
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbhI1SFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:05:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:56832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236453AbhI1SFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 14:05:13 -0400
Received: (qmail 10595 invoked by uid 109); 28 Sep 2021 18:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 18:03:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1846 invoked by uid 111); 28 Sep 2021 18:03:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 14:03:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 14:03:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: remove unused git_config_key_is_valid()
Message-ID: <YVNY9OMJmXqs8EIl@coredump.intra.peff.net>
References: <patch-1.1-ba40601a511-20210928T125516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-ba40601a511-20210928T125516Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 02:56:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The git_config_key_is_valid() function got left behind in a
> refactoring in a9bcf6586d1 (alias: use the early config machinery to
> expand aliases, 2017-06-14),
> 
> It previously had two users when it was added in 9e9de18f1ad (config:
> silence warnings for command names with invalid keys, 2015-08-24), and
> after 6a1e1bc0a15 (pager: use callbacks instead of configset,
> 2016-09-12) only one remained.
> 
> By removing it we can get rid of the "quiet" branches in this
> function, as well as cases where "store_key" is NULL, for which there
> are no other users.

Yeah, the patch here is trivially correct. The greater question is
whether we're likely to need this quiet parameter again. I kind of doubt
it given the history, so this seems like a sensible cleanup.

> Out of the 5 callers of git_config_parse_key() only one needs to pass
> a non-NULL "size_t *baselen_", so we could remove the third parameter
> from the public interface. I did not find that potential
> simplification to be worthwhile.

Yeah, I think stopping here is good for now.

-Peff
