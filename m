Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FEFC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 21:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5243222314
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U8KwoNvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgBNViM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:38:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56478 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbgBNViM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 16:38:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D86BF3E499;
        Fri, 14 Feb 2020 16:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OdVqRHZfD83D6x0GEOYfe8JYqRk=; b=U8KwoN
        vDBrItbSPSKkJi+oLe4n24X74B6M1wFT6yusSVjxaMD7DMir8H+5FYuNb1Gubuo4
        wx4MTywNxDry8TB5ENFgivjgpKA/C2MJVYF94hnkhqmFrnmWPu/R05r9lOWgPmlL
        0Po8f3qOQJR/CA8CBFfg1lU8MHgM7dLvX8FcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlBhO3LCSpL7/Or0Q4lh5IL+l+zxhsTd
        oQf5sEB4sC8JBwvdE59BfPN4Fedz3aZWJpggeQPt+q26XAvVSeINIRNubn+NscHn
        Li8iH7YE/aK04wkP7vu4RdbQvEkWRNDhfcCyefUVOkvs+MIEY30vXOkxCfEZWVPq
        dbzqp4if/E4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0E763E497;
        Fri, 14 Feb 2020 16:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E94E3E496;
        Fri, 14 Feb 2020 16:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bruno Macabeus <bruno.macabeus@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Suggestion: Allow to enforce "rename" in git while committing
References: <CANnkH-ViK9qySZGi=xbcE4YDiskhLxDsH21DMxTEHi6=X0EZuQ@mail.gmail.com>
Date:   Fri, 14 Feb 2020 13:38:08 -0800
In-Reply-To: <CANnkH-ViK9qySZGi=xbcE4YDiskhLxDsH21DMxTEHi6=X0EZuQ@mail.gmail.com>
        (Bruno Macabeus's message of "Fri, 14 Feb 2020 21:23:18 +0000")
Message-ID: <xmqqa75konnj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B1428FC-4F72-11EA-AA32-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Macabeus <bruno.macabeus@gmail.com> writes:

> I should not create one commit just renaming the file and on another
> commit updating its content, because the project won't build on the
> first commit (since the build steps is different on a .ts file). And I
> don't want to create a commit that the project can't be built on.

Even if you did the two-step renaming, comparing the end result
(i.e. HEAD) with the state before these two commits (i.e. HEAD~2,
before renaming and before editing) with "git diff HEAD~2 HEAD" will
not behave any differently if you did the renaming and modifying in
a single commit.  So it does not make much sense to split it into
two artificial steps at all.


