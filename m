Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72FC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615622075E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZTra1mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYTks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:40:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63374 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYTkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:40:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0792980C31;
        Tue, 25 Aug 2020 15:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0y3MmtNUMbrvx7T86/6h2ZiRi7A=; b=JZTra1
        mzoNfpUY103yPiGMJOsdcDX+1DstVzY1ry4OwS0mVJ+guaUEogmwN74MsKL5oDns
        7S4ADNlUC1tF9p3HGoil4VEPHFMVgXsTnhxB4wdPGMrasgc4bWpoSBiVgfA8bo1Q
        ELfnEYbB8jVP4TLaDUk1uZ3AT3oS8rorIEYlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RfKyKF74Iy/KeT9y//yNH8Kioz3ugSdf
        o41l2TRfTPjpqt2SOOLJT8o0OBKKT+1+hjBjmMxpjw0bEgLy6ElDJL1gPkPAQisP
        PZTOT6VXGzlDZzaicF2/nxKDEd//3fN+vAIvbPEAe/zWMV6fDCC/6P/5Fsu7VY/U
        cuYh8EiGdPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F240D80C2F;
        Tue, 25 Aug 2020 15:40:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FC7080C2D;
        Tue, 25 Aug 2020 15:40:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Mismatched HEAD default behavior from git log
References: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
Date:   Tue, 25 Aug 2020 12:40:42 -0700
In-Reply-To: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
        (Bryan Turner's message of "Tue, 25 Aug 2020 12:16:38 -0700")
Message-ID: <xmqq8se21pl1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD2F35A8-E70A-11EA-ACC9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> It appears the way --stdin processes input discards nonexistent
> commits before the machinery that decides whether you provided any
> revs or not runs, and so if every --stdin rev is discarded then you
> get the default HEAD. If you provide them via the command line,
> though, then it seems like they're discarded later and you don't get a
> default.
>
> I'm not sure whether this is intentional or not (certainly I don't see
> it anywhere in the git log documentation for --ignore-missing or
> --stdin), but it results in a behavior mismatch that's impossible to
> reconcile without requiring extra git processes. I can't always
> provide HEAD since, if multiple revs are supplied, if any revs exist
> then HEAD would not be included regardless of whether the revs were
> supplied via the command line or --stdin.

As the intent for adding the "--stdin" option to any subcommand has
always been "we may need to feed many many things, that may bust the
command line length limit, hence we let you feed these things from
the standard input, but otherwise there should be no change in
behaviour or semantics", when the behaviour of command line and
"--stdin" differ, it is a bug in the latter.
