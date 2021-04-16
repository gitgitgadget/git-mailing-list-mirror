Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA37C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 02:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE2761152
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 02:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhDPDAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 23:00:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:54026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhDPDAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 23:00:02 -0400
Received: (qmail 20101 invoked by uid 109); 16 Apr 2021 02:59:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Apr 2021 02:59:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20971 invoked by uid 111); 16 Apr 2021 02:59:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 22:59:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 22:59:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
Message-ID: <YHj9mUzs+jlgNuVE@coredump.intra.peff.net>
References: <xmqqa6pznlgq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6pznlgq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 05:04:37PM -0700, Junio C Hamano wrote:

> * ps/config-global-override (2021-04-13) 3 commits
>   (merged to 'next' on 2021-04-15 at 60a58d74ab)
>  + config: allow overriding of global and system configuration
>  + config: unify code paths to get global config paths
>  + config: rename `git_etc_config()`
> 
>  Replace GIT_CONFIG_NOSYSTEM mechanism to decline from reading the
>  system-wide configuration file with GIT_CONFIG_SYSTEM that lets
>  users specify from which file to read the system-wide configuration
>  (setting it to an empty file would essentially be the same as
>  setting NOSYSTEM), and introduce GIT_CONFIG_GLOBAL to override the
>  per-user configuration in $HOME/.gitconfig.
> 
>  Will merge to 'master'.

Looks like this fails CI on the Windows VS build. I get:

  ++ env GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=/dev/null git config --global --list
  fatal: unable to access 'nul': Invalid argument

from t1300.181. I thought we had some magic to make /dev/null work there
(or maybe this _is_ the magic kicking in, since it is looking for the
Windows-ish nul, but it is not working for some reason).

-Peff
