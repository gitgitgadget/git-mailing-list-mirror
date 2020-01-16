Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A7C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039A420748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ud92hya1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbgAPXZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:25:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57407 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgAPXZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 18:25:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27A8045B08;
        Thu, 16 Jan 2020 18:25:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJRxyjnLRczKsTpgmzukdBc99pQ=; b=Ud92hy
        a1JE5UsUTXP1x68Sd66G8k84du0GpwGzmmPVVqFD0yK4ETQBeAsI5siw06yYi9Ji
        drPCwJOv/n/Bdi39X8LZ5H4qW/Ps0/xCxmvPNSDnFEV2buZ1pREyPUgpUlDMRH8G
        hdx5RjGP0w87s44dJmE7dtbuMQQ68UwzxFeYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S4JyrpG1irhcgIhDiy1xo8juT1jXaDgD
        eRwpjRwvKIsfjYnY3hpk5fjDF/MFmZSAd65Dkoy87MF7SExCX56BAlS6MBxAPEyJ
        ddQ507NB/4Xt5WRGMs41ZEMC683C+OW+Ij/g694FrVQLX09pSQgR3VAdLwVMmnjn
        AA99HKlGSG0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D69B45B07;
        Thu, 16 Jan 2020 18:25:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8042545B06;
        Thu, 16 Jan 2020 18:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
        <20200110231436.GA24315@google.com>
        <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
        <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
        <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
        <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
        <20200116075810.GB242359@google.com>
        <20200116080624.GA253496@google.com>
        <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
        <20200116203521.GA71299@google.com>
        <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
Date:   Thu, 16 Jan 2020 15:25:52 -0800
In-Reply-To: <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 16 Jan 2020 13:30:38 -0800")
Message-ID: <xmqqzhendlvj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A1B3BC0-38B7-11EA-8C01-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Why?  "Commands which create no more than one commit (git-commit,
> git-merge, maybe single-commit git-revert or git-cherry-pick) call
> post-commit, commands which create several commits derived from others
> (git-am, git-rebase, git-cherry-pick, sometimes git-revert ) call
> post-rewrite instead for performance reasons"

Sounds totally wrong.  post-rewrite is about carrying forward data
that used to be associated with commit X to new commit Y when Y was
created by "rewriting" X (i.e. after Y gets created X no longer has
any purpose other than as a historical curiosity).  There is nothing
"for performance reasons" here.  There should be nothing for "git
revert" to do with post-rewrite (because the resulting commit is not
even a rewrite of the commit that was reverted), and "git
cherry-pick" is not even a rewrite operation (it is to duplicate an
existing commit into another unrelated context, without discarding
the original commit).

I am a bit confused...
