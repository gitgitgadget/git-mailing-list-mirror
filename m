Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E396C32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001E92075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ravtleTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAGBfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:35:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65247 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAGBfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 20:35:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD62690A2A;
        Mon,  6 Jan 2020 20:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bpHCVwUYLGH3IUyavzuGrbu0IOE=; b=ravtle
        TsVmtdXeA0KFf/KknTqmTYu3Kb7zEQnGS/t9uUWU9McSBDyyxL3KZ/M/E95fsRuh
        sAT5U3UdRmW0zoDNmRFsrnB7qAk+8gXHxBGJio0mOVK5vBwB9RCR+OyngBFp3Xx/
        lAOq5/5QkyALyk8b6CYeWqKd00gqR3FO09KSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rdMQeZGPPGu0DnGpDLVlv9AlGTMYj1Qn
        mCwu6PDjKyijTLDcFou3Kmkt1O95Haw+cAVvtCOsxhhr7C6YKDOriDsOWcK78Ty0
        st83cyZexfF+2sBPRimX508oE5Twa9/cTvLo0e9NDkcqretPeI8r3SknqNjTN0fA
        U1yhDVUL0Uo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C526E90A29;
        Mon,  6 Jan 2020 20:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECB1F90A26;
        Mon,  6 Jan 2020 20:34:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bisect run: allow '--' as an options terminator
References: <20200104034551.23658-1-stevie@qrpff.net>
        <xmqq1rsfddkq.fsf@gitster-ct.c.googlers.com>
        <CAD_xR9faremhsGP4G65vHj=cvskUbK1rpPrQisa2_4AD2AGNYw@mail.gmail.com>
Date:   Mon, 06 Jan 2020 17:34:53 -0800
In-Reply-To: <CAD_xR9faremhsGP4G65vHj=cvskUbK1rpPrQisa2_4AD2AGNYw@mail.gmail.com>
        (Stephen Oberholtzer's message of "Mon, 6 Jan 2020 18:29:35 -0500")
Message-ID: <xmqqtv586oci.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8D4AA74-30ED-11EA-97BC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Oberholtzer <stevie@qrpff.net> writes:

>> I do not think I have seen enough to justify addition of "--",
>
> That's fine; I was just trying to be thorough (also, it was easy to
> test.) I was taught: if you accept any -options, honor -- as well. If
> you're not concerned about that, that's fine with me.

Ahh, that indeed is the crucial piece of information that was
missing.  My review was about "Do we really *need* it?", but if you
are doing so from following a rule/dogma/principle, that changes the
equation quite a bit.

I do not think this project officially subscribes to the "anywhere
-option is taken should accept '--' as the end of options marker"
school, but because most modern command line processors use
parse_options() API which gets "--" for free, we can consider
ourselves practically accepting it already.  

And adopting such a rule/dogma/principle frees us from having to
think about each individual case and helps us being consistent, so
it is not necessarily a bad thing as long as the cost of following
the rule/dogma/principle is not too onerous.  At that point, what
needs to be reviewed instead becomes to "does this new code follow
the rule, and is it not bending backwards to do so?"

So, I do not have strong objection against "bisect run -- <cmd>".
It was, as I said in the original review, that it was so unclear
why double-dash is a logical consequence of accepting options,
because it was left unsaid.  It would have been an easy sell if
this were a part of a patch that actually adds new option(s) and
explained perhaps like so:

	Teach 'bisect run' to take --foo and --bar options, that
	tell the command to do Foo and Bar.  While at it, teach it
	the common convention that "--" is used to terminate the
	list of options.  Nobody sane may try to use <cmd> that
	begins with a dash, but supporting "--" everywhere we accept
	a dashed option is good for consistency.

Thanks.

