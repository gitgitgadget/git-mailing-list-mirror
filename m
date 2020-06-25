Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B24CC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E916B2080C
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FRCk9MMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405930AbgFYSIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:08:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58961 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405552AbgFYSIW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 14:08:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B247E271B;
        Thu, 25 Jun 2020 14:08:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vm+DkUixHS6QJDM+86W49kw5cII=; b=FRCk9M
        MGjwKohmvluqlO+jBDGIjLaZ156e6khYZTqEn4LUUbFmeACT84cPqvb2Pe2qJudF
        yPL1w0Xlant4qGAtyJKanXA9W/rlWY3CSvO2Hun+DrNfgcVOsTW/Gg5Rw8eiA7GZ
        hySnQ7nFr+ToYILpFWq02Z1oQhSEhNsyhSwMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DW7KnHxmZ2dVG3MGNCdgDmMHc1p7uyV0
        eHfX0oQBVfEtigZlP/qcumvpHSG7F6U6Of2AfEPeOzjFJbeqCf6n+JFMW5fiag+m
        oQ96PqLsm4hiajGFxL5BTeg3Pcw1j0Af11mA7cs8/dxtLLiDF4IJethBcn81+Gv6
        MQ5sGqlQAAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 031A4E271A;
        Thu, 25 Jun 2020 14:08:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83D57E2719;
        Thu, 25 Jun 2020 14:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] diff-files --raw: show correct post-image of intent-to-add files
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 11:08:14 -0700
In-Reply-To: <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 25 Jun 2020
        17:53:40 +0000")
Message-ID: <xmqqmu4r3to1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7C386D6-B70E-11EA-A737-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 61812f48c2..25fd2dee19 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -220,8 +220,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			} else if (revs->diffopt.ita_invisible_in_index &&
>  				   ce_intent_to_add(ce)) {
>  				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> -					       the_hash_algo->empty_tree, 0,
> -					       ce->name, 0);
> +					       &null_oid, 0, ce->name, 0);

This (even if the preimage were correctly using empty_blob) is *so*
simple a change that it is very surprising that the new test in
[2/2] passes without any other code change.

It means that difftool was written correctly in the first place,
right?

Nicely done.
