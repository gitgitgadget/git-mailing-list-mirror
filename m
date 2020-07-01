Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC2C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2262082F
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w+NaEeov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGAVDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:03:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53863 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGAVDm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:03:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E90926A206;
        Wed,  1 Jul 2020 17:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BHdsdPFagtB/921D5zcIJEc4cnA=; b=w+NaEe
        ovW6TyNQ4KqjRd5nOXb4cPdTzTJ3vtxu416u/gVMFQjjunexxSrqph4t0MI9ZTQU
        ACEHNUz7Iy1G46TGitsGhjp+3t/yreB3K0Zdta0vWkPNRmYC8kaCW+vH55skjhpz
        l68xJTFFYWC6pPXXCxzM5HcnlUG41V2EOPXk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VlqQA9uew6Sk3qFKlmDiHRBSOgK1F+2e
        jpXUaj/woZHqEtk1TS3/zUhB5CJVZlEH6ypv/uaAHZ17N1H0ahyjjz/D8aJoD35a
        7OuDiABYyUfzq8FvVpfR9vWRK1eIkvILuJv9tDBmpIn8OXefFehx3zjj8ihPmzNj
        Op2jIwSj23s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E12516A205;
        Wed,  1 Jul 2020 17:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B2476A204;
        Wed,  1 Jul 2020 17:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v4 2/2] difftool -d: ensure that intent-to-add files are handled correctly
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <9bb8d84ea956dcddefbe7b62baa3a5ff23b6b1e2.1593107621.git.gitgitgadget@gmail.com>
        <xmqqimff3tib.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2007011153040.56@tvgsbejvaqbjf.bet>
Date:   Wed, 01 Jul 2020 14:03:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007011153040.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 1 Jul 2020 12:01:42 +0200 (CEST)")
Message-ID: <xmqqa70jc5hx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 566153DC-BBDE-11EA-9D56-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Can we fill the gap by saying how seeing the object name of empty
>> blob (or worse, tree) instead of 0{40} made "difftool -d" upset?
>
> Sorry about catching this only now, after the commit hit `next`.
>
> Filling the gap is a slightly more complicated.
>
> And now that I looked at the code again, to make sure that I don't say
> anything stupid, I realize that I just provided incorrect information in
> my reply elsewhere in this thread: Srinidhi's fix is _not_ enough to fix
> t7800 with this here patch.
>
> Your guess was almost spot on: the empty blob would have worked (as in:
> not caused an error, but it would have shown incorrect information). The
> problem really is the attempt trying to read the empty tree as if it was a
> blob. That results in something like this:
>
> 	error: unable to read sha1 file of /tmp/git-difftool.O8CoK9/right/intent-to-add (4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> 	error: could not write 'intent-to-add'
>
> And yes, it would have been good to adjust the commit message as you
> suggested. Sorry for not getting to it in time before it hit `next`.
>
> Do you want me to send out a v5 and drop v4 from `next` in favor of the
> new iteration?

That would help the future "us" quite a lot.  Thanks for carefully
thinking it through.
