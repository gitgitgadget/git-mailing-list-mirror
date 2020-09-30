Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDEC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D8720759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcBHwLVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgI3U6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:58:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52430 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3U6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:58:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D5B21014C9;
        Wed, 30 Sep 2020 16:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zMYrtqzbBcT4SRO2I7uIdB8rttY=; b=NcBHwL
        VCB3vT6Bsn89o1k5t6+PiZk/bFZZjXsTS8MipRb5llYkSEnSDq5E8gIed/JjSQUS
        Ufwe/Gv+rsRCvL1UzikA5iHjU+aBnZHkS9qKXroibr4WndHbkHrFzXUar8KEQI0U
        tTWrl8T4/3RzbiR6ozmjpYISSrfoYnygRCFfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wUJigfdhNDk64eI2JjF7OQhqXw+O7e0C
        p2Y+MhG+DlahncP3ZWReKyeiRkW4Prh/cLognux5aDmI6m8ce/OccFcgKIiL1VST
        PQQVT/i1eANH8c7KlVtWJlKZ4a7KAvz+m2T+ZQf6XWvA5a6eiGz1PZaZ+TJwMExs
        KcZjHBFxOZk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57C361014C8;
        Wed, 30 Sep 2020 16:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2DD41014C7;
        Wed, 30 Sep 2020 16:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Dubois <tbodt@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Propagate --quiet on submodule update to merge/rebase
References: <20200930195052.118199-1-tbodt@google.com>
Date:   Wed, 30 Sep 2020 13:58:02 -0700
In-Reply-To: <20200930195052.118199-1-tbodt@google.com> (Theodore Dubois's
        message of "Wed, 30 Sep 2020 12:50:53 -0700")
Message-ID: <xmqqzh57f0dh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A26DBDBA-035F-11EB-9F45-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Dubois <tbodt@google.com> writes:

> Without this, commands such as
> git pull --rebase --recurse-submodules --quiet
> might produce non-quiet output from the merge or rebase.
>
> Also fix the parsing of git submodule update -v. Setting GIT_QUIET to 0
> has the same effect as setting GIT_QUIET to 1, because
> ${GIT_QUIET:+--quiet} only checks whether GIT_QUIET is set or unset.

Thanks.

Will queue with the following log message.

    submodule update: silence underlying merge/rebase "--quiet" is given
    
    Commands such as
    
        $ git pull --rebase --recurse-submodules --quiet
    
    produce non-quiet output from the merge or rebase.  Pass the --quiet
    option down when invoking "rebase" and "merge".
    
    Also fix the parsing of git submodule update -v.
    
    When e84c3cf3 (git-submodule.sh: accept verbose flag in cmd_update
    to be non-quiet, 2018-08-14) taught "git submodule update" to take
    "--quiet", it apparently did not know how ${GIT_QUIET:+--quiet}
    works, and reviewers seem to have missed that setting the variable
    to "0" (instead of "1" which is used when "--quiet" is given) has
    the same effect to pass "--quiet" to underlying commands.
    
    Signed-off-by: Theodore Dubois <tbodt@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

