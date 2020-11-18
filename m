Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06299C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8133224695
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 05:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qUKmqniB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgKRF50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:57:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55892 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKRF50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 00:57:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1004F10244A;
        Wed, 18 Nov 2020 00:57:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WTutmzwwINT0tNSXd8Px0aPpY1I=; b=qUKmqn
        iB9BCCtT1AGWtoJO0o9id6yQxdbhbeYjYHJnj/+VNQzUsctGJ8Lfa57F0xph7JLa
        ziJ63eXXqFhooBLf0OSrqk2Od6dxpRLBUGcODoqSXIG5sKWIIV82bYdvdMruzopM
        JsohNUrX3DJnEgh3EVzKXx31KvDXrQ93lmjU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=os8kLA6AuTxpt1b5g4NpeY5r3KfI16w8
        RX6cboeuZV6MXF44Tw8eKj/8V+VnytBW6FGStZvvJNNbVupHQwF1tFw2vD9Th2kn
        jxY71eCR8CmaSnBr/C5bc4+gRfU8TZ/Wr+NuXj8C1Fp3IKct0LXnaRVM6KmMEtfS
        EeHeF8G/Wc8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09097102449;
        Wed, 18 Nov 2020 00:57:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AA94102446;
        Wed, 18 Nov 2020 00:57:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <20201118025611.GF360414@google.com>
Date:   Tue, 17 Nov 2020 21:57:21 -0800
In-Reply-To: <20201118025611.GF360414@google.com> (Jonathan Nieder's message
        of "Tue, 17 Nov 2020 18:56:11 -0800")
Message-ID: <xmqqa6vf437i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED823C4E-2962-11EB-A009-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> That said, if I put myself in the shoes of such a script author for a
> moment, I'm likely to be irritated.  What started as a static string
> now becomes something dynamic.  If I put myself in the shoes of
> someone who has *inherited* a script (a testsuite, maybe), I'm likely
> to be even more irritated.

It is conceptually really nice to say that we do not use words like
'master' and 'main' that are 'meaningless' in the context of
thinking about the workflow used for the project and instead pick
the word the end user chose to call (some aspect of) the project
(i.e. the name of the directory to host its working tree).  It
however is much harder to defend the design in real life because it
can lead to the irritations you mention.

> Are there things we can do to make a script author's life easier?

It largely depends on what "specialness" of 'master' branch the
script is interested in, isn't it?

> Today if I want to look up a remote repository's default branch,
> the best I can do is
>
> 	git ls-remote --symref origin HEAD
>
> The output is not as easy to parse as I'd like:...

In a sense, these follower repositories are easier to work with.

You have refs/remotes/origin/HEAD that indicates what the owner of
the local repository considers of the most significance; it is
initialized to match what the remote had pointed with its HEAD when
the repository was cloned, but the local user can repoint it when
the local interest diverge from that of the remote's.  And you do
not need to talk over the network with ls-remote to find that
out (actually asking ls-remote may actively be wrong after the
local user repointed it); you only need to ask 'git symbolic-ref'
which is totally local.



