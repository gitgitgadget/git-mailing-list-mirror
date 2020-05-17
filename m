Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD96C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AABA20671
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pq44GhXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEQPHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:07:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64340 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgEQPHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:07:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13C41DBB74;
        Sun, 17 May 2020 11:07:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tEsN8+ParrLKT8m4DnW1O/7Ov7Q=; b=pq44Gh
        XoX0txdDePn4knqjnbBEyekkKVJ6HwfSxtORr6/nDYOssvsqVP9rWy8d7uIuAaFz
        EA4Ma86P9oN5wSN79jZDcQkExdQaYWPsbfgpEQ3QGu56mwIOEA1ZU6WCmVDTcdOg
        YiZoVeJNMv0fwQgIa3WL5T145E1MgMJYsUEis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rPCTrfz78HAq+vwt87RSNNJlv11eWoOl
        bMb7C782Lut4NKeVYTVVKF0yuEeoVEdVWEblDcjaJyhSQpbtpKDkl1lPned/Y4A+
        Q2JSAxe9kD2bnlctD46f6OHZMefwdQkrGlAFGs/1j7tmqkJFbzI0YfGkm/CaqPCL
        Cpj1eDUhdrU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AED9DBB73;
        Sun, 17 May 2020 11:07:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 96CCDDBB72;
        Sun, 17 May 2020 11:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] diff: add config option relative
References: <20200515155706.GA1165062@spk-laptop>
        <20200515233130.GC6362@camp.crustytoothpaste.net>
        <xmqq1rnk923o.fsf@gitster.c.googlers.com>
        <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
Date:   Sun, 17 May 2020 08:07:41 -0700
In-Reply-To: <92cb6302-09a8-6780-9398-890b1e766680@gmail.com> (Phillip Wood's
        message of "Sat, 16 May 2020 19:33:42 +0100")
Message-ID: <xmqqpnb27g76.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28BA3B08-9850-11EA-ACFA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -5494,6 +5501,9 @@ static void prep_parse_options(struct diff_options *options)
>>   			       N_("when run from subdir, exclude changes outside and show relative paths"),
>>   			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
>>   			       diff_opt_relative),
>> +		OPT_SET_INT_F(0, "no-relative", &options->flags.relative_name,
>> +			      N_("disable diff.relative config option"),
>> +			      0, PARSE_OPT_NONEG),
>
> Rather than adding a new option, it would be better to modify the
> existing --relative option. If you remove PARSE_OPT_NONEG from the
> declaration above it will support --no-relative. You will also need to
> modify diff_opt_relative() to handle clearing the option.

Excellent.
