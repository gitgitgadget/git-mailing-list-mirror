Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1572202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 06:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdKVG2a (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 01:28:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58415 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751216AbdKVG23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 01:28:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FAA9BD381;
        Wed, 22 Nov 2017 01:28:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bfkeKaDsfrwl8mbi/Cpyxg++CsE=; b=EwGjl5
        xBpKpwo3SRK8fly+SZtUdnJ5Mnwh2A4FXQU9JLCNXu5dEkj2Vw8HsSfvky7vlsPT
        Uy/q7V9P49vZMvkBA8/EppNx3b/n5T5TECD0luRMeAkwe770laY/fMCcig9P5qLC
        NdKaFAuYp6MxQttQ0IdKJoeFFiQlNcIRds7V8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CfOcjnoONWaW0nRqkeTlZvifEPvltklh
        qyOqdw2ntQQ2DxH23js9stzoZzjI7FzA6HolJJRT+p55Rz1m/SJGOjC3ndNQh0CD
        1+yPdP5fT9yIODMnQLidDZaa+DAHNwgbvx7wbdC68+7xb4Yq5HjKIUtTUTCHfSBx
        BSdMjIbYEZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 356A2BD380;
        Wed, 22 Nov 2017 01:28:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A4C6BD37F;
        Wed, 22 Nov 2017 01:28:28 -0500 (EST)
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
Subject: Re: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
        <20171121191900.GD3429@aiede.mtv.corp.google.com>
        <xmqq60a3vv63.fsf@gitster.mtv.corp.google.com>
        <20171122051014.GA7625@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 15:28:27 +0900
In-Reply-To: <20171122051014.GA7625@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 21 Nov 2017 21:10:14 -0800")
Message-ID: <xmqqfu96u8s4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A34C7FC-CF4E-11E7-A41F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>> This comment doesn't tell me how to use the function.  How do I detect
>>> whether it successfully read a line?  What do the return values
>>> represent?  What happens if the line it read doesn't match the key?
>>
>> Would this work for both of you?
>>
>> # Read a text packet, expecting that it is in the form "key=value" for
>> # the given $key.  An EOF does not trigger any error and is reported
>> # back to the caller (like packet_txt_read() does).  Die if the "key"
>> # part of "key=value" does not match the given $key, or the value part
>> # is empty.
>
> Yes, thank you.

Heh.  I actually was expecting a different response: "that describes
what the reader can easily read out of the implementation and is
useless", though.
