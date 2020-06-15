Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05100C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 17:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FB22081A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 17:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+p482uI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgFORJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:09:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59568 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 13:09:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72D20CEF91;
        Mon, 15 Jun 2020 13:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DayOJa3E/mw2WaSr8NM+hVdDxy4=; b=f+p482
        uIl8+MNcoHoNzHXDCsB4R7Fk2HOnx8SEHpQB6AFfnUoSODVCLJor8BF579nZr80E
        b85prWhl1z0kS/kyZsPZtXLP2pZeBr8gDEHT42vJxQ2TBidYK13uMsFYDMi6nNnn
        ARUdiup5i8hQ9Vjp50LlDiobVJx5XDWKYsf1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S9eBXTgYhu58+wO5/1Jaq8rybEfvXYIW
        GgVzJMcvEro4onkzcPmyPGqQP80pudtqKYLGXp6U6RP2gFSiTBP8ffniIj0f5kzS
        l3A3CmARSIdmHrnG77HB0GLPH79j3UYJv7eDIuvB/mKmsTeasJmeGER3jcqt0PfB
        OtpZ+Mr/SEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69A14CEF90;
        Mon, 15 Jun 2020 13:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF3C5CEF8C;
        Mon, 15 Jun 2020 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 05/12] fast-export: handle overridden main branch names correctly
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:09:08 -0700
In-Reply-To: <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 15 Jun 2020
        12:50:09 +0000")
Message-ID: <xmqqmu54w91n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE28B450-AF2A-11EA-A2F2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	 * While the main branch name might often be `main` for new
> +	 * repositories (and `master` for aged ones), and such well-known names

As I said, if you used a different word for the first 'main' in the
sentence, it reads much better.

> +	 * may not necessarily need anonymizing, it could be configured to use
> +	 * a secret word that the user may not want to reveal.
>  	 */
> -	if (!strcmp(refname, "refs/heads/master"))
> +	if (!main_branch)
> +		main_branch = git_main_branch_name(MAIN_BRANCH_FULL_NAME);
> +
> +	if (!strcmp(refname, main_branch))
>  		return "refs/heads/ref0";

The same comment as 02/12 applies here.  If the helper function
returns "" when the user says that no branch is more special than
others in the repository, the code would automatically do the right
thing.

In any case, thanks for working on it.  I am on "vacation" so will
be commenting on the rest of the series later in the week.

