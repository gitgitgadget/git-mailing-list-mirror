Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490191F453
	for <e@80x24.org>; Thu, 25 Apr 2019 05:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfDYFVv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 01:21:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64222 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfDYFVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 01:21:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 740A314E90E;
        Thu, 25 Apr 2019 01:21:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KUhUfHBEuJwVwgWKsgavJImpw8A=; b=TBjbwB
        JikMeOBfCMLaxVII1Iz45G4t3NDpkNC528mqlQjvW59g86WZj6mk7DsClhD6Cy6L
        DE3F1eDODrB0An3k0KmV4eRlUS/74Ls263nZnDErtdSJYWIHfa50fLP/44OVVcvb
        bs3nt6wfv4MLlZsPnfHcus71WQhkEQcmek67Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wOFZM/rEYL0whfVxGf10b3Ee4VOK3waz
        a+DCp08KpRK/W9IP0gIzgS0J600JWM7w4QYcblIbVN6rcqAY5IkBKee3UiN53ZFi
        a+CGeLiDZkKkZvPJLwyBNaEEqlrh2dfL7c7RORW6drHGNO5HoYvgl/Br5WNFhthq
        9t2shS9zx24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59E7F14E90D;
        Thu, 25 Apr 2019 01:21:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3F4714E90B;
        Thu, 25 Apr 2019 01:21:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/5] commit-graph: collapse parameters into flags
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
        <04f5df11351ec117a3a019c9186df38c19151d16.1556135881.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Apr 2019 14:21:47 +0900
In-Reply-To: <04f5df11351ec117a3a019c9186df38c19151d16.1556135881.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 24 Apr 2019
        12:58:04 -0700 (PDT)")
Message-ID: <xmqqk1fiy80k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 068BC6FE-671A-11E9-8F3C-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph() and write_commit_graph_reachable() methods
> currently take two boolean parameters: 'append' and 'report_progress'.
> We will soon expand the possible options to send to these methods, so
> instead of complicating the parameter list, first simplify it.
>
> Collapse these parameters into a 'flags' parameter, and adjust the
> callers to provide flags as necessary.

Nice.  It would make more sense for a collection of independent bits
to be in an unsigned, not signed integer variable, though.  Unless
you assign some special meaning to the top-most bit, that is.

