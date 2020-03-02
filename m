Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F1C3F2CD
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DAC208C3
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MufOo4ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCBVa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:30:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59341 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBVa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 16:30:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6ED79BF319;
        Mon,  2 Mar 2020 16:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jS6WDamxjkiZ5T48nmv9/h8uAOk=; b=MufOo4
        rishKv1GU1tIfOZNty62hG0xOpZvCLdPAUxPGzHqKRMIJmC3T1x2lurC2vUo/aHd
        i21WLljs0NfIjGCo/SPeQLVtcGUoCrDyOlvJknPNfzT6CGhjM4Lr1e2LWlaqs8bJ
        ZNP2SZIsr+ykwRko3KdIm7vb5BQFcbssdyDQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NsGJoN7iwaF83nHklmg4iBmV84B3/icT
        JNYunXk0OZFNO5czK97kdl6FXctwalWu2HnvFsvbVlb2H3xnICIsvJHlPKAkikkU
        xmme6KcTHfvqdj6nnJlcLwRD73C4GvAVkZ2SCd00sF0qE2KZK0bovcMPZ51Ffplk
        UtTkzTusITE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67909BF318;
        Mon,  2 Mar 2020 16:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AE0EBF317;
        Mon,  2 Mar 2020 16:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/2] stash: remove the stash.useBuiltin setting
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
        <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
        <20200302181832.GA1571684@cat> <20200302181924.GB1571684@cat>
Date:   Mon, 02 Mar 2020 13:30:51 -0800
In-Reply-To: <20200302181924.GB1571684@cat> (Thomas Gummerer's message of
        "Mon, 2 Mar 2020 18:19:24 +0000")
Message-ID: <xmqq7e02bg1g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18419C1C-5CCD-11EA-AF30-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> -	if (!use_builtin_stash()) {
> -		const char *path = mkpath("%s/git-legacy-stash",
> -					  git_exec_path());
> -
> -		if (sane_execvp(path, (char **)argv) < 0)
> -			die_errno(_("could not exec %s"), path);
> -		else
> -			BUG("sane_execvp() returned???");
> -	}
> -
>  	prefix = setup_git_directory();
>  	trace_repo_setup(prefix);
>  	setup_work_tree();
>  
>  	git_config(git_stash_config, NULL);
>  
> +	if (use_legacy_stash ||
> +	    !git_env_bool("GIT_TEST_STASH_USE_BUILTIN", -1))
> +		warning(_("the stash.useBuiltin support has been removed!\n"
> +			  "See its entry in 'git help config' for details."));

Makes sense.
