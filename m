Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2D020899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbdHQVBN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:01:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752820AbdHQVBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:01:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3F02ACFE5;
        Thu, 17 Aug 2017 17:01:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VmmxK/o0N3T6Kh30o70Le4+rxUU=; b=sMO2n3
        7VfqJ+VzuScHGzazX6rxZ/6rUcF872KYBUoSAVMLBmAJ0ph7h+Ir5gdX13CRu31h
        QFhxyUqg8MQf2wkvIPsEgnD9ejFAGKBsOE0IfcWRrLy49bDbl2omHfIc3nsMu47B
        H1frCzN6je0gfJmak3BjpKpBMLGZJZcRHJM3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s+ZxTm5HkqIsNwLsE1cFpTq5jwbcJdpY
        nQdA/wSYTe67HcDKOLsAw1tSXQD5H9fTWxfCAXo2gozuOncGln+CUwYgO6aOf317
        NnLy1MQpwdfrfFWupu2DOFQB21F8N2hZrGTDdDEtjhgZQaRwpuoVBkrZYxyWW3zG
        tj6AGSXLTAA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9FB7ACFE4;
        Thu, 17 Aug 2017 17:01:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFF91ACFE1;
        Thu, 17 Aug 2017 17:01:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
        <20170815111725.5d009b66@twelve2.svl.corp.google.com>
        <20170816002257.GG13924@aiede.mtv.corp.google.com>
        <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com>
        <xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1H4Pb5e2_pioQ5neROc+64e55RfvRhiyz5Df5AwJg-FQ@mail.gmail.com>
Date:   Thu, 17 Aug 2017 14:01:03 -0700
In-Reply-To: <CAP8UFD1H4Pb5e2_pioQ5neROc+64e55RfvRhiyz5Df5AwJg-FQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 17 Aug 2017 07:34:49 +0200")
Message-ID: <xmqqbmndgb8w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F07A0C8-838F-11E7-ADFF-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> ... but I think we should then emphasize more in our test
> scripts (maybe by giving a good example) and perhaps also in the doc
> that the filters/sub-processes should really pay attention and not
> output any capability that are not supported by Git.

Oh, absolutely.  If you know there is such a breakage in our test
script, please do fix it.

Thanks.
