Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621832095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757351AbdCUWl5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:41:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62742 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756464AbdCUWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:41:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ACEC6B18E;
        Tue, 21 Mar 2017 18:41:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HaigPEaHE4Q5GLlP9TSVeVYZbIc=; b=dSdjLw
        fEDQ42m0fT62XSqVrFoZxIB3g3EyoHn2qF6hboiYNxSz8T/EPqDVc6VxskcY/mie
        L0swZXrsGi0HR3oTYNSpOez1VTJRw91l36fYbFqOzBdjnfPyV9m0f/V2Ta322LrG
        M0fK3+p4pwGHlczlSGMlx7cA88e2sx7bO/x0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EyMKAhx6ifQeA4jb14T5wFGXAxQhQ14S
        P6W+CP0Ulk8lTc2hq5FEcZHB1esEVvSsTwT5+QGl8NW/leXrSyp11dSWltSkd1wK
        t2dgl2cC8M6VlIDEMRPV/O/w4RR1FjaWi2CiSkpdbKEPF8e1crO6npqVq4oLiR06
        9LG6EUn3e1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 741086B18D;
        Tue, 21 Mar 2017 18:41:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E12CB6B18C;
        Tue, 21 Mar 2017 18:41:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] builtin/describe: introduce --broken flag
References: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com>
        <20170321185139.8300-1-sbeller@google.com>
        <xmqq7f3invr6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbjsm1p+Ag5Q8fii3ncbxSsVLYRwGP=Va=btx8Tfy3aOA@mail.gmail.com>
Date:   Tue, 21 Mar 2017 15:41:53 -0700
In-Reply-To: <CAGZ79kbjsm1p+Ag5Q8fii3ncbxSsVLYRwGP=Va=btx8Tfy3aOA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 21 Mar 2017 15:27:56 -0700")
Message-ID: <xmqqvar2mevi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 957BD50E-0E87-11E7-8A48-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> AFAICT, someone is (was?) using a version of Git that doesn't contain
> f8eaa0ba98 (submodule--helper, module_clone: always operate
> on absolute paths, 2016-03-31). So then the submodule paths were
> made absolute paths on creation of the Gerrit repo.
>
> And then someone moved the repo and the absolute paths broke.
>
> Even after an upgrade of Git to its latest and greatest version, the underlying
> issue of having broken submodule paths remains in that case.
>
> So there are a couple of ways forward
> 0) as an immediate fix, manually fix the absolute path or make them relative
>
> 1A) have more error resilient tools in Git
> 1B) have a tool in git (e.g. "git submodule fsck-setup") that rewrites
>     the .git file link and the core.worktree setting to be relative and correct.
>
> I think we should do both A and B, I decided to go with A first, specifically
> "git-describe" as that was reported to not work well in this situation with the
> given broken data

Sounds sensible.  I would say that we should do less 1A (i.e. hiding
problems under the rug) and more 1B.  Of course, making the problem
less likely to happen in the first place would be more important ;-)

Thanks.
