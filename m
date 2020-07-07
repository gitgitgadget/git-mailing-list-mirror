Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6700C433E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B59120708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dbjT7Q6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGGQno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:43:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64384 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgGGQnm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 12:43:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D5F36E43B;
        Tue,  7 Jul 2020 12:43:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l6xQD7iSL8uGxz0sreHPmVXC0aI=; b=dbjT7Q
        6cvS/60QCmv78VaaBFNJS6Nlw1zZOhkM7yYsIe/JZK7tpjBO0f30skfE6VT3YFhL
        PEpWc3UGTNZONO3oi7B7ogPYoi2rDkWMLhDjUeQ+L9mrlGbN/XJKHS+MxYn1Stcg
        2IQ1zLfk+LYETBiGApq302wkOoruyXEZo40E0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eqmKTRbH0tr6Lh9dpWKJXOfqkWhzjUbq
        2rOCfSuGDCkspNQfkukuEr2ZNLIHFszVkt320AqYtgvSIJOEXYslNpqNDRdWVDSs
        AifkRl8pRaoKf9PSJhmQOMSjsIqaUzkvd9yng6roqrYlYt5vGS21D3mbdXF2P3o7
        +rTUS/BmaE8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 450616E438;
        Tue,  7 Jul 2020 12:43:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 889D26E437;
        Tue,  7 Jul 2020 12:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <lin.sun@zoom.us>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
Subject: Re: [PATCH v9] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>
        <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
        <xmqqzh8c8eda.fsf@gitster.c.googlers.com>
        <31ab701d65428$b7ca6cd0$275f4670$@zoom.us>
Date:   Tue, 07 Jul 2020 09:43:38 -0700
In-Reply-To: <31ab701d65428$b7ca6cd0$275f4670$@zoom.us> (lin sun's message of
        "Tue, 7 Jul 2020 14:34:47 +0800")
Message-ID: <xmqqmu4b5l8l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 029B34D8-C071-11EA-907A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<lin.sun@zoom.us> writes:

> So in [PATH v10], it still try get the string value first, then detecting the ""(empty)/true/false/auto. 

You cannot interpret an empty output from "git config section.variable";
it could be "[section] variable" (which is true), or it could be a sign
that there is no "[section] variable = value" in the configuration (which
you treat as false).

Catching common spellings of 'true' and 'false' in the output of the
string version of "git config", while checking for 'auto' at the
same time, may not be too bad as an optimization to save an extra
call to "git config --bool 2>/dev/null" (and ignoring errors), so I
am OK with that as long as you leave the empty output alone.
