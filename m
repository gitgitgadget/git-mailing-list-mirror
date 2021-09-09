Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2AC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FF16113A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbhIIUdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:33:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60218 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbhIIUde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 16:33:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C91A140AE7;
        Thu,  9 Sep 2021 16:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MVd8Z/C2U0sIA4pxaTgyCysK9hfSyd/6xxch8H
        4e6rA=; b=XPhSXOgoxLYotrpkuuKP2yFm4c5LcLGzrV2l2rO/MNI5CvhiV119iJ
        5eErhkDmu8nZOncJfVpEYNhqRXVrHEJunl7kRcp2+YDe1oX3vtFrCV3wbh4uJRyr
        Aj6KZI59sDvG0D6dPkXacaPk2uwNaMls6fGcmRtI+0/PHjOrSX50A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44922140AE6;
        Thu,  9 Sep 2021 16:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CE3F140AE5;
        Thu,  9 Sep 2021 16:32:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/19] Adds reftable library code from
 https://github.com/hanwen/reftable.
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 13:32:19 -0700
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 09 Sep 2021 18:47:25
        +0000")
Message-ID: <xmqq7dfpxzfw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08C73E90-11AD-11EC-8205-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The reftable format is described in Documentation/technical/reftable.txt.
>
> This is a fully reentrant implementation of reading and writing the reftable
> file format, and should be suitable for embedding in libgit2 too. It does
> not hook the code up to git to function as a ref storage backend yet.

Not a question for Han-Wen, but I am wondering how much style and
other consistency guidelines we have in our C code to the files in
this directory.  

I am guessing that rules like "no decl after statement" and "no decl
in the set-up part of the for loop control" (i.e. "for (int i = 0;
..."  is a no-no) should apply equally to this code, but it might be
OK to deviate from rules that are only meant to help human readers [*]
without affecting compilation.

Opinions?


[Footnote]

 * multi-line comment style.

 * asterisk sticks to identifier not to type

 * not enclosing a single-statement block inside {}

 * empty statement looks like

	; /* empty */
