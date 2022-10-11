Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E69AC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 05:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJKFua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 01:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJKFu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 01:50:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7C4DB01
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 22:50:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE1641C2608;
        Tue, 11 Oct 2022 01:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y2BS61QzYEE2rIT0aVC1G/s1BVRWiVUyJA9nz3
        P0dPE=; b=HTXSftqq6Oye1cN5DlqzJ8yKLC332hhOlJEQaQxuHcsdRSaINahrl8
        NaIpwVAKAZfH8KszqLRf+VVUR9UWSUfCd64o9AzlYIoDcJIGrY0XT6DW5e8E8Ltg
        W0hSrjzKh5nY31wvF/6jYBSOidK+htJoHHeDqsXDcCa+V0kwi3gi0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1F5E1C2607;
        Tue, 11 Oct 2022 01:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16EBC1C2606;
        Tue, 11 Oct 2022 01:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elsie Hupp <git@elsiehupp.com>
Cc:     git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
Date:   Mon, 10 Oct 2022 22:50:22 -0700
In-Reply-To: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com> (Elsie
        Hupp's message of "Mon, 10 Oct 2022 23:06:32 -0400")
Message-ID: <xmqqwn96x61t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 997EE240-4928-11ED-A879-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elsie Hupp <git@elsiehupp.com> writes:

> I structure my cloned repositories based on the remote host, e.g.:
>
> ~/Repositories/github/cloned-repository-name
> ~/Repositories/gitlab/other-cloned-repository-name

The above is by definition not "global" (aka "per user").

"--global" is for things that are of your personal preference, not
"when I am working on this project, these settings apply" (which is
suitable for "per repository").

What you want is a way to say "when I am working on these projects,
these settings apply".

One way to do this would be to have

	[includeIf "gitdir:~/Repositories/github/"] path = $HOME/.githubconfig
	[includeIf "gitdir:~/Repositories/gitlab/"] path = $HOME/.gitlabconfig

in $HOME/.gitconfig and then write in these two extra files that are
conditionally included whatever settings you want to use for any and
all repositories that come from GitHub or GitLab.

$ git help config

and look for Conditional includes, perhaps?


