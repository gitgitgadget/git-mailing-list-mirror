Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E3C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 21:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGIVVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGIVVC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 17:21:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EAF17E0D
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 14:21:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3598A1255E7;
        Sat,  9 Jul 2022 17:20:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SOQ4giEv3rQGTpWswYDiEJsI9JabsvUAywLC1x
        V5W1o=; b=eHCjox0CYcjOjad+kPdmoKq95YUyUJn27fD3HStdiFr7QR4+NnaKO0
        7E/tKhknp5R99v8JXa7RlkqzUN3oD7qYNIS2KOWBCxo4V4+1LMQKbbqL7t2Tgr0S
        N0nPTPEPXx3vFKer88bl6Gg+wf7cOSQF9Suwnf1CnM+/zqQd4dHVE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BB441255E6;
        Sat,  9 Jul 2022 17:20:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79AC31255DF;
        Sat,  9 Jul 2022 17:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 2/4] glossary: add commit graph description
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <32777cae24de91b0fb873ea04a802630ab85aafe.1657385781.git.gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 14:20:55 -0700
In-Reply-To: <32777cae24de91b0fb873ea04a802630ab85aafe.1657385781.git.gitgitgadget@gmail.com>
        (Philip Oakley via GitGitGadget's message of "Sat, 09 Jul 2022
        16:56:19 +0000")
Message-ID: <xmqqedyut22w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 055FD118-FFCD-11EC-9E68-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +[[def_commit_graph]]commit graph::
> +	The commit-graph file is a supplemental data structure that
> +	accelerates commit graph walks. The existing Object Data Base (ODB)
> +	is the definitive commit graph. The "commit-graph" file is stored
> +	either in the .git/objects/info directory or in the info directory
> +	of an alternate object database.

While it says nothing technically incorrect, I suspect "The existing
object data base is the definitive commit graph" may invite unneeded
confusion.

I think you wanted to say that the DAG formed by traversing the
pointers recorded in the objects is the authoritative source of
truth and the commit-graph file is merely a precomputed cache and
can be safely lost, but I am not sure the above description conveys
that to anybody who does not already know it.

    The commits in the object data base form a directed acyclic
    graph (DAG) by commits referring to their parent commits.
    Pieces of information from individual commit objects that are
    needed to traverse the DAG are pre-computed in the commit-graph
    file and stored in ...

is my attempt---I am not very happy or proud about it, but it may be
easier to follow.

Thanks.


