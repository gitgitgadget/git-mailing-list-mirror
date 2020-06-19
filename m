Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E3C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FBA20707
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5lpHTcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbgFSTah (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:30:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64643 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbgFSTaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17C6D62FB3;
        Fri, 19 Jun 2020 15:30:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Z0xHmNjMXhoWXAfVXJSATB6uGY=; b=i5lpHT
        cPO8uM9oA0bPDrIaCzbyXmEX2YKYDHoguSKEBj81j+sMSUrurN1LMe0SpYxx9+5+
        8A8qtvGIr3DtG/bOoS6R6A2HadJSGJAQCcBXirLPd4yYiMdOcryUelksEFb3qKcI
        /cgNQGI6F027LvF8XPn61vUsazY8qSW0Sja5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QrADGBlKTNZBrp8En+E99gnmy8+bKhEo
        oMtsoDRuB3ax0tdLefvVTwq5iPAnkDQHOJu1lxuSzRIEEfKmxKtJSK+eQ/EU8I0E
        lt1wRk7N7kr7fRdwZni66LitlPcWKz0VDS/ThJ+PJnmMr0+3ZDsHWFR7HqgeKjCK
        o6b72C7QJ1U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E56A62FB2;
        Fri, 19 Jun 2020 15:30:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87C8062FB1;
        Fri, 19 Jun 2020 15:30:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh' 
        <congdanhqx@gmail.com>, <randall.s.becker@rogers.com>,
        <git@vger.kernel.org>
Subject: Re: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with write_in_full
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
        <20200619150445.4380-2-randall.s.becker@rogers.com>
        <20200619163530.GB5027@danh.dev>
        <02a501d6465d$80366680$80a33380$@nexbridge.com>
Date:   Fri, 19 Jun 2020 12:30:31 -0700
In-Reply-To: <02a501d6465d$80366680$80a33380$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 19 Jun 2020 13:17:19 -0400")
Message-ID: <xmqqimfmhmzs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57616210-B263-11EA-A754-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> > +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
>> > +		die(_("couldn't write report contents '%s' to file '%s'"),
>> > +			buffer.buf, report_path.buf);
>> 
>> Doesn't this dump the whole report to the stderr?
>> If it's the case, the error would be very hard to grasp.
>
> Where else can we put the error? By this point, we're likely out of disk or virtual memory.
>
>> Nit: We wouldn't want the pair of {}.
>> 
>> > +	}
>> >  	close(report);
>
> I'm not sure what you mean in this nit? {} are balanced. You mean in the error message?

I think he means that a block that consists of a single statement
(i.e. call to die()) does not have to be enclosed in {}.

(partial quote from Documentation/CodingGuidelines):

 - We avoid using braces unnecessarily.  I.e.

	if (bla) {
		x = 1;
	}

   is frowned upon. But there are a few exceptions:
