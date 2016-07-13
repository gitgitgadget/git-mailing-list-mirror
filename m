Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EF22018F
	for <e@80x24.org>; Wed, 13 Jul 2016 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbcGMWlI (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 18:41:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751475AbcGMWlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 18:41:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECFA12D4F4;
	Wed, 13 Jul 2016 18:41:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rbh883FqPUgNiO4b5DOdbfVpft4=; b=dYe//V
	m8TJYEkVzso+iGgHnHPViP7SFtMe7cDxzHZPJ+80Iarkq+Zsbaz7NPg6gVKdEkRp
	PjAO9vtVDUkEHYku0SQJLHqJiWZZ8A9Y94oWBGQXqZFEQByZa+YLrYHuo9w5lbil
	hCPVbxvYR2roqDtK8+kWXyFAeq8B0j+FcYECU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0aNvETEl7wAj2XkpYaiYLoL+lfa/96T
	+Nj4UNbPAExlaBykevvbYpWtmhbCsi8fI9Ifr1WNWkrlX+T1BaDrmHctpQ+PswZL
	1p31X4cxqrDUuq2VRkp2WYG9nGl+WkW8oes8jdK9RLglzx9RDTUyiyv4ZXYF7f5v
	jNJs/Fq4V0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4BE02D4F3;
	Wed, 13 Jul 2016 18:41:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FF9C2D4F2;
	Wed, 13 Jul 2016 18:41:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
	<xmqqpoqh1m0o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYUMX7wewo2QEWQGU9sGR76XjrKJ3uJxpLnyWoZeZ6WXA@mail.gmail.com>
Date:	Wed, 13 Jul 2016 15:41:01 -0700
In-Reply-To: <CAGZ79kYUMX7wewo2QEWQGU9sGR76XjrKJ3uJxpLnyWoZeZ6WXA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Jul 2016 10:52:59 -0700")
Message-ID: <xmqqinw9yxdu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E115160E-494A-11E6-8045-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> I think Shawns proposal to have a receive.maxCommandBytes is a
>>> good way for an overall upper bound, but how does it stop us from
>>> going forward with this series?
>>
>> If we were to do maxcommandbytes, then max_options would become
>> irrelevant, no?
>
> Maybe?
>
> I do not know what kind of safety measures we want in place here, and
> if we want to go for overlapping things?
>
> Currently there are none at all in your upstream code, although you cannot
> push arbitrary large things to either Shawns or Peffs $Dayjob servers, so
> I wonder if we want to either agree on one format or on many overlapping
> things, as some different hosts may perceive different things as DoS threats,
> so they can fine tune as they want?

I think those extra knobs can come later.  If we are not going to
limit with max_options in the end, however, wouldn't it be more
natural for the initial iteration without any configuration not to
have hard-coded max_options at all?

As to the "SQUASH???" compilation fix, I can squash it to the one
immediately below it locally; I didn't do so in today's pushout, as
it was still unclear if you are already working on a reroll (in
which case anything I would do would be a wasted effort).


