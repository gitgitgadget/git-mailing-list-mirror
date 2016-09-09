Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521601F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbcIIUvJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:51:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59338 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751120AbcIIUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:51:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B10803D7F7;
        Fri,  9 Sep 2016 16:51:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dg65+0cADA4YvGakK6zjnAK5KvI=; b=mrtREO
        J8yt7kzKaC/t5IkW2laqbzUyKf2yFBc7b21Bnyw1wVquMHMBxhK1nl5QL4eXqSqC
        tkOmnRaNOz7zlXmKVe3KGFLlCgdj33PhWnxyyQaRw69g+NUWT/v3XhZwfZbZ9ay7
        4roqV8Pj/lSzbw0Jek71QoNOE6BKAAcWC/mvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eAk3Bb2U7PVkvOEmfaITqTfJ21uCCFkH
        mOHPWJTHrq5vizEuJj7QwRdmtdadpw8lZUHUyT6JEGKDG3ggUU7L2c2Vifg4peiO
        RSnuK5R1d4j8pY+C+5bVJG8hQpnePxKzuetd4VWX1625mIAGEFnEOmlGGpkbRKJ5
        LnCL4a1X6h0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9E4D3D7F6;
        Fri,  9 Sep 2016 16:51:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FE6D3D7F5;
        Fri,  9 Sep 2016 16:51:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
        <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
        <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
        <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
        <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
        <20160909200721.xfkbud377ja4wkrt@x>
Date:   Fri, 09 Sep 2016 13:51:04 -0700
In-Reply-To: <20160909200721.xfkbud377ja4wkrt@x> (Josh Triplett's message of
        "Fri, 9 Sep 2016 13:07:21 -0700")
Message-ID: <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20D852E0-76CF-11E6-A17B-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> On Fri, Sep 09, 2016 at 12:41:56PM -0700, Junio C Hamano wrote:
>> So here is a suggested replacement.  I notice that in the MIME case,
>> we do not leave any blank line between the last line of the patch
>> and the baseinfo, which makes it look a bit strange, e.g. output of
>> "format-patch --attach=mimemime -1" may end like this:
>> 
>>     +       test_write_lines 1 2 >expect &&
>>     +       test_cmp expect actual
>>     +'
>>     +
>>      test_expect_success 'format-patch --pretty=mboxrd' '
>>             sp=" " &&
>>             cat >msg <<-INPUT_END &&
>>     base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
>> 
>>     --------------mimemime--
>> 
>> We may want to tweak it a bit further.
>>  ...
>
> Looks good to me.

Thanks.

Do you mean that the base information that appears immediately after
the patch text (either for MIME case or plain-text) does not bother
you, though?
