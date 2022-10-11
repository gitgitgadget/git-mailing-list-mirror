Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D98BC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJKNNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKNNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:13:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0C40E06
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:13:36 -0700 (PDT)
Received: (qmail 32285 invoked by uid 109); 11 Oct 2022 13:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 13:13:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22278 invoked by uid 111); 11 Oct 2022 13:13:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Oct 2022 09:13:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Oct 2022 09:13:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elsie Hupp <git@elsiehupp.com>, git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
Message-ID: <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn96x61t.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 10:50:22PM -0700, Junio C Hamano wrote:

> One way to do this would be to have
> 
> 	[includeIf "gitdir:~/Repositories/github/"] path = $HOME/.githubconfig
> 	[includeIf "gitdir:~/Repositories/gitlab/"] path = $HOME/.gitlabconfig
> 
> in $HOME/.gitconfig and then write in these two extra files that are
> conditionally included whatever settings you want to use for any and
> all repositories that come from GitHub or GitLab.

I was about to write the same response. :) One small correction, though:
we don't expand $HOME in include paths. You can use "~", but easier
still is that non-absolute includes are relative to the including file.
Relative paths in includes are relative to the including file. So you
can just write ".githubconfig", etc, and we'll expect them adjacent to
$HOME/.gitconfig (or the xdg path if you use that, I guess).

-Peff
