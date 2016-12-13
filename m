Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E8F203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbcLMTrX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:47:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60613 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752409AbcLMTrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:47:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F4A55522;
        Tue, 13 Dec 2016 14:47:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SX8MeJ9OsaRBaF5HYoZhoXNd1Vs=; b=KQnDiA
        CazWjsmkKosGc6g0H+S+32IqcDSAmyXkzOgnky8jMpxVZDwiUJYnfaFA0NOcKZvg
        R0ulinaHf/XlzUoLO32abB8HunejLnn23o5EsTdUrE9RoQkqBrRcVDQTSNtaQSGy
        BzOUFxf+Jg+rwaRs2Y389+syq7LvQmMnUr5qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hSBBNLWsKU3fOC7s/og5GwoisY2Qj0C/
        XHyUephfmxz+RZtQ+W8HVUY8rBjqkR2zTqS+YRNcuxrZWnMIoOkqu3JD+MWYTtKh
        wigIgp1ciUPc8v4Wt9a7mjvm62Au8BoK/G+sHfrZpFF2OsJ8j8cAK87jhdQYmHiC
        VylWgs/7E+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEAF255521;
        Tue, 13 Dec 2016 14:47:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1047855520;
        Tue, 13 Dec 2016 14:47:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
References: <20161213014055.14268-1-sbeller@google.com>
        <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
        <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
        <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
        <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com>
Date:   Tue, 13 Dec 2016 11:47:08 -0800
In-Reply-To: <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Dec 2016 11:38:57 -0800")
Message-ID: <xmqq60mn3937.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF8A411A-C16C-11E6-9C64-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The desired standard for submodules is to have the git dir inside the
> superprojects git dir (since  501770e, Aug 2011, Move git-dir for
> submodules), which is why I think an "embedded submodule git dir"
> is inside the superproject already.

Think how you start a new submodule.  What are the steps you take
before you say "git submodule add"?  And where does .git for the
submodule live at that point?

With the current system, you as the submodule originator need to do
something different to make your working tree of the superproject
match what the others who clone from your public repository.

And comparing the two layout, the one originally held by the
submodule originator has .git embedded in the working tree, no?

All of the above is coming from "submodule" centric mindset.  It
just is not centric to those who follow what others originated.
