Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5BCC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E5C61944
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhCSPgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:36:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57248 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCSPg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 11:36:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BDEBBA09A;
        Fri, 19 Mar 2021 11:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1d0PlOmy0tw82OqXDNanJ+hKrZY=; b=yBYZtX
        FY7JPkIzXSaVHeBPedCvsrhXJ7QOLvqOHATgkCaCDBKGYsoB+D6BqohzQ/sHTwed
        de9nsSQeiO7akZQnh63J1FVRiQjd3mLk5TrePYXC4lvzj95rmTLvcAfqcRlvF3iu
        tERQu3aA75avNZn129tZ64vGbC4wznRUtFkZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g1hGoWIQ9Y0s7UYd81z815IWx46kTwKK
        ghhzcSwbQ57WikwjW5mvOhDRSRyiztAyi+kGMlDb4qZ+xdJDZwmPBhUq5FkD693G
        bEoSCPrcjZqHrbBUvspr5ne9xJm6kAQI3XKAHJNxhn7lQsxjP4uNY1WxiuLPDpTZ
        MxPByQ8PvK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6325CBA099;
        Fri, 19 Mar 2021 11:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCF72BA098;
        Fri, 19 Mar 2021 11:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
        <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
        <xmqq1rcctgj7.fsf@gitster.g>
        <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
Date:   Fri, 19 Mar 2021 08:36:27 -0700
In-Reply-To: <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 19 Mar 2021 17:33:23 +0800")
Message-ID: <xmqq7dm3p344.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEE3BE4A-88C8-11EB-81EB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> If `--own-identity` is mouthful, is there a better name?

I originally had "perhaps XXXX?" in the message you are responding
to, but I hoped that the message, especially the examples at the
end, would be sufficient to make you realize that the option itself
is not such a great idea (an additional ":@gitster" in whatever
syntax used would be even shorter than "--own-identity", and
obviously more flexible in that it can name other people).

If you really want to have this option, perhaps call it "--self"?  I
still do not think it is a good idea, though.
