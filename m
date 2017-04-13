Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028211FA14
	for <e@80x24.org>; Thu, 13 Apr 2017 06:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756017AbdDMGJj (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 02:09:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751400AbdDMGJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 02:09:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EBE6818E5;
        Thu, 13 Apr 2017 02:09:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OxgzzIeuDyqYsw7S5HZNSfke1Ck=; b=PCjojj
        Jl0ypt/8qwc9Ic8WVFR5I3xVGkv2OuvVaJYZEm/beMA4R/aLYLfNim3zLJRja7Oh
        jAvSFq/7cv8iXfM4rsEh1I4PlGiTxTZqM1vZ6zs348ONRHKXXXImvjzIp1/IUK4o
        6wT5q7yiXxpuMm+tq7VZ1PbxlIEOeZyBOb8po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lzqmfw91LuwnLx2Rzebr+/Lf8S1ZRxe3
        QeW5Cl/X6z5dMHRHDIaWpL8tx9HPwvqf3GbFg6BpZo+my3JnYfE0pVBIeJcAkV4K
        AQDBDnPTT/rh6ZBUbAeUOP2LOPZobwGeBwmqJKpzayY76SBe5VwX33JgRG+Xe6Aj
        qhcwQpS8QHM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26997818E4;
        Thu, 13 Apr 2017 02:09:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90909818E3;
        Thu, 13 Apr 2017 02:09:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] status: show in-progress info for short status
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
        <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xr37owZbCnwVKh0y_vUny9_pP380Y8sFA+7A-hv0Oc6AA@mail.gmail.com>
Date:   Wed, 12 Apr 2017 23:09:32 -0700
In-Reply-To: <CA+P7+xr37owZbCnwVKh0y_vUny9_pP380Y8sFA+7A-hv0Oc6AA@mail.gmail.com>
        (Jacob Keller's message of "Fri, 7 Apr 2017 09:18:01 -0700")
Message-ID: <xmqqmvbkq1nn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C39610F0-200F-11E7-ABD9-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Personally, I would want this to become the default and not have a new
> option to trigger it. I think we could also extend the porcelain
> format to include this information as well, but I'm not too familiar
> with how the v2 format extends or not.

I think the general rule of thumb for --porcelain is that we can
freely introduce new record types without version bump, and expect
the reading scripts to ignore unrecognised records (we may need to
describe this a bit more strongly in our document, though), while
changes to the format of existing records must require a command
line option that cannot be turned on by default with configuration
(or a version bump, if you want to change the output format by
default).

I am getting the impression that this "we are doing X" is a new and
discinct record type that existing readers can safely ignore?  If
that is the case, it may be better to add it without making it
optional.
