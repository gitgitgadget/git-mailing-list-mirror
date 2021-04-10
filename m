Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826EBC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E346113A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 16:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJQn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 12:43:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65163 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhDJQn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 12:43:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35730127321;
        Sat, 10 Apr 2021 12:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MH8SaHusiCzBSWbm/t3z1Q0AlAg=; b=te1LAGU7jY5p8aVaWsb3
        iiCmtbC3wc9p4VvySSYbGmQsr7Elk4ZmPIQWRDwuWqBu7eLKprd/NBzxxoIX4A55
        cVkuJvnhDUAo7HnqfeIrnTFgtctuC2G0TBxdHf2YRoy81qOLaak4aafbwwNzA8H4
        Qc18T2S0Rko3uEPSQDY0tMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=aiJH4XhKsTmN//F7o7dGWv41ymb+uV3quF0xLXPEhjRAVx
        wS1dH1mDfwnk3z1uVEBBcXp5odzM1hIsh3fYxtu7griP2Px/mUZb6WzoNoVVFFx8
        Ew5Kl6h/HDjGUe30wjHD8PYf5JNbatJtbuCqpsDw634g2uIOrAp4cETbkyFHU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 231AF127320;
        Sat, 10 Apr 2021 12:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 395BB12731F;
        Sat, 10 Apr 2021 12:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
References: <20210409211812.3869-1-sir@cmpwn.com>
        <YHEB1ClofnD6nQWA@camp.crustytoothpaste.net>
        <CAJNUBUZNAXE.283NJ968IDN2X@taiga>
Date:   Sat, 10 Apr 2021 09:43:05 -0700
Message-ID: <xmqqczv2jdk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3C291EE-9A1B-11EB-A94B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> On Fri Apr 9, 2021 at 9:39 PM EDT, brian m. carlson wrote:
>> Since I agree that "ssl/tls" may be a bit confusing, maybe we could call
>> that option "wrapped" or "tunneled"? Other names are possible, of
>> course.
>
> I would prefer to name the options after the terms we can expect the
> user to find in their mail service provider's documentation, hence
> SSL/TLS and STARTTLS. Though I can see the confusion in including the
> slash, I'll figure something else out.

OK.  

 * My e-mail provider [*] seems to label these two as SSL/TLS
   (sometimes just TLS) and STARTTLS, but that is aligning how the
   popular client programs call these two methods, so it may not be
   a good datapoint.

 * GMail help page [*] seems to use 'SSL' vs 'STARTTLS' (they seem
   to support both).

 * Outlook.live.com/ help page [*] says they want you to use
   'STARTTLS' for SMTP, but they use 'SSL/TLS' to describe their
   IMAP and POP offerings.

With the above limited samples, I agree that the choices between
'SSL/TLS' and 'STARTTLS' would appear familiar to our end-users.



[Reference]

* https://helpspot.pobox.com/index.php?pg=kb.page&id=118
  https://helpspot.pobox.com/index.php?pg=kb.page&id=125
  https://helpspot.pobox.com/index.php?pg=kb.page&id=399

* https://support.google.com/mail/answer/7126229?hl=en

* https://support.microsoft.com/en-us/office/pop-imap-and-stmp-settings-8361e398-8af4-4e97-b147-6c6c4ac95353
