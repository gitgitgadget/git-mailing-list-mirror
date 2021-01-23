Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0CEC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3708C22D57
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbhAWSvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:51:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50813 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWSv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 13:51:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D98BAF4D5;
        Sat, 23 Jan 2021 13:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zd6dkuvEL8O/M6bnk18LIQZx5vs=; b=OZPHYW
        U5OS00OWhaFLw40i8VRMJqcg68R/IMnHGKsQYDqw3o7iV28eLoPvJPBunjU675jA
        CqriLAvXPBGrcCGtlxlqiPHa3fSkOan3sPYTBGsk9UrYhYt75n/3IqcrnmpJ7Qo6
        Y1i+pJoWx470xUfqZrGJZX3v0zeNuk9JPHMfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O9wA7qQkJdzLNSr7dVQXyfEnPuFfFXah
        yuPbPd6fq9qxye34KCcMbFdjWoRMd80oRAjZ2D6dtyYo85y4hlUCVWDiaSUQKuJn
        kfmUKa74uyEl7RX8X6cHeB+2a0+cnb4S1ZRRLFTMAnCPgsKvAU6iNqq0LdlSRAP8
        AN9jlrpr/pc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AC6AF4D2;
        Sat, 23 Jan 2021 13:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EE96AF4D1;
        Sat, 23 Jan 2021 13:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 7/8] test-lib: test_region looks for trace2 regions
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <8832ce84623e9c74a88b14a05b1c303ed8aa809b.1611320640.git.gitgitgadget@gmail.com>
        <xmqq7do492sh.fsf@gitster.c.googlers.com>
        <8406512b-3d9f-e899-24fd-8a09c4af3569@gmail.com>
Date:   Sat, 23 Jan 2021 10:50:42 -0800
In-Reply-To: <8406512b-3d9f-e899-24fd-8a09c4af3569@gmail.com> (Derrick
        Stolee's message of "Sat, 23 Jan 2021 13:36:06 -0500")
Message-ID: <xmqqczxv4hdp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E538C256-5DAB-11EB-8BE4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> +	if test $exitcode != $expect_exit
>> 
>> ... this will not trigger and we return "success" (i.e. "failed as
>> expected")?
>
> Am I misunderstanding something here? If exitcode is 2, then this
> will always trigger and return 1, signaling a failure.

Are, please disregard.  Yes, the above does the right thing already.
