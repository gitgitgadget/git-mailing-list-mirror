Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCEC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48971206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uIp5Uags"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAaUig (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:38:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60270 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaUig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:38:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0273B3BC6;
        Fri, 31 Jan 2020 15:38:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gqVku17/uFSbG71pLMdKs/JZzjg=; b=uIp5Ua
        gs8sExHY1s5VnuzlJxmkmTgpHKpGVSpgFO8lViSWWiHQjbRgUlbNSWij9kYz5QrA
        +tbH0TK9iFSpb/plnY7aV4rE+TTaY5TtWCkJ8M3Z9krOh7nbgodkI51xqnmSm5R8
        tgFoFbwW5RMBVyElOw2tuTR7If0snWK5Eyjp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tn3YeH7uht7cR9SYxi1sADlTFazaJu4w
        PoIVPkes7q1dvAxWPjwwgksBbkuowDBUEKz44fFx/6WDa27mtYv+SuuAreWWzYNp
        Tivm5uxrdHly2ArvjLlr/0CdyZWMvDR2X0fIC/nHhBv3wJyFC/tdfcRGFfYXTFIn
        RT62ki+rQvE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97958B3BC5;
        Fri, 31 Jan 2020 15:38:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8509B3BC4;
        Fri, 31 Jan 2020 15:38:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: describe Git bundle format
References: <20200130225818.193825-1-masayasuzuki@google.com>
Date:   Fri, 31 Jan 2020 12:38:27 -0800
In-Reply-To: <20200130225818.193825-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Thu, 30 Jan 2020 14:58:18 -0800")
Message-ID: <xmqqk1579xa4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3C96C78-4469-11EA-AE6B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> The bundle format was not documented. Describe the format with ABNF and
> explain the meaning of each part.

Thanks.

>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  Documentation/technical/bundle-format.txt | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/technical/bundle-format.txt
>
> diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
> new file mode 100644
> index 0000000000..dbb80225b5
> --- /dev/null
> +++ b/Documentation/technical/bundle-format.txt
> @@ -0,0 +1,40 @@
> += Git bundle v2 format
> +
> +The Git bundle format is a format that represents both refs and Git objects.
> +
> +== Format
> +
> +We will use ABNF notation to define the Git bundle format. See
> +protocol-common.txt for the details.
> +
> +----
> +bundle    = signature references pack
> +signature = "# v2 git bundle" LF

Good.  "signature" is the name used by bundle.c::create_bundle() to
call this part.

> +references   = *(prerequisite / ref) LF

This allows prereq and ref can come inter-mixed, but I think we show
all prerequisites first before refs.

> +prerequisite = "-" obj-id SP comment LF
> +comment      = *CHAR

Do readers know what CHAR consists of?  Anything other than NUL and
LF?

> +ref          = obj-id SP refname LF

OK.

"prerequisite" and "ref" are both used in bundle.c::create_bundle(),
so calling these parts with these names is consistent with the code.
"head" is also a good name for the latter as "git bundle list-heads"
is the way the end-users access them from outside.

> +
> +pack         = ... ; packfile
> +----
> +
> +== Semantics
> +
> +A Git bundle consists of three parts.
> +
> +*   Prerequisites: Optional list of objects that are not included in the bundle
> +    file. A bundle can reference these prerequisite objects (or it can reference
> +    the objects reachable from the prerequisite objects). The bundle itself
> +    might not contain those objects.

While not incorrect per-se, the above misses the more important
points (and defers the description to a later paragraph).  It is
better to describe what it means to have prereqs upfront.  

> +*   References: Mapping of ref names to objects.
> +*   Git objects: Commit, tree, blob, and tags. These are included in the pack
> +    format.
> +

Match the name you used to descibe the parts in the earlier ABNF
description, so that the correspondence is clear to the readers.
You somehow used "references" to mean both prereqs and heads, but in
the above you are describing only "heads" under the label of
"references".

Perhaps something like this?

    * "Prerequisites" lists the objects that are NOT included in the
      bundle and the receiver of the bundle MUST already have, in
      order to use the data in the bundle.  The objects stored in
      the bundle may refer to prerequiste objects and anything
      reachable from them and/or expressed as a delta against
      prerequisite objects.

    * "Heads" record the tips of the history graph, iow, what the
      receiver of the bundle CAN "git fetch" from it.

    * "Pack" is the pack data stream "git fetch" would send, if you
      fetch from a repository that has the references recorded in
      the "Heads" above into a repository that has references
      pointing at the objects listed in "Prerequisites" above.

> +If a bundle contains prerequisites, it means the bundle has a thin pack and the
> +bundle alone is not enough for resolving all objects. When you read such
> +bundles, you should have those missing objects beforehand.

With the above rewrite, this paragraph is unneeded.

> +In the bundle format, there can be a comment following a prerequisite obj-id.
> +This is a comment and it has no specific meaning. When you write a bundle, you
> +can put any string here. When you read a bundle, you can ignore this part.

Is it "you can"?  At least the last one should be "readers of a
bundle MUST ignore the comment", I think.
