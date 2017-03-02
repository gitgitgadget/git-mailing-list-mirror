Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97B41F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbdCBTgc (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:36:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752090AbdCBTg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:36:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4060F84896;
        Thu,  2 Mar 2017 14:36:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=goDbw3TNGzDupihSY2yl/wPrekM=; b=Nfbo7F
        m2pKfogTKxzoqPjRt27/vSZioq1t+GRc2R1GGWsROF/AoL8vGXGj7c8EEwMHbLN6
        OW2O1BCra22XC4TauxIYqBPp02cDygWNf6jga+08z+13FTJr1bwdLNxLmxXuXj6G
        OSrdQVpyjWvT5F0WnT7PXSJdZfpwJ92poT/ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DrVm1oJ8mwpnYBynH29s7lYwlucLpn5p
        zMI2/fzAsseE/CnTmxzikBN1dK/ZiHffXFX+u1WnaJ+OLC46TuGsMbQhQ/MOTWpR
        zqwzRk2ws9yAvw5JN1lCeeoRo23+kuGEluKRygO7qzZ51XZnKas05r2Xv/yt2TXy
        3/FvYNYsNB0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3173084895;
        Thu,  2 Mar 2017 14:36:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82B8C84892;
        Thu,  2 Mar 2017 14:36:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Devin J. Pohly" <djpohly@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless commits
References: <20170223082736.31283-1-djpohly@gmail.com>
        <20170223082736.31283-3-djpohly@gmail.com>
        <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
        <20170223213333.GA3490@prospect.localdomain>
Date:   Thu, 02 Mar 2017 11:36:18 -0800
In-Reply-To: <20170223213333.GA3490@prospect.localdomain> (Devin J. Pohly's
        message of "Thu, 23 Feb 2017 15:33:33 -0600")
Message-ID: <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 827283AC-FF7F-11E6-AD8B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Devin J. Pohly" <djpohly@gmail.com> writes:

> I think your point is interesting too, though.  If a commit is also
> TREESAME to its parent(s?) in the _pre-filtered_ branch, it seems
> reasonable that someone might want to leave it in the filtered branch as
> an empty commit while pruning empt*ied* commits.  I would imagine that
> as another option (--prune-newly-empty?).

I was hoping to hear from others who may care about filter-branch to
comment on this topic to help me decide, but I haven't heard
anything, so here is my tentative thinking.

I am leaning to:

 * Take your series as-is, which would mean --prune-empty will
   change the behaviour to unconditionally lose the empty root.

 * Then, people who care deeply about it can add a new option that
   prunes commits that become empty while keeping the originally
   empty ones.

Thoughts?
