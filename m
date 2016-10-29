Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486762021E
	for <e@80x24.org>; Sat, 29 Oct 2016 01:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965024AbcJ2B0z (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 21:26:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S937351AbcJ2B0x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 21:26:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A488A4BED7;
        Fri, 28 Oct 2016 21:26:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rsTzD++qYngJ/jGDfWVLB3U78lM=; b=pFshew
        FSdwIZ1/gzZGitHf0z430vL2trMS+lWfWuwwgtiTah/Z3aLwDa1Gnb+sZ+32KVbv
        d+ZWd17bDMZBgQ1uWQXBSAUuNRKEYXe8XJ3Latlgcr9HwQSomw8uYTeKPzJaPT+4
        YVJlq4ppNKr4+WkH7nr1+1fFROkX28qtqEwrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=srcJo6bcXF/7F7ed85v7959C/wSLSFVl
        us7mTdeqPWSu6hBtecMihR5eI6GOPUbpI76EbmAYiQSPaist+HW0NemaQZ5CPSV5
        ZWrXv2mcNRN+FNFLDGTwX30KL4yGi12Q/bgvnPQeZ9eAtRo7CDfRaJR8EmtTMuQz
        wLZa0ZOgsew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CDFE4BED6;
        Fri, 28 Oct 2016 21:26:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 196244BED5;
        Fri, 28 Oct 2016 21:26:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
        <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
        <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
        <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
        <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
        <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
        <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610281306320.3264@virtualbox>
        <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
        <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
Date:   Fri, 28 Oct 2016 18:26:49 -0700
In-Reply-To: <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 28 Oct 2016 10:38:03 -0700")
Message-ID: <xmqqr370vtba.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C49571F6-9D76-11E6-93FB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Apparently windows doesn't even support it, at least not mingw....

Assuming that the above was a misunderstanding, assuming that we can
do O_CLOEXEC (but not FD_CLOEXEC) on Windows just fine, where stray
file descriptors held open in the children matter more, and ...

> In contrast, O_NOATIME isn't a maintenance problem, since it's purely
> an optimization and has no semantic difference, so it not existing on
> some platform is immaterial.

... assuming that I didn't screw up my use of fcntl() to set
O_NOATIME on a fd opened with O_CLOEXEC, are you OK with the
approach in patch *1*?  We can drop *2* to keep O_NOATIME, which has
been working for those with old kernels with many loose objects, and
it is not too much code to keep.

*1* http://public-inbox.org/git/xmqqh97w38gj.fsf@gitster.mtv.corp.google.com
*2* http://public-inbox.org/git/xmqqd1ik38f4.fsf@gitster.mtv.corp.google.com
