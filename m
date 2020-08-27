Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C3EC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 01:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3862075B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 01:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ILAprtfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgH0BXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:23:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62118 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgH0BXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 21:23:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4842EFF0E;
        Wed, 26 Aug 2020 21:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XrLz4YxuIoXBwoXRbOxckyDIHcA=; b=ILAprt
        fyetNxyN92eHNaXYxK1b6BC0At6u/i3VsGB5J4upUM7TI/sBq2xN+53210tmjWyy
        fhsfBYepEK5k3v4U14Zr8i9owY+uq4hRXWosxikmtP31GqbHmJKKty5M9TOUYyYh
        M07Ue2jGKzukGtrvn+PSjvAeBFTt12O2MwZ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ih2vaMrPwTPgTDWCDx2ZXf3TnE33zfVG
        dE/P9P14BVRXc9LNWAdRWCgg9oxyg71+IF8u3cjfyYSrRajzdRrEh5Aiyo5Qg9QP
        SFoaicZEs3wJkLRZEYSRY5hkuyHy3X+jCUsY4JDNrIZ1YTBtqJHyFD5teUg/5ceA
        k6q7QFpIFg4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD8F8EFF0C;
        Wed, 26 Aug 2020 21:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2706EEFF08;
        Wed, 26 Aug 2020 21:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] avoid running "git-subcmd" in the dashed form
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <07f26226-c1cd-494d-899e-d6452ad2751f@gmail.com>
Date:   Wed, 26 Aug 2020 18:22:56 -0700
In-Reply-To: <07f26226-c1cd-494d-899e-d6452ad2751f@gmail.com> (Derrick
        Stolee's message of "Wed, 26 Aug 2020 20:57:45 -0400")
Message-ID: <xmqqy2m0swzz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D73B57AE-E803-11EA-BD1E-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Would an interesting in-between step include removing the dashed
> forms for builtins that didn't exist in Git 2.0?

I am not sure if it makes much sense to treat newer and older
built-in commands differently.

Imagine that an old-timer wrote a script by somebody who trusted the
"futz with PATH and you can use git-foo" promise before Git 2.0 and
then the script was inherited by relatively new users.  Adhering to
the "when in doubt, mimic the surrounding code", which is usually a
good discipline to follow, these new users, who are now in charge of
maintaining the script, would add any new calls in "git-foo" form to
match the local convention in good faith.  And the resulting code
would have been working just fine.

Before such a "in-between step" is thrown at them, that is, at which
point it stops working if they were unlucky that they used a
relatively new built-ins.  Typically new end-users would not know
which ones are old built-ins and which ones are new, I suspect.

I do agree with Dscho that "we won't let you use builtin in dashed
form before you export an enviornment" I wrote was not a good way to
gauge the usage of on-disk builtins.  We should move the on-disk
builtins to a different directory and have them point at the
location with their $PATH as the escape hatch, as Dscho suggested,
if we were to do this for real, I'd think.

Thanks.
