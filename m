Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9221C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8666760C3E
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhDTXbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:31:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52958 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhDTXbY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:31:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96E4CBA2F7;
        Tue, 20 Apr 2021 19:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3wwWTRINkls1Hd4Bh00ZgDiQ5Rw=; b=HhfvYf
        3dFOFNR5Teshpbz7YTbWGCz7+HM5p94fmghD2YIL94yzIF2ob5zD0W2uKLdS1JQa
        NsE+cyaFNhGnKwELHwcWkjb7hYd0t7oQPgxuKZqsB9D220X48RvXOQJ24RTwm/17
        8kYKnfSSv2GtrCQRVxI2MwxTNB7QOeacV3YrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f9uDqjLb8BcYzsGX9/zJaX5aSNjYVwIM
        BWC643T2Phkgpx5uEIVGVB3YQrcurUSVbQinIae95NLi0a417Ir6y9iPERa/mbye
        FVjYYEe4KxXxTEwtMg54/dFgYprRYYgwWqiRZeunpFWWegl6kNzNq5mWF6YjJcm2
        05zNppEGKio=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C9C2BA2F6;
        Tue, 20 Apr 2021 19:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18088BA2F5;
        Tue, 20 Apr 2021 19:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
        albertcui@google.com, matheus.bernardino@usp.br
Subject: Re: RFC/Discussion - Submodule UX Improvements
References: <YHofmWcIAidkvJiD@google.com>
        <0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com>
        <YH9drebF84mx2t5r@google.com>
Date:   Tue, 20 Apr 2021 16:30:50 -0700
In-Reply-To: <YH9drebF84mx2t5r@google.com> (Emily Shaffer's message of "Tue,
        20 Apr 2021 16:03:09 -0700")
Message-ID: <xmqq1rb4355h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 717EF3B6-A230-11EB-B019-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> This is actually a point we discussed internally and I cut out of the
> doc before sharing, because it is very far down our roadmap (not
> expecting to address until probably the second half of the year). As I
> understand it, this can also be achieved today by setting
> 'submodule.path/to/module.active = false' in the superproject's
> .git/config.

Yeah, I think we also added support to choose which submodules can
be "active" based on the attributes system.

Three are many ways to apply band-aid to a tree that should have
been a monolithic single repository but has been split into many
submodules only because we historically did not scale well.  As you
meantioned, sparse-checkout and lazy/partial cloning may change the
picture drastically, not just "sparse" may allow such an "a set of
artificially split out submodules" to be selectively populated, but
more directly clone and work with only the parts you are interested
in a monolithic repository.
