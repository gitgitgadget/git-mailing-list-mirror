Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA3C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724020777
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkcnzBI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCTRn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:43:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCTRn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 13:43:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D303D597EC;
        Fri, 20 Mar 2020 13:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DSgoj56TpwNbdosVHkZA0z0YIMA=; b=CkcnzB
        I5dt0+z8xzqnCiIWcDEh8H3dauNaletG5xWLwdH7Iq+KBPpkMCCpHdmSh+qnaV6R
        haSSJjYdY7M2rGY+G3K9/0gL5TS59Zziq4Qm3s5w5OyX8GDk7IJWxi50P39bg9/J
        uyup1SlLgd60qgWAXqc+STxe7OaAPgXg89PgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ifs7itwGMhYPOHvEqLSSjT7Ht1JDRsvN
        Cm5NE8eILvxB19Dz5yUfNlqYk/VBMsNl+PkRBnakiSzQhiIzMP5/CIHGwEC3QryF
        V+e3pfbN9G2RBGnICqPgnLGF+CHC92xTaE2lYOK17mcbhkwb4RjPbx9LnuQNLMVY
        A/Uak6GbWRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA9B9597EB;
        Fri, 20 Mar 2020 13:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A037597EA;
        Fri, 20 Mar 2020 13:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <20200319213902.GB45325@google.com>
Date:   Fri, 20 Mar 2020 10:43:25 -0700
In-Reply-To: <20200319213902.GB45325@google.com> (Emily Shaffer's message of
        "Thu, 19 Mar 2020 14:39:02 -0700")
Message-ID: <xmqq8sjudirm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E0A480E-6AD2-11EA-96C3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> This is the kind of stuff I really wanted to get straightened out by
> sending the smaller changeset, so I'm glad to be having this
> conversation (again, and hopefully for the last time).

I actually have a suspicion that "git bugreport" that is spawned via
"git" wrapper is a bad idea (in other words, /usr/bin/git-bug that
is totally standalone may be better).

The thing is, anything launched by "git" as its subcommand (be it
standalone or builtin) sees an environment already modified by
"git", so inspecting say "$PATH" from "git bugreport" (be it
standalone or builtin) does not show what the end-user, who may be
having trouble, actually has.  The mangling of $PATH alone happens
to be simple and (we may think) we can easily reverse without losing
bits, but there would probably other differences that we think is so
subtle and insignificant, right now in this discussion without
having actual end-user who is having trouble in front of us, that
having "git" layer in between may hide from us.

Having "git-bug" a totally separate tool, that does not even go
through git.c::cmd_main(), would also allow (and force) us to treat
"git" just like any system component on the end-users' system whose
versions and configurations may affect the use of "git" by the end
user.  The tool, instead of relying on git_version_string[] that is
determined at the compile time, would ask "git version" just like
the end-users would when asked by us "what version of git do you
run?"  It also means that "git-bug" can be updated at different
cadence and the mismatch of versions between it and "git" does not
matter at all.

Having said all that, after suggesting to make the tool even more
distant from the remainder of the binary, quite honestly, I do not
even want to see us wasting any more time on builtin/standalone at
this point, and instead would like to see reports from the end-users
produced by a lets-start-small version of the tool and measure how
having the tool actually helps.

Thanks.
