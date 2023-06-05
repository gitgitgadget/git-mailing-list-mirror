Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D0C7EE2A
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 04:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFEEuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 00:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFEEut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 00:50:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0E98
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 21:50:48 -0700 (PDT)
Received: (qmail 11523 invoked by uid 109); 5 Jun 2023 04:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Jun 2023 04:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25238 invoked by uid 111); 5 Jun 2023 04:50:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Jun 2023 00:50:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Jun 2023 00:50:42 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] notes: move the documentation to the struct
Message-ID: <20230605045042.GA66000@coredump.intra.peff.net>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
 <cover.1685904424.git.code@khaugsbakk.name>
 <99c88c74ceab751c0540b51d98bf339bffc098ef.1685904424.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99c88c74ceab751c0540b51d98bf339bffc098ef.1685904424.git.code@khaugsbakk.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2023 at 08:54:00PM +0200, Kristoffer Haugsbakk wrote:

> Its better to document the struct members on the struct definition
> instead of on a function that takes a pointer to such a struct. This
> will also make it easier to update the documentation in the future.

This is better, I think, but...

> +/*
> + * - use_default_notes: less than `0` is "unset", which means that the
> + *   default notes are shown iff no other notes are given. Otherwise,
> + *   treat it like a boolean.
> + *
> + * - extra_notes_refs may contain a list of globs (in the same style
> + *   as notes.displayRef) where notes should be loaded from.
> + */
>  struct display_notes_opt {
>  	int use_default_notes;
>  	struct string_list extra_notes_refs;

...what I had meant to suggest was putting the documentation next to
each field, like:

  struct foo {
	/* when set, enable "bar" for all frotz's */
	int use_bar;

	/* etc... */
  };

For an example, try "struct bloom_filter_settings" in bloom.h (though
there are many others, too).

-Peff




> @@ -283,15 +291,7 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
>  /*
>   * Load the notes machinery for displaying several notes trees.
>   *
> - * If 'opt' is not NULL, then it specifies additional settings for the
> - * displaying:
> - *
> - * - use_default_notes: less than `0` is "unset", which means that the
> - *   default notes are shown iff no other notes are given. Otherwise,
> - *   treat it like a boolean.
> - *
> - * - extra_notes_refs may contain a list of globs (in the same style
> - *   as notes.displayRef) where notes should be loaded from.
> + * 'opt' may be NULL.
>   */
>  void load_display_notes(struct display_notes_opt *opt);
>  
> -- 
> 2.41.0
> 
