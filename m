Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1BD1F424
	for <e@80x24.org>; Wed, 18 Apr 2018 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDRHiU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 03:38:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33982 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeDRHiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 03:38:18 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5A9EF5C1224;
        Wed, 18 Apr 2018 09:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1524037094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAXwDGxsie8PKv/mmFifZMyo1mEUF3vQN3mPoWaulqw=;
        b=WVdo9RJ0xIMx7RfFAw0Up0S6pXXTDJbXVoGGWywPx7pDrmLW/hyooloJ7/m6EKFiaMnUHg
        An7hz7XlDYkZ6VsjkIoo2oO+fEmRU5tok/RMQT6Ch6T+H1e7TByTSxpRwEEtzjuQAl4f9e
        5RaGxq3rhMGeuG7QO7ULrthSn3tRK70=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Apr 2018 09:38:13 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: avoid duplicate In-Reply-To/References
In-Reply-To: <20180418005415.GA31588@dcvr>
References: <20180417211630.22873-1-stefan@agner.ch>
 <20180418005415.GA31588@dcvr>
Message-ID: <d218005b0c44b7f8a61c82d060352eee@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.04.2018 02:54, Eric Wong wrote:
> Stefan Agner <stefan@agner.ch> wrote:
>> This addresses the issue reported here:
>> https://public-inbox.org/git/997160314bbafb3088a401f1c09ccb08@agner.ch/
> 
> Thanks for bringing this up.
> 
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1642,10 +1642,15 @@ foreach my $t (@files) {
>>  			elsif (/^Content-Transfer-Encoding: (.*)/i) {
>>  				$xfer_encoding = $1 if not defined $xfer_encoding;
>>  			}
>> +			elsif (/^In-Reply-To: (.*)/i) {
>> +				$in_reply_to = $1;
>> +			}
>> +			elsif (/^References: (.*)/i) {
>> +				$references = $1;
>> +			}
> 
> References: can span multiple lines with --thread=deep in format-patch
> (technically any header can be, but References: is common)

I think that is ok because we do
# First unfold multiline header fields

...

A quick test with 3 patches in --thread=deep mode looks good:
In-Reply-To:
<87d48c04aae0594ebea7567827d08979ad346380.1524034203.git.stefan@agner.ch>
References:
<06ea66574abfb2dd66adee9996e5fb66903b95a3.1524034203.git.stefan@agner.ch>
<87d48c04aae0594ebea7567827d08979ad346380.1524034203.git.stefan@agner.ch>

--
Stefan
