Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F0D1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 02:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfJJCVD (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 22:21:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61390 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJJCNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 22:13:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 193B33FE7D;
        Wed,  9 Oct 2019 22:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=369BAo1kBkvvScEQArqy5GLed8Q=; b=F7IAPk
        cSoPRZ3ozfjqtT8pfGUG8NyLguQ5xuLoavp/2ds205XGG1ahuGgbAas5sUUa4R8N
        Y7dc8NY8YbxMLBSstIIZ3v1z19Ag3DFC1twE7fxWEAXlRusOevz1bTXtrzo7lLq1
        EiIXQV4CYArTNd3eecrB/k1LjcquUG200QZjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sTFDC5ojzEcHZFbKp9IgTRRh/knPtzdt
        NJzlaqJA7fax722iaLV//lL4KYgNhPHtXnauYP27r+S4JZuFlaqfnzh3F9kKo92/
        WAnajDUtT8m7P9shprs7Uw4FEM6US6po0duzQmI9WH9aMbteyxrYG59n3Xhher7w
        7gwFW30QJu8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1093C3FE7C;
        Wed,  9 Oct 2019 22:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 718C83FE7B;
        Wed,  9 Oct 2019 22:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git@vger.kernel.org, kernel-usp@googlegroups.com,
        rcdailey.lists@gmail.com, me@ttaylorr.com, peff@peff.net,
        matheus.bernardino@usp.br
Subject: Re: [RFC WIP PATCH 0/3] tag: fix --edit and --no-edit flags
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
Date:   Thu, 10 Oct 2019 11:13:26 +0900
In-Reply-To: <20191008184727.14337-1-lucasseikioshiro@gmail.com> (Lucas
        Oshiro's message of "Tue, 8 Oct 2019 15:47:24 -0300")
Message-ID: <xmqqwoddjqk9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BD34130-EB03-11E9-A96A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas Oshiro <lucasseikioshiro@gmail.com> writes:

> This series of patches fixes the flags --edit and --no-edit. Currently,
> --no-edit has no effect.
>
> These patches implement the following behaviour:
>
> - when --edit is provided, the editor will always be opened;
>
> - when --no-edit is provided, the editor will not be opened (if possible),
>   otherwise an error message will be displayed;
>
> - when neither --edit nor --no-edit are provided, the editor is opened only if
>   a message is not provided and there isn't a previous tag message.

Another thing that must be done is

 - when both --edit and --no-edit are given, the last one wins.

I do not know if you have implemented it in the three patches, though.

> In the future, the fix of these flags and the code factoring done in this
> patchset will be used on the implementation of a new flag --amend, as discussed
> on the mail thread started on
> https://public-inbox.org/git/CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com/.
>
> Lucas Oshiro (3):
>   tag: factor out tag reading from write_tag_body()
>   tag: factor out prepare tag template code
>   tag: add full support for --edit and --no-edit
>
>  builtin/tag.c  | 123 ++++++++++++++++++++++++++++++++++---------------
>  t/t7004-tag.sh |   4 +-
>  2 files changed, 88 insertions(+), 39 deletions(-)
