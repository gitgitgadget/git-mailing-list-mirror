Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D812AC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 15:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiJYPxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJYPxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 11:53:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6617999B
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 08:53:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C309148025;
        Tue, 25 Oct 2022 11:53:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=acmVsQdQ6TfdS1WS31Cf4ZE/9vBZ0uPHBKqx9g
        VYRRY=; b=ZyoZyA/hCNjhW+/2yx6kBNFYEWcKrkOMQ/mfqGaIZA9PpBArfC2Jjk
        MgC9VfmPqcD0NJTXSNaBN7R3JUB2ASmtzKFGorpZLexiKdn6RKhSxsgZuaLWDvF4
        lFC1Xek6XBLHveA/oZn/p22DaBnSwShGVqT/WtIBS2hR2MoU/rOK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 433C6148024;
        Tue, 25 Oct 2022 11:53:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BBDB148021;
        Tue, 25 Oct 2022 11:53:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
        GitList <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/3] glossary: add reachability bitmap description
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <20221022222539.2333-1-philipoakley@iee.email>
        <20221022222539.2333-4-philipoakley@iee.email>
        <CAPOJW5zmYC9q8+aXh9-kZnvT28GQ1ud3LenFi9qxV4DVdCWKxg@mail.gmail.com>
        <xmqq1qqxuqf0.fsf@gitster.g>
        <746491f4-fb41-92fe-7360-20a845dc21fc@iee.email>
        <c9e90df3-6f70-6422-00db-beb7afda0439@github.com>
Date:   Tue, 25 Oct 2022 08:53:13 -0700
In-Reply-To: <c9e90df3-6f70-6422-00db-beb7afda0439@github.com> (Derrick
        Stolee's message of "Tue, 25 Oct 2022 08:34:52 -0400")
Message-ID: <xmqqpmefoq6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 229086BA-547D-11ED-8DD4-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The one thing I will say is that there can be multiple .bitmap
> files, but Git will only use one of them. Not sure if that is
> worth being pedantic about here, though.

That matches my understanding, but "can be" is less of the norm
these days, no?  "repack -b" would refuse without "-a" so we may
have more than one by accident, or am I missing a common scenario
that we do perfectly normal things and still end up with multiple?

I agree with you that it probably is a good idea to say there can
be, so that the readers do not have to alarmed.

      Only one '.bitmap' file (which stores multiple reachability
      bitmaps) per repository is used in a repository (note. it is
      not wrong to have more than one).  The bitmap file may belong
      to either one pack, or the repository's multi-pack index (if
      it exists).

But then the readers who do have more than one would next think "how
do I get rid of the ones that are not used? they are wasting my
precious disk space".  So I also am not sure if it helps to write
more.  "It is generally true that.." white lie may be better than
technical correctness in this case.

> We'll need to keep this glossary section in mind in case things
> change (such as "at most one bitmap file").

True.

Thanks.
