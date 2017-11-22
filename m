Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB642036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdKVDsJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:48:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751415AbdKVDsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:48:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FBB1BB6F8;
        Tue, 21 Nov 2017 22:48:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f3/JkTJIZHafAf62ATOpncrhbbE=; b=JMmLPf
        Ic/Ed9vemZWdFjcPhzy/03tzSEoccyX99BzkjTHf3nqoVpzigR2bUXwwPobUB4iU
        oybkWeUGHKV/Jcx9C1DKObYIZTqX9z4abD7AWMpnc0ZdsbtedGqtE5bWdFpXg+Ig
        jyutPHg8EYBPjb7n53ImHd3bPNeXgAn1Cxf0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fYL9na60cgf0eRUW6Ao7ifTYcJMSl96l
        3CEz9hmMS/ZCQkbdlFptrXCMRMHe7QcqIlJF8HUEcmFmhfyY7fWaOyKStpLkaZSB
        B5MjU3YDUOm7KttC7pjGO3OBUE5aiFatHVMNG8nrr0VPNmoT6ru3v94Lc+ljCxzJ
        wwbxga5BNyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56C4EBB6F7;
        Tue, 21 Nov 2017 22:48:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B98FEBB6F6;
        Tue, 21 Nov 2017 22:48:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] Git/Packet.pm: use 'if' instead of 'unless'
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
        <20171121160939.22962-2-chriscool@tuxfamily.org>
        <20171121192440.GE3429@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 12:48:06 +0900
In-Reply-To: <20171121192440.GE3429@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 21 Nov 2017 11:24:40 -0800")
Message-ID: <xmqq1skrvurt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3CB1C70-CF37-11E7-8529-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> [...]
>> --- a/perl/Git/Packet.pm
>> +++ b/perl/Git/Packet.pm
>> @@ -68,16 +68,16 @@ sub packet_bin_read {
>>  
>>  sub remove_final_lf_or_die {
>>  	my $buf = shift;
>> -	unless ( $buf =~ s/\n$// ) {
>
> For readability, I find this whitespace within parens more distracting.

I personally find them distracting, too.  This file seems full of
them so it is OK to be consistent with the existing practice in this
step, leaving the eventual clean-up (if we agree that it is a good
idea) to a later step that does it for the entire file contents.

Thanks.
