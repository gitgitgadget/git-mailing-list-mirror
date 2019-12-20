Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF9C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 20:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A3F206D8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 20:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rBmotE8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTUWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:22:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLTUWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 15:22:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC93899FC2;
        Fri, 20 Dec 2019 15:22:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3fsMJmUzOyJu
        Ner6vZlMbCK+ZT0=; b=rBmotE8wFIBnu2IdK0cfEhmtjDkTZCem/RNsD9IXCM4b
        2Au8mAOldLybvsQtlQkLnolp2dUhkFnJACpOfVNuDEWcjKR8swVac7Dw4bemyA42
        u6fGUhpUxz0x0BJU0WDr3J8MFNkLQ9NahNB1/tRmKoHbtMGHo6paoU2qsjPzVEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NP+dQ/
        1nrslAGUHxZzzdPdcAvSzl9dCxHAgKgS+CdpIt16B6hnPqADNt2WwnDn4u/eQrTD
        3DEMYSvI6sJipRap/5P7DLVaHzgZYLRJBt37FBLi2dnq7s7jTWfWK0cHukGlIpHH
        Xm1AAkdkVd134l5M6vbtGtU9s3iBGqjkmpe5w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9304A99FC1;
        Fri, 20 Dec 2019 15:22:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9E6799FBE;
        Fri, 20 Dec 2019 15:21:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Casey Meijer <cmeijer@strongestfamilies.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GIT BUG] show-ref doesn't work with Symbolic Refs other than HEAD
References: <46A996A1-4B9D-4613-A49B-A95E98119DFA@strongestfamilies.com>
        <BF8A29F0-0572-49EA-9E3F-AC6964C6D8B0@strongestfamilies.com>
Date:   Fri, 20 Dec 2019 12:21:55 -0800
In-Reply-To: <BF8A29F0-0572-49EA-9E3F-AC6964C6D8B0@strongestfamilies.com>
        (Casey Meijer's message of "Fri, 20 Dec 2019 20:04:10 +0000")
Message-ID: <xmqqo8w2928s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F1F5034-2366-11EA-B275-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casey Meijer <cmeijer@strongestfamilies.com> writes:

> `git version 2.21.0`
> =C2=A0
> Example
> ------------
> =C2=A0
> `git symbolic-ref DEV refs/heads/dev`
> `git symbolic-ref DEV`
> `>> refs/heads/dev
> `git show-ref DEV`
> `>> [NO OUTPUT]`
> =C2=A0
> Expected output
> ---------------------
> =C2=A0
> `FULL_COMMIT_HASH refs/heads/dev`

What made you expect such an output?  That may be caused by a
documentation bug or two, which may well be worth fixing.

The show-ref command never resolves a symbolic ref to its pointee,
and it only shows things under refs/ hierarchy.

And DEV is not special.

	git show-ref HEAD

would not show HEAD (i.e. the commit that is at the tip of the
current branch), and it would show refs/remotes/origin/HEAD in a
repository cloned from elsewhere but it does not say what other ref
is pointed at (in other words, what the remote repository considered
the primarily interesting branch).

Thanks.
