Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C8C20756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdATW46 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:56:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57190 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdATW45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:56:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 202C263755;
        Fri, 20 Jan 2017 17:56:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L3V+HJTyix+6hIqHgpKH6fnyi7s=; b=cbHcfr
        GN2PypwnotW5x0+DVqM0vun6bpB+U56ijAT6S7u4FxB0AJNPHReXritAPWsdK5om
        pje7sg16LYmkJ5pnqzS/ozt1wPu9wYOjxN03RYogYcLmGjduSgi4PwFT+YJL5zTa
        DlqOAlsQHgiDU3eqYDnjaMVKjbwF9+EUdqEJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TqLAwQY+mFSbxDfDdsrxdufZEmZhdLeS
        QiJDrjZsB7YC6faRwROvpheiRarxnTJPb5SIuhClZO4cOyYN1qtU+/u56N5i+ePh
        5WKaVgPKmY/DymVhYZd5A7UlsVqIGa1JVB2D2Iwhrkk3/m7A1q1MZWmWHw9ixuf9
        DpHC/bjE0Ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F175C63754;
        Fri, 20 Jan 2017 17:56:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46E0063753;
        Fri, 20 Jan 2017 17:56:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, git@vger.kernel.org
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
References: <20170119150347.3484-1-stefanha@redhat.com>
        <20170119150347.3484-3-stefanha@redhat.com>
        <xmqqpoji2851.fsf@gitster.mtv.corp.google.com>
        <20170120141212.GC17499@stefanha-x1.localdomain>
        <20170120141954.xyocl6oqoykqmpl5@sigill.intra.peff.net>
Date:   Fri, 20 Jan 2017 14:56:26 -0800
In-Reply-To: <20170120141954.xyocl6oqoykqmpl5@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 20 Jan 2017 09:19:55 -0500")
Message-ID: <xmqq60l9wdb9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACABD4C0-DF63-11E6-B69C-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's not ignored; just as with git-log, it's a pathspec to limit the
> diff. E.g.:
>
>   $ git show --name-status v2.9.3
>   ...
>   M       Documentation/RelNotes/2.9.3.txt
>   M       Documentation/git.txt
>   M       GIT-VERSION-GEN
>
>   $ git show --name-status v2.9.3 -- Documentation
>   M       Documentation/RelNotes/2.9.3.txt
>   M       Documentation/git.txt
>
> That's typically less useful than it is with log (where limiting the
> diff also kicks in history simplification and omits some commits
> entirely). But it does do something.

I think Stefan is missing the fact that the argument to "git show
<tree-ish>:<path>" actually is naming a blob that sits at the <path>
in the <tree-ish>.  In other words, "show" is acting as a glorified
"git -p cat-file blob", in that use.

The use of "git show" you are demonstrating is still about showing
the commit object, whose behaviour is defined to show the log
message and the diff relative to its sole parent, limited to the
paths that match the pathspec.

It is perfectly fine and desirable that "git show <commit>:<path>"
and "git show <commit> -- <path>" behaves differently.  These are
two completely different features.


