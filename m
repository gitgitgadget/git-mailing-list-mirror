Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BBC54FCF
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A074820409
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JkaDNU5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgCWUYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:24:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50397 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCWUYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:24:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81C2DBC8CF;
        Mon, 23 Mar 2020 16:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4DDSIYlYeuuACN8OWxSeQLzGPIE=; b=JkaDNU
        5dtByEQRTZDPpKY3Nq0YeV4E6ph6V+FSowoR4s46O2Q8DicqG84GwT9Gr9zq2Izr
        RrTocl4WE3rm7BZdtmkL/9X43LmMqkW9/jg+TJQVcerh+5mtt4mTsvjGaS8FWb33
        0svXuEnAa+5/BW3WFRhvmijadyTAGTmEsxfvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvCbGRWbHA2k8XMyweVSNDoj0Prq2yK8
        PfraHU0t5tOgn5WClXwCsmeIIiYg33fwV+xLTQLy9OVb3oWpWkMNGaWPx5XNnBzw
        sOaD/JvNuG3xCW14uhd5PtEapieKNc5kAL+arUMCEdXRZjwbl01MSJWwVGQ6Sf8s
        TKV5O+vAJPU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7945CBC8CE;
        Mon, 23 Mar 2020 16:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C0D4CBC8CB;
        Mon, 23 Mar 2020 16:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 09/18] unpack-trees: add a new update_sparsity() function
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <a46439c8536f912ad4a1e1751852cf477d3d7dc7.1584813609.git.gitgitgadget@gmail.com>
        <9501e018-fe87-16b8-b0d8-913e4331778d@gmail.com>
        <CABPp-BF7=jJ2fWFcriC3E0=ZrUWawXoLbz659jtYdtkTJ4we_w@mail.gmail.com>
        <5a83259e-af03-1930-a62b-75ad37b05f37@gmail.com>
Date:   Mon, 23 Mar 2020 13:24:07 -0700
In-Reply-To: <5a83259e-af03-1930-a62b-75ad37b05f37@gmail.com> (Derrick
        Stolee's message of "Mon, 23 Mar 2020 14:21:27 -0400")
Message-ID: <xmqqo8sm4y6w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 400DFD26-6D44-11EA-B37F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>>> +int update_sparsity(struct unpack_trees_options *options);
>>>> +
>>>
>>> This appears to not use the enum as it should.
>> 
>> Whoops!  Will fix.  (Interesting that the compiler didn't flag any
>> kind of warning based on mismatch of declared function return types
>> for update_sparsity() in the .c and .h files...)
>
> *shrug* enums are essentially decoration over an int, so I'm not
> surprised it can happen.

;-)  

Yeah, the value of preferring enum over preprocessor macros because
it helps debuggers to show symbolic constants, is oversold, I think.
Types of variables and functions' return values need to be set to
the enum or the benefit won't come to us X-<.

