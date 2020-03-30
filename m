Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D4C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938E320578
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RF7PsFTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgC3QbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:31:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgC3QbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:31:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21C8F43181;
        Mon, 30 Mar 2020 12:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G3Ezd/cv7JwxYcGEly9ik64Xq2o=; b=RF7PsF
        TQW/RjVKS7plc9I3fY0aNR5lJMP5ZaiOoGWZW31ZOiz6QQ25r+Q+c0KbIqOqFQjo
        ehLT6/Kv+UenWjWuv6g4QAsr0gyBAU02NSnYWjrxfUiEgMoqRU1NY6recf0x1yN0
        Wx/v/4ImfEn115P7mzREzwKvNILi0F4RnnoOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yeR4L43+GZnwV9S+1BYZ1e4M12Md7GhD
        Qpes9eKi7TIp3Xq29w+xkzOgdy3QVDQiLM4MkkHieSYI/UU/4dJoe9TDtkzkTgpb
        n1n58wgR9n4VwuThWF1OjIw8ZetCcYywjYR2Z3yCIeilN+oVJpFh18gZr8+GW798
        kuMwnKb/toM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBB1F43180;
        Mon, 30 Mar 2020 12:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 500C24317E;
        Mon, 30 Mar 2020 12:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why "Not currently on any branch" but no "HEAD detached"?
References: <alpine.LFD.2.21.2003301211330.14880@localhost.localdomain>
Date:   Mon, 30 Mar 2020 09:31:05 -0700
In-Reply-To: <alpine.LFD.2.21.2003301211330.14880@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 30 Mar 2020 12:16:50 -0400
        (EDT)")
Message-ID: <xmqq8sjhajp2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DABFBD6E-72A3-11EA-B014-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   probably a silly question (and probably related to using an old
> version of git), but on a ubuntu 16.04.6 dev system, i used google's
> "repo" tool to check out a bunch of git repos, and when i pop into
> those git repos and run "git status", i see:
>
>   # Not currently on any branch
>   nothing to commit, working tree clean
>
> i'm used to seeing "HEAD detached at <something>" ... is the above
> just an older style of the same message, given that this system uses
> git 2.9.2? or is there something else going on here?

b397ea48 (status: show more info than "currently not on any branch",
2013-03-13) is the culprit.  We used to just say the HEAD was
detached, but for the past 7 years or so, when we know the last
branch we were on before detaching, we report the name of the
branch.
