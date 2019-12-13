Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E6C79DD8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BC92474A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LHJirQ7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfLMRQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:16:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51542 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfLMRQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:16:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 278353FFA7;
        Fri, 13 Dec 2019 12:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwABNuXQq3fLsPeVzfk8NeD30uk=; b=LHJirQ
        7Vo7jJs7drC3F1cfswXkSloHJe8EhOApHWsw4hZ0JSx59SfGl5CZ9A75SLFOpBCo
        TrawLKHDT3luvXJxQ+rBozQ7fd8u3D4v9a1rLGzo9/IHqi9Dnhj1vOC1HEQ+XlNS
        W5FfVTI70iwklYSmc287b/bgRsjKMYO+SGO1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LjRwymFlb+B4DTGjB2LUNYNRLyiDMWuz
        87bQVWnzjIokM+UrRfs91+c+DsamtoOaNM4nmprZGA4+IIoR3CfX5iYQ+slGmzI4
        hPmoG8wr8f9CEpVWftuJ3m/z1XK5+veKVH479WqqdcUjHiK/t6cnYW+n4y8zJ19z
        nk2mFM1pJBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E7483FFA6;
        Fri, 13 Dec 2019 12:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81F753FFA5;
        Fri, 13 Dec 2019 12:16:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Denton Liu <liu.denton@gmail.com>, rottis@fea.st,
        git@vger.kernel.org
Subject: Re: git checkout --autostash and git branch --autopop
References: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
        <20191212180901.GA35927@generichostname>
        <e7850a51-4396-4698-ed98-62f991e33992@iee.email>
Date:   Fri, 13 Dec 2019 09:16:19 -0800
In-Reply-To: <e7850a51-4396-4698-ed98-62f991e33992@iee.email> (Philip Oakley's
        message of "Thu, 12 Dec 2019 22:02:14 +0000")
Message-ID: <xmqq7e30m9i4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47ED10F8-1DCC-11EA-B3CF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Isn't this meant to be something similar to the --no-merge option for
> checkout. That is: I am where I am, but really I want this to be on
> branch X. Or is the --no-merge option meant to be something else?

Is there a --no-merge option to "git checkout"?  I know the reason
why I invented "git checkout --merge" was because I wanted the
command to carry more changes in the working tree than the default
behaviour would while checking out another branch, but I do not
think I added an option to do less, i.e. forbid it from carrying any
change in the working tree while checking out another branch.

