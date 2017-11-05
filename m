Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2854820562
	for <e@80x24.org>; Sun,  5 Nov 2017 02:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdKECDX (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 22:03:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63163 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751508AbdKECDW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 22:03:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A38499F055;
        Sat,  4 Nov 2017 22:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EvBamwcdqHAkqgyhJRsF2foiCLw=; b=rreDlz
        Ayz+3eCzswJUkuF51wOrcF4v1lfiT4yk7WpiA5STR+eUG8RXV9S7YJPY03XPn1dP
        QVBot5f8wesAtdYbzN7UTqDlL871dMI5ZkOG/lJ2+QeMOSsN5DWBZDFVNeidYjTQ
        TtlAs6byrG6m9DFxQ688MQiYEsKKjomqCDT3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kq3+Dk8KMr+WFHZroHAsgUUn/A7vkUY+
        XQ/VVz96Y484roxO4I15CRzSfg0GLoRYwHDf4h6txm1anBET8lXLnU9KZ2X5wKBc
        bd00PyzOkdY61tus+RCbXbCB70UyGc5KddLmaA7bxK2jJiCSwm/u10HVNM9T98pj
        3HhuiC2CpdI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9919D9F054;
        Sat,  4 Nov 2017 22:03:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0820E9F053;
        Sat,  4 Nov 2017 22:03:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/6] t0021/rot13-filter: add capability functions
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <20171019123030.17338-6-chriscool@tuxfamily.org>
        <xmqqefpwdkf9.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0MppGwD5iXNjs8y+qxpFGc2NbYE9gcqe2pmJWAt6CZfg@mail.gmail.com>
Date:   Sun, 05 Nov 2017 11:03:20 +0900
In-Reply-To: <CAP8UFD0MppGwD5iXNjs8y+qxpFGc2NbYE9gcqe2pmJWAt6CZfg@mail.gmail.com>
        (Christian Couder's message of "Sat, 4 Nov 2017 09:38:58 +0100")
Message-ID: <xmqqwp35lbx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F96C632-C1CD-11E7-9C97-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>>> +             my ( $res, $buf ) = packet_bin_read();
>>> +             return ( $res, @cap ) if ( $res != 0 );
>>
>> The original had the same "'list eq list' does not do what you may
>> think it does" issue.  This one corrects it, which is good.
>>
>> I am not sure if ($res != 0) is correct though.  What should happen
>> when you get an unexpected EOF at this point?  The original would
>> have died; this ignores and continues.
>
> Well if there is an unexpected EOF, then packet_bin_read() returns
> (-1, ""), so packet_read_capabilities() returns (-1, @cap) where @cap
> contains the capabilities already received. Then
> packet_read_and_check_capabilities() checks that we received all the
> capabilities we expect and dies if that is not the case. If we did
> receive all the capabilities, then
> packet_read_and_check_capabilities() still returns -1, so the caller
> may check that and die.

In other words, it happens, by accident, to stop before going very
far.  I think we'd be better off making it an explicitly checked
error.

> But yeah we could also just die in packet_read_capabilities() if $res
> is -1. I will make this change.

Good.

Thanks.
