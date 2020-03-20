Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145FC4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD31020775
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qKyTcN6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCTSIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:08:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63821 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSIm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 14:08:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC2B048870;
        Fri, 20 Mar 2020 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hhcKipFMwySWY/q9yUOX2lJxm8M=; b=qKyTcN
        6zuWRq19NaI1BJK/p7phXuZW9GdsgIOVXGqfMhLuXl6TD3CW14U550ThVph/JPN1
        V7kvHFy5QcvCOFzvvt/3c4tmaepFGx4oyOwUGdRwe2k4n7dAVvslIua/ZnTosWMZ
        DOEP4GhEWIusIlcDL7VYyX2vfmy8mFspxZOL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WoNSTqMPCB0Mh2jdAY3etHD5oF/18uig
        OYh4vWx8An+A7cJSpsTX/1IfddP0CrFjwXv4Of6gf+YZaoq8cmKRRK/2qY5XUdbz
        R1BAxkBtpVtQrfbV7ij7qVpShQz+o6MqeQEIDNht77J2snfibKLj62I2chgs8lyo
        GBXPan3WULg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C35FB4886F;
        Fri, 20 Mar 2020 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B3AD4886B;
        Fri, 20 Mar 2020 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Adrian Wijaya <adrianwijaya100@gmail.com>
Subject: Re: [GSOC][PATCH v2] t1300: convert "test -f" with "test_path_is_file"
References: <CA+0Uiy-gtdn07=QOx3JcOH-zhMz5yAKOW6=9mNc8Zi+RdfWGyQ@mail.gmail.com>
        <20200320160723.15190-1-adrianwijaya100@gmail.com>
Date:   Fri, 20 Mar 2020 11:08:40 -0700
In-Reply-To: <20200320160723.15190-1-adrianwijaya100@gmail.com> (Adrian
        Wijaya's message of "Fri, 20 Mar 2020 23:07:23 +0700")
Message-ID: <xmqqzhcac313.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D44DAE12-6AD5-11EA-AAAB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adrian Wijaya <adrianwijaya100@gmail.com> writes:

>  	test "z$(git config --file=notyet test.frotz)" = znitfol &&

We see 130+ instances of this rather antiquated construct that
presumably avoids to compare an empty string with something else
using "test X = Y" tool.  It might have been a good idea in 2005 (I
do not remember why we started doing this), but perhaps it is time
to clean them up by listing it as another microproject idea for the
next year?

