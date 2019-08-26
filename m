Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8B91F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbfHZRAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:00:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55322 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZRAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:00:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D41246D227;
        Mon, 26 Aug 2019 13:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ih3yFEDkbI8IuplJ1MTFgIAX6j8=; b=Uia4I8
        JAKVqW3M5zcxIGsMWZdQR7FluLRy66NZTi43ouhRKidFLyi1sP4GqcmHMAJTKIbY
        HTWTxzv1916Xk4QvSCrxUtS6W69QYuJuFLNcdjj/pjAp0ur1EyVGWeCfPekMkbsH
        lddF1OP5Zr0uIG1FDSOVAMX+fXMoZ/VpdjvgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N3JpJY8SUdnzpu7vogH7oexKRvfABzEJ
        4d8tkwFLeYhXaGwIGcuCq3lfi3feI8XB+gzeFva1BgYlsFGJmhjIR5v/hA6wqOKk
        NQIdOMeGoVnrfdOSmeJRYFNbeDvhPTVl60k5uNpBYU0ReLUroPaPBsa6dc95zIO7
        Zey7Vd+d004=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBE726D226;
        Mon, 26 Aug 2019 13:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB1816D211;
        Mon, 26 Aug 2019 12:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] completion: merge options for cherry-pick and revert
References: <cover.1566637431.git.liu.denton@gmail.com>
        <cdcac975548502a58234f7537a5fe11dcdb538ea.1566637431.git.liu.denton@gmail.com>
Date:   Mon, 26 Aug 2019 09:59:56 -0700
In-Reply-To: <cdcac975548502a58234f7537a5fe11dcdb538ea.1566637431.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 24 Aug 2019 05:04:49 -0400")
Message-ID: <xmqqftlnj20j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFCCDBA0-C822-11E9-8C0A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Since revert and cherry-pick share the same sequencer code, they should
> both accept the same command-line options. Merge the
> `__git_cherry_pick_inprogress_options` and
> `__git_revert_inprogress_options` variables together into
> `__git_cherry_pick_revert_inprogress_options` so that the options aren't
> unnecessarily duplicated twice.

Hmm, will the claim hold true in the future?  I do agree that they
will share continue, quit and abort (and skip) forever, but I am not
bold enough to declare that they will never have some unique option
in addition to the common one only because they "share the same
sequencer" machinery.  It is trivial to add a "if we are in revert,
do this" to the code, and it already works that way.

__git_sequencer_inprogress_common_options="--continue --quit --abort"
__git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_common_options
__git_revert_inprogress_options=$__git_sequencer_inprogress_common_options

may be a bit more future-proof way, perhaps?  The places that use
the variable(s) already correctly distinguish cherry-pick and
revert, so even though the above and your version equally "unify"
the set of common options and allow adding a new common option
(i.e. skip) with equal ease, yours makes giving unique option to one
but not to the other more difficult.
