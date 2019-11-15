Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF331F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKOLX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:23:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56496 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKOLX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:23:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 172BD1A8AE;
        Fri, 15 Nov 2019 06:23:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vyqE5QGFhTg6KIJhJLMSa0z5E60=; b=KawoEI
        ccSvzYk76JbdmO5cBjigFLtIUFacgyjV5nETvI/40G2cdu4yP1q1/oLkpIuUgxUM
        7PqYtWx5hsnBvAzjPydjjgc/+7Z901pHqsFh4z6UFWE5WmwL+bMQ4OQMsS01SuDk
        f37LIur+6oqQ7KPp0tbTFCV2Plsrkydhm0KFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vr4XqWDlE+HexP7t97+ZANK4o2xlCymh
        xw9Mvs1w6V84qio/k1KEkOY4g8w0DQjzdBB4lGUOU6BQ9mlYbYa31uwBqJyPlfnv
        X71kQg0xcgbkW2kwiae042aqAKNVED8c3C+XmJc9zztsNfCEcBX4fgQtKFmxNY5k
        g45V6KiCiIM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EE9A1A8AD;
        Fri, 15 Nov 2019 06:23:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79A791A8AC;
        Fri, 15 Nov 2019 06:23:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
        <20191114055906.GA10643@sigill.intra.peff.net>
        <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
        <xmqqa78x918e.fsf@gitster-ct.c.googlers.com>
        <20191115081614.GA27149@sigill.intra.peff.net>
Date:   Fri, 15 Nov 2019 20:23:52 +0900
In-Reply-To: <20191115081614.GA27149@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 15 Nov 2019 03:16:14 -0500")
Message-ID: <xmqq4kz57587.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67BF069A-079A-11EA-AA5E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 15, 2019 at 02:07:13PM +0900, Junio C Hamano wrote:
>
>> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
>> 
>> > Just out of curiosity: Is there a use case for inspecting non-commit
>> > objects with git log?
>> 
>> I do not think there is (rev-list is a different story, given that
>> you can pass --objects), and it probably is not too difficult to
>> teach "git log" and friends that they only want commit-ish.
>
> I think you already did; see my other reply. ;)

Heh, indeed I did.  I just did not recall.

