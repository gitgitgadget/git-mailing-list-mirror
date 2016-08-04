Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93CE20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810AbcHDQug (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:50:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757556AbcHDQug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:50:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C385131696;
	Thu,  4 Aug 2016 12:50:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0F9siwTgaPzIP1LDRpxe1ij6r6M=; b=hbFuRt
	/p56YH3Nd2OHAjSKF6mV4rIPAJBeQep3k3EdOPYj+2XQA7CkrM4d4UoOIUrRADxU
	QqLPi2HldF5M38oUtN9SKPSdGB8kn8/+PooGdm73+aTwUqn/QFA+6VEcVLP6guxy
	CTrrzviiKUTIW30KNIvoQ3NAJG+optaEsWIBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RQUZyySlSgKjVOj1RGZH0GlqTZ0El6Sr
	sQALy9MpM9eBEuIQxANpcfuzHpm9pt2BQUjVnt+EvwCWEIyZrX5l0BGtISCpOGd9
	+dNi7/8fPc9Q7R21HJDGNZPVHcdQMACOmmRarQVmo9lrFYWD4NmEQYzIpvr03KTb
	cyiUjhIRizc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB11A31695;
	Thu,  4 Aug 2016 12:50:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F41F31694;
	Thu,  4 Aug 2016 12:50:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH v11 04/13] bisect--helper: `bisect_clean_state` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
	<xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPNFohRLCS4piB1t0LO-=keucwzRKZ2Jyhhf234tnWnVGg@mail.gmail.com>
	<xmqqr3a45yi7.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPMdOawVT6W6Ko=xkMLu4PcWkd0s_GiJA-T5uu-oY2m23g@mail.gmail.com>
Date:	Thu, 04 Aug 2016 09:50:32 -0700
In-Reply-To: <CAFZEwPMdOawVT6W6Ko=xkMLu4PcWkd0s_GiJA-T5uu-oY2m23g@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 4 Aug 2016 21:37:10 +0530")
Message-ID: <xmqq1t245vhj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FCAE718-5A63-11E6-82A4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Hey Junio,
>
> On Thu, Aug 4, 2016 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>>> Also you do not seem to check the error from the function to smudge
>>>> the "result" you are returning from this function.
>>>
>>> Yes I should combine the results from every removal.
>>>
>>>> Isn't unlink_or_warn() more correct helper to use here?
>>>
>>> The shell code uses rm -f which is silent and it removes only if
>>> present.
>>
>> Isn't that what unlink_or_warn() do?  Call unlink() and happily
>> return if unlink() succeeds or errors with ENOENT (i.e. path didn't
>> exist in the first place), but otherwise reports an error (imagine:
>> EPERM).
>
> Umm, I am confused. I tried "rm -f" with a non-existing file and it
> does not show any warning or error.

You are, or you were?  I hope it is the latter, iow, you are no
longer confused and now understand why unlink_or_warn() was
suggested.

