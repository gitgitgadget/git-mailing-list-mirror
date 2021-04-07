Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1501C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A709F61177
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbhDGTrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:47:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60794 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbhDGTrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:47:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 347C2C1F84;
        Wed,  7 Apr 2021 15:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x0t65qrreikkwvHOV0fVvOSexHY=; b=ujIwgz
        zkumM+Bn9D8Nw2Zi7X2/BB3MzqpQzqc4MrgtbxdC45Rmzm+eX/Veb2y2qwlkJ38b
        szAJtiOeZ3bRfWIxqZCSGnnmAwV95QsI94K2rBL+ZpB8S8ZAiGsFQmNanBfVVBYd
        PQzS4yoA7mKrfyGNFx9iK6t3oUKD+iZkgojwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ua4V+HPYIgCWHbMJbYAn7Fg/myncDhm5
        XBtUwLfEDkz9J/lXc6AhvmCN97uTEhZExuD1otZ3iKGGHs1G85WGrSV0vbRSp9kJ
        Nj0HaLq0WNnT31IfxHnhNesivEdLgIPXc/1zhWdWE97JTV25wvnU3Eq9ZBXNFJnP
        t7yvW3bzLpc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C37CC1F83;
        Wed,  7 Apr 2021 15:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEDF0C1F82;
        Wed,  7 Apr 2021 15:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Lodato <lodato@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
References: <20210407134646.2866522-1-lodato@google.com>
Date:   Wed, 07 Apr 2021 12:46:56 -0700
In-Reply-To: <20210407134646.2866522-1-lodato@google.com> (Mark Lodato's
        message of "Wed, 7 Apr 2021 09:46:46 -0400")
Message-ID: <xmqqv98xzxlb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0333D2F6-97DA-11EB-8E6C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Lodato <lodato@google.com> writes:

> The common thread is that systems need a way to uniquely identify a git
> repository or some object therein. I believe this means some combination
> of:
>
> - VCS type (git)
> - Transport location (e.g. https://github.com/git/git)
> - Ref (e.g. master)
> - Resolved commit ID (e.g. 48bf2fa8bad054d66bd79c6ba903c89c704201f7)
> - Path (e.g. contrib/diff-highlight)
> - (possibly) Clone depth

Nice.  So there is no reason to expect that these downstream systems
can sanely force various VCS systems that the notation they use for
"transport location" would identify what VCS type uses that
location.  All the other details (like refs, which may other VCS
many not even have) other than VCS type depend on the VCS used.

Thanks.
