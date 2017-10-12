Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8ABB20469
	for <e@80x24.org>; Thu, 12 Oct 2017 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbdJLA0c (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 20:26:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752156AbdJLA0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 20:26:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1C8697120;
        Wed, 11 Oct 2017 20:26:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I9ltEfa9RjQ3gHwUO9a92wUIxhA=; b=goSDaW
        HWd+3PLxh2BkmdZ+AsyqqP37tE3eQb1vddTascWe7Oc0jYxDeeNd4Y1V6PZdGBFw
        FI3M+pcBUDm79qqB5mEPGhDRrQoCfZu9hhyuACW7kgImGFNvQ+bdxCzbcHP71W0j
        zCrBIarLSBghIN2q9wwJ8FcB4L5gMhIf6BVxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fQVRPVNPhEXy9q3UzOnYq7NAOG4qtTsf
        0v68fJQ2MMKd/BK/FF/rykckIx/sxsGX8URrlrp2aLzBVUBR1JQszezqDQNPOFBC
        9oB5z1RCjNeXdLzbpT8E1H1fM/sR6lOxVN5y927zlLOTdizo6w5N7gFLC8N4LmPp
        5eGHDih+THI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6B2A9711F;
        Wed, 11 Oct 2017 20:26:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19CFB9711E;
        Wed, 11 Oct 2017 20:26:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper repository setup
References: <20171006222544.GA26642@sandbox> <20171006223234.GC26642@sandbox>
        <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
        <20171010130335.GB75189@book.hvoigt.net>
        <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
        <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
        <20171011145657.GB85076@book.hvoigt.net>
Date:   Thu, 12 Oct 2017 09:26:27 +0900
In-Reply-To: <20171011145657.GB85076@book.hvoigt.net> (Heiko Voigt's message
        of "Wed, 11 Oct 2017 16:56:57 +0200")
Message-ID: <xmqq7ew143f0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD7EFC60-AEE3-11E7-BB49-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This "default" value thing got me thinking in a different direction. We
> could use a scheme like that to get names (and values) for submodules
> that are missing from the .gitmodules file. If we decide that we need to
> handle them.

Yes, I suspect that would improve things quite a bit in a repository
where it added a new submodule by filling the gap between the time
when a gitlink is added and an entry in .gitmodules is added.  The
latter needs to happen if the result of the work done in that
repository is pushed out elsewhere---otherwise it won't usable by
other people.
