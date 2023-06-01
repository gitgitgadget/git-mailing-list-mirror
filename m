Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA3C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFARwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjFARwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:52:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68B4123
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:52:19 -0700 (PDT)
Received: (qmail 6122 invoked by uid 109); 1 Jun 2023 17:52:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 17:52:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25426 invoked by uid 111); 1 Jun 2023 17:52:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 13:52:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 13:52:18 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] notes: update documentation for `use_default_notes`
Message-ID: <20230601175218.GB4165405@coredump.intra.peff.net>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
 <3c757bcb3d5c8b597b7f267549f90e1a021d229a.1685535115.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c757bcb3d5c8b597b7f267549f90e1a021d229a.1685535115.git.code@khaugsbakk.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2023 at 02:14:21PM +0200, Kristoffer Haugsbakk wrote:

> `suppress_default_notes` was renamed to `use_default_notes` in
> 3a03cf6b1d (notes: refactor display notes default handling,
> 2011-03-29).
> 
> The commit message says that “values less than one [indicates] “not
> set” ”, but I think what was meant was “less than zero”.

Yes, I think you're right. Thanks for catching my error, however
belatedly. ;)

> diff --git a/notes.h b/notes.h
> index c1682c39a9..826a2595fa 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -286,8 +286,9 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
>   * If 'opt' is not NULL, then it specifies additional settings for the
>   * displaying:
>   *
> - * - suppress_default_notes indicates that the notes from
> - *   core.notesRef and notes.displayRef should not be loaded.
> + * - use_default_notes: less than `0` is "unset", which means that the
> + *   default notes are shown iff no other notes are given. Else treat it
> + *   like a boolean.
>   *
>   * - extra_notes_refs may contain a list of globs (in the same style
>   *   as notes.displayRef) where notes should be loaded from.

This looks good to me. Arguably these should be documented in the
definition of "struct display_notes_opt", which would have avoided the
problem (3a03cf6b1d would not have forgotten to update the name since it
would be right there already). But it may not be worth the trouble to
move them now.

-Peff
