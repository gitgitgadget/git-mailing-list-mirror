Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1576B1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 22:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbcLJWEh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 17:04:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59085 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752223AbcLJWEg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 17:04:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2352B5551B;
        Sat, 10 Dec 2016 17:04:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BHpEqvPa0oInJ+mEX0yPuPqxeYA=; b=w6zGhv
        UKFlEiky2hxi1heognS8idzNESlBiD3poHqPTKQfSAZAlAyzLLf4GO6uUHp+t2j2
        qIuziiYz8MnUQ5Z5aDYI6PsSBN5Nvc0ACAQZiKY3z1pdG/spHkKYRy+678bFs3o+
        uxDJ+woKyX/wzyWXQRPbwJb+h2kGuOfBar9Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K36xu090dYGykMR/+Cszn7Sbc91qxOBs
        O/rGUD4U6kKpqcrwahYQVdzc79JbY+Qw/bKczRbDkMffOgz/sU+prvRbDU9pSJsO
        tursfsz0sLnkiWaK6+3p8xKAOOwC7bk2UTxBEycpDAMX81+8kAOBQo/JQo/RavSU
        VVNmzGE2HDo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A83A5551A;
        Sat, 10 Dec 2016 17:04:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A3FA55519;
        Sat, 10 Dec 2016 17:04:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ariel <asgit@dsgml.com>, git@vger.kernel.org
Subject: Re: git add -p with new file
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
        <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
        <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
        <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
Date:   Sat, 10 Dec 2016 14:04:33 -0800
In-Reply-To: <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Dec 2016 03:55:56 -0500")
Message-ID: <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A267D9D2-BF24-11E6-B898-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 09, 2016 at 01:43:24PM -0500, Ariel wrote:
> ...
>> But it doesn't have to be that way. You could make add -p identical to add
>> without options, except the -p prompts to review diffs first.
>
> The question is whether you would annoy people using "-p" if you started
> including untracked files by default. I agree because it's inherently an
> interactive process that we can be looser with backwards compatibility.

It might be interactive, but it will be irritating that we suddenly
have to see hundreds of lines in an untracked file before we are
asked to say "no I do not want to add this file" and have to do so
for all the untracked files that happen to match the given pathspec.

It might make it less irritating if one of the interactive choices
offered in the first prompt were N that tells the command: "No,
ignore all the untracked paths", though.  I dunno.

Also, because "git add -p" (no pathspec) is NOT a no-op, the
similarity Ariel sees with "git add" (no other options) does not
hold.  As you kept explaining (but perhaps not successfully being
understood yet), "add -p" works like "add -u", and it will make the
command incoherent if we allowed "git add -p <path>" to add new
paths, exactly because "git add -u <path>" does not do so.  Of
course that can be fixed by allowing "git add -u" to also add new
paths that match pathspec.

Of course, Ariel can vote for making "add -p" more like "add" (with
no options) than "add -u".  I _think_ it is a better way to solve
the incoherence than making "add -u" to add new paths.  But what it
means is that "add -p <paths>" works on both tracked and untracked
paths that match the given pathspec <paths>, and also "add -p" (no
pathspec) must become a no-op (because "add" without option and
pathspec is).

