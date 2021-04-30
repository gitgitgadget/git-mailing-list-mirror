Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B89C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A7F61420
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3AD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:03:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61734 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3AD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:03:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15E38C04D3;
        Thu, 29 Apr 2021 20:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RQXxcSwNwgGW2eIbkQ4JfF9+tS/Nm/cl3kvN7C
        +L39E=; b=EZ323482d48/wYAiB6CzC4yaYUOEZO2do/7iTPaUB5B1JMwuFa2Lb7
        juh5ORrlS45lWDXzGpX+vIm3uO231BwT63q705TcWGfCUBMrtQXl1ol8ojGx84+P
        0HR0iCCK8jzJFi++6FCPfbJiWJQqY5HbK3+in04NZ2Cs2pVEiXvk4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09694C04D2;
        Thu, 29 Apr 2021 20:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 019E7C04CF;
        Thu, 29 Apr 2021 20:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 2/3] fast-export: rename --signed-tags='warn' to
 'warn-verbatim'
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
        <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210423164118.693197-3-lukeshu@lukeshu.com>
        <xmqqpmyfccjb.fsf@gitster.g> <87pmycq5h7.wl-lukeshu@lukeshu.com>
Date:   Fri, 30 Apr 2021 09:03:05 +0900
In-Reply-To: <87pmycq5h7.wl-lukeshu@lukeshu.com> (Luke Shumaker's message of
        "Thu, 29 Apr 2021 13:02:28 -0600")
Message-ID: <xmqqeeesfxl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70835934-A947-11EB-84B8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> How about:
>
> | Specify how to handle signed tags.  Since any transformation after the
> | export (or during the export, such as excluding revisions) can change
> | the hashes being signed, the signatures may not match.

I find it a bit worrying that it is unclear what the signature may
not match.  Knowing Git, I know the answer is "contents that is
signed", and I want to make sure it is clear for all readers.

Would "may become invalid" be better?  I dunno.

> | When asking to 'abort' (which is the default), this program will die
> | when encountering a signed tag.  With 'strip', the tags will silently
> | be made unsigned, with 'warn-strip' they will be made unsigned but a
> | warning will be displayed, with 'verbatim', they will be silently
> | exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
> | they will be exported, but you will see a warning.  'verbatim' should
> | not be used unless you know that no transformations affecting tags
> | will be performed, or unless you do not care that the resulting tag
> | will have an invalid signature.

OK.

As the current version of "fast-import" has no way to specify what
is done to incoming signed tags, it may be the best we can do to
discourage 'verbatim'.  But if it learns "--signed-tags=<disposition>",
I think the resulting ecosystem would become much better.

In the ideal world, I would imagine that we want to encourage to
always write out the original signatures to the export stream, let
any intermediary filters process the stream, and at the very end
stage at fast-import, have the --signed-commit/tag option to control
what is done to such signatures.  The set of plausible options are
what you invented for the export side in this series, plus "if the
signature still matches, keep it, otherwise strip with warning".

If we want to get closer to such an ideal world (you can point out I
am wrong and why such a world is not ideal, of course, though), we
probably do not want to add "--signed-commit" to "fast-export", as
it will have to get deprecated when the ideal world happens.
Rather, the future would deprecate the existing "--signed-tags"
option from "fast-export" instead.
