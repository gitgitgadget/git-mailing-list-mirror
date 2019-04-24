Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDC31F453
	for <e@80x24.org>; Wed, 24 Apr 2019 02:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfDXClt (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 22:41:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56335 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfDXCls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 22:41:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4E6A6159C;
        Tue, 23 Apr 2019 22:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PO4HgVPPs+drW78BFLCdEZQ0kwc=; b=RKW4f+
        ZIUXLgcvet5MeEaRXPEzUeOOAZk3vrcaUMt7v2RONNHAtARf/dZ3eiVYNBpY7oGS
        1XV29z5vKDMA0gtY8M6cfOh1SDR0tdVd29p7dIPL2VpsMElyrjpv+vJvbpP8ALfU
        maggjgKUAMe2cQeeviXqo+hCpoohEfVE+vGa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=no/FtY+6wjauRlv0Y4p8AA0wyM2NtGTp
        x/2lge0GcikZzFfXg7E6naMQROJKKPeYO6gNCA+00itVCCAhEzAHUN7mCqjso8MH
        VYEUpEU27wr+3KqOC2fO1sSAtkBql92vWReop0hdDIMwhm9FCT9adyRcWI3pFOvf
        6HMX4t0ryh8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C75256159B;
        Tue, 23 Apr 2019 22:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F315B6159A;
        Tue, 23 Apr 2019 22:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
        <xmqqtveo2lyx.fsf@gitster-ct.c.googlers.com>
        <20190424022240.GH6316@genre.crustytoothpaste.net>
Date:   Wed, 24 Apr 2019 11:41:41 +0900
In-Reply-To: <20190424022240.GH6316@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 24 Apr 2019 02:22:41 +0000")
Message-ID: <xmqqk1fk2kgq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F398D1A-663A-11E9-81C5-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Apr 24, 2019 at 11:09:10AM +0900, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > To preserve backwards compatibility, we don't run the hooks in the ".d"
>> > directory if the single file is a valid hook (i.e. it exists and is
>> > executable). This is because some people already have multiple hook
>> > scripts configured, and if we ran them both, we'd run the hooks twice.
>> > This would be bad for e.g. the prepare-commit-msg hook. This is also the
>> > least surprising behavior.
>> 
>> OK.  An obvious alternative may be to see if the expected hooks path
>> is a directory and use the contents.  If ".git/hooks/pre-commit" is
>> a single file, we know it is the single hook as before, and if it is
>> a directory, we know that is not a custom made (i.e. from the world
>> before this series supported in the core-git) multi-hook setup.
>
> That's an idea I hadn't considered. I'm interested to hear other folks'
> ideas on it, but that certainly avoids a lot of the problems in my
> approach.

One downside is that the transition from the old to the new world
order becomes a bigger deal.  You could have been using a precursor
of this series implemented entirely as a shell script

	$ cat >.git/pre-commit <<\EOF
	#!/bin/sh
	for x in .git/pre-commit.d/*
	do
		"$x" "$@" || exit 1
	done
	exit 0
	EOF
	$ chmod +x .git/pre-commit

and with your approach, the user can keep using that set-up and then
simply remove that single file once all the Git executables the user
uses are natively aware of the multi-hook setup.  With "either a
file or directory" approach, the transition would be removing the
file *and* renaming pre-commit.d directory to pre-commit.
