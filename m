Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B8B1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdALXIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:08:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51296 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750794AbdALXIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:08:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1908F5F15C;
        Thu, 12 Jan 2017 18:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G2MCNAz6fSwj
        D01WMfIMfOKNyyQ=; b=DhzBWYz3senRIcFZkfSQWAGWx4xgS7k3N9Nenu6kNJ/j
        R0Fnp4rcW81PpD0fp5Y2fSRI9ND+UnhItp+kEz7djKBEmtVKk7/4RZoUtwQfOl9/
        O6LR8k5w55oL3laRulICYVYvm7nr7iFqmT89/QIDwkr2MQUPbKDvRRTzPOOOdUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wVejqd
        BofuFEd+wYlCJiFVwtZ5WajYfTPcPdGWqkXBrw0Wn1ucev67z/EwjW+Bxya3hdo4
        oAhcMS1B71NFpy1SjZ/reqWVLu/3r1NLsbJhRbXSn8DG8uMfCqwk37ErQI6Xyp6c
        24veqgj1zwhZAYwKo/0Umdv8ZQXMqIhYqa5II=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EECA5F15B;
        Thu, 12 Jan 2017 18:08:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 501A05F159;
        Thu, 12 Jan 2017 18:08:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 5/4] Redefine core.bare in multiple working tree setting
References: <20170110112524.12870-1-pclouds@gmail.com>
        <20170110113320.13119-1-pclouds@gmail.com>
Date:   Thu, 12 Jan 2017 15:08:39 -0800
In-Reply-To: <20170110113320.13119-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 10 Jan 2017 18:33:20 +0700")
Message-ID: <xmqqh953j2q0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0EE32A38-D91C-11E6-8375-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> With per-worktree configuration in place, core.bare is moved to main
> worktree's private config file. But it does not really make sense
> because this is about _repository_. Instead we could leave core.bare in
> the per-repo config and change/extend its definition from:
>
>    If true this repository is assumed to be 'bare' and has no working
>    directory associated with it.
>
> to
>
>    If true this repository is assumed to be 'bare' and has no _main_
>    working directory associated with it.
>
> In other words, linked worktrees are not covered by core.bare. This
> definition is the same as before when it comes to single worktree setup=
.

Up to this point, I think it is not _wrong_ per-se, but it does not
say anything about secondary worktrees.  Some may have their own
working tree, others may be bare, and there is no way for programs
to discover if a particular secondary worktree has or lacks its own
working tree.

Granted, "git worktree" porcelain may be incapable of creating a
secondary worktree without a working tree, but I think the
underlying repository layout still is capable of expressing such a
secondary worktree.

So there still is something else necessary, I suspect, to make the
definition complete.  Perhaps core.bare should be set in
per-worktree configuration for all worktrees including the primary
one, and made the definition/explanation of core.bare to be
"definition of this variable, if done, must be done in per-worktree
config file.  If set to true, the worktree is 'bare' and has no
working directory associated with it"?  That makes things even more
equal, as there is truly no "special one" at that point.

I dunno.
