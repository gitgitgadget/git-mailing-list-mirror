Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7243820C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdLCWtD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:49:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64988 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752144AbdLCWtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:49:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DA98C3CBB;
        Sun,  3 Dec 2017 17:49:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DvT6fFIhEFPzi6O+Crx2aN9wKSI=; b=Ys1jZP
        9K/XKlm68m2EdQxaLH5Fwc6ej2OKeEwzE/gRgfL3TBxD5KX1YVLlwcrjvhPCZ7sI
        l4hP3nqufK8Bw0a6mEp0g/+SY0BZXecAZukjOmyy8CtXSZRsF1O5tw+2KrvhEjQs
        imF2O0U0mrYFyq02/dho+oPTlwt/birFNrS8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cDkEabCl6MvcNeHisR7Au4ITiTHBotcN
        byQfOMPvflYInJFLPnnd1VGnDNJtg0nTxIXhdb2eaG1FCSn3o2CzCl2mLlIlzm4X
        A7lR3qV+tqGf52rBqb/QvzQXYOjyUsfHbbXUVlfQHldrAejW8OwybFgcSxc0H9VU
        I3WSrt5G72k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61640C3CB8;
        Sun,  3 Dec 2017 17:49:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97499C3CB4;
        Sun,  3 Dec 2017 17:49:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] git-compat-util: introduce skip_to_opt_val()
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
        <xmqqk1y3ira9.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2OSsqzhyAL-QG1TOowB-xgbf=kC9wHre+FLc+0J1Xy+Q@mail.gmail.com>
Date:   Sun, 03 Dec 2017 14:48:59 -0800
In-Reply-To: <CAP8UFD2OSsqzhyAL-QG1TOowB-xgbf=kC9wHre+FLc+0J1Xy+Q@mail.gmail.com>
        (Christian Couder's message of "Sun, 3 Dec 2017 21:34:29 +0100")
Message-ID: <xmqqfu8rig10.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2764FFC2-D87C-11E7-A8D5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Anyway there is a design choice to be made. Adding a "const char
> *default" argument makes the function more generic,...

I didn't suggest anything of that sort, and I do not understand why
you are repeatedly talking about "default" that you considered and
rejected, as if it were an alternative viable option.  I agree that
"default" is not yet a good idea and it is a solution to a problem
that is not yet shown to exist.  

On the other hand, just assigning NULL to *arg when you did not see
a delimiting '=', on the other hand, is an alternative option that
is viable.

> .... I think setting
> "arg" to NULL increases the risk of crashes and makes it too easy to
> make "--key" and "--key=" behave differently which I think is not
> consistent and not intuitive.

So now this is very specific to the need of command line argument
parsing and is not a generic thing?  You cannot have your cake and
eat it too, though.

