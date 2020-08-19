Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4688C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 20:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A3B207DE
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 20:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xnZPd6mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHSUcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:32:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59653 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHSUcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 16:32:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 270FCF581A;
        Wed, 19 Aug 2020 16:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3y+0z86ScnKPZcpai3tuRuV2cgM=; b=xnZPd6
        mh+oSEsyi+iGw9V58RKK07mgejfmSQmbnw9Q1UmqI19W0ioC9SN2sM/PQ1JQv2+j
        eXP+vnFNCV6cjSnH+hRx+Oy+U1/744+e8rdDsGnpHVT/udZxrmZ8r63Oewp3wMQR
        eqOdJEik/L+iKwzPB/3ogSj/dV4mkXRYk0XJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RnVABml6BfrVgL1CDk1pIaDfdxEd1Eb9
        3LuV12a1TWgT7p6yyOnusQK8MFvn4jKz+pGt9UNDotLqjvSKbVuW0K477b813l74
        UjBmqvikiIxugXCuPgJYX6x6g6yfY3QfU+iUklqHFBRFWvwuQsk+/OmJloRg4Ulw
        Dl/JiRoWqz4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F6E4F5819;
        Wed, 19 Aug 2020 16:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 572D8F5818;
        Wed, 19 Aug 2020 16:32:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Lukas Straub' <lukasstraub2@web.de>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
        <xmqqimdetpuw.fsf@gitster.c.googlers.com>
        <20200819201736.GA2511157@coredump.intra.peff.net>
Date:   Wed, 19 Aug 2020 13:32:28 -0700
In-Reply-To: <20200819201736.GA2511157@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 19 Aug 2020 16:17:36 -0400")
Message-ID: <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A8F97D0-E25B-11EA-8599-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It _could_ still be useful in a more isolated environment (e.g., your
> company server that is serving only internal repos to employees). But I
> have misgivings about a feature that lets people intentionally create
> repositories whose history cannot ever interact with other users who
> haven't set a special config flag. It's one thing to say "to take
> advantage of this feature, we must all agree to have version X, or set
> flag Y". But it's another to bake that restriction into the repository
> history for all time.

If people want a pre-prepared repository propagated to CI
environment and keep trakc of the state of such repository over
time, for example, they can use (versioned) tarballs.  Such a
tarball won't automatically get extracted after "git pull" (which
is a feature), but those who want such a pre-prepared repository
for CI can make the extraction step as a part of their CI build
procedure.
