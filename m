Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA4FEE49A3
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjHVPvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjHVPvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 11:51:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E3CEC
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 08:50:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CB651E693;
        Tue, 22 Aug 2023 11:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KOgjxwguxKcUDN9D3O/7xbVU4GlQaWoYnC8J2H
        IIW4I=; b=LPK7BTKvz9ONAIoH7hzCKQXmzBhAXX12pxVyIps0wHJv1i5CDYy92Z
        1eVobXegzm25EsWzBJZTi3rR7Kgxq6BOhbXJxpzrNM6y+alBTCrQlcuCwXATEyWL
        HCADqcLZEyj/xIn3fv6QWzI/HnC8IxB2Aw7cZS60EWkMI0acludAw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 351241E692;
        Tue, 22 Aug 2023 11:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3EEA51E691;
        Tue, 22 Aug 2023 11:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 1/1] t6300: fix match with insecure memory
References: <20230821202606.49067-1-list@eworm.de>
        <ZORpucPcjzm-dhjP@five231003> <20230822110404.1c002dcf@leda.eworm.net>
Date:   Tue, 22 Aug 2023 08:50:38 -0700
In-Reply-To: <20230822110404.1c002dcf@leda.eworm.net> (Christian Hesse's
        message of "Tue, 22 Aug 2023 11:04:04 +0200")
Message-ID: <xmqqcyzfm5yp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4541360-4103-11EE-9D8D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> writes:

> Kousik Sanagavarapu <five231003@gmail.com> on Tue, 2023/08/22 13:24:
>> Christian Hesse <list@eworm.de> wrote:
>> 
>> > From: Christian Hesse <mail@eworm.de>
>> > 
>> > Running the tests in a build environment makes gnupg print a warning:
>> > 
>> > gpg: Warning: using insecure memory!
>> >
>> > This warning breaks the match, as `head` misses one line. Let's strip
>> > the line, make `head` return what is expected and fix the match.
>> >
>> > Signed-off-by: Christian Hesse <mail@eworm.de>  
>> 
>> I think a bit of an explanation about why this warning is showing up in the
>> commit message would be good.
>> 
>> "man gpg" gives me <stripped>
>> 
>> So it seems that this warning will pop up if gpg is writing memory pages to
>> disk which is bad because as stated above we don't want these pages written
>> to disk which is a security risk.
>
> The Arch Linux packages are built inside a clean container, started via
> systemd-nspawn. Within the container the system call @memlock is not allowed
> by default, for security reasons.

Thanks for Kousik and Christian for discussing this.  The phrase "in
a build environment" in the proposed log message puzzled me, as the
program does not seem to print such warning in my build environment.

And environments where memlock is disabled are probably not limited
to containers used to build Arch's packages.  "in a build
environment" -> "in an enviornment where memlock is disabled" would
have avoided puzzling readers.

