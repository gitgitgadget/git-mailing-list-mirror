Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FEB20984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759634AbcIMQAp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:00:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753462AbcIMQAn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:00:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB3653D5E4;
        Tue, 13 Sep 2016 12:00:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YtDF02YPZcwjWGNQa+ez08BsKr0=; b=ab2WsI
        kpQrdFgSxOj76u4b8gzYLvDFn1aWpz+3Nxpx66KyANFOLgyYONbCiv2Nsta57mhP
        HJb0TApbNEOP0aiDjfiz+Ly8tJBMKmSkxoqqSBLdL5fNaehZ6lOAjU9m/nreaS41
        BPePoYrpgiNAYQPPhwN87eW69ocBpOMJlg2mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQuibKRtPLki/RB5E3inaSMh6wDd2pSM
        ZxmYbMrE9Z3AjrONSpcxjQp0WVzMeHy6IjwVUHYv4MOBT2vfjeCRsfB9Q149pVpB
        tVfzUfFGIKTDwsb1KKpuD0sXPyE5UxKphfvy6/kp1a950GMHiYpmiTl1CNMQkyA6
        qW/J0MTgBaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3EBD3D5E3;
        Tue, 13 Sep 2016 12:00:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 252723D5E0;
        Tue, 13 Sep 2016 12:00:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 00/10] Git filter protocol
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Date:   Tue, 13 Sep 2016 09:00:39 -0700
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 8 Sep 2016 20:21:22
        +0200")
Message-ID: <xmqq4m5jx00o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 385C9FD0-79CB-11E6-9E64-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The goal of this series is to avoid launching a new clean/smudge filter
> process for each file that is filtered.

I tentatively queued this in 'pu' because I wanted to see these
changes in context and also wanted to know if there are overlaps and
conflicts with other topics in flight.  As your earlier steps
renamed packet_write() to packet_write_fmt() but didn't add a new
packet_write() that has different semantics, it was pleasantly easy
to make sure there is no new caller added in the meantime (it did
conflict with Duy's shallow-deepen topic and the resolution had to
touch outside the <<< conflicted === regions >>>, but it was
otherwise trivial).

Some details of the protocol (I think Torsten has already pointed
out that not all paths can be representable with the current
incarnation; there may be other minor nits like that) may still need
to be worked out, but I think the series at this point gets the
basic code structure right and such additional fixes would not
change things too drastically (IOW, I think we are very close to
being 'next'-ready).

Thanks.

