Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D08C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiFCSk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243951AbiFCSk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:40:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457186461
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:40:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7FCC12D231;
        Fri,  3 Jun 2022 14:40:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2lXg80ZRFA4lCNtlOUzWgLOvESWo3pNA+vP/qk
        WPfTg=; b=ve7pHqg2z4JhxQFZtcT6ZPhJP3SRJo3cKCmfeOoZPERgyQt8qU1Xj5
        sXNZwEUKW76vcSNapCuk9RaJ1Gmcq/sNAkJT4DNfjMeu9cYUNGSMttN5DIeUKzME
        CskvU6V/hipFyA5pJl0hhuKW7cHGNWTAknLpP3QjSmvwQ+T+Xt8as=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D09D712D22F;
        Fri,  3 Jun 2022 14:40:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42ED312D22E;
        Fri,  3 Jun 2022 14:40:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com
Subject: Re: [PATCH 1/4] log-tree: create for_each_decoration()
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <4f9f34876413927d819313a70fcdefcad5b35689.1654263472.git.gitgitgadget@gmail.com>
        <xmqqa6athcif.fsf@gitster.g>
        <55d7146d-0fc4-3c29-b9a4-72f5ff856255@github.com>
Date:   Fri, 03 Jun 2022 11:40:21 -0700
In-Reply-To: <55d7146d-0fc4-3c29-b9a4-72f5ff856255@github.com> (Derrick
        Stolee's message of "Fri, 3 Jun 2022 13:58:32 -0400")
Message-ID: <xmqqv8thfv56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A00E3024-E36C-11EC-B43A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> +	for_each_decoration(commit, append_decoration, &ctx);
>> 
>> The function for_each_decoration() that does not take decoration but
>> a commit felt iffy,...
>> ...
>> 	for_each_decoration(get_name_decoration(&commit->object),
>>         		    do_whatever_they_need_to_do, &ctx);
>> 
>> so, we may want to revisit this after we finish reading the series
>> through.  Making the iterator take name_decoration does not look
>> too bad.
>
> You are right that this would work, but it's a bit messier. We
> could go this route to avoid the duplicate get_name_decoration()
> calls in format_decorations_extended().

Having a convenience function that takes a commit and let you walk
over its decoration is OK, but calling it for_each_decoration()
bothers me somewhat (which is where my comment started from after
all).

Hopefully it will stay unambiguous, and it will stay to be
unnecessary to name it for_each_decoration_for_commit(), as I do not
think we'd add "decoration" to things that are not commits (or if we
added one, we probably will call it differently from "decoration").

So, OK.
