Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79119C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiBYRjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiBYRje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:39:34 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAA8B7149
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:38:59 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC74918B64A;
        Fri, 25 Feb 2022 12:38:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+h813cVdWuY4BpqMaeta2IdSJiEw8SXC0i2bbm
        LGFpw=; b=pckXnHxTiKUjsXcUq/haveLjWPPCd4FG9GanhMQFh67/dpMZXJ4dCr
        yxk8FEwOgugetDu7CQE5foPaynraL2ZYv+UiS0EleyVaQK/vHovy4HLUkB7gVNx+
        ZgP57EWrXe3EItugQZgvaqFmcE/bSbItx1KRkiAtUiY+VJlT6oUlI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B53AF18B649;
        Fri, 25 Feb 2022 12:38:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A08E18B648;
        Fri, 25 Feb 2022 12:38:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
Subject: Re: [PATCH 4/7] commit-graph: fix generation number v2 overflow values
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <de7ab2f39d90c6b33b21a5adf126ec2ef5ce27e6.1645735117.git.gitgitgadget@gmail.com>
        <xmqqbkyvki54.fsf@gitster.g>
        <3d303ba3-36ed-4bda-e499-8b7da0dc1413@github.com>
Date:   Fri, 25 Feb 2022 09:38:55 -0800
In-Reply-To: <3d303ba3-36ed-4bda-e499-8b7da0dc1413@github.com> (Derrick
        Stolee's message of "Fri, 25 Feb 2022 08:53:08 -0500")
Message-ID: <xmqqr17qeths.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE7C359E-9661-11EC-97CC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> +# The remaining tests check timestamps that flow over
>>> +# 32-bits. The graph_git_behavior checks can't take a
>>> +# prereq, so just stop here if we are on a 32-bit machine.
>>> +
>>> +if ! test_have_prereq TIME_IS_64BIT
>>> +then
>>> +	test_done
>>> +fi
>>> +if ! test_have_prereq TIME_T_IS_64BIT
>>> +then
>>> +	test_done
>>> +fi
>> 
>> The above is OK but is there a reason why we cannot do
>> 
>> 	if A || B
>> 	then
>> 		test_done
>> 	fi
>> 
>> here (I am assuming not, but in case I am missing the reason why it
>> has to be separate)?
>
> Does not need to be separate. I just discovered the two different
> prereqs for similar, but not exact, checks. I can swap this to an
> or statement.

I do not think a single condition with single test_done is
necessarily better. I was just curious if there was anything subtle
going on.

Thanks.
