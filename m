Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B591FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967076AbdAGBJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:09:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57295 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933163AbdAGBJi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:09:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28D965D5B8;
        Fri,  6 Jan 2017 20:09:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SeEECipA23L+6lsVX2qARTfcx1c=; b=OT4t8i
        hD2n7PwhieKWf5HA4F9Q6M4KzHDu+1RBZXIx0Pcg6FrzBK7JP/Ny47Z9wS+VRRPF
        /oxNtZjpXdXcARc4szsOvS9EliItc+2/OLZbNHbEO1Zx9FyZRwj9Vx2e9G2ECEUx
        dB0BW4tQaVYe16UWmFra3AhvsUpfEpekzLNZ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EADE5D5B7;
        Fri,  6 Jan 2017 20:09:37 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96CD75D5B6;
        Fri,  6 Jan 2017 20:09:36 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
References: <20170106045623.21118-1-kyle@kyleam.com>
        <alpine.DEB.2.20.1701061438300.3469@virtualbox>
X-Attribution: Kyle
Date:   Fri, 06 Jan 2017 20:09:32 -0500
In-Reply-To: <alpine.DEB.2.20.1701061438300.3469@virtualbox> (Johannes
        Schindelin's message of "Fri, 6 Jan 2017 14:41:42 +0100 (CET)")
Message-ID: <87inprllpv.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4E5B600-D475-11E6-B726-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type; s=mesmtp; bh=SeEECipA23L+6lsVX2qARTfcx1c=; b=Nq2mLdKxcZ6hEsVyLxZ4Uw8l5ez25r2BIrR81/ZjY8N6uI57hQ0Ki7hY7NYD2TqxIdep6/mlI/sEpWStJ6FEXOEeV9opsVNbGqXToO0RtfSwktL9W3eBJMBE7janNef/GFIuw8wl+Yb858xkpP4vsIPpi0HA5GZjS8yxjBOAIoI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[...]

>> +test_expect_success 'resolving @{push} fails with a detached HEAD' '
>> +	git checkout HEAD^{} &&
>
> I seem to recall that we prefer HEAD^0 over HEAD^{} and the existing
> scripts seem to agree with me:
>
> $ git grep -c HEAD^0 junio/pu -- t/
> junio/pu:t/t1450-fsck.sh:1
> junio/pu:t/t1507-rev-parse-upstream.sh:2
> junio/pu:t/t2020-checkout-detach.sh:5
> junio/pu:t/t3200-branch.sh:1
> junio/pu:t/t3203-branch-output.sh:3
> junio/pu:t/t3400-rebase.sh:1
> junio/pu:t/t3404-rebase-interactive.sh:1
> junio/pu:t/t5407-post-rewrite-hook.sh:2
> junio/pu:t/t5505-remote.sh:1
> junio/pu:t/t5510-fetch.sh:1
> junio/pu:t/t5533-push-cas.sh:3
> junio/pu:t/t6035-merge-dir-to-symlink.sh:3
> junio/pu:t/t7201-co.sh:2
> junio/pu:t/t7402-submodule-rebase.sh:1
> junio/pu:t/t9105-git-svn-commit-diff.sh:1
> junio/pu:t/t9107-git-svn-migrate.sh:1
>
> $ git grep -c HEAD^{} junio/pu -- t/
> junio/pu:t/t3200-branch.sh:3
>
> Maybe use HEAD^0 just for consistency?

Yes, thanks for pointing that out.

--
Kyle
