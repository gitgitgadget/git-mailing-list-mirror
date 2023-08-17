Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA6C3DA4E
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353441AbjHQQDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353451AbjHQQDU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 12:03:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AECBD1
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 09:03:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BA4034E2C;
        Thu, 17 Aug 2023 12:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DW9YZ96kQJ3pe9XxS7Hbrr/0jiqSH2CxvQ1UlF
        asdPs=; b=CLIUcrhQnbNE7NuQubpUQrCIjeLfhN36O49TJN5kczy0J8pZTSYyxo
        S519mtqcdP56Am9TmQVHcyjStcd3keDLgqas+4Hv7j5ysk1kzjJn6wa6G+CzB6pL
        wg0tMYApGphDW+1vjgMtvf4BbbayQqOQXP2BChBBak84s1Sb5c5AE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9373334E2B;
        Thu, 17 Aug 2023 12:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9C3434E2A;
        Thu, 17 Aug 2023 12:03:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [Leftoverbits] exit code clean-up?
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
        <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
        <xmqqjztvezen.fsf@gitster.g> <xmqqsf8iex5v.fsf_-_@gitster.g>
        <20230817053627.GC3006160@coredump.intra.peff.net>
Date:   Thu, 17 Aug 2023 09:03:13 -0700
In-Reply-To: <20230817053627.GC3006160@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 17 Aug 2023 01:36:27 -0400")
Message-ID: <xmqq4jkxd5by.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92899262-3D17-11EE-B398-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We _could_ document "128 means something really unexpected happened and
> we called die() deep in the code". But even that seems misleading to me,
> as we also die() for everyday shallow things (like "the name you gave is
> not valid"). The value really means very little in practice, and the
> biggest reason not to change it is that we know it doesn't conflict with
> any codes that programs _do_ promise are meaningful (like "1" from "diff
> --exit-code").

Yeah, I forgot to say that we should mention 128 to tell the users
that it is a meaningless positive number chosen to signal a general
error and it is set sufficiently high so that it won't conflict with
a range of low positive numbers certain subcommands use to convey
specific meaning in their errors.  And you said it nicely above.

With that clarified, my vote still goes to the "do not overly tied
to what the current implementation happens to do" route.

Thanks.
