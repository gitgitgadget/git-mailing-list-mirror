Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989451F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfFXRJd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:09:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52288 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfFXRJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:09:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E675653CB;
        Mon, 24 Jun 2019 13:09:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SWTol1vNExxHUFscpe63zVRKPWk=; b=tCxrLP
        7jtvP6J806rhxGTW1nBTKwIv4BJRStobYRY7+d6scJSA16Zys1Cf/AIfQJtkC3Cd
        7MH6yRlmuZpvzVsl/XW0pSNZbhW2XnNTdrpnpFLVX7ZnneU6LYzX4LX96d90YNQb
        QeFwwsFNgiGbCWYVUiNuQFUlGpex+Jm2AyLjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SnAjmet8fFOdAl0JQGhGrdVwMNzfg4Tn
        acDGUOdCXdVmRymK/pGE+phnI2JWXlhNsZS8I9B+AA447Lx2dLnPDKM13+UMrutH
        pmH+TZM/VDsGejlz8m+y4l+Or182tz01MLSohkXLj4x4aorK8zwwdJHF5yvqMRf3
        DgLwhvXuINA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 877BF653CA;
        Mon, 24 Jun 2019 13:09:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFF7B653C8;
        Mon, 24 Jun 2019 13:09:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.git.gitgitgadget@gmail.com>
        <pull.151.v2.git.gitgitgadget@gmail.com>
        <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet>
        <xmqqh88ikfpb.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906241212220.44@tvgsbejvaqbjf.bet>
Date:   Mon, 24 Jun 2019 10:09:26 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906241212220.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 24 Jun 2019 12:13:44 +0200 (CEST)")
Message-ID: <xmqqimsuj4ft.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D36B606E-96A2-11E9-AD10-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I wonder if we want (possibly local) test_cmp_fspath that can be
>> used more like
>>
>> 	test_cmp_fspath "$(pwd)/realgitdir" "$(sed -e "s/^gitdir: //" newdir/.git)"
>>
>> to compare two paths, honoring the case sensitivity of the
>> filesystem.
>
> I agree that that's a much better approach to fix the issue.

I find that response somewhat surprising :-|.  In any case, I am not
sure what kind of 'path' other than the filesystem one we would deal
with in the context of Git and its test suite, so perhaps we should
drop 'fs' from the name of the helper function if we were to go that
route.


