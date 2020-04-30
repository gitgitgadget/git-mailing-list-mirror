Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5312C83001
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6D420709
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGbngoVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD3Dl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:41:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54929 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3Dl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 23:41:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69713CC86C;
        Wed, 29 Apr 2020 23:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EF7G1maphpx2jOSNmro/MP7ZPdI=; b=oGbngo
        Vam4Y5BNvm7kcd1fottB3kmsQHz1y7pqbY1zum7hWTzrfAo38y6m/Zsqr2dNePe5
        owt8Y3lpRsteYAn4EYNTEU64UqVc0or5KUVHC1dlANaZ+VEv5z1sWlHFkbcaiom2
        y/jXXU63sqi1+rPNbMvtnPpVtTs6tKLYMJNP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cMAmM1nnPhlNL3p273Dx5+uZf983qxST
        wELYHK6XT8DJdx9OW2meTcQpmfVo7Ki6FpUeRayWaEw/Q0x0umyNw6/caR7FMNfu
        vCyzrTIa6ARNtHd6HdI9iJtyL7kcI2sypj8luxFpD3BEUS8CEzWsqkE5cPUFq7bM
        2F3RE8yZfuk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60916CC86B;
        Wed, 29 Apr 2020 23:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB41BCC86A;
        Wed, 29 Apr 2020 23:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] lib-submodule-update: pass OVERWRITING_FAIL
References: <cover.1588162842.git.liu.denton@gmail.com>
        <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
        <xmqqpnbqw0vz.fsf@gitster.c.googlers.com>
        <20200430011056.GA3036@generichostname>
Date:   Wed, 29 Apr 2020 20:41:23 -0700
In-Reply-To: <20200430011056.GA3036@generichostname> (Denton Liu's message of
        "Wed, 29 Apr 2020 21:10:56 -0400")
Message-ID: <xmqqd07ptzbw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7728C602-8A94-11EA-BE23-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> Here, $command may or may not be a git command and more importantly,
>> it could be a shell function, right?  Then we need to take it into
>> account that 
>> 
>> 	VAR=VAL shell_function args...
>> 
>> will not work, no?
>> 
>> Some shells do not make this a single-shot environment variable
>> assignment that will not persist once the single function invocation
>> returns.
>
> ...
> which makes me suspect that these shells are not POSIX-compliant. What
> are some examples of shells that behave this way?

I think the most relevant thread is the one that contains this
message:

  https://public-inbox.org/git/7vljfzz0yd.fsf@alter.siamese.dyndns.org/

FWIW, shells that do not retain the assignment after a function
returns are not POSIX compliant.

