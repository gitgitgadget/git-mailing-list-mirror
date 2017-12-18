Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6701F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760228AbdLRSho (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:37:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760223AbdLRShj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:37:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E878DC5E51;
        Mon, 18 Dec 2017 13:37:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BuEVQtM2k4flCeskZ+jAIj6Np1c=; b=xX5fOP
        3bmvOWnk6TlHKQzdmlCp+N2Fzx0lDTC62v9mfeg4kLL5ae0NH4EXxNxABHn8Jogi
        Wn1SJrzuUPzHFFV5zj1DYQU4It/HDfd63Yau890LdEhF474rVO1Dn9f5whZh/Rxv
        EFPY5pLdbecSo5X247Ni7A5Aufbafngg1AIDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MPUr1cqQ6HuyWI32ZhxxPhPHmjvKiNK0
        s9s2KUYoJ0dfmlAtVm+njuaYHp2TWXBAgOaOhy/FTeV4YaY8p9I7nTy67ymQYvj9
        ypUbIfkA4aulmU2/aWiYOcFC4cUcRck7dTThFbhewR1/4xKaRgBDL9L6y/JKHm7Q
        dDMemzFj+94=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E109BC5E50;
        Mon, 18 Dec 2017 13:37:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56EFEC5E4F;
        Mon, 18 Dec 2017 13:37:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: 'git format-patch <ref> --summary' seems to be turning off the stat
References: <b620caf9-e11c-1511-67a6-d9f981f28728@gmail.com>
Date:   Mon, 18 Dec 2017 10:37:37 -0800
In-Reply-To: <b620caf9-e11c-1511-67a6-d9f981f28728@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 17 Dec 2017 00:27:28 +0530")
Message-ID: <xmqqlghzyj9q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85D8F16A-E422-11E7-B6BF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Note: I do see that "--summary" is a diff-option but does that mean we
> should't be printing stat information in the patch when the user
> didn't mention "--no-stat"? Yeah, "git format-patch <ref> --summary
> --stat" does bring back the stat. --- Kaartic

The old design decision shared across "log" family of commands [*1*]
wrt to these "how and what are shown" options is that they started
without any default set of options and the user gave all options (if
they want both summary and stat, they gave them from the command
line); over time they gained a set of built-in default options that
take effect only when the user gives no option.

So, yes, giving "--summary" will turn off the built-in ones that are
"--summary --stat" (IIRC).


[Footnote]

*1* "show" turns "-p" on by default, but with "show --stat" you can
    get "--stat" without the patch.  That comes from the same design.
