Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A706120960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdDMWuI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:50:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbdDMWuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:50:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB51E87CAA;
        Thu, 13 Apr 2017 18:50:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NAMORT1G9j2a
        /Nhhb3aNJ/lmXVc=; b=tYlW/bPiR4a8JBtYv8t8+5b2PiSltDWvgQZWuKLud1fc
        lQ2MbuNA1EivCRCOwZLAVDYMj1sPAEzHYQprWsU7CzfiWK6XegsaJRQ4jVg37c6k
        s6m3VQ3tOe21Kukcgc5daNFkTrTq4laLKmSGs1mVpXwO0pyuRBjQOprYWaYTiGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XNWWRQ
        9raVWDb66j4tMda7/7qy97FG5nL9pj7fv2zQ4NlUhYT4UiJ2Y3BsVcGNlSVZSW82
        C4PpRX7oVmtCZh5VWtWdKA1wvtC9P2n4SJsU+GrMAspJEj+8wPw8shMQrQzuAH7V
        +aJ3uKs1VZGZ/ebT1kfc7VSulW5Pf8FuuUW4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B19E787CA8;
        Thu, 13 Apr 2017 18:50:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D42187CA6;
        Thu, 13 Apr 2017 18:50:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, David.Taylor@dell.com
Subject: Re: [PATCH] worktree add: add --lock option
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
        <20170412135805.29837-1-pclouds@gmail.com>
Date:   Thu, 13 Apr 2017 15:50:04 -0700
In-Reply-To: <20170412135805.29837-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 12 Apr 2017 20:58:05 +0700")
Message-ID: <xmqqy3v3orc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89B8E632-209B-11E7-A6F5-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> As explained in the document. This option has an advantage over the
> command sequence "git worktree add && git worktree lock": there will be
> no gap that somebody can accidentally "prune" the new worktree (or soon=
,
> explicitly "worktree remove" it).
>
> "worktree add" does keep a lock on while it's preparing the worktree.
> If --lock is specified, this lock remains after the worktree is created=
.
>
> Suggested-by: David Taylor <David.Taylor@dell.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  A patch that adds --lock may look like this.

This looks more like "I do believe the idea by David is a useful
addition and here is how I did it to the best of my ability---let's
make sure we polish it for eventual inclusion" than a mere "it may
look like so---do whatever you want with it" patch.

To me "git worktree add --lock" somehow sounds less correct than
"git worktree add --locked", but I'd appreciate if natives can
correct me.

Thanks.
