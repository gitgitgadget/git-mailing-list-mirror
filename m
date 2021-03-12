Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987E064F1C
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhCLXMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:12:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56060 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhCLXMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:12:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CB46BEF1C;
        Fri, 12 Mar 2021 18:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XafELUro4kobJGjBNmIAX5ax3Hk=; b=XAFYnF
        ETTbhfkRIGPFMVfhPCCqcuuWtdNWhKnaPJq7ZV+wtH5mc5QaI6uOL44n0jHCZ1oV
        uHNkEVDZTLWFde+YQ1SvkFYCnXf18b1jE3SBxDMJ6wpajsJGaoAqVhN+ZySTL92E
        cPlMvHg0qcrfivThBMF3qgoi1jItvC5NIOe+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qVHh2n7QHDJAflrKwE1OXvxOBNoSehK8
        ei+XPAH5zz2QT6PfcU9NzCDb7c7gb04h+oMSH5Eb+bOyjeISjA4WvMfjFmTbn0Rc
        FZt/hRhv414OKk0KMVu/0OC8IhoXoAebOGKXntzoq7MNxSOAHChn7aABdNDoaMd1
        TuLJ+IloT2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4126BEF1B;
        Fri, 12 Mar 2021 18:12:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F86EBEF1A;
        Fri, 12 Mar 2021 18:12:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
        <20210209200712.156540-2-seth@eseth.com> <YEbdj27CmjNKSWf4@google.com>
        <xmqqmtvbjuvl.fsf@gitster.g> <xmqqzgzafo5o.fsf@gitster.g>
Date:   Fri, 12 Mar 2021 15:12:03 -0800
In-Reply-To: <xmqqzgzafo5o.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Mar 2021 17:57:07 -0800")
Message-ID: <xmqqlfas55mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C45C900-8388-11EB-ABAB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> As we want to disable the feature for any backend when the user does
>> not explicitly say the feature is wanted (either in general, or for
>> a specific backend), the change in the above hunk is exactly want we
>> want to see.
>>
>> Looking good.  Let's not revert the series and disable by default.
>>
>> Should I expect an updated log message, though?  What was in the
>> proposed log message sounded more unsubstantiated complaint than
>> giving readable reasons why the feature is unwanted, but both the
>> response by Seth and your response to Seth's response had material
>> that made it more convincing why we would want to disable this by
>> default, e.g. "with little to no explanation", "We don't have a way
>> to communicate to the end-user" (both by Seth), "when ... didn't end
>> up lining up the files correctly", "no way to visually distinguish"
>> (yours) are all good ingredients to explain why this feature is
>> prone to subtly and silently give wrong information to the
>> end-users.
>
> For tonight's pushout, I'll use the patch as-is and merge it in
> 'seen'.

Any progress here?
