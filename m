Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E355C20281
	for <e@80x24.org>; Mon,  6 Nov 2017 01:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbdKFBlP (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 20:41:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51761 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750778AbdKFBlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 20:41:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8959BB564C;
        Sun,  5 Nov 2017 20:41:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GBNr8TefXUPdJkktcVHbkmYVmvg=; b=tiY4jf
        TCJKpHIXZ4y5HlOUyg3zSVjFLahNIl7CtLoJf3qqrINmXjpU+HdbpGOrw6YDQmvj
        wZS70KS2EbHRCGQXEsTkmVRQ+Uy2U7VngjlK/YOlV+GdkhDFlZ4vsAs+cb7yjMMN
        RuY3lJjSPHjYDIIP+QfsagCXlfPZoM+9PSHT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cykn49WhHQ+U7xCWzudXibmdSwpebcyy
        txPq8jrRFQ56Y2DxUNCsAaLomxYSL+4GhBq+cQL9OibsqLs3m5sVgAOuGjO3bktP
        dyhpM0k5oxzO0HdTV/k88WP2yD+DpKpqs0FcyjUQZ3geG8/fAnaLcnmT0dnI4TJX
        bBEfZ7vPc9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F0BB564B;
        Sun,  5 Nov 2017 20:41:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 024D6B564A;
        Sun,  5 Nov 2017 20:41:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: what is the function of .git/branches/?
References: <alpine.LFD.2.21.1711051122160.3602@localhost.localdomain>
Date:   Mon, 06 Nov 2017 10:41:12 +0900
In-Reply-To: <alpine.LFD.2.21.1711051122160.3602@localhost.localdomain>
        (Robert P. J. Day's message of "Sun, 5 Nov 2017 11:24:00 +0200 (EET)")
Message-ID: <xmqqo9ogji9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92FEC744-C293-11E7-8116-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   currently proofing "pro git" book, and an example of a new repo
> doesn't show a .git/branches/ directory, but initializing a new repo
> with current version of 2.13.6 *does* show an initially empty
> directory by that name. however, AFAICT, branches are still tracked
> under .git/refs/heads/, so what's with that branches/ directory?

There are three ways to specify what branches of which remote
repository your fetch and/or push interacts with, and having
.git/branches/foo file is one of these three ways (the other two are
to have .git/remotes/foo file, and to have [remote "foo"] section in
the .git/config).

If your workflow involves having to interact with tons of remotes
(imagine being a maintainer who regularly pulls from dozens of
sub-maintainer's repositories, each of which places the material to
be upstreamed on a single branch) and that set changes from time to
time, using .git/branches/* is a lot more efficient than having to
keep track of the same information in other two formats, so even
though it was the invented the earliest and is the least flexible
format among the three, it still has its uses.
