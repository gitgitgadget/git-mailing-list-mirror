Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9F62095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdCRTeR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:34:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751785AbdCRTeR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:34:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83F5A83F84;
        Sat, 18 Mar 2017 15:27:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w7DKx6SgNqu9
        U0S/5voIYT3SBDo=; b=csWl8aslrZaHHrnW0iBItgTi/WPKEf1p/KuswF3+xSk4
        XBRgY5psjggthwzPFOYolFlEannBvrhLbaU4ypOzlhr6Py1M1bXeoSMwEGYlVmxO
        YpRt0I56tlZsBOHgwqOrQRjFojauiMU56nLg9dnSaKgl8RwYqb+vSrA/7IBRB04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dyf+7j
        OlWUpOjUeIFyAjIYEDkxFxAXOvc9mu6UbekmxXtzSa/nrYIRpHu/HX8UXZ3ksNNj
        qMlktqpa1ZcHgI+ltpLVAzIy4PGt32xPz5R0gWFVwTcSE9rd13WuaWIriwir6pRs
        ILUfMW4XDWU1Nh77PljOwraN6x88Q6MQUbiv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D1C283F83;
        Sat, 18 Mar 2017 15:27:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCF6C83F82;
        Sat, 18 Mar 2017 15:27:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 2/8] tag: Refactor the options handling code to be less bizarro
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-3-avarab@gmail.com>
        <xmqqr31u301u.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4Zs=00QXv5eaafQd8-n7OakcL3WeQh8XxiMo-9a+kAzQ@mail.gmail.com>
Date:   Sat, 18 Mar 2017 12:27:03 -0700
In-Reply-To: <CACBZZX4Zs=00QXv5eaafQd8-n7OakcL3WeQh8XxiMo-9a+kAzQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 18 Mar
 2017 20:13:12
        +0100")
Message-ID: <xmqqo9wy1j3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DE73388E-0C10-11E7-88A4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But I thought it was very a very bizarre pattern to set us to cmdmode
> =3D 'l' when we're not in that mode at all just to, as can be seen in
> the diff, get around a slightly more verbose one-time if-check.

When I wrote my response, I viewed that setting as committing to be
in the "list" mode, not as a workaround.  So checking with !cmdmode
to make sure that the command line is not asking to create a tag
makes tons of sense; the new test makes it unreadable from that
point of view.
