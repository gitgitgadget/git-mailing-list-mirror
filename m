Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B411F731
	for <e@80x24.org>; Fri,  2 Aug 2019 21:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfHBVUj (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 17:20:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63646 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfHBVUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 17:20:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4596740F5;
        Fri,  2 Aug 2019 17:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+rzwPunvdMp1
        4GbAhUbaQRBpYco=; b=V35+IQmnmPGKG94kadmgRLHaLi5RoHRTRi1wHfpXSd2h
        E50n+xy9ABuHtFsd1va5kYNbmj8h8pcKiik9CnlVK8BrdIwFRgWXnitExEXQZEXS
        wZyLwjZjiXWlZMJYtvRKZJvPUA9ke6w+e9skULW6/hBKFD99DsIqF1fqLEca/YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=b5ODMc
        VigoCrG9doGsu9AadZVWIKfZjuNqnDL/YFI1KM9MKUOo9xuMW9rO6u+A+i+ppJY8
        0OYdbLEcnnETDO7EMi4md2+n8B7ltEH9Q85ElmBkZEOWctkatoxgVAxvxpx4lAuq
        vcU8Vegtx/dn2EBx56zQAyTn61mqaNgtTtCn4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC685740F4;
        Fri,  2 Aug 2019 17:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB56F740F3;
        Fri,  2 Aug 2019 17:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?Q?=C3=89tienne?= SERVAIS <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
        <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
        <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
        <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
Date:   Fri, 02 Aug 2019 14:20:31 -0700
In-Reply-To: <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 2 Aug 2019 22:36:33 +0200")
Message-ID: <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D1CAE12-B56B-11E9-AC74-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Having cmd_log_init_finish() call load_ref_decorations() before
> setup_revisions() would indeed solve the issue as well.  But we need
> to call the latter to check if --pretty=3Draw was given and avoid loadi=
ng
> decorations in that case, don't we?

I was thinking about giving an instance of the decoration_filter to
either rev_info or setup_revision_opt, and moving the call to
load_ref_decorations() and the decision to make that call from
cmd_log_init_finish() to setup_revisions().

>> Other two callers of load_ref_decorations() are deep inside pretty.c
>> but I wonder in the longer term if we would want to turn them into
>> an "a lot higher level should have already loaded decorations"
>> assert.
>
> This would require that higher level to parse the user format to check
> if %d or %D is present before formatting the first item.  Hmm.

Yes.  Don't we pre-scan what kind of formatting primitives are used
in the end-user supplied string already to optimize loading of notes
and source information?

