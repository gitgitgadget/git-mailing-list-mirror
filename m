Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89521F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 05:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfJ3FzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 01:55:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60873 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJ3FzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 01:55:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48374180EC;
        Wed, 30 Oct 2019 01:55:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VuMCZ8eoXQjhQKIMfTTp8lH5V/w=; b=oSAQhp
        E6+IrZkvuuKJZcuShp2fg58VJjK9pvRGrgkI1zEeMQQfaV9solU0jY86E6woJdEv
        sDMmAAegS3Yy5yQlsWYkCFkiQqHhQg1foGKdTHOCb9E4pr+VGI6iYaJxtTbXlTDC
        vVDJClFxBvMEv3OMwNNbv+3MYmKQekmNol2AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q0DeuKuzYDejj6h25xzBipH8Q59S23xc
        ljr5ZsUYeXyyhfMJcgWbIC2W/mLZgTHfUJXemQEiWvsDfITekee+kB6Klbo84hga
        NLLO4C5NBBXHtZ69C4jtezvwJXbImSzV3q9bTcoHP3CJWE6yLD2y7nXyOG8etY/h
        sSmUiZG99AE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEE10180EA;
        Wed, 30 Oct 2019 01:55:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1692E180E9;
        Wed, 30 Oct 2019 01:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Danh Doan <congdanhqx@gmail.com>
Subject: Re: [PATCH v3] submodule: teach set-url subcommand
References: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
        <f5f44812af2b43fe3f7ea837f8b07c4747eedcc0.1572368447.git.liu.denton@gmail.com>
Date:   Wed, 30 Oct 2019 14:54:58 +0900
In-Reply-To: <f5f44812af2b43fe3f7ea837f8b07c4747eedcc0.1572368447.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 29 Oct 2019 10:01:52 -0700")
Message-ID: <xmqqtv7q3hhp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF1BCFB2-FAD9-11E9-94C8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Currently, in the event that a submodule's upstream URL changes, users
> have to manually alter the URL in the .gitmodules file then run
> `git submodule sync`. Let's make that process easier.

Right now, submodule.<name>.url might be the only thing that gets
synched down to .git/config of the submodule; we may not learn any
more things that needs "edit in .gitmodules and then run sync".  Can
we sately say that "sync" is now obsolete and what it has been used
for can now be done with "set-url"?  In other words, does "set-url"
makes "sync" unnecessary and deprecated?

Or is it expected that we would learn more things end users can edit
in .gitmodules and run sync to propagate necessary pieces of
information down?  If so, do we want to add an extra command like
set-url for each of these new things, or do we tell users "if you
are editing url, use set-url, otherwise edit .gitmodules and run
sync"?  If the former, that would make the set of subcommands quite
noisy, and if the latter, the users need to learn two things,
i.e. it is not making it easier but harder to learn the system.

There is nothing _wrong_ to introduce the new subcommand per-se, but
given that the URL should not change that often, and due to above
concerns, I am not sure if I want to back this change.
