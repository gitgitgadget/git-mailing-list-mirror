Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8D420193
	for <e@80x24.org>; Thu,  1 Sep 2016 22:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbcIAW7I (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:59:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57611 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753847AbcIAW7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:59:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63ECB3A630;
        Thu,  1 Sep 2016 18:59:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E63kaRRbDa2e
        hM2aS2PPc3+LYDY=; b=D/MNms47Vkh2DmG17sWyMewN3y4mM/mieSoK58E7cE/1
        TgqoIV4gmKFowe7aiqDIyevAD15cXG/on2hh+nnxbe0OcEVQHMht1XG4pMHjVNj7
        A6fRl+JnQYtobFj37mVFrbAQf/AdW1q6bo3yjHulODhjzDA2wI/ZIgT1M1KbGJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bBI/YA
        qWwvOSVODvOvtN7W7j9OUGfM8vD82GpRtT8aUsW70DBc1PzXAnlO2kiWhwQbmjD1
        fcIsKPtttAlwBgBJBDiIryqJDKNWXYXMCt6lVqoshHrqxJ+/O4lfjkQ7oLxzriHA
        BEUkbF51deMBwvlENDTuHqlrhoi42gbFulsgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BB613A62F;
        Thu,  1 Sep 2016 18:59:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D64C83A62E;
        Thu,  1 Sep 2016 18:59:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the todo file
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
        <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
        <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609011052260.129229@virtualbox>
        <63004be3-04de-00c5-a94d-1b600201bc6f@gmail.com>
Date:   Thu, 01 Sep 2016 15:59:03 -0700
In-Reply-To: <63004be3-04de-00c5-a94d-1b600201bc6f@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 2 Sep 2016 00:46:19 +0200")
Message-ID: <xmqqvayftefc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEF32962-7097-11E6-B207-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I wonder how probable is situation where we save instruction sheet
> for interactive rebase, with shortened SHA-1, and during rebase
> shortened SHA-1 stops being unambiguous...

It is my understanding that the shortened ones are only for end-user
consumption.  The insn sheet internally uses fully expanded form for
this exact reason, and then abbreviated back at each step before the
updated one is presented to the end-user.  Uniqueness guarantee is
enforced with new objects created during each step taken into
account by doing it this way.


