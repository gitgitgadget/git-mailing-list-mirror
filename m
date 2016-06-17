Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3BF1F744
	for <e@80x24.org>; Fri, 17 Jun 2016 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbcFQJUb (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 05:20:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41363 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754453AbcFQJUM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 05:20:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 4A7682032A;
	Fri, 17 Jun 2016 05:20:11 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Jun 2016 05:20:11 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=zNjcD4EdTsQbs1LOYXP5jYI4HYA=; b=jdg9H1
	s9zmEizzs5/M9XKPuZEaUF876NVKgsfDIzoKJQZMQ/uwee+BEtvkPxIP638qQWTB
	8+dIQjqhNZ19c+vv7NTH9Fy3RI7AxOg5giCNdcGTtohHvKYCwuzmNUbCnKkcxpZ1
	r/JOOrIjwt5deHPh0VUJEQyZIwBmNkZ06mP0Y=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=zNjcD4EdTsQbs1L
	OYXP5jYI4HYA=; b=MF2BluAIqZKtvRZjYyO8O6ertLcZ2Zmd60Jqt1TGk2wsLgh
	sZx4b9Ufj6RIRaImwA8zqs0lSx+zWuJVByKdbNI0qs6Bagxm0kV0V0U48HVIlVLL
	pkZgzasI4KgRoiLsOcHcTeXFT6ctT+khVrL9oFehbYEXzIAQmTkNc6a9ciRg=
X-Sasl-enc: KesFq6ZA4OHhWbnY2dSak69jbJxZwgs9l4qhZyOwyp5K 1466155210
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 98452CCDB0;
	Fri, 17 Jun 2016 05:20:10 -0400 (EDT)
Subject: Re: [PATCH 0/7] gpg-interface cleanups
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
 <xmqqy4653si6.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <11a07248-ddf5-1424-2197-ca3ed117e200@drmicha.warpmail.net>
Date:	Fri, 17 Jun 2016 11:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqy4653si6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 16.06.2016 20:20:
> Jeff King <peff@peff.net> writes:
> 
>> This started off with Michael's patch to sign_buffer, which is at the
>> tip, and then me trying to address the possible deadlocks there and in
>> verify_signed_buffer. While I was in the area, I took the opportunity to
>> do a few cleanups.
>>
>> It's unclear to me whether the deadlocks are possible in practice; see
>> patch 5 for discussion.
> 
> I do recall thinking about the verification side and coming up with
> the same conclusion as yours when we queued that code (i.e. they
> need to read the whole thing before checking).
> 
>> My guess is probably not, but the amount of code
>> to support doing it right is not all that much. But if we don't like it,
>> we can drop 4-6.
> 
> Let's keep all of them; they all looked reasonable.
> 
>> Patch 7 is still authored by Michael, but has been massaged greatly by
>> me. I'll comment more directly on the changes there.
>>
>>   [1/7]: gpg-interface: use child_process.args
>>   [2/7]: verify_signed_buffer: drop pbuf variable
>>   [3/7]: verify_signed_buffer: use tempfile object
>>   [4/7]: run-command: add pipe_command helper
>>   [5/7]: verify_signed_buffer: use pipe_command
>>   [6/7]: sign_buffer: use pipe_command
>>   [7/7]: gpg-interface: check gpg signature creation status
> 
> Thanks.

Thanks, too. I approve of and enjoyed all of Jeff's massaging.

(With tests, I'm always unsure whether to follow surrounding style or
the style guide; I did the former, Jeff improved the config handling by
doing the latter.)

Michael

