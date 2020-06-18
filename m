Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E75C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0D207E8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hmgUaINe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgFRSc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:32:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52944 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgFRSc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 14:32:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8A2DD9390;
        Thu, 18 Jun 2020 14:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oo3Bf5HPc7yOUvnuTAU7Ou3lFFI=; b=hmgUaI
        Ne2/6K85FjPYLSi4BpCatF5UR5G8T5Fdqa6o0QaORQUJhqtjYdl5UgJdH1fihs99
        iqqAjDoA/B4lG7kdu7G4XDjUhBGAab5ES2IG5yXIpGo0T/EuKfpe52tIvL6fqzx+
        /22G+4lLdPPwx3psILRXeL5a5gvt8hRRcUQNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VFED9HWENzBzevgsQyuh6mD3DSmg0ufy
        q7uP9QtOHQR10M9e2X6WOrHnJQE/OwBIP+IYyOReLheZ/24M5wBg+yYrucnaWJi3
        g9jdg4aGMJ/t34w5zHlgrQv9FdhOzisDj/sSIIZfg5eCqWqxWHLrG2FF0kT6uOiN
        /JKexsGGO6k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0F13D938F;
        Thu, 18 Jun 2020 14:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2D71D938D;
        Thu, 18 Jun 2020 14:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Riddell\, Matthew A" <mriddell@paychex.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git config command ignores explicitly set file permissions
References: <MN2PR02MB66232254F5F4BE27F21C441CD89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
Date:   Thu, 18 Jun 2020 11:32:21 -0700
In-Reply-To: <MN2PR02MB66232254F5F4BE27F21C441CD89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
        (Matthew A. Riddell's message of "Thu, 18 Jun 2020 13:13:57 +0000")
Message-ID: <xmqqsgesns22.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D94DBF2-B192-11EA-8C57-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Riddell, Matthew A" <mriddell@paychex.com> writes:

> I noticed while working with Git that the file permissions on the
> gitconfig file is ignored and the parent folder permissions are
> used instead to update the file.  An example is as follows:
>
> Before running git config ensure the user running the command is
> not able to edit the file but has read access to the file. Ensure
> the User has full access to the parent folder.  After running any
> git config command the user previously without edit permissions on
> a file can now edit the config file.

That is pretty much how things are intended to work on a filesystem
and is not limited to Git.  Your arrangement, contrary to what you
said, does not "ensure the user running the command is not able to
edit but has read access".

    mkdir newdir
    chmod +rwx newdir
    >newdir/file
    chmod a-w newdir/file

would not forbid you from doing

    rm -f newdir/file
    ehco new >newdir/file

In other words, if you allow your user to write to a directory, you
cannot forbid the user from creating and removing files in it.
