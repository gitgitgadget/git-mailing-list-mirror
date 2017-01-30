Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3121FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdA3RDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:03:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62031 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750772AbdA3RDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:03:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 837B362328;
        Mon, 30 Jan 2017 12:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZhpF9f4+Q6wk2+S56ZyvPTj1b/s=; b=S/FIQ3
        0BlGl0w5+QzkwYsdubGpCMBC3+Zbq3wNWlYEcYdJ3N9b2rYSrF830DDEmlWze5cR
        CBdsI5Jlb3Lu7cQn58HW34BubZQ08ePOVbhAPgjk1GLmAm3dTppmmrXl99CxdRSP
        xy3SKGe01nkI8NoRpvqwJVS6IY3zDIAfz9Xhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xT8wkVd5jto8bn6YkttIci7dTDR77DSz
        SHGit8GRd5sqnzvx5Y8lZxkhXc6ob9i6m3HUwa3Mg1PzwVqO/v1vqHdUgbEEOdyv
        h6yqcniEdcTXJjfDpDVm9TY4Nd9oda6uMfci0X0ZL6afjWTr5hl/Gb3k/Lcfk6yG
        Dqgbe5xB4kY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C22D62327;
        Mon, 30 Jan 2017 12:03:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8C6862326;
        Mon, 30 Jan 2017 12:03:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2] help: improve is_executable() on Windows
References: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de>
        <4b93fe44ff9020ed80e4fd93a24a6ffa647e7678.1485780050.git.johannes.schindelin@gmx.de>
Date:   Mon, 30 Jan 2017 09:03:11 -0800
In-Reply-To: <4b93fe44ff9020ed80e4fd93a24a6ffa647e7678.1485780050.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 30 Jan 2017 13:40:58 +0100
        (CET)")
Message-ID: <xmqqmve8wkds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBF3D53A-E70D-11E6-AE44-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Heiko Voigt <hvoigt@hvoigt.net>
>
> On Windows, executables need to have the file extension `.exe`, or they
> are not executables. Hence, to support scripts, Git for Windows also
> looks for a she-bang line by opening the file in question, and executing
> it via the specified script interpreter.
>
> To figure out whether files in the `PATH` are executable, `git help` has
> code that imitates this behavior. With one exception: it *always* opens
> the files and looks for a she-bang line *or* an `MZ` tell-tale
> (nevermind that files with the magic `MZ` but without file extension
> `.exe` would still not be executable).
>
> Opening this many files leads to performance problems that are even more
> serious when a virus scanner is running. Therefore, let's change the
> code to look for the file extension `.exe` early, and avoid opening the
> file altogether if we already know that it is executable.

Much more readable than the initial round.  Will queue; thanks.
