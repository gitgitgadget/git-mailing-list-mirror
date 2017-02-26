Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436372022D
	for <e@80x24.org>; Sun, 26 Feb 2017 20:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdBZUpv (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 15:45:51 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:50350 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdBZUpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 15:45:50 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id A88E1C561;
        Sun, 26 Feb 2017 21:45:46 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id A304910031B;
        Sun, 26 Feb 2017 21:45:46 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 8E31D125EAE;
        Sun, 26 Feb 2017 21:45:46 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Hovold <johan@kernel.org>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: only allow one address per body tag
References: <xmqqbmu0pgg6.fsf@gitster.mtv.corp.google.com>
        <20170220114406.19436-1-johan@kernel.org>
        <vpqo9xxkqqo.fsf@anie.imag.fr>
        <xmqqfuj491sc.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 26 Feb 2017 21:45:46 +0100
In-Reply-To: <xmqqfuj491sc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 23 Feb 2017 10:53:39 -0800")
Message-ID: <vpq60jwr891.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Johan Hovold <johan@kernel.org> writes:
>>
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -1563,7 +1563,7 @@ foreach my $t (@files) {
>>>  	# Now parse the message body
>>>  	while(<$fh>) {
>>>  		$message .=  $_;
>>> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
>>> +		if (/^(Signed-off-by|Cc): ([^>]*>?)/i) {
>>
>> I think this is acceptable, but this doesn't work with trailers like
>>
>> Cc: "Some > Body" <Some.Body@example.com>
>>
>> A proper management of this kind of weird address should be doable by
>> reusing the regexp parsing "..." in parse_mailbox:
>>
>> 	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
>>
>> So the final regex would look like
>>
>> if (/^(Signed-off-by|Cc): (([^>]*|"(?:[^\"\\]|\\.)*")>?)/i) {
>>
>> I don't think that should block the patch inclusion, but it may be worth
>> considering.
>>
>> Anyway, thanks for the patch!
>
> Somehow this fell off the radar.  So your reviewed-by: and then
> we'll cook this in 'next' for a while?

OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
