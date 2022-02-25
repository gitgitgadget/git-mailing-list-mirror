Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED89C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiBYRLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbiBYRLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:11:53 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31E202893
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:11:20 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7938C18B33B;
        Fri, 25 Feb 2022 12:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=qZtCBvtdFzzs7VZqgXJHkowN+i+/GM2/s58Svj
        WA56o=; b=wthRdJUK+VLuwdfFLCm9UwCLAW27J8CgpCVZAMSTdwVp+Xp3yr5wbo
        dNVpAEHEO0rALxCVMRG+qAkilxV6mR4SAJ0sQL+Fl5YOfkfDgyTLrTZDD8eHCDW4
        6/aJ1TFOPsUK3+BRq1batnSFeV/n9Yelb9ck4kgIoPmHLL9wsCvE0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7259E18B33A;
        Fri, 25 Feb 2022 12:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15AFC18B339;
        Fri, 25 Feb 2022 12:11:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kang-Che Sung <explorer09@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "Git worktree list" on paths with newlines
In-Reply-To: <CADDzAfNTuuAWn1ynswTayRqgNNcPn3ou=v6c+z_tRsu5uoqJZA@mail.gmail.com>
        (Kang-Che Sung's message of "Fri, 25 Feb 2022 16:32:37 +0800")
References: <CADDzAfNTuuAWn1ynswTayRqgNNcPn3ou=v6c+z_tRsu5uoqJZA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Fri, 25 Feb 2022 09:11:16 -0800
Message-ID: <xmqqilt2g9cb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F197E75C-965D-11EC-8B68-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kang-Che Sung <explorer09@gmail.com> writes:

> I wish "git worktree list --porcelain" would show directory names with some
> quoting or escaping so that tricky names can be handled easily for any program
> that reads the porcelain output. But I didn't see any command line option that
> enables quoting or escaping of file names.
>
> Does anyone have an idea on what I could do?

I agree that an output mode that claims to be --porcelain should
produce output that is machine-parseable without ambiguity.

The usual practice is to use quote_c_style() for output without
"-z", and with "-z", just use the NUL as the termination character,
as you shouldn't be listing strings with embedded NUL.

