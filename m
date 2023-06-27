Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA246EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 22:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjF0W6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 18:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0W6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 18:58:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97626B6
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 15:58:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0C5F1ED10;
        Tue, 27 Jun 2023 18:58:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GNfAPnPQMEf0lS8NB3gbd7cPiFhR+RROCU1eA0
        Lywj0=; b=hGrD16GJ16Cc+w/0dRkVONNVb3k3jwD9QjB1VdNE/2qmp3XEWEGkuB
        8FBlvewhQmLC92sIw6OgUXra2pz8/X/mlzsS16mGNTp2xYYIY2vi8KZ0zEpOL86r
        ql0XmZXDUIFRDvH0aITQZMnm9WWyN+N1+/36L8Tp7irjmAjT/kxMs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C3CC1ED0F;
        Tue, 27 Jun 2023 18:58:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B9051ED0E;
        Tue, 27 Jun 2023 18:58:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
Subject: Re: [RFC PATCH 5/8] parse: create new library for parsing strings
 and env values
References: <20230627195251.1973421-1-calvinwan@google.com>
        <20230627195251.1973421-6-calvinwan@google.com>
Date:   Tue, 27 Jun 2023 15:58:15 -0700
In-Reply-To: <20230627195251.1973421-6-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 27 Jun 2023 19:52:48 +0000")
Message-ID: <xmqq5y78fr7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A2F40D8-153E-11EE-B06C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> While string and environment value parsing is mainly consumed by
> config.c, there are other files that only need parsing functionality and
> not config functionality. By separating out string and environment value
> parsing from config, those files can instead be dependent on parse,
> which has a much smaller dependency chain than config.
>
> Move general string and env parsing functions from config.[ch] to
> parse.[ch].

Quite sensible and ...

>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  Makefile                   |   1 +
>  attr.c                     |   2 +-
>  config.c                   | 180 +-----------------------------------

... long overdue to have this.

>  config.h                   |  14 +--
>  pack-objects.c             |   2 +-
>  pack-revindex.c            |   2 +-
>  parse-options.c            |   3 +-
>  parse.c                    | 182 +++++++++++++++++++++++++++++++++++++
>  parse.h                    |  20 ++++
>  pathspec.c                 |   2 +-
>  preload-index.c            |   2 +-
>  progress.c                 |   2 +-
>  prompt.c                   |   2 +-
>  rebase.c                   |   2 +-
>  t/helper/test-env-helper.c |   2 +-
>  unpack-trees.c             |   2 +-
>  wrapper.c                  |   2 +-
>  write-or-die.c             |   2 +-
>  18 files changed, 219 insertions(+), 205 deletions(-)
>  create mode 100644 parse.c
>  create mode 100644 parse.h

It is somewhat surprising and very pleasing to see so many *.c files
had and now can lose dependency on <config.h>.  Very nice.

