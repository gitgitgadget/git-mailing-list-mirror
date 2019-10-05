Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E111F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 22:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfJEWpA (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 18:45:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJEWpA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 18:45:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2096785A5;
        Sat,  5 Oct 2019 18:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Q5E8wbK4Z3A4g2MCNHACqVubj8=; b=I39ycn
        hFZiEcWSk8DaMRkzPJHFeSAb2jfHi7HLdkYm55nQZoT/Ct2zlqKNxffkxo1dSvYH
        2dFcnDFEZmmqN9lOdiTMaWC+INr/xVcpYyQKmGPoFWDPFaTovj8j9kL7qDatEM/b
        +ACYGhrcQX+PLXxIB7ZCL4oTYZCd40p7I3xiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=okenuV8ZYq/IPERqvhG4vRiXSnx8pZaA
        9f+XGFu5YX+kHK38rr5PIl39P7n1ko6kg46BW3gfwm/x3j5nozLsbl1sGaoJraOo
        CuGfGFHgegIIyyuFRTZQ2W9uFjsu8Lb48LWhbB2lbGIvlEv7wELk2YUJmqsxslsR
        k1sdfb92/Co=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9EA3785A4;
        Sat,  5 Oct 2019 18:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 026F8785A0;
        Sat,  5 Oct 2019 18:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] apply: tell user location of corrupted patch file
References: <20191002184546.GA22174@generichostname>
        <ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com>
        <xmqqv9t37fsw.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 06 Oct 2019 07:44:52 +0900
In-Reply-To: <xmqqv9t37fsw.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 05 Oct 2019 17:33:03 +0900")
Message-ID: <xmqqbluu7qxn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C02B0430-E7C1-11E9-8888-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> An alternate design was considered which involved printing the line
>> numbers relative to the output of `git am --show-current-patch` (in
>> other words, the actual mail file that's provided to am). This design
>> was not chosen because am does not store the whole mail and instead,
>> splits the mail into several files. As a result of this, this would
>> break existing users' workflow if they piped their mail directly to am
>> from their mail client, the whole mail would not exist in any file and
>> they would have to manually recreate the mail to see the line number.
>
> More importantly,...

Addendum.

I think the primary reason why the "alternate design" will not fly
is *NOT* that it breaks existing users (which it would), but giving
a line number in the original mbox file is not always possible.

Imagine the message you received was munged by the sending mailer,
or a relaying mailer, and what you received is encoded in base64 ;-)


