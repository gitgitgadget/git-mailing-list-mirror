Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F2B207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 17:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbcJLRUY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 13:20:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932277AbcJLRUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 13:20:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 473C045934;
        Wed, 12 Oct 2016 13:18:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=96hqJVjSIjhkvyURCOJVCT3bC4U=; b=usMqnp
        XVl7Y98hsJqWOb3yOLg9d4Nq0f5ueJBo6TKIKpQonodj1z2xVySCaoccV549BXut
        D9nfKsmaGWigF59cwP1FRdFtbR2QUwbp4KNnYfbSQC1et/q3mJfrFUq0heSDcoZf
        olEsqs70HkwckVCtqMWp2moMCRjn6M93LXyJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HOCdFc2ksbWOFVMCsINlAX/JMsL0GOg+
        Gm6yo3OeQeFSpW3dAPAVqsHVV0+9MIkd1OLyLt6bqafmcl6JUZbh2alIQ001gJRM
        VcXeMQvD7Fi2QwYrtPqAg8Vt76WGyZFKWEUFmgUGyBdkNHsOUb6LEtIK6jtF2EFa
        KZZOcO2q5Ts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E2F045933;
        Wed, 12 Oct 2016 13:18:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A19D045932;
        Wed, 12 Oct 2016 13:18:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 1/3] serialize collection of changed submodules
References: <cover.1475851621.git.hvoigt@hvoigt.net>
        <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
        <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
        <xmqqvawzbzb2.fsf@gitster.mtv.corp.google.com>
        <20161012130034.GA84247@book.hvoigt.net>
Date:   Wed, 12 Oct 2016 10:18:28 -0700
In-Reply-To: <20161012130034.GA84247@book.hvoigt.net> (Heiko Voigt's message
        of "Wed, 12 Oct 2016 15:00:34 +0200")
Message-ID: <xmqq1szl5vvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E595F5B2-909F-11E6-94B1-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Which seems quite extensively long for a static function so how about
> we shorten it a bit and add a comment:
>
> 	/* lookup or create commit object list for submodule */
> 	get_commit_objects_for_submodule_path(...

Or you can even lose "get_" and "path", I guess.  You are not even
"getting" commits but the array that holds them, so the caller can
use it to "get" one of them or it can even use it to "put" a new
one, no?  "get-commit-objects" is a misnomer in that sense.  Either
one of

    get_submodule_commits_array()
    submodule_commits()

perhaps?  I dunno.
