Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE02D20259
	for <e@80x24.org>; Wed, 23 Nov 2016 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755336AbcKWQv2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 11:51:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755316AbcKWQvY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 11:51:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9DD051937;
        Wed, 23 Nov 2016 11:51:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NxGJMMwr6ErmfJcWb6M3DgFtHr8=; b=xIDh33
        tS87QM8NbRCQPDhPS5UWvPyiq7Vvl244mUzWkY6v//wemrt4tfyaIACq0uzK+DZO
        0johVGcgysVKZLYtEaNtwSQCgQhAbiuSPltz2Q8YVRy9zLxnATf9LcAUUTD/Qzsk
        Wd0Jmc1SXUP13+33z0H0eAftMaZq81gdpFDJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aX48FO1Q0BmmQp7UBqLwQ7CmMoz1QVWx
        5GcoJC5tstso8OdgOa8vpcVcaTTiiLBWAghkS3uDppZ5exXOzyC4GlMTyIgk0aoC
        zjR4bjkAgCpZPDvEdWAnVtj1QD4mCnqOKos7G8DUz7Qn2TGF9PQiSIBNwH2geQP5
        RY29CikYmKs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A23A151935;
        Wed, 23 Nov 2016 11:51:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 233B051934;
        Wed, 23 Nov 2016 11:51:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] push: fix --dry-run to not push submodules
References: <1479172735-698-1-git-send-email-bmwill@google.com>
        <1479408364-150268-1-git-send-email-bmwill@google.com>
        <1479408364-150268-3-git-send-email-bmwill@google.com>
        <CAGZ79kY1x1HWJFjiyFdMFh8S_Y1F0ecLB5-JPb+nPE0gujfF-A@mail.gmail.com>
        <20161117190255.GK66382@google.com>
        <xmqqk2bvquk1.fsf@gitster.mtv.corp.google.com>
        <20161122181839.GF149321@google.com>
Date:   Wed, 23 Nov 2016 08:51:21 -0800
In-Reply-To: <20161122181839.GF149321@google.com> (Brandon Williams's message
        of "Tue, 22 Nov 2016 10:18:39 -0800")
Message-ID: <xmqqfuminnqu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10DBCC1A-B19D-11E6-8ABE-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 11/22, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> > On 11/17, Stefan Beller wrote:
>> >> On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:
>> >> 
>> >> >                                 sha1_array_clear(&commits);
>> >> > -                               die("Failed to push all needed submodules!");
>> >> > +                               die ("Failed to push all needed submodules!");
>> >> 
>> >> huh? Is this a whitespace change?
>> >
>> > That's odd...I didn't mean to add that lone space.
>> 
>> Is that the only glitch in this round?  IOW, is the series OK to be
>> picked up as long as I treak this out while queuing?
>
> It looks that way.  And I did fix this in my local series.  Let me know
> if you would rather I resend the series. Otherwise I think it looks
> good.

OK, queued with trivial fix for now.

Thanks.
